package stockcharts

class StockRegionInfo {

    String stockName
    String provinceRegion
    String stockCode
    String cityRegion
    Integer level

    static constraints = {
        stockName nullable: false
        stockCode nullable: false
        provinceRegion nullable: true
        cityRegion nullable: true
    }
}