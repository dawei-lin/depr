package com.infinova.depr.enums;

/**
 * @author ldw
 * @date 2019/8/14 9:22
 */
public enum RegulationType {
    PRODUCT_DEMAND("1", "产品需求表"),
    NORMS_ILLUSTRATE("2", "规格说明书"),
    TEST_CASE("3", "测试用例"),
    DEMAND_ASSESS_CENSOR("4", "需求评审检查表"),
    DEMAND_ASSESS_REPORT("5", "需求评审报告"),
    DEMAND_FOLLOWING_MATRIX("6", "需求跟踪矩阵"),
    DEMAND_BASE_BUILD("7", "需求基线建立"),
    CCB_MEETING_RECORD("8", "CCB会议记录"),
    OUTLINE_DESIGN_EXPLAIN("9", "概要设计说明书"),
    OUTLINE_DESIGN_ASSESS_CHECK("10", "概要设计评审检查表"),
    OUTLINE_DESIGN_ASSESS_REPORT("11", "概要设计评审报告"),
    DETAIL_DESIGN_EXPLAIN("12", "详细设计说明书"),
    DETAIL_DESIGN_ASSESS_CHECK("13", "详细设计评审检查表"),
    DETAIL_DESIGN_ASSESS_REPORT("14", "详细设计评审报告"),
    CODE("15", "代码"),
    DEPLOY_AUDIT_REPORT("16", "配置审计报告"),
    PROJECT_SCHEDULE_PLAN("17", "项目进度计划"),
    PROJECT_WEEKLY("18", "项目周报"),
    MILEPOST_STATE_REPORT("19", "里程碑状态报告"),
    METRIC_DATA("20", "度量数据表"),
    PROBLEM_MANAGE("21", "问题管理表"),
    PROCESS_CHECK("22", "过程检查单"),
    PRODUCT_MONITOR("23", "产品检测单"),
    QUALITY_ENSURE_REPORT("24", "质量保证报告");
    private String id;
    private String name;

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    RegulationType(String id, String name) {
        this.id = id;
        this.name = name;
    }
}
