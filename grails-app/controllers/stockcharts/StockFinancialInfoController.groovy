package stockcharts

import base.Industry
import com.alibaba.fastjson.JSON
import report.ReportConstant

class StockFinancialInfoController {

    def stockFinancialInfoService
    def dataUtilsService

    def index() {
        def defaultStockList = StockBasicInfo.findAllByStockNameInList(ReportConstant.TOP10_BASICEPS_STOCK_LIST)
        [defaultStockList:defaultStockList]
    }

    def loadStockListByKeyWords() {
        def stockList = StockBasicInfo.withCriteria {
            or {
                and {
                    eq("listStatusCD", "L")
                    like("stockName", "%" + params.q + "%")
                }
                and {
                    eq("listStatusCD", "L")
                    like("stockCode", "%" + params.q + "%")
                }
            }
        }
        def resultList = []
        stockList?.each { stock->
            def stockMap = [:]
            stockMap['id'] = stock.stockCode
            stockMap['stockName'] = stock.stockName
            resultList << stockMap
        }
        render(contentType: "text/json") {
            stockList:resultList
        }
    }

    def loadStockFinancialInfoChartData() {
        def result = [:]
        String index = params.index
        def stockCodeList = params."stockCodes[]"
        if (stockCodeList instanceof String) {
            def tempList = []
            tempList << stockCodeList
            stockCodeList = tempList
        }
        result = stockFinancialInfoService.loadStockFinancialInfoData(stockCodeList,index)
        render(JSON.toJSONString(result))
    }

    def loadStockFinancialInfoRankingTable() {
        def result = [:]
        String index = params.index
        def stockCodeList = params."stockCodes[]"
        if (stockCodeList instanceof String) {
            def tempList = []
            tempList << stockCodeList
            stockCodeList = tempList
        }
        result = stockFinancialInfoService.loadStockFinancialInfoTableData(stockCodeList,index)
        render template: 'stock_financial_info_ranking_table',model: [result:result]
    }

    def financialInfoByIndustryFilter() {
        Industry selectedIndustryL1 = null;
        Industry selectedIndustryL2 = null;
        Industry selectedIndustryL3 = null;
        if (params.industryId) {
            Industry industry = Industry.findByIndustryID(params.industryId)
            switch (industry.level) {
                case 3:
                    selectedIndustryL3 = Industry.findByIndustryID(params.industryId)
                    selectedIndustryL2 = industry.parent
                    selectedIndustryL1 = industry.parent.parent
                    break;
                case 2:
                    selectedIndustryL2 = industry
                    selectedIndustryL1 = industry.parent
                    break;
                case 1:
                    selectedIndustryL1 = industry
                    break;
            }
        }

        def industryL1List = Industry.findAllByLevel(1)
        render(view: "financialInfoByIndustryFilter",model: [industryL1List:industryL1List,selectedIndustryL1:selectedIndustryL1,selectedIndustryL2:selectedIndustryL2,selectedIndustryL3:selectedIndustryL3])
    }

    def loadChildIndustry(){
        def parentIndustry = Industry.findByIndustryID(params.parentIndustryId)
        def childrenIndustryList = Industry.findAllByParent(parentIndustry)
        def result = []
        childrenIndustryList.each {
            result << ["industryId":it.industryID,"industryName":it.industryName]
        }
        render (JSON.toJSONString(result))
    }

    def loadStockFinancialTrendDataByIndustry() {
        def stockCodeList
        def index = params.index
        if (params.industryL3 != "") {
            stockCodeList = StockMainBusinessInfo.findAllByIndustryID3(params.industryL3).stockCode
        } else if (params.industryL2 !="") {
            stockCodeList = StockMainBusinessInfo.findAllByIndustryID2(params.industryL2).stockCode
        } else if (params.industryL1 != "") {
            stockCodeList = StockMainBusinessInfo.findAllByIndustryID1(params.industryL1).stockCode
        }
        def result = stockFinancialInfoService.loadStockFinancialInfoData(stockCodeList,index)
        render(JSON.toJSONString(result))
    }

    def financialInfoRadar() {
        def stockList = StockBasicInfo.findAllByListStatusCD("L")
        [stockList: stockList]
    }

    def loadStockFinancialInfoRadarChart() {
        def indexes = params.indexes.split(",")
        def stockCodes = params.stockCodes.split(",")
        def result = stockFinancialInfoService.loadStockFinancialInfoRadarChartData(stockCodes,indexes,ReportConstant.STOCK_CHART_YEAR_LIST.last(),null)
        render (JSON.toJSONString(result))
    }

    def financialInfoCompare() {
        def stockList
        def selectedIndex
        def selectedYear
    }

    def detailInfo () {

    }
}
