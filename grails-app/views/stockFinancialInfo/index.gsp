<%--
  Created by IntelliJ IDEA.
  User: huangsiwei
  Date: 15/7/7
  Time: 下午11:13
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>上司公司财务数据趋势图</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap Core CSS -->
    <link href="${resource(dir: "bootstrap-template/css",file: "bootstrap.min.css")}" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="${resource(dir: "bootstrap-template/css",file: "agency.css")}" rel="stylesheet">

    <link href="${resource(dir: "bootstrap-template/font-awesome/css",file: "font-awesome.min.css")}" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

    <script src="${resource(dir: 'js', file: 'jquery-1.11.1.min.js')}"></script>
    <script src="${resource(dir: "bootstrap-template/js",file: "bootstrap.min.js")}"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="${resource(dir:'js',file: 'select2.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}">

    <title></title>
</head>

<body>

<g:render template="/layouts/navbar"></g:render>

<h1 align="center">上司公司财务数据趋势图</h1>

<div style="width: 700px; margin: 40px auto">
    <select name="stockCodes" multiple="multiple" style="width: 400px;">
        <g:each in="${stockFinancialInfoMap}" var = "stockFinancialInfo" >
            <option value="${stockFinancialInfo.key}">${stockFinancialInfo.value}</option>
        </g:each>
    </select>
    <select name="index" style="width: 160px;">
        <option value="basicEPS" selected>基本每股收益</option>
        <option value="nIncome">净利润</option>
        <option value="tProfit">利润总额</option>
        <option value="tRevenue">营业总收入</option>
        <option value="revenue">营业收入</option>
        <option value="operateProfit">营业利润</option>
        <option value="noperateIncome">营业外收入</option>
        <option value="noperateExp">营业外支出</option>
    </select>
    <button class="btn btn-success btn-sm" onclick="loadStockFinancialInfoChart()">
        查询
    </button>
</div>

<div id="stockFinancialInfoChart" style="height:500px;width: 800px;margin: 40px auto"></div>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

<script type="text/javascript">
    $(function () {
        $('[name=stockCodes]').select2();
        $('[name=index]').select2();
    });

    function loadStockFinancialInfoChart() {
        var stockCodes = $('[name=stockCodes]').val();
        var index = $('[name=index]').val();
        $.ajax({
            url:"${createLink(controller: 'stockFinancialInfo',action: 'loadStockFinancialInfoData')}",
            data:{stockCodes:stockCodes,index:index},
            dataType:"json",
            success: function (jsonObj) {
                var seriesDataList = [];
                var xAxisData = [];
                var legendDataList = [];
                for (var i = 0; i < jsonObj.dataList.length; i++) {
                    var seriesData = new Object();
                    seriesData.name= jsonObj.dataList[i].stockName;
                    seriesData.type = 'line';
                    seriesData.data = jsonObj.dataList[i].indexDataList;
                    seriesDataList.push(seriesData);
                    legendDataList.push(seriesData.name);
                }
                for (var i = 0; i < jsonObj.yearList.length; i++) {
                    xAxisData.push(jsonObj.yearList[i]);
                }

                require.config({
                    paths: {
                        echarts: 'http://echarts.baidu.com/build/dist'
                    }
                });

                // 使用
                require(
                        [
                            'echarts',
                            'echarts/chart/line'
                        ],
                        function (ec) {
                            var myChart = ec.init(document.getElementById('stockFinancialInfoChart'));

                            var option = {
                                tooltip : {
                                    trigger: 'axis',
                                    formatter: function (parmas) {
                                        return toolTipFormatter(index,parmas);
                                    }
                                },
                                legend: {
                                    data:legendDataList
                                },
                                calculable:false,
                                toolbox: {
                                    show: false,
                                    orient : 'vertical',
                                    x: 'right',
                                    y: 'center',
                                    feature : {
                                        mark : {show: true},
                                        dataView : {show: true, readOnly: false},
                                        restore : {show: true},
                                        saveAsImage : {show: true}
                                    }
                                },
                                xAxis : [
                                    {
                                        type : 'category',
                                        boundaryGap : false,
                                        data : xAxisData
                                    }
                                ],
                                yAxis : [
                                    {
                                        type : 'value'
                                    }
                                ],
                                series : seriesDataList
                            };
                            myChart.setTheme('macarons');
                            myChart.setOption(option);
                        }
                );
            },
            error: function (error) {
                console.log(error);
            }
        })
    }

    function toolTipFormatter(index,params) {
        var res = "";
        switch (index) {
            case "basicEPS":
                for (var i = 0;i<params.length;i++) {
                    res = res + params[i].seriesName +": " + params[i].data + " " + "元/每股" + "<br>"
                }
                break;
            case "nIncome":
                for (var i = 0;i<params.length;i++) {
                    res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
                }
                break;
            case "tProfit":
                for (var i = 0;i<params.length;i++) {
                    res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
                }
                break;
            case "tRevenue":
                for (var i = 0;i<params.length;i++) {
                    res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
                }
                break;
            case "revenue":
                for (var i = 0;i<params.length;i++) {
                    res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
                }
                break;
            case "operateProfit":
                for (var i = 0;i<params.length;i++) {
                    res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
                }
                break;
            case "noperateIncome":
                for (var i = 0;i<params.length;i++) {
                    res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
                }
                break;
            case "noperateExp":
                for (var i = 0;i<params.length;i++) {
                    res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
                }
                break;
        }
        return res
    }
</script>
<script type="text/javascript">
    // 路径配置

</script>
</body>
</html>