package stockcharts

import com.alibaba.fastjson.JSON

class CompanyRegionDistributionController {

    def index() {

    }

    def loadStockRegionDistributionData() {
        def result = []
        StockRegionInfo.list().groupBy { it.provinceRegion }.each {
            result << [name: it.key, value: it.value.size()]
        }
        render(JSON.toJSONString(result))
    }
}
