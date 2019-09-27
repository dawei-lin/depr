package com.infinova.depr.enums;

/**
 * @author ldw
 * @date 2019/7/25 17:47
 */
public enum DemandCategoryType {
    UQ_SD("2.1、标准与规范需求", "UQ-SD"),
    UQ_ENVI("2.2、运行环境需求", "UQ-ENVI"),
    UQ_INTF("2.3、接口需求", "UQ-INTF"),
    UQ_UI("2.4、用户界面需求", "UQ-UI"),
    UQ_SA("2.5、安全需求", "UQ-SA"),
    UQ_PERF("2.6、性能需求", "UQ-PERF"),
    UQ_CA("2.7、兼容性", "UQ-CA"),
    UQ_TA("2.8、可测试性", "UQ-TA"),
    UQ_PA("2.9、可生产性", "UQ-PA"),
    UQ_MT("2.10、可维护性", "UQ-MT"),
    UQ_EXT("2.11、可扩展性", "UQ-EXT"),
    UQ_TRP("2.12、可移植性", "UQ-TRP"),
    UQ_CER("2.13、认证需求", "UQ-CER"),
    UQ_QMS("2.14、国际化需求", "UQ-QMS"),
    UQ_MEC("2.15、结构需求", "UQ-MEC"),
    UQ_LAR("2.16、法律法规需求", "UQ-LAR"),
    UQ_OTH("2.17、其他需求", "UQ-OTH");
    private String name;
    private String num;

    public String getName() {
        return name;
    }

    public String getNum() {
        return num;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setNum(String num) {
        this.num = num;
    }

    DemandCategoryType(String name, String num) {
        this.name = name;
        this.num = num;
    }
}
