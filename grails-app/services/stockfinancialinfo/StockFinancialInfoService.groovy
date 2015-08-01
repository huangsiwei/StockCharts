package stockfinancialinfo

import grails.transaction.Transactional
import stockcharts.StockFinancialInfo

@Transactional
class StockFinancialInfoService {

    def loadStockFinancialInfoData(def stockCodeList,String index) {
        def result = [:]
        def dataList = []
        def yearStrList = []
        def yearDateList = []
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
                if (StockFinancialInfo.findByStockCodeAndEndDate(stockCode, endDate, [sort: "actPubtime", order: "desc"])?."${index}") {
                    stockFinancialData << StockFinancialInfo.findByStockCodeAndEndDate(stockCode, endDate, [sort: "actPubtime", order: "desc"])?."${index}"
                } else {
                    stockFinancialData << "-"
                }
            }
            stockFinancialInfoMap["stockName"] = StockFinancialInfo.findByStockCode(stockCode)?.stockName
            stockFinancialInfoMap["indexDataList"] = stockFinancialData
            dataList << stockFinancialInfoMap
        }

        yearDateList.each { yearDate -> yearStrList << yearDate.format("yyyy") }
        result["yearList"] = yearStrList
        result["dataList"] = dataList
        return result
    }
}
