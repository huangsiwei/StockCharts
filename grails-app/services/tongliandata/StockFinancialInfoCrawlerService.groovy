package tongliandata

import grails.converters.JSON
import grails.transaction.Transactional
import org.apache.http.HttpEntity
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpGet
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.params.CoreConnectionPNames
import org.apache.http.util.EntityUtils
import stockcharts.StockFinancialInfo

@Transactional
class StockFinancialInfoCrawlerService {

    def fetchStockFinancialInfo(String stockCode) {
        String url = "https://api.wmcloud.com/data/v1/api/fundamental/getFdmtIS.json?ticker=" + stockCode + "&secID=&beginDate=&endDate=&publishDateBegin=&publishDateEnd=&reportType=&field="
        HttpClient httpClient = new DefaultHttpClient()
        httpClient.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT,10000)
        httpClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT,10000)
        try {
            HttpGet httpGet = new HttpGet(url)
            httpGet.addHeader("Authorization", "Bearer 5c97761c5f15ec4d41eef90557588fa3b2e0fb1ccb104ff18158cd1ba3319139")
            def response = httpClient.execute(httpGet)
            HttpEntity entity = response.getEntity()
            String body = EntityUtils.toString(entity)
            JSON.parse(body).data.each { financialReport ->
                StockFinancialInfo stockFinancialInfo = new StockFinancialInfo()
                stockFinancialInfo.stockCode = stockCode
                stockFinancialInfo.stockName = financialReport.secShortName
                stockFinancialInfo.reportType = financialReport.reportType
                stockFinancialInfo.exchangeCD = financialReport.exchangeCD
                stockFinancialInfo.endDate = new Date().parse("yyyy-MM-dd", financialReport.endDate)
                stockFinancialInfo.actPubtime = new Date().parse("yyyy-MM-dd", financialReport.actPubtime)
                stockFinancialInfo.fiscalPeriod = financialReport.fiscalPeriod as int
                stockFinancialInfo.tRevenue = financialReport.tRevenue ? financialReport.tRevenue as Float : null
                stockFinancialInfo.revenue = financialReport.revenue ? financialReport.revenue as Float : null
                stockFinancialInfo.operateProfit = financialReport.operateProfit ? financialReport.operateProfit as Float : null
                stockFinancialInfo.noperateIncome = financialReport.NoperateIncome ? financialReport.NoperateIncome as Float : null
                stockFinancialInfo.noperateExp = financialReport.NoperateExp ? financialReport.NoperateExp as Float : null
                stockFinancialInfo.tProfit = financialReport.TProfit ? financialReport.TProfit as Float : null
                stockFinancialInfo.nIncome = financialReport.NIncome ? financialReport.NIncome as Float : null
                stockFinancialInfo.basicEPS = financialReport.basicEPS ? financialReport.basicEPS as Float : null
                stockFinancialInfo.cogs = financialReport.COGS ? financialReport.COGS as Float : null
                stockFinancialInfo.investIncome = financialReport.investIncome ? financialReport.investIncome as Float : null
                stockFinancialInfo.save(flush: true)
            }
        } catch (Exception e) {
            e.printStackTrace()
            println("exception occured:" + stockCode)
        }
    }
}
