/**
 * Created by huangsiwei on 15/8/23.
 */
public enum StockChartType {


//    regionDistribution("地域分布图","regionDistributionChart","companyRegionDistribution","index"),
//    mainBusinessPieChart("主营业务分布图","mainBusinessPieChart","stockBasicInfo","mainBusinessInfo"),
    financialInfoTrendChart("业绩趋势图","financialInfoTrendChart","stockFinancialInfo","index"),
//    financialInfoTrendChartByIndustryFilter("业绩趋势图(按行业分类)","financialInfoTrendChartByIndustryFilter","stockFinancialInfo","financialInfoByIndustryFilter"),
    financialInfoRadarChart("个股业绩雷达图","financialInfoRadarChart","stockFinancialInfo","financialInfoRadar")

    final String chartName
    final String chartKey
    final String chartController
    final String chartAction

    StockChartType (String chartName,String chartKey,String chartController,String chartAction) {
        this.chartName = chartName
        this.chartKey = chartKey
        this.chartController = chartController
        this.chartAction = chartAction
    }

}