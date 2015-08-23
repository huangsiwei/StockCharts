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
</head>

<body>

<g:render template="/layouts/navbar"></g:render>

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
                var seriesDataTotalList = [];

                for (var i = 0; i < jsonObj.length; i++) {
                    var seriesDataList = [];
                    for (var j = 0; j< jsonObj[i].length;j++) {

                        console.log(jsonObj[i][j].color);
                        var labelTop = {
                            normal : {
                                color:jsonObj[i][j].color,
                                label : {
                                    show : false
                                },
                                labelLine : {
                                    show : false
                                }
                            }
                        };
                        legendDataList.push(jsonObj[i][j].name);
                        var seriesData = jsonObj[i][j];
                        seriesData.itemStyle = labelTop;
                        seriesDataList.push(seriesData);
                    }
                    seriesDataTotalList.push(seriesDataList);
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
                                calculable : true,
                                series : [
                                    {
                                        type:'pie',
                                        radius : [0, 70],
                                        center: ['50%', '60%'],
                                        data:seriesDataTotalList[0]
                                    },
                                    {
                                        type:'pie',
                                        radius : [100, 120],
                                        center: ['50%', '60%'],
                                        data:seriesDataTotalList[1]
                                    },
                                    {
                                        type:'pie',
                                        radius : [140, 160],
                                        center: ['50%', '60%'],
                                        data:seriesDataTotalList[2]
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