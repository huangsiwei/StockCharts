<%--
  Created by IntelliJ IDEA.
  User: huangsiwei
  Date: 15/7/26
  Time: 上午12:40
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="shortcut icon" href="${resource(dir: 'images',file: 'stocks-icon.png')}" type="image/x-icon">
    <title>XXXX</title>
    %{--<title>同行业个股基本面数据比较</title>--}%

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
</head>

<body>

<g:render template="/layouts/navbar"></g:render>

%{--<h2 align="center">上司公司财务数据趋势图(按行业筛选)</h2>--}%
<h2 align="center">XXXXX</h2>

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
                        <div class="col-sm-3 control-label">请选择行业分类:</div>

                        <div class="col-sm-7">
                            <select name="industryL1" style="width: 160px;" onchange="loadChildIndustrySelect(this.value,'industryL2')">
                                <option value="">请选择行业</option>
                                <g:each in="${industryL1List}" var = "industryL1" >
                                    <option value="${industryL1.industryID}">${industryL1.industryName}</option>
                                </g:each>
                            </select>
                            <select name="industryL2" style="width: 160px;" onchange="loadChildIndustrySelect(this.value,'industryL3')">
                                <option value="">请选择父行业</option>
                            </select>
                            <select name="industryL3" style="width: 160px;">
                                <option value="">请选择父行业</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-8">

                        </div>
                        <div class="col-sm-4">
                            <button onclick="loadStockFinancialTrendDataByIndustry()" type="button" class="btn btn-success btn-sm" id="queryBtn">查询</button>
                        </div>
                    </div>
                </form>

                %{--TODO:需要一个动态计算Chart Height 的方法,用于留取足够的空间工给legend--}%
                <div id="stockFinancialInfoChart" style="height:500px;width: 100%;"></div>
            </div>
        </div>
    </div>
</div>


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
<script src="${resource(dir: 'js/common',file: 'common.js')}"></script>

<script>

    $(function () {
        initSelectedIndustries();
    });

    function initSelectedIndustries() {
        if ("${selectedIndustryL3}" != "") {
            $("[name=industryL1]").html("<option value='${selectedIndustryL1?.industryID}'>${selectedIndustryL1?.industryName}</option>");
            $("[name=industryL2]").html("<option value='${selectedIndustryL2?.industryID}'>${selectedIndustryL2?.industryName}</option>");
            $("[name=industryL3]").html("<option value='${selectedIndustryL3?.industryID}'>${selectedIndustryL3?.industryName}</option>");
        } else if ("${selectedIndustryL2}" != ""){
            $("[name=industryL1]").html("<option value='${selectedIndustryL1?.industryID}'>${selectedIndustryL1?.industryName}</option>");
            $("[name=industryL2]").html("<option value='${selectedIndustryL2?.industryID}'>${selectedIndustryL2?.industryName}</option>");
        } else if ("${selectedIndustryL1}" != "") {
            $("[name=industryL1]").html("<option value='${selectedIndustryL1?.industryID}'>${selectedIndustryL1?.industryName}</option>");
        }
        $("select").select2();
        if ("${selectedIndustryL1}" != "") {
            $("#queryBtn").click();
        }
    }

    function loadStockFinancialTrendDataByIndustry() {
        var industryL1 = $("[name=industryL1]").val();
        var industryL2 = $("[name=industryL2]").val();
        var industryL3 = $("[name=industryL3]").val();
        var index = $("[name=index]").val();
        $.ajax({
            url:"${createLink(controller: 'stockFinancialInfo',action: 'loadStockFinancialTrendDataByIndustry')}",
            data:{industryL1:industryL1,industryL2:industryL2,industryL3:industryL3,index:index},
            dataType:"json",
            success: function (jsonObj) {
                var seriesDataList = [];
                var xAxisData = [];
                var legendDataList = [];
                for (var i = 0; i < jsonObj.dataList.length; i++) {
                    var seriesData = new Object();
                    seriesData.name= jsonObj.dataList[i].stockName;
                    seriesData.type = 'line';
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
                                    formatter: function (parmas) {
                                        return toolTipItemFormatter(index,parmas);
                                    }
                                },
                                grid:{
                                    y:"30px",
                                    height:"400px"
                                },
                                legend: {
                                    data:legendDataList,
                                    orient:'horizontal',
                                    x:'center',
                                    y:'bottom'
                                },
                                calculable:false,
                                toolbox: {
                                    show: true,
                                    orient : 'vertical',
                                    x: 'right',
                                    y: 'center',
                                    feature : {
                                        dataView : {show: true, readOnly: false},
                                        restore : {show: true}
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



    function loadChildIndustrySelect(parentIndustryId,childIndustrySelectName) {
        if (parentIndustryId != "") {
            $.ajax({
                url: "${createLink(controller: "stockFinancialInfo",action: "loadChildIndustry")}",
                data: {parentIndustryId: parentIndustryId},
                dataType: "json",
                success: function (jsonObj) {
                    var optionHtml = "<option value=''>请选择父行业</option>";
                    for (var i = 0; i < jsonObj.length; i++) {
                        var option = "<option value='" + jsonObj[i].industryId + "'>" + jsonObj[i].industryName + "</option>";
                        optionHtml = optionHtml + option;
                    }
                    $("[name={0}]".format(childIndustrySelectName)).html(optionHtml);
                    $("[name={0}]".format(childIndustrySelectName)).select2();
                    if (childIndustrySelectName == "industryL2") {
                        $("[name=industryL3]").html("<option value=''>请选择父行业</option>");
                        $("[name=industryL3]").select2();
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            })
        } else {
            $("[name=industryL2]").html("<option value=''>请选择父行业</option>");
            $("[name=industryL3]").html("<option value=''>请选择父行业</option>");
            $("[name=industryL2]").select2();
            $("[name=industryL3]").select2();
        }
    }
    
</script>
</body>
</html>