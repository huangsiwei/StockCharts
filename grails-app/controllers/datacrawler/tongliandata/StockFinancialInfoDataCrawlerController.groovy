package datacrawler.tongliandata

import stockcharts.StockBasicInfo
import tongliandata.StockFinancialInfoCrawlerService

class StockFinancialInfoDataCrawlerController {

    StockFinancialInfoCrawlerService stockFinancialInfoCrawlerService

    def index() {}

    def fetchStockFinancialInfo() {
        List stockCodeList = StockBasicInfo.findAllByListStatusCD("L").stockCode
        stockCodeList?.each { String stockCode ->
            stockFinancialInfoCrawlerService.fetchStockFinancialInfo(stockCode)
        }
    }
}
