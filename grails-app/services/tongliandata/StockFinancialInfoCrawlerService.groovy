package tongliandata

import grails.converters.JSON
import grails.transaction.Transactional
import org.apache.http.HttpEntity
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpGet
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils
import stockcharts.StockFinancialInfo

@Transactional
class StockFinancialInfoCrawlerService {

    def fetchStockFinancialInfo(String stockCode) {
        String url = "https://api.wmcloud.com/data/v1/api/fundamental/getFdmtIS.json?ticker=" + stockCode + "&secID=&beginDate=&endDate=&publishDateBegin=&publishDateEnd=&reportType=&field="
        HttpClient httpClient = new DefaultHttpClient()
        HttpGet httpGet = new HttpGet(url)
        httpGet.addHeader("Authorization", "Bearer 5c97761c5f15ec4d41eef90557588fa3b2e0fb1ccb104ff18158cd1ba3319139")
        def response = httpClient.execute(httpGet)
        HttpEntity entity = response.getEntity()
        String body = EntityUtils.toString(entity)
        JSON.parse(body).data.each{ financialReports ->
            if (12 == (financialReports.fiscalPeriod as int)) {
                StockFinancialInfo stockFinancialInfo = new StockFinancialInfo()
                stockFinancialInfo.stockCode = stockCode
                stockFinancialInfo.stockName = financialReports.secShortName
                stockFinancialInfo.endDate = new Date().parse("yyyy-MM-dd",financialReports.endDate)
                stockFinancialInfo.actPubtime = new Date().parse("yyyy-MM-dd",financialReports.actPubtime)
                stockFinancialInfo.fiscalPeriod = financialReports.fiscalPeriod as int
                stockFinancialInfo.tRevenue = financialReports.tRevenue? financialReports.tRevenue as Float: null
                stockFinancialInfo.revenue = financialReports.revenue?financialReports.revenue as Float:null
                stockFinancialInfo.operateProfit = financialReports.operateProfit?financialReports.operateProfit as Float:null
                stockFinancialInfo.noperateIncome = financialReports.NoperateIncome?financialReports.NoperateIncome as Float:null
                stockFinancialInfo.noperateExp = financialReports.NoperateExp?financialReports.NoperateExp as Float:null
                stockFinancialInfo.tProfit = financialReports.TProfit?financialReports.TProfit as Float:null
                stockFinancialInfo.nIncome = financialReports.NIncome?financialReports.NIncome as Float:null
                stockFinancialInfo.basicEPS = financialReports.basicEPS?financialReports.basicEPS as Float:null
                stockFinancialInfo.save(flush: true)
            }
        }
    }
}
