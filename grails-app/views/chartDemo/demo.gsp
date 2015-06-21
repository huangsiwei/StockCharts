<%--
  Created by IntelliJ IDEA.
  User: huangsiwei
  Date: 15/1/4
  Time: 下午10:40
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap-theme.min.css">
    <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
    <script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
    <title></title>
</head>

<body>

<div id="main" style="width: 500px;height: 500px"></div>
<script type="text/javascript">
    // 路径配置
    require.config({
        paths: {
            echarts: 'http://echarts.baidu.com/build/dist'
        }
    });

    // 使用
    require(
            [
                'echarts',
                'echarts/chart/pie' // 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main'));

                var option = {
                    title : {
                        text: '美的电器主要股东',
                        subtext: '',
                        x:'center'
                    },
                    tooltip : {
                        trigger: 'item',
                        formatter: "{a} <br/>{b} : {c} ({d}%)"
                    },
                    legend: {
                        orient : 'vertical',
                        x : 'left',
                        data:['美的控股有限公司','融睿股权投资(珠海)合伙企业(有限合伙)','方洪波','天津鼎晖嘉泰股权投资合伙企业(有限合伙)','黄健','宁波美晟股权投资合伙企业(有限合伙)','袁利群','鼎晖美泰(香港)有限公司','鼎晖绚彩(香港)有限公司','黄晓明']
                    },
                    calculable : true,
                    series : [
                        {
                            name:'持股数(万股)',
                            type:'pie',
                            radius : '70%',
                            center: ['50%', '60%'],
                            data:[
                                {value:149625.00, name:'美的控股有限公司'},
                                {value:30450.00, name:'融睿股权投资(珠海)合伙企业(有限合伙)'},
                                {value:9132.70,name:'方洪波'},
                                {value:7800.00, name:'天津鼎晖嘉泰股权投资合伙企业(有限合伙)'},
                                {value:7570.00, name:'黄健'},
                                {value:7500.00, name:'宁波美晟股权投资合伙企业(有限合伙)'},
                                {value:6050.00,name:'袁利群'},
                                {value:6000.00,name:'鼎晖美泰(香港)有限公司'},
                                {value:5750.00,name:'鼎晖绚彩(香港)有限公司'},
                                {value:5221.34,name:'黄晓明'},
                                {value:186481,name:'其他'}

                            ]
                        }
                    ]
                };


                // 为echarts对象加载数据
                myChart.setOption(option);
            }
    );
</script>

</body>
</html>

