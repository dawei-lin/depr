package com.infinova.depr.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

/**
 * @author ldw
 * @date 2019/8/15 15:54
 */
@ApiModel
public class Project implements Serializable {
    @ApiModelProperty("项目id")
    private String projectId;
    @ApiModelProperty("项目名字")
    @NotNull(message = "非空")
    @Size(min = 1, max = 100, message = "名字长度不符合")
    private String projectName;
    @ApiModelProperty("项目编号")
    @NotNull(message = "非空")
    @Size(min = 1, max = 100, message = "项目编号长度不符合")
    private String projectNum;
    @ApiModelProperty("立项时间")
    private Long projectTime;
    @NotNull(message = "非空")
    private Date projectDate;
    private String projectTimeStr;
    @NotNull(message = "非空")
    @ApiModelProperty("项目经理id")
    private String projectManagerId;
    @NotNull(message = "非空")
    @ApiModelProperty("项目经理名字")
    private String projectManagerName;
    @ApiModelProperty("项目类型")
    private Integer projectType;
    @ApiModelProperty("产品id")
    private String productId;
    @ApiModelProperty("产品名字")
    private String productName;
    @ApiModelProperty("重要度")
    private Integer projectImportance;
    @ApiModelProperty("紧急度")
    private Integer projectUrgency;
    @ApiModelProperty("项目描述")
    @Size(max = 500, message = "项目描述长度不符合")
    private String projectDescribe;
    @ApiModelProperty("项目状态")
    private Integer projectState;
    @ApiModelProperty("产品线id")
    private String productLineId;
    @ApiModelProperty("产品线名字")
    private String productLineName;
    @ApiModelProperty("四象限法则")
    private String quadrantRule;

    public String getProjectId() {
        return projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public String getProjectNum() {
        return projectNum;
    }

    public Long getProjectTime() {
        return projectTime;
    }

    public String getProjectManagerId() {
        return projectManagerId;
    }

    public String getProjectManagerName() {
        return projectManagerName;
    }

    public Integer getProjectType() {
        return projectType;
    }

    public String getProductId() {
        return productId;
    }

    public Integer getProjectImportance() {
        return projectImportance;
    }

    public Integer getProjectUrgency() {
        return projectUrgency;
    }

    public String getProjectDescribe() {
        return projectDescribe;
    }

    public Integer getProjectState() {
        return projectState;
    }

    public String getProductLineId() {
        return productLineId;
    }

    public String getQuadrantRule() {
        return quadrantRule;
    }

    public Date getProjectDate() {
        return projectDate;
    }

    public String getProjectTimeStr() {
        return projectTimeStr;
    }

    public String getProductName() {
        return productName;
    }

    public String getProductLineName() {
        return productLineName;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public void setProjectNum(String projectNum) {
        this.projectNum = projectNum;
    }

    public void setProjectTime(Long projectTime) {
        this.projectTime = projectTime;
    }

    public void setProjectManagerId(String projectManagerId) {
        this.projectManagerId = projectManagerId;
    }

    public void setProjectManagerName(String projectManagerName) {
        this.projectManagerName = projectManagerName;
    }

    public void setProjectType(Integer projectType) {
        this.projectType = projectType;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setProjectImportance(Integer projectImportance) {
        this.projectImportance = projectImportance;
    }

    public void setProjectUrgency(Integer projectUrgency) {
        this.projectUrgency = projectUrgency;
    }

    public void setProjectDescribe(String projectDescribe) {
        this.projectDescribe = projectDescribe;
    }

    public void setProjectState(Integer projectState) {
        this.projectState = projectState;
    }

    public void setProductLineId(String productLineId) {
        this.productLineId = productLineId;
    }

    public void setProjectDate(Date projectDate) {
        this.projectDate = projectDate;
    }

    public void setProjectTimeStr(String projectTimeStr) {
        this.projectTimeStr = projectTimeStr;
    }

    public void setQuadrantRule(String quadrantRule) {
        this.quadrantRule = quadrantRule;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setProductLineName(String productLineName) {
        this.productLineName = productLineName;
    }

    public Project(String projectId, String projectName, String projectNum, Long projectTime, Date projectDate, String projectTimeStr, String projectManagerId, String projectManagerName, Integer projectType, String productId, String productName, Integer projectImportance, Integer projectUrgency, String projectDescribe, Integer projectState, String productLineId, String productLineName, String quadrantRule) {
        this.projectId = projectId;
        this.projectName = projectName;
        this.projectNum = projectNum;
        this.projectTime = projectTime;
        this.projectDate = projectDate;
        this.projectTimeStr = projectTimeStr;
        this.projectManagerId = projectManagerId;
        this.projectManagerName = projectManagerName;
        this.projectType = projectType;
        this.productId = productId;
        this.productName = productName;
        this.projectImportance = projectImportance;
        this.projectUrgency = projectUrgency;
        this.projectDescribe = projectDescribe;
        this.projectState = projectState;
        this.productLineId = productLineId;
        this.productLineName = productLineName;
        this.quadrantRule = quadrantRule;
    }

    public Project() {
    }
}
