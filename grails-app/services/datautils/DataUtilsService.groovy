package datautils

import grails.transaction.Transactional
import stockcharts.StockBasicInfo
import stockcharts.StockFinancialInfo

@Transactional
class DataUtilsService {

    def stockBasicInfoMap(String ListStatusCD) {
        def stockBasicInfoMap = [:]
        StockBasicInfo.findAllByListStatusCD(ListStatusCD).each { stockBasicInfo ->
            if (!stockBasicInfoMap[stockBasicInfo.stockCode]) {
                stockBasicInfoMap[stockBasicInfo.stockCode] = stockBasicInfo.stockName
            }
        }
        [stockBasicInfoMap: stockBasicInfoMap]
    }

    def getNIncomeRate(StockFinancialInfo stockFinancialInfo) {
        if (stockFinancialInfo?.nIncome && stockFinancialInfo?.revenue) {
            return stockFinancialInfo.nIncome / stockFinancialInfo.revenue
        } else {
            return 0
        }

    }
}
