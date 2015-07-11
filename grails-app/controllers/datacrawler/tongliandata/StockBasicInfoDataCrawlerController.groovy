package datacrawler.tongliandata

import base.Region
import stockcharts.StockRegionInfo
import tongliandata.StockBasicInfoCrawlerService

class StockBasicInfoDataCrawlerController {

    StockBasicInfoCrawlerService stockBasicInfoCrawlerService

    def index() {}

    //取得地域MAP信息
    def fetchRegionInfo() {
        stockBasicInfoCrawlerService.fetchRegionInfo()
        render "OK"
    }

    //获取所有股票的地域信息
    def fetchAllStockRegionInfo () {
        stockBasicInfoCrawlerService.fetchAllStockRegionInfo()
        render "OK"
    }

    //获取所有股票的所在省份
    def matchStockProvinceData() {
        StockRegionInfo.list().each { stockRegionInfo ->
            Region region = Region.findByName(stockRegionInfo.cityRegion)
            if (region.level == 6) {
                stockRegionInfo.provinceRegion = region.parent.aliasNameMap
                stockRegionInfo.save()
            }
        }
    }

    def test() {
        stockBasicInfoCrawlerService.test()
    }
}
