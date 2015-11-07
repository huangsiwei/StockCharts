package stockcharts

class HomeController {

    def index() {

    }

    def index2() {
        redirect(controller: 'stockFinancialInfo',action: 'index')
    }
}
