<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Agency - Start Bootstrap Theme</title>

    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" href="${resource(dir: 'assets/css/', file: 'bootstrap.css')}">

    <!-- Custom CSS -->
    <link href="${resource(dir: "bootstrap-template/css",file: "agency.css")}" rel="stylesheet">
    <link rel="stylesheet" href="${resource(dir: 'css',file: 'loader.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/fonts/fontawesome/css/', file: 'font-awesome.min.css')}">
    <link rel="stylesheet" href="${resource(dir: 'assets/css/', file: 'bootstrap.css')}">
    %{----}%

    <!-- Custom Fonts -->
    %{--<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">--}%
    %{--<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">--}%
    %{--<link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>--}%
    %{--<link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>--}%
    %{--<link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>--}%

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body id="page-top" class="index">

    <!-- Header -->
    <header>
        <div class="container">
            <div class="intro-text">
                <div class="intro-heading" style="color: #666">Stock Graph</div>
                <div class="intro-lead-in" style="color: #666">图读财报</div>
                <div class="intro-description">帮助你从枯燥的财务报表中解脱出来</div>
                %{--<a href="#services" class="page-scroll btn btn-xl"></a>--}%
            </div>
        </div>
    </header>

    <!-- Services Section -->
    <section id="services">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">丰富的可视化效果</h2>
                    <h3 class="section-subheading text-muted"></h3>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-md-4">
                    <h4 class="service-heading">个股详情</h4>
                    <img src="${resource(dir: 'images',file: '1.png')}" style="width: 200px;height: 200px"/>
                    <p class="text-muted">从过去到现在,展现股票的基本面趋势</p>
                </div>
                <div class="col-md-4">
                    <h4 class="service-heading">同业比较</h4>
                    <img src="${resource(dir: 'images',file: '2.png')}" style="width: 200px;height: 200px"/>
                    <p class="text-muted">这支股票的业绩和它的同行相比如何? 更好or更糟?</p>
                </div>
                <div class="col-md-4">
                    <h4 class="service-heading">深度挖掘</h4>
                    <img src="${resource(dir: 'images',file: '6.png')}" style="width: 200px;height: 200px"/>
                    <p class="text-muted">穿透表面的财务数据,了解背后的事件</p>
                </div>
            </div>
        </div>
    </section>

    <footer style="background-color: #d92231">
        <div class="container">
            <div class="row">
                <div class="col-md-offset-4 col-md-4">
                    <ul class="list-inline social-buttons">
                        %{--支付宝--}%
                        <li><a href="javascript:;"><i class="fa fa-qrcode"></i></a>
                        </li>
                        %{--信息反馈--}%
                        <li><a href="javascript:;"><i class="fa fa-question"></i></a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <span class="copyright" style="color: #dddddd">Copyright &copy; 2016 StockGraph</span>
                </div>
            </div>
        </div>
    </footer>

</body>

</html>
