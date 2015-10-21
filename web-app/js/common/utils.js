/**
 * Created by huangsiwei on 15/10/18.
 */

function toolTipFormatter(index,params) {
    var res = "";
    switch (index) {
        case "basicEPS":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + params[i].data + " " + "元/每股" + "<br>"
            }
            break;
        case "nIncome":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
            }
            break;
        case "tProfit":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
            }
            break;
        case "tRevenue":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
            }
            break;
        case "revenue":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
            }
            break;
        case "operateProfit":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
            }
            break;
        case "noperateIncome":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
            }
            break;
        case "noperateExp":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + params[i].data + " " + "元" + "<br>"
            }
            break;
    }
    return res
}
