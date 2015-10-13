<%--
  Created by IntelliJ IDEA.
  User: huangsiwei
  Date: 15/8/9
  Time: 下午1:52
--%>

<%@ page import="report.ReportConstant" contentType="text/html;charset=UTF-8" %>
<html>
<head>

    <title></title>

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
    <script src="${resource(dir: 'js/common', file: 'common.js')}"></script>

</head>

<body>

<g:render template="/layouts/navbar"></g:render>

<h2 align="center">基本面信息雷达图</h2>

<div class="col-md-12" style="padding-top: 10px">
    <div class="col-md-3">

    </div>
    <div class="col-md-6">
        <select name="indexes" style="width: 100%" multiple="multiple">
            <g:each in="${ReportConstant.STOCK_FINANCIAL_INDEX_KEYS}" var="index" status="i">
                    <option value="${index}" <g:if test="${i < 5}"> selected="selected" </g:if> >${ReportConstant.STOCK_FINANCIAL_INDEXES.get(index)}</option>

            </g:each>
        </select>
    </div>
    <div class="col-md-3">

    </div>
</div>

<div class="col-md-12" style="padding-top: 10px">
    <div class="col-md-3">

    </div>
    <div class="col-md-6">
        <select name="stockCodes" style="width: 100%;" multiple="multiple">
            <g:each in="${stockBasicInfoMap}" var = "stockBasicInfo" >
                <option value="${stockBasicInfo.key}">${stockBasicInfo.value}</option>
            </g:each>
        </select>
    </div>
    <div class="col-md-3">
        <button class="btn btn-success btn-sm" onclick="loadStockFinancialInfoRadarChart()">
            查询
        </button>
    </div>
</div>

<div id="stockFinancialInfoRadarChart" style="height:500px;width: 800px;margin: 40px auto">

</div>

</body>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

<script type="text/javascript">
    $(function () {
        $('[name=stockCodes]').select2({
            placeholder:"请添加股票"
        });
        $('[name=indexes]').select2({
            placeholder:"请选择指标"
        });
    });


    function loadStockFinancialInfoRadarChart() {
        var indexes = $("[name=indexes]").val().join();
        var stockCodes = $('[name=stockCodes]').val().join();
        $.ajax({
            url:"${createLink(controller: 'stockFinancialInfo',action: 'loadStockFinancialInfoRadarChart')}",
            data:{indexes:indexes,stockCodes:stockCodes},
            dataType:"json",
            success: function (jsonObj) {
                var polarIndicatorList = [];
                var seriesDataList = [];
                var legendDataList = [];
                for (var i = 0; i < jsonObj.seriesData.length; i++) {
                    var seriesData = new Object();
                    seriesData.name = jsonObj.seriesData[i].name;
                    seriesData.value = jsonObj.seriesData[i].value;
                    seriesDataList.push(seriesData);
                    legendDataList.push(jsonObj.seriesData[i].name);
                }
                for (var i = 0; i < jsonObj.indicatorMapList.length; i++) {
                    var indicatorItem = new Object();
                    indicatorItem.text = jsonObj.indicatorMapList[i].name;
                    indicatorItem.max = jsonObj.indicatorMapList[i].max;
                    polarIndicatorList.push(indicatorItem);
                }

                require.config({
                    paths: {
                        echarts: 'http://echarts.baidu.com/build/dist'
                    }
                });

                require(
                        [
                            'echarts',
                            'echarts/chart/radar'
                        ],
                        function (ec) {
                            var myChart = ec.init(document.getElementById('stockFinancialInfoRadarChart'));

                            var option = {
                                tooltip : {
                                    trigger: 'axis',
                                    formatter: function (params) {
                                        return toolTipFormatter($("[name=indexes]").val(),params);
                                    }
                                },
                                legend: {
                                    orient : 'vertical',
                                    x : 'right',
                                    y : 'bottom',
                                    data:legendDataList
                                },
                                calculable:false,
                                polar : [
                                    {
                                        indicator : polarIndicatorList
                                    }
                                ],
                                series : [
                                    {
                                        type: 'radar',
                                        data : seriesDataList
                                    }
                                ]
                            };
                            myChart.setTheme('macarons');
                            myChart.setOption(option);
                        }
                );
            },
            error:function (error) {
                console.log(error);
            }
        })
    }

    function toolTipFormatter(indexes, params) {
        var res = "";
        for (var i = 0; i < params.length; i++) {
            var unit = "";
            switch (indexes[params[i].dataIndex]) {
                case "basicEPS":
                    unit = "元/每股";
                    break;
                case "nIncome":
                    unit = "元";
                    break;
                case "tProfit":
                    unit = "元";
                    break;
                case "tRevenue":
                    unit = "元";
                    break;
                case "revenue":
                    unit = "元";
                    break;
                case "operateProfit":
                    unit = "元";
                    break;
                case "noperateIncome":
                    unit = "元";
                    break;
                case "noperateExp":
                    unit = "元";
                    break;
            }
            res += params[i][1] + "<br>" + params[i].indicator + ":" + params[i].value + " " + unit + "<br>";
        }
        return res
    }

</script>
</html>