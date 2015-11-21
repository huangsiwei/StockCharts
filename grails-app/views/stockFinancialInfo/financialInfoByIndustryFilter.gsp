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
    <title>同行业个股基本面数据比较</title>

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

<h2 align="center">上司公司财务数据趋势图(按行业筛选)</h2>

<div style="width: 700px; margin: 40px auto">
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
    <button onclick="loadStockFinancialTrendDataByIndustry()" class="btn btn-success btn-sm">
        查询
    </button>
</div>

<div id="stockFinancialInfoChart" style="height:700px;width: 1200px;margin: 40px auto"></div>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script src="${resource(dir: 'js/common',file: 'utils.js')}"></script>

<script>

    $(function () {
        $("select").select2();
    });

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
                                    formatter: function (parmas) {
                                        return toolTipFormatter(index,parmas);
                                    }
                                },
                                legend: {
                                    data:legendDataList
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