package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/8/13 17:16
 */
public class DemandMatrix implements Serializable {
    private Integer demandState;
    private Integer demandPriority;
    private String demandNum;
    private String normsNum;
    private String overallDesignRuleNum;
    private String changeRecord;
    private String businessNum;
    private String testCaseNum;
    private String operationManualNum;
    private String detailDesignNum;
    private String demandCategoryName;

    public Integer getDemandState() {
        return demandState;
    }

    public Integer getDemandPriority() {
        return demandPriority;
    }

    public String getDemandNum() {
        return demandNum;
    }

    public String getNormsNum() {
        return normsNum;
    }

    public String getOverallDesignRuleNum() {
        return overallDesignRuleNum;
    }

    public String getChangeRecord() {
        return changeRecord;
    }

    public String getBusinessNum() {
        return businessNum;
    }

    public String getTestCaseNum() {
        return testCaseNum;
    }

    public String getOperationManualNum() {
        return operationManualNum;
    }

    public String getDetailDesignNum() {
        return detailDesignNum;
    }

    public String getDemandCategoryName() {
        return demandCategoryName;
    }

    public void setDemandState(Integer demandState) {
        this.demandState = demandState;
    }

    public void setDemandPriority(Integer demandPriority) {
        this.demandPriority = demandPriority;
    }

    public void setDemandNum(String demandNum) {
        this.demandNum = demandNum;
    }

    public void setNormsNum(String normsNum) {
        this.normsNum = normsNum;
    }

    public void setOverallDesignRuleNum(String overallDesignRuleNum) {
        this.overallDesignRuleNum = overallDesignRuleNum;
    }

    public void setChangeRecord(String changeRecord) {
        this.changeRecord = changeRecord;
    }

    public void setBusinessNum(String businessNum) {
        this.businessNum = businessNum;
    }

    public void setTestCaseNum(String testCaseNum) {
        this.testCaseNum = testCaseNum;
    }

    public void setOperationManualNum(String operationManualNum) {
        this.operationManualNum = operationManualNum;
    }

    public void setDetailDesignNum(String detailDesignNum) {
        this.detailDesignNum = detailDesignNum;
    }

    public void setDemandCategoryName(String demandCategoryName) {
        this.demandCategoryName = demandCategoryName;
    }

    public DemandMatrix(Integer demandState, Integer demandPriority, String demandNum, String normsNum, String overallDesignRuleNum, String changeRecord, String businessNum, String testCaseNum, String operationManualNum, String detailDesignNum, String demandCategoryName) {
        this.demandState = demandState;
        this.demandPriority = demandPriority;
        this.demandNum = demandNum;
        this.normsNum = normsNum;
        this.overallDesignRuleNum = overallDesignRuleNum;
        this.changeRecord = changeRecord;
        this.businessNum = businessNum;
        this.testCaseNum = testCaseNum;
        this.operationManualNum = operationManualNum;
        this.detailDesignNum = detailDesignNum;
        this.demandCategoryName = demandCategoryName;
    }

    public DemandMatrix() {
    }
}
