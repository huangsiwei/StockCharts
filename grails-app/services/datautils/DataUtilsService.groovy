package datautils

import grails.transaction.Transactional
import stockcharts.StockBasicInfo

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
}
