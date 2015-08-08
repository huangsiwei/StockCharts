package tongliandata

import base.Industry
import grails.transaction.Transactional
import stockcharts.StockBasicInfo
import stockcharts.StockMainBusinessInfo
import stockcharts.StockRegionInfo

@Transactional
class DataHandlerService {

    def addListDateToStockRegionInfo() {
        StockRegionInfo.list().each { stockRegionInfo ->
            def stockCode = stockRegionInfo.stockCode
            stockRegionInfo.listDate = StockBasicInfo.findByStockCode(stockCode)?.listDate
            if (!stockRegionInfo.save(flush: true)) {
                stockRegionInfo.errors.each {
                    println stockCode + ":" + it
                }
            }
        }
    }

    def initIndustryData() {

        def industryL1IdList = []
        def industryL2IdList = []
        def industryL3IdList = []
        StockMainBusinessInfo.findAllByIsNew(true).each {
            if (!industryL1IdList.contains(it.industryID1)) {
                industryL1IdList << it.industryID1
                Industry industry = new Industry()
                industry.industryID = it.industryID1
                industry.industryName = it.industryName1
                industry.level = 1
                industry.save(flush: true)
            }
        }
        StockMainBusinessInfo.findAllByIsNew(true).each {
            if (!industryL2IdList.contains(it.industryID2)) {
                industryL2IdList << it.industryID2
                Industry industry = new Industry()
                industry.industryID = it.industryID2
                industry.industryName = it.industryName2
                industry.level = 2
                industry.save(flush: true)
            }
        }
        StockMainBusinessInfo.findAllByIsNew(true).each {
            if (!industryL3IdList.contains(it.industryID3)) {
                industryL3IdList << it.industryID3
                Industry industry = new Industry()
                industry.industryID = it.industryID3
                industry.industryName = it.industryName3
                industry.level = 3
                industry.save(flush: true)
            }
        }

        industryL1IdList.each { industryL1Id ->
            def l2IdList = StockMainBusinessInfo.findAllByIndustryID1(industryL1Id).industryID2
            Industry industryL1 = Industry.findByIndustryID(industryL1Id)
            industryL1.children = Industry.findAllByIndustryIDInList(l2IdList)
            industryL1.save(flush: true)
            Industry.findAllByIndustryIDInList(l2IdList).each {
                it.parent = industryL1
                it.save(flush: true)
            }
        }

        industryL2IdList.each { industryL2Id ->
            def l3IdList = StockMainBusinessInfo.findAllByIndustryID2(industryL2Id).industryID3
            Industry industryL2 = Industry.findByIndustryID(industryL2Id)
            industryL2.children = Industry.findAllByIndustryIDInList(l3IdList)
            industryL2.save(flush: true)
            Industry.findAllByIndustryIDInList(l3IdList).each {
                it.parent = industryL2
                it.save(flush: true)
            }
        }
    }
}
