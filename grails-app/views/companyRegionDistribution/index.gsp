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

<h1 align="center">中国上市公司地域分布</h1>

<div id="stockRegionMapChart" style="height:500px;width: 800px;margin: 40px auto"></div>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script type="text/javascript">
    $(function () {
        loadStockRegionMapChart();
    });

    function loadStockRegionMapChart() {
        var seriesData = [];
        var max = 0;
        var min = 1000;
        $.ajax({
            url:"${createLink(controller: 'companyRegionDistribution',action: 'loadStockRegionDistributionData')}",
            data:{},
            dataType:"json",
            success: function (jsonObj) {
                for (var i = 0;i<jsonObj.length;i++) {
                    seriesData.push(jsonObj[i]);
                    if (jsonObj[i].value > max) {
                        max = jsonObj[i].value
                    }
                    if (jsonObj[i].value < min) {
                        min = jsonObj[i].value
                    }
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
                            'echarts/chart/map'
                        ],
                        function (ec) {
                            var myChart = ec.init(document.getElementById('stockRegionMapChart'));

                            var option = {
                                tooltip : {
                                    trigger: 'item'
                                },
                                dataRange: {
                                    min: parseInt(min),
                                    max: parseInt(max),
                                    x: 'left',
                                    y: 'bottom',
                                    text:['高','低'],           // 文本，默认为数值文本
                                    calculable : true
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
                                roamController: {
                                    show: true,
                                    x: 'right',
                                    mapTypeControl: {
                                        'china': true
                                    }
                                },
                                series : [
                                    {
                                        name: '上市公司',
                                        type: 'map',
                                        mapType: 'china',
                                        roam: false,
                                        itemStyle:{
                                            normal:{label:{show:true}},
                                            emphasis:{label:{show:true}}
                                        },
                                        data: seriesData
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