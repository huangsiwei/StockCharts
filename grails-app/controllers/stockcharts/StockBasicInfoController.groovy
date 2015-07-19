package stockcharts

import com.alibaba.fastjson.JSON

class StockBasicInfoController {

    def commonUtilsService

    def index() {}

    def mainBusinessInfo() {

    }

    def loadStockMainBusinessInfoPieChart() {
        def industryName1MapList = StockMainBusinessInfo.findAllByIsNew(true, [sort: "industryName1"]).groupBy {
            it.industryName1
        }
        def industryName2MapList = StockMainBusinessInfo.findAllByIsNew(true, [sort: "industryName1"]).groupBy {
            it.industryName2
        }
        def industryName3MapList = StockMainBusinessInfo.findAllByIsNew(true, [sort: "industryName1"]).groupBy {
            it.industryName3
        }
        def result = []
        def industryName1Result = []
        def industryName2Result = []
        def industryName3Result = []
        industryName1MapList.each {
            industryName1Result << [name: it.key, value: it.value.size(), color: commonUtilsService.generateRGBA(it.key, 1,1).toString()]
        }
        industryName2MapList.each {
            industryName2Result << [name: it.key, value: it.value.size(), color: commonUtilsService.generateRGBA(StockMainBusinessInfo.findByIndustryName2(it.key).industryName1, 0.7.toFloat(),(0.8).toFloat()).toString()]
        }
        industryName3MapList.each {
            industryName3Result << [name: it.key, value: it.value.size(), color: commonUtilsService.generateRGBA(StockMainBusinessInfo.findByIndustryName3(it.key).industryName1, 0.5.toFloat(),(0.7).toFloat()).toString()]
        }
        result << industryName1Result
        result << industryName2Result
        result << industryName3Result
        render(JSON.toJSONString(result))
    }
}
