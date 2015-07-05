package tongliandata

import base.Region
import grails.converters.JSON
import grails.transaction.Transactional
import org.apache.http.HttpEntity
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpGet
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils
import stockcharts.StockRegionInfo

@Transactional
class StockBasicInfoCrawlerService {

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
}
