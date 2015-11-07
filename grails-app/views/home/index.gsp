<%--
  Created by IntelliJ IDEA.
  User: huangsiwei
  Date: 15/7/22
  Time: 上午1:46
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <meta charset="utf-8">
    <meta name="baidu-site-verification" content="84ZsVrPj4D"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="shortcut icon" href="${resource(dir: 'images',file: 'stocks-icon.png')}" type="image/x-icon">

    <title>Stock Graph 股票基本面信息的图表展现</title>

    <!-- Bootstrap Core CSS -->
    <link href="${resource(dir: "bootstrap-template/css",file: "bootstrap.min.css")}" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${resource(dir: "bootstrap-template/css",file: "agency.css")}" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="${resource(dir: "bootstrap-template/font-awesome/css",file: "font-awesome.min.css")}" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style>
        header {
            background-color: rgba(255,0,0,0.85);
            height: 100%;
        }

        #portfolio {
            padding-bottom: 70px;
            height: 100%;
        }

        .chart-desc {
            margin: 15px 5px 5px 5px;
            /*border-color: #cccccc;*/
            /*border-width: 1px;*/
            /*border-style:solid;*/
        }

        footer {
            height: 70px;
            position: relative;
            margin-top: -70px;
            background-color: #ffffff;
        }
    </style>

</head>
<body id="page-top" class="index">

<!-- Navigation -->
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
            <a class="navbar-brand page-scroll" href="#page-top">Stock Graph</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li class="hidden">
                    <a href="#page-top"></a>
                </li>
                <li>
                    <a class="page-scroll" href="#second-page" style="background-color: #fed136;border-radius:5px">More</a>
                </li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>

<!-- Header -->
%{--<header>--}%
    %{--<div class="container">--}%
        %{--<div class="intro-text">--}%
            %{--<div class="intro-heading">Stock Graph!</div>--}%
            %{--<a href="#portfolio" class="page-scroll btn btn-xl" style="padding: 10px 20px;">基本面数据的图形化展现</a>--}%
        %{--</div>--}%
    %{--</div>--}%
%{--</header>--}%

<div class="second-page" id="second-page">
    <!-- Portfolio Grid Section -->
    <section id="portfolio" class="bg-light-gray">
        <div class="container">
            <div class="row">

                <div style="margin-left: auto;margin-right: auto;width: 100%">
                    <div class="col-md-6 portfolio-item">
                        <div class="portfolio-caption" style="margin-left: auto;margin-right: auto;">
                            <a href="${createLink(controller: 'stockFinancialInfo', action: 'index')}">
                                <h3>股票业绩趋势折线图</h3>
                            </a>
                            <div class="chart-desc">
                                <p>选择一只或多只股票，查看它们的基本面指标</p>
                                <img alt="股票基本面 业绩 折线图" src="${resource(dir: 'images',file: 'line-chart.png')}" style="width: 100%">
                            </div>
                        </div>
                    </div>

                    %{--<div class="col-md-4 portfolio-item">--}%
                        %{--<div class="portfolio-caption">--}%
                            %{--<a href="${createLink(controller: 'stockFinancialInfo', action: 'financialInfoByIndustryFilter')}">--}%
                                %{--<h4>同行业业绩折线图</h4>--}%
                            %{--</a>--}%
                            %{--<div class="chart-desc">--}%
                                %{--<p>选择一个行业，查看它们的基本面指标</p>--}%
                            %{--</div>--}%
                        %{--</div>--}%
                    %{--</div>--}%

                    <div class="col-md-6 portfolio-item">
                        <div class="portfolio-caption" style="margin-left: auto;margin-right: auto;">
                            <a href="${createLink(controller: 'stockFinancialInfo', action: 'financialInfoRadar')}">
                                <h3>股票业绩雷达图</h3>
                            </a>
                            <div class="chart-desc">
                                <p>选择多只股票，同时比较它们的多种基本面指标</p>
                                <img alt="股票 基本面 业绩雷达图" src="${resource(dir: 'images',file: 'web-chart.png')}" style="width: 100%">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-2">

            </div>
            <div class="col-md-8">
                需要更多功能？发送邮件到 stockgraph@sina.com 我来帮你实现！
            </div>
            <div class="col-md-2">

            </div>
        </div>
    </div>
</footer>



<!-- jQuery -->
<script src="${resource(dir: 'js', file: 'jquery-1.11.1.min.js')}"></script>

<!-- Bootstrap Core JavaScript -->
<script src="${resource(dir: "bootstrap-template/js",file: "bootstrap.min.js")}"></script>

<!-- Plugin JavaScript -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
<script src="${resource(dir: "bootstrap-template/js",file: "classie.js")}"></script>
<script src="${resource(dir: "bootstrap-template/js",file: "cbpAnimatedHeader.js")}"></script>

<!-- Contact Form JavaScript -->
<script src="${resource(dir: "bootstrap-template/js",file: "jqBootstrapValidation.js")}"></script>
<script src="${resource(dir: "bootstrap-template/js",file: "contact_me.js")}"></script>

<!-- Custom Theme JavaScript -->
<script src="${resource(dir: "bootstrap-template/js",file: "agency.js")}"></script>

<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?0c0b5113d101bcca87968935c57f8cbe";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>


</body>
</html>