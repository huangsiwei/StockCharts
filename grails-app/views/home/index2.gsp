<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="${resource(dir: 'images',file: 'stocks-icon.png')}" type="image/x-icon">

    <title>Stock Graph 图读财报</title>

    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" href="${resource(dir: 'assets/css/', file: 'bootstrap.css')}">

    <!-- Custom CSS -->
    <link href="${resource(dir: "bootstrap-template/css", file: "agency.css")}" rel="stylesheet">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'loader.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/fonts/fontawesome/css/', file: 'font-awesome.min.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/', file: 'bootstrap.css')}">
    <link rel="stylesheet" href="${resource(dir: 'css/', file: 'component.css')}">
    <link rel="stylesheet" href="${resource(dir: 'css/', file: 'jquery.fullPage.css')}">


    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style>
    .echart-symbol {
        width: 200px;
        height: 200px;
        transition: 0.5s;
    }

    .echart-symbol:hover {
        width: 220px;
        height: 220px;
    }

    .copyright {
        float: right;
        color: #dddddd;
        margin-right: 30px;
        margin-top: 15px;
    }

    .footer {
        background-color: #d92231;
        position: absolute;
        bottom: 0%;
        width: 100%;
    }

    .footer .fa {
        font-size: 30px;
        color: #eeeeee;
        margin-top: 10px;
        margin-bottom: 10px;
    }

    .footer .fa:hover {
        color: #e6c400;
    }

    </style>

</head>

<body id="page-top" class="index">

<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header page-scroll">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand page-scroll" href="#page-top">Stock Graph</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li class="hidden">
                    <a href="#page-top"></a>
                </li>
                <li>
                    <a class="page-scroll" href="#services">Services</a>
                </li>
                <li>
                    <a class="page-scroll" href="#about">About</a>
                </li>
                <li>
                    <a class="page-scroll" href="#contact">Feed back</a>
                </li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>

<div id="dowebok">
    <div class="section">
        <!-- Header -->
        <header>
            <div class="container">
                <div class="intro-text">
                    <div class="intro-heading" style="color: #666">Stock Graph</div>

                    <div class="intro-lead-in" style="color: #666">图读财报</div>

                    <div class="intro-description">帮助你从枯燥的财务报表中解脱出来</div>
                    %{--<a href="#services" class="page-scroll btn btn-xl"></a>--}%
                </div>
            </div>
        </header>

    </div>

    <div class="section">
        <!-- Services Section -->
        <div id="services">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h2 class="section-heading">丰富的可视化效果</h2>

                        <h3 class="section-subheading text-muted"></h3>
                    </div>
                </div>

                <div class="row text-center">
                    <div class="col-md-4">
                        <h4 class="service-heading">个股详情</h4>

                        <div style="height: 220px"
                             onclick="window.location.href = '${createLink(controller: 'stockFinancialInfo',action: 'index')}'">
                            <img class="echart-symbol" src="${resource(dir: 'images', file: '1.png')}"/>
                        </div>

                        <p class="text-muted">从过去到现在,展现股票的基本面趋势</p>
                    </div>

                    <div class="col-md-4">
                        <h4 class="service-heading">同业比较</h4>

                        <div style="height: 220px"
                             onclick="window.location.href = '${createLink(controller: 'stockFinancialInfo',action: 'financialInfoByIndustryFilter')}'">
                            <img class="echart-symbol" src="${resource(dir: 'images', file: '2.png')}"/>
                        </div>

                        <p class="text-muted">这支股票的业绩和它的同行相比如何? 更好or更糟?</p>
                    </div>

                    <div class="col-md-4">
                        <h4 class="service-heading">深度挖掘</h4>

                        <div style="height: 220px">
                            <img class="echart-symbol"
                                 onclick="window.location.href = '${createLink(controller: 'stockDetailInfo',action: 'detailInfo')}'"
                                 src="${resource(dir: 'images', file: '6.png')}"/>
                        </div>

                        <p class="text-muted">穿透表面的财务数据,了解背后的事件</p>
                    </div>
                </div>
            </div>

            <div class="footer">
                <div class="row">
                    <div class="col-md-offset-4 col-md-4">
                        <div class="col-md-offset-4 col-md-2">
                            <a href="javascript:;" onclick="showZhifubaoModal()">
                                <i class="fa fa-qrcode"></i>
                            </a>
                        </div>

                        <div class="col-md-6">
                            <a href="javascript:;">
                                <i class="fa fa-question"></i>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <span class="copyright">Copyright &copy; 2016 StockGraph</span>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>


<div class="md-modal md-effect-3" id="modal-zhifubao">
    <div class="md-content">
        <h3>Modal Dialog</h3>
        <div>
            <p>This is a modal window. You can do the following things with it:</p>
            <ul>
                <li><strong>Read:</strong> modal windows will probably tell you something important so don't forget to read what they say.</li>
                <li><strong>Look:</strong> a modal window enjoys a certain kind of attention; just look at it and appreciate its presence.</li>
                <li><strong>Close:</strong> click on the button below to close the modal.</li>
            </ul>
            <button onclick="hiddenZhifubaoModal()" class="md-close">Close me!</button>
        </div>
    </div>
</div>

<script src="${resource(dir: 'js',file: 'jquery-1.11.1.min.js')}"></script>
<script src="${resource(dir: 'js',file: 'jquery.fullPage.min.js')}"></script>
<script>
    $(function () {
        $('#dowebok').fullpage();
    });

    function showZhifubaoModal() {
        $("#modal-zhifubao").addClass("md-show");
    }

    function hiddenZhifubaoModal() {
        $("#modal-zhifubao").removeClass("md-show");
    }
</script>

</body>

</html>
