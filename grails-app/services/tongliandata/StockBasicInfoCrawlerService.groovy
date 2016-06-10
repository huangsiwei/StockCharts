package tongliandata

import base.Region
import grails.converters.JSON
import grails.transaction.Transactional
import org.apache.http.HttpEntity
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpGet
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils
import stockcharts.StockBasicInfo
import stockcharts.StockDailyMarketingInfo
import stockcharts.StockMainBusinessInfo
import stockcharts.StockRegionInfo

@Transactional
class StockBasicInfoCrawlerService {

    def fetchStockTodayMktInfo() {
        String url = "https://api.wmcloud.com/data/v1/api/market/getMktEqud.json?field=&beginDate=&endDate=&secID=&ticker=&tradeDate=20160321"
        HttpClient httpClient = new DefaultHttpClient()
        HttpGet httpGet = new HttpGet(url)
        httpGet.addHeader("Authorization", "Bearer 5c97761c5f15ec4d41eef90557588fa3b2e0fb1ccb104ff18158cd1ba3319139")
        def response = httpClient.execute(httpGet)
        HttpEntity entity = response.getEntity()
        String body = EntityUtils.toString(entity)
        JSON.parse(body).data.each { stockMktInfo ->
            StockDailyMarketingInfo stockDailyMarketingInfo = new StockDailyMarketingInfo()
            stockDailyMarketingInfo.stockCode = stockMktInfo.ticker
            stockDailyMarketingInfo.secShortName = stockMktInfo.secShortName
            stockDailyMarketingInfo.exchangeCD = stockMktInfo.exchangeCD
            stockDailyMarketingInfo.tradeDate = stockMktInfo.tradeDate? Date.parse("yyyy-MM-dd", stockMktInfo.tradeDate) : null
            stockDailyMarketingInfo.preClosePrice = stockMktInfo.preClosePrice
            stockDailyMarketingInfo.actPreClosePrice = stockMktInfo.actPreClosePrice
            stockDailyMarketingInfo.openPrice = stockMktInfo.openPrice
            stockDailyMarketingInfo.highestPrice = stockMktInfo.highestPrice
            stockDailyMarketingInfo.lowestPrice = stockMktInfo.lowestPrice
            stockDailyMarketingInfo.closePrice = stockMktInfo.closePrice
            stockDailyMarketingInfo.turnoverVol = stockMktInfo.turnoverVol
            stockDailyMarketingInfo.turnoverValue = stockMktInfo.turnoverValue
            stockDailyMarketingInfo.dealAmount = stockMktInfo.dealAmount
            stockDailyMarketingInfo.turnoverRate = stockMktInfo.turnoverRate
            stockDailyMarketingInfo.negMarketValue = stockMktInfo.negMarketValue
            stockDailyMarketingInfo.marketValue = stockMktInfo.marketValue
            if (stockMktInfo.isOpen == '1') {
                stockDailyMarketingInfo.isOpen = stockMktInfo.isOpen
            } else {
                stockDailyMarketingInfo.isOpen = false
            }
            if (!stockDailyMarketingInfo.save(flush: true)){
                stockDailyMarketingInfo.errors.each {
                    println (stockMktInfo.ticker + ":" + it)
                }
            }
        }
    }

    def fetchStockBasicInfo() {
        String url = "https://api.wmcloud.com/data/v1/api/master/getSecID.json?field=&assetClass=E&ticker=&partyID=&cnSpell="
        HttpClient httpClient = new DefaultHttpClient()
        HttpGet httpGet = new HttpGet(url)
        httpGet.addHeader("Authorization", "Bearer 5c97761c5f15ec4d41eef90557588fa3b2e0fb1ccb104ff18158cd1ba3319139")
        def response = httpClient.execute(httpGet)
        HttpEntity entity = response.getEntity()
        String body = EntityUtils.toString(entity)
        JSON.parse(body).data.each { stock ->
            if (stock.transCurrCD == "CNY") {
                StockBasicInfo stockBasicInfo = new StockBasicInfo()
                stockBasicInfo.stockCode = stock.ticker
                stockBasicInfo.stockName = stock.secShortName
                stockBasicInfo.listStatusCD = stock.listStatusCD
                stockBasicInfo.listDate = stock.listDate? Date.parse("yyyy-MM-dd", stock.listDate) : null
                stockBasicInfo.exchangeCD = stock.exchangeCD
                stockBasicInfo.assetClass = stock.assetClass
                if (!stockBasicInfo.save(flush: true)) {
                    stockBasicInfo.errors.each {
                        println (stock.ticker + ":" + it)
                    }
                }
            }
        }
    }

    def fetchRegionInfo() {
        String url = "https://api.wmcloud.com/data/v1/api/master/getSecType.json?field="
        HttpClient httpClient = new DefaultHttpClient()
        HttpGet httpGet = new HttpGet(url)
        httpGet.addHeader("Authorization", "Bearer 5c97761c5f15ec4d41eef90557588fa3b2e0fb1ccb104ff18158cd1ba3319139")
        def response = httpClient.execute(httpGet)
        HttpEntity entity = response.getEntity()
        String body = EntityUtils.toString(entity)
        def districtList = [] //大区域级别 level 4
        def provinceList = [] //省份 level 5
        def cityList = []     //城市 level 6

        JSON.parse(body).data.findAll { it.parentID == "101001004" }.each { regionJson ->
            Region region = new Region()
            region.name = regionJson.typeName
            region.level = regionJson.typeLevel as int
            region.code = regionJson.typeID
            region.save(flush: true)
            districtList << regionJson.typeID
        }

        JSON.parse(body).data.findAll { it.parentID in districtList }.each { regionJson ->
            Region region = new Region()
            region.name = regionJson.typeName
            region.level = regionJson.typeLevel as int
            region.code = regionJson.typeID
            region.parent = Region.findByCode(regionJson.parentID)
            region.aliasNameMap = region.name.replace("省","").replace("市","")
            region.save(flush: true)
            provinceList << regionJson.typeID
        }

        JSON.parse(body).data.findAll { it.parentID in provinceList }.each { regionJson ->
            Region region = new Region()
            region.name = regionJson.typeName
            region.level = regionJson.typeLevel as int
            region.code = regionJson.typeID
            region.parent = Region.findByCode(regionJson.parentID)
            region.aliasNameMap = region.name
            region.save(flush: true)
        }
    }

    def fetchAllStockRegionInfo() {
        def result
        String url = "https://api.wmcloud.com/data/v1/api/master/getSecTypeRegionRel.json?field=&typeID=&secID=&ticker="
        HttpClient httpClient = new DefaultHttpClient()
        HttpGet httpGet = new HttpGet(url)
        httpGet.addHeader("Authorization", "Bearer 5c97761c5f15ec4d41eef90557588fa3b2e0fb1ccb104ff18158cd1ba3319139")
        def response = httpClient.execute(httpGet)
        HttpEntity entity = response.getEntity()
        String body = EntityUtils.toString(entity)
        JSON.parse(body).data.each{ stock ->
            StockRegionInfo stockRegionInfo = new StockRegionInfo()
            stockRegionInfo.stockName = stock.secShortName
            stockRegionInfo.cityRegion = stock.typeName
            stockRegionInfo.stockCode = stock.ticker
            stockRegionInfo.save(flush: true)
        }
    }

    def fetchStockMainBusinessInfo(String stockCode) {
        String url = "https://api.wmcloud.com/data/v1/api/equity/getEquIndustry.json?field=&industryVersionCD=010303&industry=&secID=&ticker=" + stockCode + "&intoDate="
        HttpClient httpClient = new DefaultHttpClient()
        HttpGet httpGet = new HttpGet(url)
        httpGet.addHeader("Authorization", "Bearer 5c97761c5f15ec4d41eef90557588fa3b2e0fb1ccb104ff18158cd1ba3319139")
        def response = httpClient.execute(httpGet)
        HttpEntity entity = response.getEntity()
        String body = EntityUtils.toString(entity)
        JSON.parse(body).data?.each { stock ->
            StockMainBusinessInfo stockMainBusinessInfo = new StockMainBusinessInfo()
            stockMainBusinessInfo.stockName = stock.secShortName
            stockMainBusinessInfo.stockCode = stock.ticker
            stockMainBusinessInfo.industry = stock.industry
            stockMainBusinessInfo.industryID = stock.industryID
            stockMainBusinessInfo.industrySymbol = stock.industrySymbol
            stockMainBusinessInfo.intoDate = stock.intoDate ? Date.parse("yyyy-MM-dd", stock.intoDate) : null
            stockMainBusinessInfo.outDate = stock.outDate ? Date.parse("yyyy-MM-dd", stock.outDate) : null
            stockMainBusinessInfo.isNew = stock.isNew
            stockMainBusinessInfo.industryID1 = stock.industryID1 ?: null
            stockMainBusinessInfo.industryName1 = stock.industryName1 ?: null
            stockMainBusinessInfo.industryID2 = stock.industryID2 ?: null
            stockMainBusinessInfo.industryName2 = stock.industryName2 ?: null
            stockMainBusinessInfo.industryID3 = stock.industryID3 ?: null
            stockMainBusinessInfo.industryName3 = stock.industryName3 ?: null
            stockMainBusinessInfo.industryName4 = stock.industryName4 ?: null
            stockMainBusinessInfo.industryName4 = stock.industryName4 ?: null
            if (stockMainBusinessInfo.isNew) {
                if (!stockMainBusinessInfo.save(flush: true)) {
                    stockMainBusinessInfo.errors.each {
                        println stockCode + ":" + it
                    }
                }
            }
        }
    }

    def fetchAllStockMainBusinessInfo() {
        String url = "https://api.wmcloud.com/data/v1/api/equity/getEquIndustry.json?field=&industryVersionCD=010303&industry=%E7%94%B3%E4%B8%87%E8%A1%8C%E4%B8%9A&secID=&intoDate="
        HttpClient httpClient = new DefaultHttpClient()
        HttpGet httpGet = new HttpGet(url)
        httpGet.addHeader("Authorization", "Bearer 5c97761c5f15ec4d41eef90557588fa3b2e0fb1ccb104ff18158cd1ba3319139")
        def response = httpClient.execute(httpGet)
        HttpEntity entity = response.getEntity()
        String body = EntityUtils.toString(entity)
        JSON.parse(body).data?.each { stock ->
            StockMainBusinessInfo stockMainBusinessInfo = new StockMainBusinessInfo()
            stockMainBusinessInfo.stockName = stock.secShortName
            stockMainBusinessInfo.stockCode = stock.ticker
            stockMainBusinessInfo.industry = stock.industry
            stockMainBusinessInfo.industryID = stock.industryID
            stockMainBusinessInfo.industrySymbol = stock.industrySymbol
            stockMainBusinessInfo.intoDate = stock.intoDate ? Date.parse("yyyy-MM-dd", stock.intoDate) : null
            stockMainBusinessInfo.outDate = stock.outDate ? Date.parse("yyyy-MM-dd", stock.outDate) : null
            stockMainBusinessInfo.isNew = stock.isNew
            stockMainBusinessInfo.industryID1 = stock.industryID1 ?: null
            stockMainBusinessInfo.industryName1 = stock.industryName1 ?: null
            stockMainBusinessInfo.industryID2 = stock.industryID2 ?: null
            stockMainBusinessInfo.industryName2 = stock.industryName2 ?: null
            stockMainBusinessInfo.industryID3 = stock.industryID3 ?: null
            stockMainBusinessInfo.industryName3 = stock.industryName3 ?: null
            stockMainBusinessInfo.industryName4 = stock.industryName4 ?: null
            stockMainBusinessInfo.industryName4 = stock.industryName4 ?: null
            if (stockMainBusinessInfo.isNew) {
                if (!stockMainBusinessInfo.save(flush: true)) {
                    stockMainBusinessInfo.errors.each {
                        stockMainBusinessInfo.stockCode
                    }
                }
            }
        }
    }
}
