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
    %{--<link href="${resource(dir: "css",file: "bootstrap-table.css")}">--}%
    <!-- Custom CSS -->
    <link href="${resource(dir: "bootstrap-template/css",file: "agency.css")}" rel="stylesheet">

    %{--<link href="${resource(dir: "bootstrap-template/font-awesome/css",file: "font-awesome.min.css")}" rel="stylesheet" type="text/css">--}%
    %{--<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">--}%
    %{--<link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>--}%
    %{--<link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>--}%
    %{--<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>--}%

    <script src="${resource(dir: 'js', file: 'jquery-1.11.1.min.js')}"></script>
    <script src="${resource(dir: "bootstrap-template/js",file: "bootstrap.min.js")}"></script>
    %{--<script src="${resource(dir: "js",file: "bootstrap-table.js")}"></script>--}%

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="${resource(dir:'js',file: 'select2.min.js')}"></script>
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}">--}%

    <link rel="stylesheet" href="${resource(dir:'assets/css/fonts/linecons/css/',file: 'linecons.css')}">
    <link rel="stylesheet" href="${resource(dir:'assets/css/fonts/fontawesome/css/',file: 'font-awesome.min.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/',file: 'bootstrap.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/',file: 'xenon-core.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/',file: 'xenon-forms.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/',file: 'xenon-components.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/',file: 'xenon-skins.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/',file: 'custom.css')}">


    <!-- Imported styles on this page -->
    <link rel="stylesheet" href="${resource(dir: 'assets/js/select2/',file: 'select2.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/js/select2/',file: 'select2-bootstrap.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/js/multiselect/css/',file: 'multi-select.css')}">

    <!-- Bottom Scripts -->
    <script src="${resource(dir: 'assets/js/',file:  'bootstrap.min.js')}"></script>
    <script src="${resource(dir: 'assets/js/',file:  'TweenMax.min.js')}"></script>
    <script src="${resource(dir: 'assets/js/',file:  'resizeable.js')}"></script>
    <script src="${resource(dir: 'assets/js/',file:  'joinable.js')}"></script>
    <script src="${resource(dir: 'assets/js/',file:  'xenon-api.js')}"></script>
    <script src="${resource(dir: 'assets/js/',file:  'xenon-toggles.js')}"></script>
    <script src="${resource(dir: 'assets/js/',file:  'moment.min.js')}"></script>

    <!-- Imported scripts on this page -->
    <script src="${resource(dir: 'assets/js/select2/',file:  'select2.min.js')}"></script>
    <script src="${resource(dir: 'assets/js/jquery-ui/',file:  'jquery-ui.min.js')}"></script>
    <script src="${resource(dir: 'assets/js/selectboxit/',file:  'jquery.selectBoxIt.min.js')}"></script>
    <script src="${resource(dir: 'assets/js/tagsinput/',file:  'bootstrap-tagsinput.min.js')}"></script>
    <script src="${resource(dir: 'assets/js/',file:  'typeahead.bundle.js')}"></script>
    <script src="${resource(dir: 'assets/js/',file:  'handlebars.min.js')}"></script>
    <script src="${resource(dir: 'assets/js/multiselect/js/',file:  'jquery.multi-select.js')}"></script>

    <!-- JavaScripts initializations and stuff -->
    <script src="${resource(dir: 'assets/js/',file: 'xenon-custom.js')}"></script>


</head>

<body>

<g:render template="/layouts/navbar"></g:render>

<h2 align="center">XXXXX</h2>
%{--<h2 align="center">上司公司财务数据趋势图</h2>--}%

<div class="row">
    <div class="col-sm-2">

    </div>
    <div class="col-sm-8">

        <div class="panel panel-default">
            <div class="panel-body">

                <form role="form" class="form-horizontal" style="margin-bottom: 0px">

                    <div class="form-group">
                        <label class="col-sm-3 control-label">请选择指标:</label>

                        <div class="col-sm-9">
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
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-3 control-label">
                            请选择个股:
                        </div>

                        <div class="col-sm-9">
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
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-8">

                        </div>
                        <div class="col-sm-4">
                            <button class="btn btn-info btn-sm" type="button" >
                                重置
                            </button>

                            <button class="btn btn-success btn-sm" type="button" onclick="loadPage()">
                                查询
                            </button>
                        </div>
                    </div>


                </form>

                <div class="col-sm-12">
                    <div id="stockFinancialInfoChart" style="width: 100%;height:600px"></div>
                </div>

            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-sm-2">

    </div>
    <div class="col-sm-8">
        <div class="panel panel-color">
            <div class="panel-body">
                <div class="col-sm-12">
                    <div style="padding: 10px;">
                        <table id="stockFinancialInfoTable" class="table table-model-2 table-hover">
                            <thead>
                            <tr>
                                <th>股票名称</th>
                                <th>最近年报数据</th>
                                <th>行业排名</th>
                            </tr>
                            </thead>
                            <tbody id="stockFinancialInfoTableContainer">

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script src="${resource(dir: 'js/common',file: 'utils.js')}"></script>

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

    function resetStockSelected() {

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
//                    seriesData.symbol = 'none';
                    seriesData.symbolSize = 2;
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
                                    trigger: 'item',
//                                    axisPointer:{
//                                        type:'line',
//                                        lineStyle:{
//                                            color:"#FF0000",
//                                            width:1,
//                                            type:"dashed"
//                                        }
//                                    },
                                    formatter: function (params) {
                                        return toolTipItemFormatter(index,params);
                                    }
                                },
                                grid:{
                                    y:"30px",
                                    y2:"60px"
                                },
                                legend: {
                                    data:legendDataList,
                                    orient:'horizontal',
                                    x:'center',
                                    y:'bottom'
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
            url:"${createLink(controller: 'stockFinancialInfo',action: 'loadStockFinancialInfoRankingTable')}",
            data:{stockCodes:stockCodes,index:index},
            dataType:"html",
            success: function (html) {
                $("#stockFinancialInfoTableContainer").html(html);
            },
            error:function (error) {
                console.log(error);
            }
        })
    }

    function goToFinancialInfoByIndustryFilter(obj) {
        var industryId = obj.attr("industryId");
        window.location = "financialInfoByIndustryFilter?industryId=" + industryId;
    }

</script>
</body>
</html>