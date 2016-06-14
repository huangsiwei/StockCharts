<%--
  Created by IntelliJ IDEA.
  User: huangsiwei
  Date: 16/6/12
  Time: 下午2:53
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'stocks-icon.png')}" type="image/x-icon">
    <title>公司基本面数据详情</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="公司基本面数据详情">
    <meta name="author" content="StockGraph">
    <!-- Custom CSS -->
    <link href="${resource(dir: "bootstrap-template/css", file: "agency.css")}" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'loader.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/fonts/linecons/css/', file: 'linecons.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/fonts/fontawesome/css/', file: 'font-awesome.min.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/', file: 'bootstrap.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/', file: 'xenon-core.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/', file: 'xenon-forms.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/', file: 'xenon-components.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/', file: 'xenon-skins.css')}">
    <!-- Imported styles on this page -->
    %{--<link rel="stylesheet" href="${resource(dir: 'assets/js/select2/', file: 'select2.css')}">--}%
    <link rel="stylesheet" href="${resource(dir: 'assets/js/select2/', file: 'select2-bootstrap.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/js/multiselect/css/', file: 'multi-select.css')}">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.2-rc.1/css/select2.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${resource(dir: 'assets/css/', file: 'custom.css')}">
</head>

<body>
<g:render template="/layouts/navbar"></g:render>

<div class="row">
    <div class="col-sm-offset-1 col-sm-10">
        <div class="panel panel-default">
            <div class="panel-body">
                %{--<h2 class="title" style="text-align: center;margin-bottom: 18px;color: #5084c4">公司基本面数据趋势图</h2>--}%
                <div class="col-sm-4">

                    <div class="xe-widget xe-counter-block" data-count=".num" data-from="0" data-to="99.9"
                         data-suffix="%" data-duration="2">
                        <div class="xe-upper">

                            <div class="xe-icon">
                                <i class="fa-thumbs-o-up"></i>
                            </div>

                            <div class="xe-label">
                                <strong class="num">19倍</strong>
                                <span>市盈率</span>
                            </div>

                        </div>

                        <div class="xe-lower">
                            <div class="border"></div>

                            <span>行业平均</span>
                            <strong>25倍</strong>
                        </div>
                    </div>

                </div>

                %{--http://cj.gw.com.cn/news/stock/sh600000/gbgd.shtml--}%
                <div class="col-sm-4">

                    <div class="xe-widget xe-counter-block xe-counter-block-blue" data-suffix="k" data-count=".num"
                         data-from="0" data-to="310" data-duration="4" data-easing="false">
                        <div class="xe-upper">

                            <div class="xe-icon">
                                <i class="linecons-user"></i>
                            </div>

                            <div class="xe-label">
                                <strong class="num">272085</strong>
                                <span>总股东户数</span>
                            </div>

                        </div>

                        <div class="xe-lower">
                            <div class="border"></div>

                            <span>环比增减</span>
                            <strong>-140328</strong>
                        </div>
                    </div>
                </div>
            </div>
            %{--http://webf10.gw.com.cn/SZ/B3/SZ300015_B3.html 主营环形图 负数占内环--}%
            %{--TODO:--}%
        </div>
    </div>
</div>

</body>
</html>