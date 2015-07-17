package datacrawler.tongliandata

import base.Region
import stockcharts.StockRegionInfo
import tongliandata.StockBasicInfoCrawlerService

class StockBasicInfoDataCrawlerController {

    StockBasicInfoCrawlerService stockBasicInfoCrawlerService

    def index() {}

    //TODO:十大流通股股东通过sina接口调用
    //Example:http://vip.stock.finance.sina.com.cn/corp/go.php/vCI_StockHolder/stockid/300005/displaytype/30.phtml
    def top10StockHolder() {

    }

    //取得地域MAP信息
    def fetchRegionInfo() {
        stockBasicInfoCrawlerService.fetchRegionInfo()
        render "OK"
    }

    //获取所有股票的地域信息
    def fetchAllStockRegionInfo () {
        stockBasicInfoCrawlerService.fetchAllStockRegionInfo()
        render "OK"
    }

    //获取所有股票的所在省份
    def matchStockProvinceData() {
        StockRegionInfo.list().each { stockRegionInfo ->
            Region region = Region.findByName(stockRegionInfo.cityRegion)
            if (region.level == 6) {
                stockRegionInfo.provinceRegion = region.parent.aliasNameMap
                stockRegionInfo.save()
            }
        }
    }

    def fetchStockMainBusinessInfo() {
        (1..100).each {
            String stockCode = (300000 + it).toString()
            stockBasicInfoCrawlerService.fetchStockMainBusinessInfo(stockCode)
        }
    }
}