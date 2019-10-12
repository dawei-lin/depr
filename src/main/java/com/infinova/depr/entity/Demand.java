package com.infinova.depr.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/7/20 14:30
 */
@ApiModel("需求")
public class Demand implements Serializable {
    private static final long serialVersionUID = 1386697237209638496L;
    @ApiModelProperty("需求id")
    private String demandId;
    @ApiModelProperty("需求名字")
    @NotNull(message = "非空")
    @Size(min = 1, max = 200, message = "名字长度不符合")
    private String demandName;
    @ApiModelProperty("需求编号")
    private String demandNum;
    @ApiModelProperty("需求父分类id")
    @NotNull(message = "非空")
    private String demandCategoryId;
    @ApiModelProperty("需求父分类名字")
    @NotNull(message = "非空")
    private String demandCategoryName;
    @ApiModelProperty("需求子分类id")
    private String demandChildCategoryId;
    @ApiModelProperty("需求子分类名称")
    private String demandChildCategoryName;
    @ApiModelProperty("需求简述")
    @Size(max = 200, message = "简述长度不符合")
    private String demandResume;
    @NotNull(message = "非空")
    @Size(min = 1, max = 300, message = "描述长度不符合")
    @ApiModelProperty("需求描述")
    private String demandDescribe;
    @ApiModelProperty("需求优先级，1代表B,2代表A，3代表S")
    private Integer demandPriority;
    @ApiModelProperty("需求验收标准")
    @NotNull(message = "非空")
    @Size(min = 1, max = 300, message = "验收标准长度不符合")
    private String demandAcceptCriteria;
    @ApiModelProperty("需求备注")
    @Size(max = 300, message = "需求备注长度不符合")
    private String demandRemarks;
    @ApiModelProperty("产品id")
    private String productId;
    @ApiModelProperty("需求状态")
    private Integer demandState;
    @ApiModelProperty("需求来源，1代表产品管理，2代表技术标准和规范，3代表技术服务，4代表测试，5代表友商，6代表直接客户，7代表商业需求")
    private Integer demandOrigin;
    @ApiModelProperty("是否核心需求，1为核心，0不是核心")
    private Integer isCore;
    @ApiModelProperty("实现版本")
    @Size(max = 40, message = "实现版本长度不符合")
    private String realizeEdition;
    @ApiModelProperty("规格编号")
    private String normsNum;
    @ApiModelProperty("需求序号")
    private String demandOrder;
    @ApiModelProperty("总体设计说明书的规则编号")
    private String overallDesignRuleNum;

    public String getDemandId() {
        return demandId;
    }

    public String getDemandName() {
        return demandName;
    }

    public String getDemandNum() {
        return demandNum;
    }

    public String getDemandCategoryId() {
        return demandCategoryId;
    }

    public String getDemandCategoryName() {
        return demandCategoryName;
    }

    public String getDemandChildCategoryId() {
        return demandChildCategoryId;
    }

    public String getDemandChildCategoryName() {
        return demandChildCategoryName;
    }

    public String getDemandResume() {
        return demandResume;
    }

    public String getDemandDescribe() {
        return demandDescribe;
    }

    public Integer getDemandPriority() {
        return demandPriority;
    }

    public String getDemandAcceptCriteria() {
        return demandAcceptCriteria;
    }

    public String getDemandRemarks() {
        return demandRemarks;
    }

    public String getProductId() {
        return productId;
    }

    public Integer getDemandState() {
        return demandState;
    }

    public Integer getDemandOrigin() {
        return demandOrigin;
    }

    public Integer getIsCore() {
        return isCore;
    }

    public String getRealizeEdition() {
        return realizeEdition;
    }

    public String getNormsNum() {
        return normsNum;
    }

    public String getDemandOrder() {
        return demandOrder;
    }

    public String getOverallDesignRuleNum() {
        return overallDesignRuleNum;
    }

    public void setDemandId(String demandId) {
        this.demandId = demandId;
    }

    public void setDemandName(String demandName) {
        this.demandName = demandName;
    }

    public void setDemandNum(String demandNum) {
        this.demandNum = demandNum;
    }

    public void setDemandCategoryId(String demandCategoryId) {
        this.demandCategoryId = demandCategoryId;
    }

    public void setDemandCategoryName(String demandCategoryName) {
        this.demandCategoryName = demandCategoryName;
    }

    public void setDemandChildCategoryId(String demandChildCategoryId) {
        this.demandChildCategoryId = demandChildCategoryId;
    }

    public void setDemandChildCategoryName(String demandChildCategoryName) {
        this.demandChildCategoryName = demandChildCategoryName;
    }

    public void setDemandResume(String demandResume) {
        this.demandResume = demandResume;
    }

    public void setDemandDescribe(String demandDescribe) {
        this.demandDescribe = demandDescribe;
    }

    public void setDemandPriority(Integer demandPriority) {
        this.demandPriority = demandPriority;
    }

    public void setDemandAcceptCriteria(String demandAcceptCriteria) {
        this.demandAcceptCriteria = demandAcceptCriteria;
    }

    public void setDemandRemarks(String demandRemarks) {
        this.demandRemarks = demandRemarks;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setDemandState(Integer demandState) {
        this.demandState = demandState;
    }

    public void setDemandOrigin(Integer demandOrigin) {
        this.demandOrigin = demandOrigin;
    }

    public void setIsCore(Integer isCore) {
        this.isCore = isCore;
    }

    public void setRealizeEdition(String realizeEdition) {
        this.realizeEdition = realizeEdition;
    }

    public void setNormsNum(String normsNum) {
        this.normsNum = normsNum;
    }

    public void setDemandOrder(String demandOrder) {
        this.demandOrder = demandOrder;
    }

    public void setOverallDesignRuleNum(String overallDesignRuleNum) {
        this.overallDesignRuleNum = overallDesignRuleNum;
    }

    public Demand(String demandId, @NotNull String demandName, String demandNum, String demandCategoryId, String demandCategoryName, String demandChildCategoryId, String demandChildCategoryName, String demandResume, String demandDescribe, Integer demandPriority, String demandAcceptCriteria, String demandRemarks, String productId, Integer demandState, Integer demandOrigin, Integer isCore, String realizeEdition, String normsNum, String demandOrder, String overallDesignRuleNum) {
        this.demandId = demandId;
        this.demandName = demandName;
        this.demandNum = demandNum;
        this.demandCategoryId = demandCategoryId;
        this.demandCategoryName = demandCategoryName;
        this.demandChildCategoryId = demandChildCategoryId;
        this.demandChildCategoryName = demandChildCategoryName;
        this.demandResume = demandResume;
        this.demandDescribe = demandDescribe;
        this.demandPriority = demandPriority;
        this.demandAcceptCriteria = demandAcceptCriteria;
        this.demandRemarks = demandRemarks;
        this.productId = productId;
        this.demandState = demandState;
        this.demandOrigin = demandOrigin;
        this.isCore = isCore;
        this.realizeEdition = realizeEdition;
        this.normsNum = normsNum;
        this.demandOrder = demandOrder;
        this.overallDesignRuleNum = overallDesignRuleNum;
    }

    public Demand() {
    }
}
