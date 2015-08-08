package datacrawler

class DataHandlerController {

    def dataHandlerService

    def index() {}

    def initIndustryData() {
        dataHandlerService.initIndustryData()
    }

    def addListDateToStockRegionInfo () {
        dataHandlerService.addListDateToStockRegionInfo()
    }
}
