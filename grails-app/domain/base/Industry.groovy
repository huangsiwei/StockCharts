package base

class Industry {

    static hasMany = [children: Industry]
    String industryName
    String industryID
    Industry parent
    Integer level

    static constraints = {
        industryName nullable: false
        industryID nullable: false
        parent nullable: true
        children nullable: true
    }
}
