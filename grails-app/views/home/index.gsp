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
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Agency - Start Bootstrap Theme</title>

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
        }
    </style>

</head>
<body id="page-top" class="index">

<!-- Navigation -->
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header page-scroll">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand page-scroll" href="#page-top">Stock Charts</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li class="hidden">
                    <a href="#page-top"></a>
                </li>
                <li>
                    <a class="page-scroll" href="#portfolio">More</a>
                </li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
</nav>

<!-- Header -->
<header>
    <div class="container">
        <div class="intro-text">
            <div class="intro-heading">Stock Charts!</div>
            <a href="#portfolio" class="page-scroll btn btn-xl" style="padding: 10px 20px;">基本面数据的图形化展现</a>
        </div>
    </div>
</header>

<!-- Portfolio Grid Section -->
<section id="portfolio" class="bg-light-gray">
    <div class="container">
        <div class="row">
            <div class="col-md-4 col-sm-4 portfolio-item">
                <a href="${createLink(controller: 'stockFinancialInfo',action: 'index')}" class="portfolio-link">
                    <img src="${resource(dir:"images",file: "chart.jpg")}" class="img-responsive" alt="">
                </a>
                <div class="portfolio-caption">
                    <h4>业绩趋势图</h4>
                </div>
            </div>

            <div class="col-md-4 col-sm-4 portfolio-item">
                <a href="${createLink(controller: 'stockFinancialInfo',action: 'financialInfoByIndustryFilter')}" class="portfolio-link">
                    <img src="${resource(dir:"images",file: "chart.jpg")}" class="img-responsive" alt="">
                </a>
                <div class="portfolio-caption">
                    <h4>业绩趋势图(按行业分类)</h4>
                </div>
            </div>

            <div class="col-md-4 col-sm-4 portfolio-item">
                <a href="${createLink(controller: 'stockFinancialInfo',action: 'financialInfoRadar')}" class="portfolio-link">
                    <img src="${resource(dir:"images",file: "chart.jpg")}" class="img-responsive" alt="">
                </a>
                <div class="portfolio-caption">
                    <h4>个股业绩雷达图</h4>
                </div>
            </div>

        </div>
    </div>
</section>

<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4">

            </div>
            <div class="col-md-4">

            </div>
            <div class="col-md-4">

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


</body>
</html>