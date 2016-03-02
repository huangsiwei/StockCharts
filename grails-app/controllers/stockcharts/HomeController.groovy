package stockcharts

class HomeController {

    def index() {
        redirect(controller: 'stockFinancialInfo',action: 'index')
    }

    def index2() {
        redirect(controller: 'stockFinancialInfo',action: 'index')
    }
}
