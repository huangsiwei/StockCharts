package stockcharts

import com.alibaba.fastjson.JSON

class StockBasicInfoController {

    def index() {}

    def mainBusinessInfo() {

    }

    def loadStockMainBusinessInfoPieChart() {
        def industryName1MapList = StockMainBusinessInfo.findAllByIsNew(true,[sort:"industryName1"]).groupBy { it.industryName1 }
        def industryName2MapList = StockMainBusinessInfo.findAllByIsNew(true,[sort:"industryName1"]).groupBy { it.industryName2 }
        def industryName3MapList = StockMainBusinessInfo.findAllByIsNew(true,[sort:"industryName1"]).groupBy { it.industryName3 }
        def result = []
        def industryName1Result = []
        def industryName2Result = []
        def industryName3Result = []
        industryName1MapList.each {
            industryName1Result << [name: it.key, value: it.value.size()]
        }
        industryName2MapList.each {
            industryName2Result << [name: it.key, value: it.value.size()]
        }
        industryName3MapList.each {
            industryName3Result << [name: it.key, value: it.value.size()]
        }
        result << industryName1Result
        result << industryName2Result
        result << industryName3Result
        render(JSON.toJSONString(result))
    }
}
