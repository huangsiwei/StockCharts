package base

class Region {

    static hasMany = [children: Region]
    String name
    String code
    Region parent
    String aliasNameMap // echarts
    Integer level

    static constraints = {
        name nullable: false
        code nullable: true
        parent nullable: true
        children nullable: true
        aliasNameMap nullable: true
    }
}
