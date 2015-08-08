package stockcharts

import com.alibaba.fastjson.JSON

class CompanyRegionDistributionController {

    def companyRegionDistributionService

    def index() {

    }

    def loadStockRegionDistributionData() {
        def resultMap = companyRegionDistributionService.loadStockRegionDistributionData()
        render(JSON.toJSONString(resultMap))
    }

    def test (){
        companyRegionDistributionService.loadStockRegionDistributionData()
    }
}
