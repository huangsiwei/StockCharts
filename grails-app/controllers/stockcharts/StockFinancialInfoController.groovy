package stockcharts

import base.Industry
import com.alibaba.fastjson.JSON
import report.ReportConstant

class StockFinancialInfoController {

    def stockFinancialInfoService
    def dataUtilsService

    def index() {
        def stockList = StockBasicInfo.findAllByListStatusCD("L")
        def defaultStock = ReportConstant.TOP10_BASICEPS_STOCK_LIST
        [stockList: stockList,defaultStock:defaultStock]
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

    def financialInfoByIndustryFilter() {
        def industryL1List = Industry.findAllByLevel(1)
        render(view: "financialInfoByIndustryFilter",model: [industryL1List:industryL1List])
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
}
