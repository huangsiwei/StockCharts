package stockcharts

class DataAnalysisController {

    def dataUtilsService

    def index() {}

    def highGrowth() {
        def resultList = []
        def stockCodeList = StockBasicInfo.findAllByListStatusCD("L")?.stockCode
        stockCodeList?.each { stockCode ->
            def revenue2014 = (long) StockFinancialInfo.findByEndDateAndStockCode(Date.parse("yyyy-MM-dd", "2014-12-31"), stockCode)?.revenue ?: 0
            def revenue2013 = (long) StockFinancialInfo.findByEndDateAndStockCode(Date.parse("yyyy-MM-dd", "2013-12-31"), stockCode)?.revenue ?: 0
            def revenue2012 = (long) StockFinancialInfo.findByEndDateAndStockCode(Date.parse("yyyy-MM-dd", "2012-12-31"), stockCode)?.revenue ?: 0
            def revenue2014NR = dataUtilsService.getNIncomeRate(StockFinancialInfo.findByEndDateAndStockCode(Date.parse("yyyy-MM-dd", "2014-12-31"), stockCode))
            def revenue2013NR = dataUtilsService.getNIncomeRate(StockFinancialInfo.findByEndDateAndStockCode(Date.parse("yyyy-MM-dd", "2013-12-31"), stockCode))
            def revenue2012NR = dataUtilsService.getNIncomeRate(StockFinancialInfo.findByEndDateAndStockCode(Date.parse("yyyy-MM-dd", "2012-12-31"), stockCode))
            if (revenue2014 > 0 && revenue2013 > 0 && revenue2012 > 0 && revenue2014 > revenue2013 * 1.1 && revenue2013 > revenue2012 * 1.1 && revenue2012NR > 0.05 && revenue2013NR > 0.05 && revenue2014NR > 0.05 && revenue2014NR > revenue2013NR * 1.1) {
                println(StockBasicInfo.findByStockCode(stockCode).stockName + ":" + StockDailyMarketingInfo.findByStockCode(stockCode).marketValue)
                resultList << [stockName:StockBasicInfo.findByStockCode(stockCode).stockName,marketValue:(long) StockDailyMarketingInfo.findByStockCode(stockCode).marketValue]
            }
        }
        render resultList.sort {it.marketValue}
    }

}
