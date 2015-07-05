package stockcharts

import grails.transaction.Transactional

@Transactional
class CompanyBasicInfoCrawlerService {

    def fetchCompanyRegionInfo(String stockCode) {
        String companyBasicInfoUrl = "http://xueqiu.com/stock/f10/compinfo.json?symbol=" + stockCode + "&page=1&size=4" //"http://xueqiu.com/S/" + stockCode + "/GSJJ"
        String companyRegion = ""
        def data = new URL("http://xueqiu.com/stock/f10/compinfo.json?symbol=SZ300001")
                .getText(
                requestProperties: [
                        'Accept'         : 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
                        'Accept-Encoding': 'gzip, deflate, sdch',
                        'Accept-Language': 'zh-CN,zh;q=0.8,en;q=0.6',
                        'Cache-Control'  : 'max-age=0',
                        'Connection'     : 'keep-alive',
                        'Host'           : 'xueqiu.com',
                        'User-Agent'     : 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.130 Safari/537.36',
                        'Cookie'         : 'bid=f352f6291a2509ef66f571b9fdd26602_i9h4toq9; xq_a_token=6de6259bca2605e3c1e9d49b0fdbbd8b47da2ef8; xq_r_token=4a0e2b80fd6bd95c720f29804a548b3dc501b8e8; xq_token_expire=Mon%20Jun%2029%202015%2011%3A32%3A40%20GMT%2B0800%20(CST); xq_is_login=1; s=mnt1254aec; __utma=1.405413696.1431182021.1434953538.1435069093.46; __utmz=1.1434046491.33.4.utmcsr=baidu|utmccn=(organic)|utmcmd=organic|utmctr=site%3Axueqiu.com%20%E5%BB%96%E8%8B%B1%E5%BC%BA; Hm_lvt_1db88642e346389874251b5a1eded6e3=1434859780,1434944788,1434955007,1435069093']
        )
        println(data)
    }
}
