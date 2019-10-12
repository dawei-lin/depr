package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/8/7 13:39
 */
public class OverallDesignRule implements Serializable {
    private static final long serialVersionUID = -6709785583178435252L;
    private String overallDesignRuleId;
    private String overallDesignRuleNum;
    private String overallDesignRuleName;
    private String overallDesignRuleContext;
    private String demandId;
    private String productId;
    private Integer pdfPage;

    public String getOverallDesignRuleId() {
        return overallDesignRuleId;
    }

    public String getOverallDesignRuleName() {
        return overallDesignRuleName;
    }

    public String getOverallDesignRuleNum() {
        return overallDesignRuleNum;
    }

    public String getOverallDesignRuleContext() {
        return overallDesignRuleContext;
    }

    public String getDemandId() {
        return demandId;
    }

    public String getProductId() {
        return productId;
    }

    public Integer getPdfPage() {
        return pdfPage;
    }

    public void setOverallDesignRuleId(String overallDesignRuleId) {
        this.overallDesignRuleId = overallDesignRuleId;
    }

    public void setOverallDesignRuleName(String overallDesignRuleName) {
        this.overallDesignRuleName = overallDesignRuleName;
    }

    public void setOverallDesignRuleNum(String overallDesignRuleNum) {
        this.overallDesignRuleNum = overallDesignRuleNum;
    }

    public void setOverallDesignRuleContext(String overallDesignRuleContext) {
        this.overallDesignRuleContext = overallDesignRuleContext;
    }

    public void setDemandId(String demandId) {
        this.demandId = demandId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setPdfPage(Integer pdfPage) {
        this.pdfPage = pdfPage;
    }

    public OverallDesignRule(String overallDesignRuleId, String overallDesignRuleName, String overallDesignRuleNum, String overallDesignRuleContext, String demandId, String productId, Integer pdfPage) {
        this.overallDesignRuleId = overallDesignRuleId;
        this.overallDesignRuleName = overallDesignRuleName;
        this.overallDesignRuleNum = overallDesignRuleNum;
        this.overallDesignRuleContext = overallDesignRuleContext;
        this.demandId = demandId;
        this.productId = productId;
        this.pdfPage = pdfPage;
    }

    public OverallDesignRule() {
    }
}
