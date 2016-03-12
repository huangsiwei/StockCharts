package report

/**
 * Created by huangsiwei on 15/8/9.
 */
class ReportConstant {

    public static final Map STOCK_FINANCIAL_INDEXES = new HashMap();
    public static final List STOCK_FINANCIAL_INDEX_KEYS = new ArrayList();
    //精确到日期，供查询数据试用
    public static final List STOCK_CHART_YEAR_LIST = new ArrayList();

    public static final List TOP10_BASICEPS_STOCK_LIST = new ArrayList();

    static {

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

        STOCK_CHART_YEAR_LIST.add(new Date("2006/12/31"))
        STOCK_CHART_YEAR_LIST.add(new Date("2007/12/31"))
        STOCK_CHART_YEAR_LIST.add(new Date("2008/12/31"))
        STOCK_CHART_YEAR_LIST.add(new Date("2009/12/31"))
        STOCK_CHART_YEAR_LIST.add(new Date("2010/12/31"))
        STOCK_CHART_YEAR_LIST.add(new Date("2011/12/31"))
        STOCK_CHART_YEAR_LIST.add(new Date("2012/12/31"))
        STOCK_CHART_YEAR_LIST.add(new Date("2013/12/31"))
        STOCK_CHART_YEAR_LIST.add(new Date("2014/12/31"))
        STOCK_CHART_YEAR_LIST.add(new Date("2015/12/31"))

        TOP10_BASICEPS_STOCK_LIST.add("贵州茅台")
        TOP10_BASICEPS_STOCK_LIST.add("大商股份")
        TOP10_BASICEPS_STOCK_LIST.add("葵花药业")
        TOP10_BASICEPS_STOCK_LIST.add("中国平安")
        TOP10_BASICEPS_STOCK_LIST.add("格力电器")
//        TOP10_BASICEPS_STOCK_LIST.add("大商股份")
//        TOP10_BASICEPS_STOCK_LIST.add("厚普股份")
//        TOP10_BASICEPS_STOCK_LIST.add("飞天诚信")
//        TOP10_BASICEPS_STOCK_LIST.add("春秋航空")
//        TOP10_BASICEPS_STOCK_LIST.add("迅游科技")
    }
}
