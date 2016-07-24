<style>
.nav.navbar-nav.navbar-right > li > .active > button {
    border-radius: 3px;
    color: #fff;
    background-color: #fea836;
    border: 0px;
    padding-top: 10px;
    padding-bottom: 10px;
}

.nav.navbar-nav.navbar-right > li > .active > button:hover,
.nav.navbar-nav.navbar-right > li > .active > button:focus {
    color: #fff;
    background-color: #fea836;
    border: 0px;
}

.navbar-default .nav li a {
    color: #000;
}

.navbar-default .nav li a:hover,
.navbar-default .nav li a:focus {
    outline: 0;
    color: #848484;
}

.nav.navbar-nav.navbar-right > li > .active > button {
    margin-top: 5px;
    padding-top: 5px;
    padding-bottom: 5px;
}

.navbar-right {
    margin-top: 10px;
}



/*.navbar-default .navbar-brand:hover {*/
    /*color: rgba(216, 216, 216, 0.83);*/
    /*font-weight: bold;*/
/*}*/


</style>

<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header page-scroll">
            <a class="navbar-brand page-scroll" href="${createLink(controller: 'home',action: 'index')}">Stock Graph</a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <div class="active btn-group btn-group-xs">
                        <button type="button" class="btn page-scroll btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
                            更多图表
                        </button>
                        <ul class="dropdown-menu">
                            <g:each in="${StockChartType}" var="chart">
                                <li><a href="${createLink(controller: "${chart.chartController}",action: "${chart.chartAction}")}">${chart.chartName}</a></li>
                            </g:each>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div style="height: 50px"></div>

<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?0c0b5113d101bcca87968935c57f8cbe";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
