package stockfinancialinfo

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
        def queryResult = StockFinancialInfo.executeQuery("select rpt.stockCode,rpt.stockName, rpt.endDate,rpt.${index} from StockFinancialInfo rpt where rpt.stockCode in :stockCodeList and rpt.reportType = 'A' group by rpt.stockCode,rpt.endDate",[stockCodeList:stockCodeList as List])
        stockCodeList?.each { stockCode ->
            def stockFinancialInfoMap = [:]
            def stockFinancialData = []
            yearDateList?.each { yearDate ->
                def stockYearFinancialDate = queryResult.find { it[0] == stockCode && it[2] == yearDate }
                if (stockYearFinancialDate) {
                    if ((stockYearFinancialDate[3])) {
                        stockFinancialData << stockYearFinancialDate[3]
                    } else {
                        stockFinancialData << "-"
                    }
                } else {
                    stockFinancialData << "-"
                }
            }
            //queryResult.find { it[0] == stockCode } 没有结果:可能是因为暂停上市等原因
            if (queryResult.find { it[0] == stockCode }) {
                stockFinancialInfoMap["stockName"] = queryResult.find { it[0] == stockCode }[1]
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
            if (stockFinancialInfo) {
                stockFinancialInfoMap["stockName"] = stockFinancialInfo.stockName
                stockFinancialInfoMap["indexValue"] = stockFinancialInfo."${index}"
            } else {
                stockFinancialInfoMap["stockName"] = "-"
                stockFinancialInfoMap["indexValue"] = "-"
            }
            //对没有找到主营业务的个股进行处理
            if (stockMainBusinessInfo) {
                def industryId1 = stockMainBusinessInfo.industryID1
                def industryId1Name = stockMainBusinessInfo.industryName1
                def industryId2 = stockMainBusinessInfo.industryID2
                def industryId2Name = stockMainBusinessInfo.industryName2
                def industryId3 = stockMainBusinessInfo.industryID3
                def industryId3Name = stockMainBusinessInfo.industryName3
                def industryId1ResultList = StockFinancialInfo.findAllByStockCodeInListAndEndDateAndReportType(StockMainBusinessInfo.findAllByIndustryID1(industryId1).stockCode, endData, "A")."${index}".sort { a, b -> b <=> a }
                def industryId2ResultList = StockFinancialInfo.findAllByStockCodeInListAndEndDateAndReportType(StockMainBusinessInfo.findAllByIndustryID2(industryId2).stockCode, endData, "A")."${index}".sort { a, b -> b <=> a }
                def industryId3ResultList = StockFinancialInfo.findAllByStockCodeInListAndEndDateAndReportType(StockMainBusinessInfo.findAllByIndustryID3(industryId3).stockCode, endData, "A")."${index}".sort { a, b -> b <=> a }
                    stockFinancialInfoMap["rankInIndustry1"] = industryId1ResultList.indexOf(stockFinancialInfoMap["indexValue"]) + 1
                    stockFinancialInfoMap["industryId1Name"] = industryId1Name
                    stockFinancialInfoMap["industryId1"] = industryId1
                    stockFinancialInfoMap["rankInIndustry2"] = industryId2ResultList.indexOf(stockFinancialInfoMap["indexValue"]) + 1
                    stockFinancialInfoMap["industryId2Name"] = industryId2Name
                    stockFinancialInfoMap["industryId2"] = industryId2
                    stockFinancialInfoMap["rankInIndustry3"] = industryId3ResultList.indexOf(stockFinancialInfoMap["indexValue"]) + 1
                    stockFinancialInfoMap["industryId3Name"] = industryId3Name
                    stockFinancialInfoMap["industryId3"] = industryId3
            } else {
                stockFinancialInfoMap["noIndustryInfo"] = "暂无行业排名信息"
            }
            if (index == 'basicEPS') {
                stockFinancialInfoMap["indexValue"] = stockFinancialInfo."${index}"
                stockFinancialInfoMap["indexUnit"] = "元/每股"
            } else {
                stockFinancialInfoMap["indexValue"] = ((long) stockFinancialInfo."${index}")
                stockFinancialInfoMap["indexUnit"] = "元"
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
