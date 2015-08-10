<%--
  Created by IntelliJ IDEA.
  User: huangsiwei
  Date: 15/7/26
  Time: 上午12:40
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <script src="${resource(dir: 'js', file: 'jquery-1.11.1.min.js')}"></script>
    <script src="${resource(dir:'js',file: 'select2.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}">
    <script src="${resource(dir: 'js/common', file: 'common.js')}"></script>
    <link href="${resource(dir: "bootstrap-template/css",file: "bootstrap.min.css")}" rel="stylesheet">
</head>

<body>
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
                                    trigger: 'axis'
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