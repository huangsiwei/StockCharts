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
    <script src="${resource(dir:'js',file: 'select2.min.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'select2.css')}">
    <script src="${resource(dir: 'js/common', file: 'common.js')}"></script>
</head>

<body>
<h1 align="center">上司公司财务数据趋势图(按行业筛选)</h1>

<div style="width: 700px; margin: 40px auto">
    <select name="industryL1" style="width: 160px;" onchange="loadChildIndustrySelect(this.value,'industryL2')">
        <option value="">请选择行业</option>
        <g:each in="${industryL1List}" var = "industryL1" >
            <option value="${industryL1.industryID}">${industryL1.industryName}</option>
        </g:each>
    </select>
    <select name="industryL2" style="width: 160px;" onchange="loadChildIndustrySelect(this.value,'industryL3')">
        <option value="null">请选择父行业</option>
    </select>
    <select name="industryL3" style="width: 160px;">
        <option value="null">请选择父行业</option>
    </select>
    <button onclick="">
        查询
    </button>
</div>

<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

<script>

    $(function () {
        $("select").select2();
    });
    
    function loadChildIndustrySelect(parentIndustryId,childIndustrySelectName) {
        if (parentIndustryId != "") {
            $.ajax({
                url: "${createLink(controller: "stockFinancialInfo",action: "loadChildIndustry")}",
                data: {parentIndustryId: parentIndustryId},
                dataType: "json",
                success: function (jsonObj) {
                    var optionHtml = "<option value='null'>请选择父行业</option>";
                    for (var i = 0; i < jsonObj.length; i++) {
                        var option = "<option value='" + jsonObj[i].industryId + "'>" + jsonObj[i].industryName + "</option>";
                        optionHtml = optionHtml + option;
                    }
                    $("[name={0}]".format(childIndustrySelectName)).html(optionHtml);
                    $("[name={0}]".format(childIndustrySelectName)).select2();
                    if (childIndustrySelectName == "industryL2") {
                        $("[name=industryL3]").html("<option value='null'>请选择父行业</option>");
                        $("[name=industryL3]").select2();
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            })
        } else {
            $("[name=industryL2]").html("<option value='null'>请选择父行业</option>");
            $("[name=industryL3]").html("<option value='null'>请选择父行业</option>");
        }
    }
    
</script>
</body>
</html>