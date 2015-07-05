package datacrawler.tongliandata

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
}
