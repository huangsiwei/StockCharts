package datacrawler

import stockcharts.CompanyBasicInfoCrawlerService

class CompanyBasicInfoCrawlerController {

    CompanyBasicInfoCrawlerService companyBasicInfoCrawlerService

    def index() {}

    def fetchCompanyRegionInfo () {
        companyBasicInfoCrawlerService.fetchCompanyRegionInfo("SZ300005")
    }

}
