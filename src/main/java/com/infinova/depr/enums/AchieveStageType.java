package com.infinova.depr.enums;

/**
 * @author ldw
 * @date 2019/8/14 9:14
 */
public enum AchieveStageType {
    PLAN_STAGE("1", "计划阶段"),
    DESIGN_STAGE("2", "设计阶段"),
    CODE_STAGE("3", "编码阶段"),
    TEST_STAGE("4", "测试阶段"),
    CHECK_STAGE("5", "验收阶段");
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

    AchieveStageType(String id, String name) {
        this.id = id;
        this.name = name;
    }
}
