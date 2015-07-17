package stockcharts

class StockMainBusinessInfo {

    String stockName
    String stockCode

    String industry             //行业分类标准
    String industryID           //行业分类编码
    String industrySymbol       //行业分类编码，行业编制机构发布的行业编码
    Date intoDate               //成分纳入日期
    Date outDate                //成分剔除日期
    boolean isNew               //是否最新
    String industryID1
    String industryName1
    String industryID2
    String industryName2
    String industryID3
    String industryName3
    String industryID4
    String industryName4

    static constraints = {
        stockName nullable: false
        stockCode nullable: false
        intoDate nullable: false

        outDate nullable: true
        industryID1 nullable: true
        industryName1 nullable: true
        industryID2 nullable: true
        industryName2 nullable: true
        industryID3 nullable: true
        industryName3 nullable: true
        industryID4 nullable: true
        industryName4 nullable: true
    }
}
