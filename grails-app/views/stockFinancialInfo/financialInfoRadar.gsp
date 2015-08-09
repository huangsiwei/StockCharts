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
    <script src="${resource(dir: 'js', file: 'jquery-1.11.1.min.js')}"></script>
    <script src="${resource(dir:'js',file: 'select2.min.js')}"></script>
    <script src="${resource(dir:'js',file: 'select2.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}">
    <script src="${resource(dir: 'js/common', file: 'common.js')}"></script>
    <link href="${resource(dir: "bootstrap-template/css",file: "bootstrap.min.css")}" rel="stylesheet">
</head>

<body>
<h2 align="center">基本面信息雷达图</h2>

<div style="width: 700px; margin: 40px auto">
    <select name="stockCodes" style="width: 400px;" multiple="multiple">
        <g:each in="${stockFinancialInfoMap}" var = "stockFinancialInfo" >
            <option value="${stockFinancialInfo.key}">${stockFinancialInfo.value}</option>
        </g:each>
    </select>
    <select name="indexes" style="width: 160px;" multiple="multiple">
        <g:each in="${ReportConstant.STOCK_FINANCIAL_INDEX_KEYS}" var="index" status="i">
            <option value="${index}">${ReportConstant.STOCK_FINANCIAL_INDEXES.get(index)}</option>
        </g:each>
    </select>
    <button onclick="loadStockFinancialInfoRadarChart()">
        查询
    </button>
</div>

<div id="stockFinancialInfoRadarChart" style="height:500px;width: 800px;margin: 40px auto">

</div>

</body>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

<script type="text/javascript">
    $(function () {
        $('[name=stockCodes]').select2();
        $('[name=indexes]').select2();
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
                                    trigger: 'axis'
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
                                        name: '预算 vs 开销（Budget vs spending）',
                                        type: 'radar',
                                        data : seriesDataList
                                    }
                                ]
                            };
                            myChart.setOption(option);
                        }
                );
            },
            error:function (error) {
                console.log(error);
            }
        })
    }

</script>
</html>