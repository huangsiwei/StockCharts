package datacrawler.tongliandata

import stockcharts.StockBasicInfo
import tongliandata.StockFinancialInfoCrawlerService

class StockFinancialInfoDataCrawlerController {

    StockFinancialInfoCrawlerService stockFinancialInfoCrawlerService

    def index() {}

    def fetchStockFinancialInfo() {
        List stockCodeList = StockBasicInfo.list().stockCode
        stockCodeList?.each { String stockCode ->
            stockFinancialInfoCrawlerService.fetchStockFinancialInfo(stockCode)
        }
    }
}
