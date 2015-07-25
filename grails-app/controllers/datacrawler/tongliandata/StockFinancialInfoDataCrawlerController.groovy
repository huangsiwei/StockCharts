package datacrawler.tongliandata

import tongliandata.StockFinancialInfoCrawlerService

class StockFinancialInfoDataCrawlerController {

    StockFinancialInfoCrawlerService stockFinancialInfoCrawlerService

    def index() {}

    def fetchStockFinancialInfo() {
        (1..500).each {
            String stockCode = (300000 + it).toString()
            stockFinancialInfoCrawlerService.fetchStockFinancialInfo(stockCode)
        }

    }
}
