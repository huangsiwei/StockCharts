package stockcharts

import com.alibaba.fastjson.JSON

class StockFinancialInfoController {

    def index() {}

    def loadStockFinancialInfoData() {
        def result = [:]
        def yearList = []
        def dataList = []
        def stockFinancialInfoList = StockFinancialInfo.findAllByStockCode(params.stockCode).sort {it.endDate}
        stockFinancialInfoList.each { stockFinancialInfo ->
            yearList << stockFinancialInfo.endDate.format("yyyy")
            dataList << stockFinancialInfo.basicEPS
        }
        result["yearList"] = yearList
        result["dataList"] = dataList
        render(JSON.toJSONString(result))
    }
}
