<g:each in="${result}" var="stock">
    <tr>
        <td>${stock.stockName}</td>
        <td>${stock.indexValue}</td>
        <td>在<span class='label label-warning' onclick='goToFinancialInfoByIndustryFilter($(this))'
                   industryId="${stock.industryId1}">${stock.industryId1Name}</span>行业中排名第${stock.rankInIndustry1},在<a
                href='javascript:;' onclick='goToFinancialInfoByIndustryFilter($(this))'
                industryId="${stock.industryId2}">${stock.industryId2Name}</a>行业中排排名第 ${stock.rankInIndustry2},在<a
                href='javascript:;' onclick='goToFinancialInfoByIndustryFilter($(this))'
                industryId="${stock.industryId3}">${stock.industryId3Name}</a>行业中排排名第${stock.rankInIndustry3}
        </td>
    </tr>
</g:each>