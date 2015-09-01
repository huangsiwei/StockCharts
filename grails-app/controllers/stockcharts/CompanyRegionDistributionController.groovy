package stockcharts

import com.alibaba.fastjson.JSON

class CompanyRegionDistributionController {

    def companyRegionDistributionService

    def index() {

    }

    def loadStockRegionDistributionDataByYear() {
        def resultMap = companyRegionDistributionService.loadStockRegionDistributionDataByYear()
        render(JSON.toJSONString(resultMap))
    }

    def loadStockRegionDistributionDataTotally() {
        def resultMap = companyRegionDistributionService.loadStockRegionDistributionDataTotally()
        render(JSON.toJSONString(resultMap))
    }

    def test (){
        companyRegionDistributionService.loadStockRegionDistributionDataByYear()
    }
}
