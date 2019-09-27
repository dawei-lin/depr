package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/8/2 10:35
 */
public class Norms implements Serializable {
    private String normsId;
    private String normsNum;
    private String normsDescribe;
    private String normsEvent;
    private String normsBaseflow;
    private String normsExtflow;
    private String normsExcflow;
    private String normsPrecondition;
    private String normsPostcondition;
    private String normsRule;
    private String normsOther;
    private String normsUser;
    private String demandId;
    private String normsName;
    private String productId;
    private Integer pdfPage;
    private String normsVersion;

    public String getNormsId() {
        return normsId;
    }

    public String getNormsNum() {
        return normsNum;
    }

    public String getNormsDescribe() {
        return normsDescribe;
    }

    public String getNormsEvent() {
        return normsEvent;
    }

    public String getNormsBaseflow() {
        return normsBaseflow;
    }

    public String getNormsExtflow() {
        return normsExtflow;
    }

    public String getNormsExcflow() {
        return normsExcflow;
    }

    public String getNormsPrecondition() {
        return normsPrecondition;
    }

    public String getNormsPostcondition() {
        return normsPostcondition;
    }

    public String getNormsRule() {
        return normsRule;
    }

    public String getNormsOther() {
        return normsOther;
    }

    public String getNormsUser() {
        return normsUser;
    }

    public String getDemandId() {
        return demandId;
    }

    public String getNormsName() {
        return normsName;
    }

    public String getProductId() {
        return productId;
    }

    public Integer getPdfPage() {
        return pdfPage;
    }

    public String getNormsVersion() {
        return normsVersion;
    }

    public void setNormsId(String normsId) {
        this.normsId = normsId;
    }

    public void setNormsNum(String normsNum) {
        this.normsNum = normsNum;
    }

    public void setNormsDescribe(String normsDescribe) {
        this.normsDescribe = normsDescribe;
    }

    public void setNormsEvent(String normsEvent) {
        this.normsEvent = normsEvent;
    }

    public void setNormsBaseflow(String normsBaseflow) {
        this.normsBaseflow = normsBaseflow;
    }

    public void setNormsExtflow(String normsExtflow) {
        this.normsExtflow = normsExtflow;
    }

    public void setNormsExcflow(String normsExcflow) {
        this.normsExcflow = normsExcflow;
    }

    public void setNormsPrecondition(String normsPrecondition) {
        this.normsPrecondition = normsPrecondition;
    }

    public void setNormsPostcondition(String normsPostcondition) {
        this.normsPostcondition = normsPostcondition;
    }

    public void setNormsRule(String normsRule) {
        this.normsRule = normsRule;
    }

    public void setNormsOther(String normsOther) {
        this.normsOther = normsOther;
    }

    public void setNormsUser(String normsUser) {
        this.normsUser = normsUser;
    }

    public void setDemandId(String demandId) {
        this.demandId = demandId;
    }

    public void setNormsName(String normsName) {
        this.normsName = normsName;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setPdfPage(Integer pdfPage) {
        this.pdfPage = pdfPage;
    }

    public void setNormsVersion(String normsVersion) {
        this.normsVersion = normsVersion;
    }

    public Norms(String normsId, String normsNum, String normsDescribe, String normsEvent, String normsBaseflow, String normsExtflow, String normsExcflow, String normsPrecondition, String normsPostcondition, String normsRule, String normsOther, String normsUser, String demandId, String normsName, String productId, Integer pdfPage, String normsVersion) {
        this.normsId = normsId;
        this.normsNum = normsNum;
        this.normsDescribe = normsDescribe;
        this.normsEvent = normsEvent;
        this.normsBaseflow = normsBaseflow;
        this.normsExtflow = normsExtflow;
        this.normsExcflow = normsExcflow;
        this.normsPrecondition = normsPrecondition;
        this.normsPostcondition = normsPostcondition;
        this.normsRule = normsRule;
        this.normsOther = normsOther;
        this.normsUser = normsUser;
        this.demandId = demandId;
        this.normsName = normsName;
        this.productId = productId;
        this.pdfPage = pdfPage;
        this.normsVersion = normsVersion;
    }

    public Norms() {
    }
}
