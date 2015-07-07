package datacrawler.tongliandata

import base.Region
import stockcharts.StockRegionInfo
import tongliandata.StockBasicInfoCrawlerService

class StockBasicInfoController {

    StockBasicInfoCrawlerService stockBasicInfoCrawlerService

    def index() {}

    def fetchRegionInfo() {
        stockBasicInfoCrawlerService.fetchRegionInfo()
        render "OK"
    }

    def fetchAllStockRegionInfo () {
        stockBasicInfoCrawlerService.fetchAllStockRegionInfo()
        render "OK"
    }

    def matchStockProvinceData() {
        StockRegionInfo.list().each { stockRegionInfo ->
            Region region = Region.findByName(stockRegionInfo.cityRegion)
            if (region.level == 6) {
                stockRegionInfo.provinceRegion = region.parent.aliasNameMap
                stockRegionInfo.save()
            }
        }
    }
}
