package stockcharts

import grails.transaction.Transactional

@Transactional
class CompanyRegionDistributionService {

    def loadStockRegionDistributionDataByYear() {
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

    def loadStockRegionDistributionDataTotally() {
        def resultMap = [:]
        def queryResult = StockRegionInfo.executeQuery("select DATE_FORMAT(rpt.listDate,'%Y'),rpt.provinceRegion,count(rpt.id) from StockRegionInfo rpt group by DATE_FORMAT(rpt.listDate,'%Y'),rpt.provinceRegion")
        def regionHistoryMap = [:]
        queryResult.grep{it[0] != null}.groupBy {it[0]}.each {
            def yearInfoList = []
            it.value.each {
                if (regionHistoryMap[it[1]]) {
                    regionHistoryMap[it[1]] = regionHistoryMap[it[1]] + it[2]
                } else {
                    regionHistoryMap[it[1]] = it[2]
                }
            }
            regionHistoryMap.each {
                yearInfoList << [name: it.key,value: it.value]
            }
            resultMap[it.key] = yearInfoList
        }
        return resultMap
    }
}
