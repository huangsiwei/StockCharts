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
    <link href="${resource(dir: 'css',file: 'bootstrap-switch.min.css')}" rel="stylesheet">
    <script src="${resource(dir: 'js',file: 'bootstrap-switch.min.js')}"></script>

    <style>
        .bootstrap-switch-wrapper {
            width: 54px;
        }
    </style>

</head>

<body>

<g:render template="/layouts/navbar"></g:render>

<h1 align="center">中国每年股市上市家数</h1>

<div class="col-sm-12">
    <div class="col-sm-8">

    </div>

    <div class="switch" data-on="primary" data-off="info" style="height: 28px">
        <input id="switch-onText" type="checkbox" name="my-checkbox" checked="" data-on-text="按年" data-off-text="累计"
               data-on-color="info" data-off-color="warning" data-label-width="0"/>
    </div>

</div>

<div id="stockRegionMapChart" style="height:500px;width: 800px;margin: 40px auto"></div>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<script type="text/javascript">
    $(function () {
        $("[name='my-checkbox']").bootstrapSwitch();
        $(".bootstrap-switch-wrapper").css("width","54px");
        $(".bootstrap-switch-label").remove();
        loadStockRegionMapChartByYear();
    });

    function loadStockRegionMapChartTotally() {
        var seriesData = [];
        var max = 0;
        var min = 1000;
        $.ajax({
            url:"${createLink(controller: 'companyRegionDistribution',action: 'loadStockRegionDistributionDataTotally')}",
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
                                    autoPlay : false,
                                    playInterval : 2000
                                },
                                options:[
                                    {
                                        tooltip : {'trigger':'item'},
                                        dataRange: {
                                            min: 0,
                                            max: 300,
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

    function loadStockRegionMapChartByYear() {
        var seriesData = [];
        var max = 0;
        var min = 1000;
        $.ajax({
            url:"${createLink(controller: 'companyRegionDistribution',action: 'loadStockRegionDistributionDataByYear')}",
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