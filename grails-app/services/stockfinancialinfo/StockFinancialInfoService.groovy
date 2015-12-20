package stockfinancialinfo

import datautils.DataUtilsService
import grails.transaction.Transactional
import report.ReportConstant
import stockcharts.StockFinancialInfo
import stockcharts.StockMainBusinessInfo

@Transactional
class StockFinancialInfoService {

    def loadStockFinancialInfoData(def stockCodeList,String index) {
        def result = [:]
        def dataList = []
        def yearStrList = []
        def yearDateList = ReportConstant.STOCK_CHART_YEAR_LIST
        stockCodeList.each { stockCode ->
            def stockFinancialInfoMap = [:]
            def stockFinancialData = []
            yearDateList.each { endDate ->
                def indexValue = StockFinancialInfo.findByStockCodeAndEndDateAndReportType(stockCode, endDate, "A", [sort: "actPubtime", order: "desc"])?."${index}"
                if (indexValue) {
                    stockFinancialData << indexValue
                } else {
                    stockFinancialData << "-"
                }
            }
            if (StockFinancialInfo.findByStockCode(stockCode)) {
                stockFinancialInfoMap["stockName"] = StockFinancialInfo.findByStockCode(stockCode)?.stockName
                stockFinancialInfoMap["indexDataList"] = stockFinancialData
                dataList << stockFinancialInfoMap
            }
        }

        yearDateList.each { yearDate -> yearStrList << yearDate.format("yyyy") }
        result["yearList"] = yearStrList
        result["dataList"] = dataList
        return result
    }

    def loadStockFinancialInfoTableData (def stockCodeList,String index) {
        def dataList = []
        def yearStrList = ReportConstant.STOCK_CHART_YEAR_LIST
        Date endData = yearStrList.last()
        stockCodeList.each {String stockCode ->
            def stockFinancialInfoMap = [:]
            def stockFinancialInfo = StockFinancialInfo.findByStockCodeAndEndDateAndReportType(stockCode,endData,"A",[sort:"actPubtime", order: "desc"])
            def stockMainBusinessInfo = StockMainBusinessInfo.findByStockCode(stockCode)
            def industryId1 = stockMainBusinessInfo.industryID1
            def industryId1Name = stockMainBusinessInfo.industryName1
            def industryId2 = stockMainBusinessInfo.industryID2
            def industryId2Name = stockMainBusinessInfo.industryName2
            def industryId3 = stockMainBusinessInfo.industryID3
            def industryId3Name = stockMainBusinessInfo.industryName3
            def industryId1ResultList = StockFinancialInfo.findAllByStockCodeInListAndEndDateAndReportType(StockMainBusinessInfo.findAllByIndustryID1(industryId1).stockCode, endData, "A")."${index}".sort { a, b -> b <=> a }
            def industryId2ResultList = StockFinancialInfo.findAllByStockCodeInListAndEndDateAndReportType(StockMainBusinessInfo.findAllByIndustryID2(industryId2).stockCode, endData, "A")."${index}".sort { a, b -> b <=> a }
            def industryId3ResultList = StockFinancialInfo.findAllByStockCodeInListAndEndDateAndReportType(StockMainBusinessInfo.findAllByIndustryID3(industryId3).stockCode, endData, "A")."${index}".sort { a, b -> b <=> a }
            if (stockFinancialInfo) {
                stockFinancialInfoMap["stockName"] = stockFinancialInfo.stockName
                stockFinancialInfoMap["indexValue"] = stockFinancialInfo."${index}"
                stockFinancialInfoMap["rankInIndustry1"] = industryId1ResultList.indexOf(stockFinancialInfoMap["indexValue"]) + 1
                stockFinancialInfoMap["industryId1Name"] = industryId1Name
                stockFinancialInfoMap["rankInIndustry2"] = industryId2ResultList.indexOf(stockFinancialInfoMap["indexValue"]) + 1
                stockFinancialInfoMap["industryId2Name"] = industryId2Name
                stockFinancialInfoMap["rankInIndustry3"] = industryId3ResultList.indexOf(stockFinancialInfoMap["indexValue"]) + 1
                stockFinancialInfoMap["industryId3Name"] = industryId3Name
            } else {
                stockFinancialInfoMap["stockName"] = "-"
                stockFinancialInfoMap["indexValue"] = "-"
            }
            dataList << stockFinancialInfoMap
        }
        return dataList
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
