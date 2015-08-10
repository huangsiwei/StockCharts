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
    <link href="${resource(dir: "bootstrap-template/css",file: "bootstrap.min.css")}" rel="stylesheet">
    <script src="${resource(dir: "bootstrap-template/js",file: "bootstrap.min.js")}"></script>
</head>

<body>

<h1 align="center">中国每年公司上市家数</h1>

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
                                timeline:{
                                    data:[
                                        '1990','1991','1992','1993','1994','1995','1996','1997','1998','1999',
                                        '2000','2001','2002','2003','2004','2005','2006','2007','2008','2009',
                                        '2010','2011','2012','2013','2014','2015'
                                    ],
                                    label : {
                                        formatter : function(s) {
                                            return s.slice(0, 4);
                                        }
                                    },
                                    autoPlay : true,
                                    playInterval : 2000
                                },
                                options:[
                                    {
                                        tooltip : {'trigger':'item'},
                                        dataRange: {
                                            min: 0,
                                            max: 50,
                                            x: 'left',
                                            y: 'bottom',
                                            text: ['高', '低'],           // 文本，默认为数值文本
                                            calculable: true,
                                            color: ['#FF6C00','#A8C4F9','#CAFCF6']
                                        },
                                        series : [
                                            {
                                                'name':'上市公司',
                                                'type':'map',
                                                'data': jsonObj["1990"]
                                            }
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["1991"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["1992"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["1993"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["1994"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["1995"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["1996"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["1997"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["1998"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["1999"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2000"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2001"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2002"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2003"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2004"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2005"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2006"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2007"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2008"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2009"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2010"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2011"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2012"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2013"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2014"]}
                                        ]
                                    },
                                    {
                                        series : [
                                            {'data': jsonObj["2015"]}
                                        ]
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