<%--
  Created by IntelliJ IDEA.
  User: huangsiwei
  Date: 15/7/18
  Time: 上午2:29
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <script src="${resource(dir: 'js', file: 'jquery-1.11.1.min.js')}"></script>
    <script src="${resource(dir:'js',file: 'select2.min.js')}"></script>
    <script src="${resource(dir:'js',file: 'select2.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}">
</head>

<body>

<h1 align="center">上司公司主营业务分布</h1>

<div id="stockBusinessInfoPieChart" style="height:400px;width: 800px;margin: 40px auto"></div>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

<script type="text/javascript">

    $(function () {
        loadStockMainBusinessInfoPieChart()
    });

    function loadStockMainBusinessInfoPieChart() {
        $.ajax({
            url:"${createLink(controller: 'stockBasicInfo',action: 'loadStockMainBusinessInfoPieChart')}",
            data:{},
            dataType:"json",
            success: function (jsonObj) {
                var legendDataList = [];
                var seriesDataList = [];
                for (var i = 0; i < jsonObj.length; i++) {
                    legendDataList.push(jsonObj[i].name);
                    seriesDataList.push(jsonObj[i])
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
                            'echarts/chart/pie'
                        ],
                        function (ec) {
                            var myChart = ec.init(document.getElementById('stockBusinessInfoPieChart'));

                            var option = option = {
                                tooltip : {
                                    trigger: 'item',
                                    formatter: "{b} : {c} ({d}%)"
                                },
                                legend: {
                                    orient : 'vertical',
                                    x : 'left',
                                    data:legendDataList
                                },
                                toolbox: {
                                    show : true,
                                    feature : {
                                        mark : {show: true},
                                        dataView : {show: true, readOnly: false},
                                        magicType : {
                                            show: true,
                                            type: ['pie', 'funnel'],
                                            option: {
                                                funnel: {
                                                    x: '25%',
                                                    width: '50%',
                                                    funnelAlign: 'left',
                                                    max: 1548
                                                }
                                            }
                                        },
                                        restore : {show: true},
                                        saveAsImage : {show: true}
                                    }
                                },
                                calculable : true,
                                series : [
                                    {
                                        type:'pie',
                                        radius : '70%',
                                        center: ['50%', '60%'],
                                        data:seriesDataList
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

</body>
</html>