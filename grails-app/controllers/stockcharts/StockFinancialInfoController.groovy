package stockcharts

import base.Industry
import com.alibaba.fastjson.JSON

class StockFinancialInfoController {

    def stockFinancialInfoService

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
}
