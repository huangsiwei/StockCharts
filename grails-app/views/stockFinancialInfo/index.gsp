<%--
  Created by IntelliJ IDEA.
  User: huangsiwei
  Date: 15/7/7
  Time: 下午11:13
--%>

<%@ page import="report.ReportConstant" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="shortcut icon" href="${resource(dir: 'images',file: 'stocks-icon.png')}" type="image/x-icon">
    <title>上司公司财务数据趋势图</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap Core CSS -->
    <link href="${resource(dir: "bootstrap-template/css",file: "bootstrap.min.css")}" rel="stylesheet">
    <link href="${resource(dir: "css",file: "bootstrap-table.css")}">
    <!-- Custom CSS -->
    <link href="${resource(dir: "bootstrap-template/css",file: "agency.css")}" rel="stylesheet">

    <link href="${resource(dir: "bootstrap-template/font-awesome/css",file: "font-awesome.min.css")}" rel="stylesheet" type="text/css">
    %{--<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">--}%
    %{--<link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>--}%
    %{--<link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>--}%
    %{--<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>--}%

    <script src="${resource(dir: 'js', file: 'jquery-1.11.1.min.js')}"></script>
    <script src="${resource(dir: "bootstrap-template/js",file: "bootstrap.min.js")}"></script>
    <script src="${resource(dir: "js",file: "bootstrap-table.js")}"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="${resource(dir:'js',file: 'select2.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}">

</head>

<body>

<g:render template="/layouts/navbar"></g:render>

<h2 align="center">上司公司财务数据趋势图</h2>

<div style="width: 800px; margin: 20px auto">
    <select name="stockCodes" multiple="multiple" style="width: 500px;">
        <g:each in="${stockList}" var = "stock" >
            <g:if test="${ReportConstant.TOP10_BASICEPS_STOCK_LIST.contains(stock.stockName)}">
                <option value="${stock.stockCode}" selected="selected">${stock.stockName}</option>
            </g:if>
            <g:else>
                <option value="${stock.stockCode}">${stock.stockName}</option>
            </g:else>
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
    <button class="btn btn-success btn-sm" onclick="loadPage()">
        查询
    </button>
</div>

<div id="stockFinancialInfoChart" style="height:500px;width: 900px;margin: 20px auto"></div>

<div style="width: 900px;margin: 20px auto">
    <div style="padding: 10px; ">
        <br>
        <table id="stockFinancialInfoTable"></table>
    </div>
</div>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script src="${resource(dir: 'js/common',file: 'utils.js')}"></script>

<style>
.row-index {
    width: 50px;
    display: inline-block;
}
</style>

<script type="text/javascript">
    $(function () {
        $('[name=stockCodes]').select2({
            placeholder:"请输入或者选择要查看的股票"
        },loadPage());
        $('[name=index]').select2();
    });

    function loadPage() {
        loadStockFinancialInfoChart();
        loadStockFinancialInfoRankingTable();
    }

    function loadStockFinancialInfoChart() {
        var stockCodes = $('[name=stockCodes]').val();
        var index = $('[name=index]').val();
        $.ajax({
            url:"${createLink(controller: 'stockFinancialInfo',action: 'loadStockFinancialInfoChartData')}",
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
                    seriesData.symbol = 'none';
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
                                    axisPointer:{
                                        type:'line',
                                        lineStyle:{
                                            color:"#FF0000",
                                            width:1,
                                            type:"dashed"
                                        }
                                    },
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
                                        type : 'value',
                                        axisLabel:{
                                            rotate: 45
                                        }
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

    function loadStockFinancialInfoRankingTable() {
        var stockCodes = $('[name=stockCodes]').val();
        var index = $('[name=index]').val();
        $.ajax({
            url:"${createLink(controller: 'stockFinancialInfo',action: 'loadStockFinancialInfoChartTableData')}",
            data:{stockCodes:stockCodes,index:index},
            dataType:"json",
            success: function (jsonObj) {
                bindStockFinancialInfoRankingTable(jsonObj,index)
            },
            error:function (error) {
                console.log(error);
            }
        })
    }

    function bindStockFinancialInfoRankingTable(stockFinancialDataListWithRanking,index) {
        var tableData = [];
        for (var i = 0; i < stockFinancialDataListWithRanking.length; i++) {
            var obj = {};
            obj["stockName"] = stockFinancialDataListWithRanking[i].stockName;
            if (index == "basicEPS") {
                obj["indexValue"] = stockFinancialDataListWithRanking[i].indexValue + "元/每股";
            } else {
                obj["indexValue"] = toThousands(stockFinancialDataListWithRanking[i].indexValue) + "元";
            }
//            obj["indexValue"] = stockFinancialDataListWithRanking[i].indexValue;
            obj["rankingInfo"] = "在<a href='javascript:;'  onclick='goToFinancialInfoByIndustryFilter($(this))' industryId=" + stockFinancialDataListWithRanking[i].industryId1 + ">" + stockFinancialDataListWithRanking[i].industryId1Name + "</a>"+ "行业中排名第" + stockFinancialDataListWithRanking[i].rankInIndustry1 +",在<a href='javascript:;'  onclick='goToFinancialInfoByIndustryFilter($(this))' industryId=" + stockFinancialDataListWithRanking[i].industryId2 + ">" + stockFinancialDataListWithRanking[i].industryId2Name + "</a>" +"行业中排排名第" + stockFinancialDataListWithRanking[i].rankInIndustry2 +",在<a href='javascript:;'  onclick='goToFinancialInfoByIndustryFilter($(this))' industryId=" + stockFinancialDataListWithRanking[i].industryId3 + ">" + stockFinancialDataListWithRanking[i].industryId3Name + "</a>" + "行业中排排名第" + stockFinancialDataListWithRanking[i].rankInIndustry3;
            tableData.push(obj);
        }
        if ($('#stockFinancialInfoTable').html() == "") {
            $('#stockFinancialInfoTable').bootstrapTable({
                columns: [{
                    field: 'stockName',
                    title: '股票名称'
                }, {
                    field: 'indexValue',
                    title: '最近年报数据'
                },{
                    field: 'rankingInfo',
                    title: '行业排名'
                }],
                data: tableData,
                formatLoadingMessage: function () {
                    return '';
                }
            });
        } else {
            $('#stockFinancialInfoTable').bootstrapTable("load",{
                data: tableData,
                formatLoadingMessage: function () {
                    return '';
                }
            });
        }
    }

    function goToFinancialInfoByIndustryFilter(obj) {
        var industryId = obj.attr("industryId");
        window.location = "financialInfoByIndustryFilter?industryId=" + industryId;
    }

</script>
</body>
</html>