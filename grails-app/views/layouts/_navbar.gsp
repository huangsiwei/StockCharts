<style>
.nav.navbar-nav.navbar-right > li > .active > button {
    border-radius: 3px;
    color: #fff;
    background-color: #fed136;
    border: 0px;
    padding-top: 10px;
    padding-bottom: 10px;
}

.nav.navbar-nav.navbar-right > li > .active > button:hover,
.nav.navbar-nav.navbar-right > li > .active > button:focus {
    color: #fff;
    background-color: #fec503;
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


</style>

<nav class="navbar navbar-default navbar-fixed-top navbar-shrink">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header page-scroll">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand page-scroll" href="${createLink(controller: 'home',action: 'index')}">Stock Charts</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <div class="active btn-group">
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

            <!-- Single button -->

        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>

<div style="height: 80px"></div>

<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?0c0b5113d101bcca87968935c57f8cbe";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>
