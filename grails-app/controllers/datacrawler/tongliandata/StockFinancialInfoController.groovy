package datacrawler.tongliandata

import tongliandata.StockFinancialInfoCrawlerService

class StockFinancialInfoController {

    StockFinancialInfoCrawlerService stockFinancialInfoCrawlerService

    def index() {}

    def fetchStockFinancialInfo() {
        stockFinancialInfoCrawlerService.fetchStockFinancialInfo("300005")
    }
}
