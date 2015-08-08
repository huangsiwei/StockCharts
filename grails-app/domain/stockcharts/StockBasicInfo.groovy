package stockcharts

class StockBasicInfo {

    String stockName
    String stockCode
    String exchangeCD
    String assetClass
    String listStatusCD
    Date listDate

    static constraints = {
        stockName nullable: false
        stockCode nullable: false
        exchangeCD nullable: false
        assetClass nullable: false
        listStatusCD nullable: true
        listDate nullable: true
    }
}
