package stockcharts

import grails.transaction.Transactional

@Transactional
class CompanyRegionDistributionService {

    def loadStockRegionDistributionData() {
        def resultMap = [:]
        def queryResult = StockRegionInfo.executeQuery("select DATE_FORMAT(rpt.listDate,'%Y'),rpt.provinceRegion,count(rpt.id) from StockRegionInfo rpt group by DATE_FORMAT(rpt.listDate,'%Y'),rpt.provinceRegion")
        queryResult.grep{it[0] != null}.groupBy {it[0]}.each {
            def yearInfoList = []
            it.value.each {
                yearInfoList << [name: it[1], value: it[2]]
            }
            resultMap[it.key] = yearInfoList
        }
        return resultMap
    }
}
