package stockcharts

import com.alibaba.fastjson.JSON

class StockBasicInfoController {

    def index() {}

    def mainBusinessInfo() {

    }

    def loadStockMainBusinessInfoPieChart() {
        def industryName1MapList = StockMainBusinessInfo.findAllByIsNew(true).groupBy {it.industryName1}
        def result = []
        industryName1MapList.each {
            result << [name:it.key,value:it.value.size()]

        }
        render(JSON.toJSONString(result))
    }
}
