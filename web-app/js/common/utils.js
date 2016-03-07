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
                res = res + params[i].seriesName +": " + toThousands(params[i].data) + " " + "元" + "<br>"
            }
            break;
        case "tProfit":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + toThousands(params[i].data) + " " + "元" + "<br>"
            }
            break;
        case "tRevenue":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + toThousands(params[i].data) + " " + "元" + "<br>"
            }
            break;
        case "revenue":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + toThousands(params[i].data) + " " + "元" + "<br>"
            }
            break;
        case "operateProfit":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + toThousands(params[i].data) + " " + "元" + "<br>"
            }
            break;
        case "noperateIncome":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + toThousands(params[i].data) + " " + "元" + "<br>"
            }
            break;
        case "noperateExp":
            for (var i = 0;i<params.length;i++) {
                res = res + params[i].seriesName +": " + toThousands(params[i].data) + " " + "元" + "<br>"
            }
            break;
    }
    return res
}

function toolTipItemFormatter(index,params) {
    var res = "";
    switch (index) {
        case "basicEPS":
            res = res + params.seriesName + ": " + params.data + " " + "元/每股" + "<br>";
            break;
        default :
            res = res + params.seriesName +": " + toThousands(params.data) + " " + "元" + "<br>";
            break;
    }
    return res
}

function toThousands(num) {
    if (num == "-") {
        return "-"
    } else {
        var numInt = parseInt(num);
        var numFloat = (num - numInt).toFixed(2);
        var result = '', counter = 0;
        numInt = (numInt || 0).toString();
        for (var i = numInt.length - 1; i >= 0; i--) {
            counter++;
            result = numInt.charAt(i) + result;
            if (!(counter % 3) && i != 0) {
                result = ',' + result;
            }
        }
        if (numFloat && numFloat != 0) {
            result = result + (numFloat.replace("0.",".") + "");
        }
        return result;
    }
}
