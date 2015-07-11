<%--
  Created by IntelliJ IDEA.
  User: huangsiwei
  Date: 15/7/7
  Time: 下午11:13
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <script src="${resource(dir: 'js', file: 'jquery-1.11.1.min.js')}"></script>
</head>

<body>

<h1 align="center">探路者财务数据趋势图</h1>

<div id="stockFinancialInfoChart" style="height:500px;width: 800px;margin: 40px auto"></div>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script type="text/javascript">
    $(function () {
        loadStockFinancialInfoChart();
    });

    function loadStockFinancialInfoChart() {
        var seriesData = [];
        $.ajax({
            url:"${createLink(controller: 'stockFinancialInfo',action: 'loadStockFinancialInfoData')}",
            data:{stockCode:'300005'},
            dataType:"json",
            success: function (jsonObj) {

                var seriseData = [];
                var xAxisData = [];
                for (var i = 0; i < jsonObj.dataList.length; i++) {
                    seriseData.push(jsonObj.dataList[i]);
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
                                series : [
                                    {
                                        name:'基本每股收益',
                                        type:'line',
                                        stack: '总量',
                                        data:seriseData
                                    }
                                ]
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
</script>
<script type="text/javascript">
    // 路径配置

</script>
</body>
</html>