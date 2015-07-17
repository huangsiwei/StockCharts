package stockcharts

class StockFinancialInfo {

    String stockName
    String stockCode

    Date endDate            //截止日期
    Date actPubtime         //实际披露时间
    Integer fiscalPeriod    //会计期间
    Float tRevenue          //营业总收入
    Float revenue           //营业收入
    Float operateProfit     //营业利润
    Float noperateIncome    //营业外收入
    Float noperateExp       //营业外支出
    Float tProfit           //利润总额
    Float nIncome           //净利润
    Float basicEPS          //基本每股收益

    static constraints = {
        tRevenue nullable: true
        revenue nullable: true
        operateProfit nullable: true
        noperateIncome nullable: true
        noperateExp nullable: true
        tProfit nullable: true
        nIncome nullable: true
        basicEPS nullable: true
    }
}
