package report

/**
 * Created by huangsiwei on 15/8/9.
 */
class ReportConstant {

    public static final Map CHART_TYPE_INDEXES = new HashMap();
    public static final List CHART_TYPE_INDEX_KEYS = new ArrayList();

    public static final Map STOCK_FINANCIAL_INDEXES = new HashMap();
    public static final List STOCK_FINANCIAL_INDEX_KEYS = new ArrayList();

    static {

        CHART_TYPE_INDEX_KEYS.add("regionDistributionChart")
        CHART_TYPE_INDEX_KEYS.add("mainBusinessPieChart")
        CHART_TYPE_INDEX_KEYS.add("financialInfoTrendChart")
        CHART_TYPE_INDEX_KEYS.add("financialInfoTrendChartByIndustryFilter")
        CHART_TYPE_INDEX_KEYS.add("financialInfoRadarChart")

        CHART_TYPE_INDEXES.put("regionDistributionChart","地域分布图")
        CHART_TYPE_INDEXES.put("mainBusinessPieChart","主营业务分布图")
        CHART_TYPE_INDEXES.put("financialInfoTrendChart","业绩趋势图")
        CHART_TYPE_INDEXES.put("financialInfoTrendChartByIndustryFilter","业绩趋势图(按行业分类)")
        CHART_TYPE_INDEXES.put("financialInfoRadarChart","个股业绩雷达图")

        STOCK_FINANCIAL_INDEX_KEYS.add("basicEPS")
        STOCK_FINANCIAL_INDEX_KEYS.add("nIncome")
        STOCK_FINANCIAL_INDEX_KEYS.add("tProfit")
        STOCK_FINANCIAL_INDEX_KEYS.add("tRevenue")
        STOCK_FINANCIAL_INDEX_KEYS.add("revenue")
        STOCK_FINANCIAL_INDEX_KEYS.add("operateProfit")
        STOCK_FINANCIAL_INDEX_KEYS.add("noperateIncome")
        STOCK_FINANCIAL_INDEX_KEYS.add("noperateExp")

        STOCK_FINANCIAL_INDEXES.put("basicEPS","基本每股收益")
        STOCK_FINANCIAL_INDEXES.put("nIncome","净利润")
        STOCK_FINANCIAL_INDEXES.put("tProfit","利润总额")
        STOCK_FINANCIAL_INDEXES.put("tRevenue","营业总收入")
        STOCK_FINANCIAL_INDEXES.put("revenue","营业收入")
        STOCK_FINANCIAL_INDEXES.put("operateProfit","营业利润")
        STOCK_FINANCIAL_INDEXES.put("noperateIncome","营业外收入")
        STOCK_FINANCIAL_INDEXES.put("noperateExp","营业外支出")
    }
}
