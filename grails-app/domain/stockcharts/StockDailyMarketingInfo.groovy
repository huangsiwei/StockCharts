package stockcharts

class StockDailyMarketingInfo {

    String stockCode
    String secShortName
    String exchangeCD
    Date tradeDate
    Float preClosePrice
    Float actPreClosePrice
    Float openPrice
    Float highestPrice
    Float lowestPrice
    Float closePrice
    Float turnoverVol
    Float turnoverValue
    long dealAmount
    Float turnoverRate
    Float negMarketValue
    Float marketValue
    boolean isOpen = true

    static constraints = {
        tradeDate nullable: true
        preClosePrice nullable: true
        actPreClosePrice nullable: true
        openPrice nullable: true
        highestPrice nullable: true
        lowestPrice nullable: true
        closePrice nullable:true
        turnoverVol nullable: true
        turnoverValue nullable:true
        dealAmount nullable: true
        turnoverRate nullable:true
        negMarketValue nullable: true
        marketValue nullable: true
    }
}
