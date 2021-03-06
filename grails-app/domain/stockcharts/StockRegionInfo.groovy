package stockcharts

class StockRegionInfo {

    String stockName
    String stockCode
    String provinceRegion
    String cityRegion
    Integer level
    Date listDate

    static constraints = {
        stockName nullable: false
        stockCode nullable: false
        provinceRegion nullable: true
        cityRegion nullable: true
        listDate nullable: true
    }
}
