package stockcharts

import com.alibaba.fastjson.JSON

class StockFinancialInfoController {

    def index() {
        def stockFinancialInfoMap = [:]
        StockFinancialInfo.list().each { stockFinancialInfo ->
            if (!stockFinancialInfoMap[stockFinancialInfo.stockCode]) {
                stockFinancialInfoMap[stockFinancialInfo.stockCode] = stockFinancialInfo.stockName
            }
        }
        [stockFinancialInfoMap: stockFinancialInfoMap]
    }

    def loadStockFinancialInfoData() {
        def result = [:]
        def dataList = []
        def yearStrList = []
        def yearDateList = []

        def stockCodeList = params."stockCodes[]"
        if (stockCodeList instanceof String) {
            def tempList = []
            tempList << stockCodeList
            stockCodeList = tempList
        }
        stockCodeList.each { stockCode ->
            StockFinancialInfo.findAllByStockCode(stockCode).each { stockFinancialInfo ->
                yearDateList << stockFinancialInfo.endDate
            }
        }
        yearDateList = yearDateList.unique().sort()
        stockCodeList.each { stockCode ->
            def stockFinancialInfoMap = [:]
            def stockFinancialData = []
            yearDateList.each { endDate ->
                println()
                if (StockFinancialInfo.findByStockCodeAndEndDate(stockCode, endDate, [sort: "actPubtime", order: "desc"]).basicEPS) {
                    stockFinancialData << StockFinancialInfo.findByStockCodeAndEndDate(stockCode, endDate, [sort: "actPubtime", order: "desc"]).basicEPS
                } else {
                    stockFinancialData << "-"
                }
            }
            stockFinancialInfoMap["stockName"] = StockFinancialInfo.findByStockCode(stockCode).stockName
            stockFinancialInfoMap["basicEPSList"] = stockFinancialData
            dataList << stockFinancialInfoMap
        }

        yearDateList.each { yearDate -> yearStrList << yearDate.format("yyyy") }
        result["yearList"] = yearStrList
        result["dataList"] = dataList
        render(JSON.toJSONString(result))

    }
}
