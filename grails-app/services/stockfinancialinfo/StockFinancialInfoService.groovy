package stockfinancialinfo

import grails.transaction.Transactional
import report.ReportConstant
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

    def loadStockFinancialInfoRadarChartData(def stockCodeList,def indexes,Date endDate,def compareTarget) {
        def seriesData = []
        def indicatorMap = [:]
        def indicatorMapList = []
        indexes.each { index ->
            indicatorMap[index] = 0
        }
        stockCodeList.each { String stockCode ->
            def stockFinancialInfoSeriesData = [:]
            StockFinancialInfo stockFinancialInfo = StockFinancialInfo.findByStockCodeAndEndDate(stockCode,endDate)
            def stockFinancialInfoDataList = []
            indexes.each { index ->
                stockFinancialInfoDataList << stockFinancialInfo."${index}"
                if (stockFinancialInfo."${index}" > indicatorMap[index]) {
                    indicatorMap[index] = stockFinancialInfo."${index}"
                }
            }
            stockFinancialInfoSeriesData["value"] = stockFinancialInfoDataList
            stockFinancialInfoSeriesData["name"] = stockFinancialInfo.stockName
            seriesData << stockFinancialInfoSeriesData
        }
        indexes.each { index ->
            indicatorMapList << [name:ReportConstant.STOCK_FINANCIAL_INDEXES.get(index),max:indicatorMap[index]* 1.2]
        }
        return [indicatorMapList:indicatorMapList,seriesData:seriesData]
    }
}
