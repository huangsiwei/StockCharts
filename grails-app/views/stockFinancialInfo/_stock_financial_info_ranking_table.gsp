<g:each in="${result}" var="stock">
    <tr>
        <g:if test="${stock.noIndustryInfo}">
            <td><p class="description">${stock.stockName}</p></td>
            <td><p class="description"><span class="indexValue">${stock.indexValue}</span>${stock.indexUnit}</p></td>
            <td>
                <p class="description" style="cursor: default">
                    ${stock.noIndustryInfo}
                </p>
            </td>
        </g:if>
        <g:else>
            <td><br><p class="description">${stock.stockName}</p></td>
            <td><br><p class="description"><span class="indexValue">${stock.indexValue}</span>${stock.indexUnit}</p></td>
            <td>
                <p class="description">
                    <span onclick='goToFinancialInfoByIndustryFilter($(this))'
                          industryId="${stock.industryId1}">
                        在<span class='badge badge-info'>${stock.industryId1Name}</span>行业中排名第${stock.rankInIndustry1}
                    </span>
                    <br>
                    <span onclick='goToFinancialInfoByIndustryFilter($(this))'
                          industryId="${stock.industryId2}">
                        在<span class='badge badge-secondary'>${stock.industryId2Name}</span>行业中排排名第 ${stock.rankInIndustry2}
                    </span>
                    <br>
                    <span onclick='goToFinancialInfoByIndustryFilter($(this))'
                          industryId="${stock.industryId3}">
                        在<span class='badge badge-warning'>${stock.industryId3Name}</span>行业中排排名第${stock.rankInIndustry3}
                    </span>
                </p>
            </td>
        </g:else>
    </tr>
</g:each>

<script>
    $(function () {
        for (var i = 0; i < $(".indexValue").length; i++) {
            $($(".indexValue")[i]).text((toThousands($($(".indexValue")[i]).text())));
        }
    })
</script>