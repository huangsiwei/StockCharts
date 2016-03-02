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
    <title>公司基本面数据趋势图</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Custom CSS -->
    <link href="${resource(dir: "bootstrap-template/css",file: "agency.css")}" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <link rel="stylesheet" href="${resource(dir: 'css',file: 'loader.css')}">
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
    <style>
        td:nth-child(3) .description {
            cursor: pointer
        }
    </style>

</head>

<body>

<g:render template="/layouts/navbar"></g:render>

<div class="row">
    <div class="col-sm-1">
    </div>
    <div class="col-sm-10">
        <div class="panel panel-default">
            <div class="panel-body">
                <h2 class="title" style="text-align: center;margin-bottom: 18px;color: #5084c4">公司基本面数据趋势图</h2>
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

                        <div class="col-sm-7">
                            <select name="stockCodes" multiple="multiple" style="width: 100%">
                                <g:each in="${defaultStockList}" var="defaultStock">
                                    <option value="${defaultStock.stockCode}" selected="selected">${defaultStock.stockName}</option>
                                </g:each>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-8">

                        </div>
                        <div class="col-sm-4">
                            <button class="btn btn-info btn-sm" type="button" onclick="emptyStockCodesSelected()">清空</button>
                            <button class="btn btn-success btn-sm" type="button" onclick="loadPage()">查询</button>
                        </div>
                    </div>
                </form>

                <div class="col-sm-12">
                    %{--TODO:需要一个动态计算Chart Height 的方法,用于留取足够的空间工给legend--}%
                    <div id="stockFinancialInfoChart" style="width: 100%;height:500px"></div>
                </div>

            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-sm-1">

    </div>
    <div class="col-sm-10">
        <div class="panel panel-color">
            <div class="panel-body">
                <div class="col-sm-12">
                    <div style="padding: 10px;">
                        <table id="stockFinancialInfoTable" class="table table-model-2 table-hover">
                            <thead>
                            <tr>
                                <th>股票名称</th>
                                <th>最近年报数据(2014年)</th>
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

<div class="modal fade" id="no-stock-selected-hint-modal" data-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h4 class="modal-title">请选择股票</h4>
            </div>

            <div class="modal-body">

                你还没有选择需要查看的股票,请先选择!

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-info" data-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

<footer class="main-footer sticky footer-type-1" style="">

    <div class="footer-inner">

        <!-- Add your copyright text here -->
        <div class="footer-text">
            © 2014
            <strong>Xenon</strong>
            theme by <a href="http://laborator.co" target="_blank">Laborator</a> - <a href="http://themeforest.net/item/xenon-bootstrap-admin-theme/9059661?ref=Laborator" target="_blank">Purchase for only <strong>23$</strong></a>
        </div>


        <!-- Go to Top Link, just add rel="go-top" to any link to add this functionality -->
        <div class="go-up">

            <a href="#" rel="go-top">
                <i class="fa-angle-up"></i>
            </a>

        </div>

    </div>

</footer>

<!-- Bottom Scripts -->
<script src="${resource(dir: 'js', file: 'jquery-1.11.1.min.js')}"></script>
<script src="${resource(dir: 'assets/js/', file: 'bootstrap.min.js')}"></script>
<script src="${resource(dir: 'assets/js/', file: 'resizeable.js')}"></script>
<script src="${resource(dir: 'assets/js/', file: 'xenon-api.js')}"></script>
<script src="${resource(dir: 'assets/js/', file: 'xenon-toggles.js')}"></script>

<!-- Imported scripts on this page -->
%{--<script src="${resource(dir: 'assets/js/select2/', file: 'select2.min.js')}"></script>--}%
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.2-rc.1/js/select2.min.js"></script>
<script src="${resource(dir: 'assets/js/jquery-ui/', file: 'jquery-ui.min.js')}"></script>
<script src="${resource(dir: 'assets/js/selectboxit/', file: 'jquery.selectBoxIt.min.js')}"></script>
<script src="${resource(dir: 'assets/js/tagsinput/', file: 'bootstrap-tagsinput.min.js')}"></script>

<!-- JavaScripts initializations and stuff -->
<script src="${resource(dir: 'assets/js/',file:'xenon-custom.js')}"></script>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script src="${resource(dir: 'js/common',file: 'utils.js')}"></script>

<script type="text/javascript">
    $(function () {
        initStockCodesSelect();
        $('[name=index]').select2();
    });

    function initStockCodesSelect(){
        $('[name=stockCodes]').select2({
            placeholder:"请输入或者选择要查看的股票",
            ajax: {
                url:"${createLink(controller: 'stockFinancialInfo',action: 'loadStockListByKeyWords')}",
                dataType:'json',
                delay:250,
                data: function (params) {
                    return {
                        q: params.term, // search term
                        page: params.page
                    };
                },
                processResults: function (data, params) {
                    params.page = params.page || 1;
                    return {
                        results: data,
                        pagination: {
                            more: (params.page * 30) < data.total_count
                        }
                    };
                },
                cache: true
            },
            language: {
                inputTooShort: function () { return '请输入股票代码或者名称'; }
            },
            escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
            minimumInputLength: 1,
            templateResult: formatStock, // omitted for brevity, see the source of this page
            templateSelection: formatStockSelection // omitted for brevity, see the source of this page
        },loadPage());
    }

    function formatStock(repo) {
        if (repo.loading) return repo.text;
        var markup = "<div class='select2-result-repository__title'>" + repo.stockName + "</div>";
        return markup;
    }

    function formatStockSelection (repo) {
        return repo.stockName || repo.text;
    }

    function loadPage() {
        if ($("[name=stockCodes]").val() == null) {
            $("#no-stock-selected-hint-modal").modal("show");
        } else {
            loadStockFinancialInfoChart();
            loadStockFinancialInfoRankingTable();
        }
    }

    function emptyStockCodesSelected() {
        $("[name=stockCodes]").select2("val","");
    }

    function loadStockFinancialInfoChart() {
        var stockCodes = $('[name=stockCodes]').val();
        var index = $('[name=index]').val();
        $.ajax({
            url:"${createLink(controller: 'stockFinancialInfo',action: 'loadStockFinancialInfoChartData')}",
            data:{stockCodes:stockCodes,index:index},
            dataType:"json",
            beforeSend: function () {
                $("#stockFinancialInfoChart").html('<div style="width:100px;margin-left: auto;margin-right: auto;margin-top: 150px"><div class="ouro"><span class="ouro-left"><span class="anim"></span></span><span class="ouro-right"><span class="anim"></span></span></div></div>');
            },
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
                                    y:"30px"
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
            beforeSend: function () {
                $("#stockFinancialInfoTableContainer").html('<td colspan="3"><div style="width:100px;margin-left: auto;margin-right: auto"><div class="ouro"><span class="ouro-left"><span class="anim"></span></span><span class="ouro-right"><span class="anim"></span></span></div></div></td>');
            },
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
        window.open("financialInfoByIndustryFilter?industryId=" + industryId);
    }

</script>
</body>
</html>