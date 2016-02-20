<g:each in="${result}" var="stock">
    <tr>
        <td><p class="description"><br>${stock.stockName}</p></td>
        <td><p class="description"><br>${stock.indexValue}</p></td>
        <td>
            <p class="description">
            在<span class='badge badge-info' onclick='goToFinancialInfoByIndustryFilter($(this))'
                   industryId="${stock.industryId1}">${stock.industryId1Name}</span>行业中排名第${stock.rankInIndustry1}<br>
            在<span class='badge badge-secondary' onclick='goToFinancialInfoByIndustryFilter($(this))'
                industryId="${stock.industryId2}">${stock.industryId2Name}</span>行业中排排名第 ${stock.rankInIndustry2}<br>
            在<span class='badge badge-warning' onclick='goToFinancialInfoByIndustryFilter($(this))'
                industryId="${stock.industryId3}">${stock.industryId3Name}</span>行业中排排名第${stock.rankInIndustry3}
            </p>
        </td>
    </tr>
</g:each>