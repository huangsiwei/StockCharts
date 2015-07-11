package datacrawler.tongliandata

import tongliandata.StockFinancialInfoCrawlerService

class StockFinancialInfoDataCrawlerController {

    StockFinancialInfoCrawlerService stockFinancialInfoCrawlerService

    def index() {}

    def fetchStockFinancialInfo() {
        stockFinancialInfoCrawlerService.fetchStockFinancialInfo("300005")
    }
}
