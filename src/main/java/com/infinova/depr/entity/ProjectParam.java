package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/8/15 16:46
 */
public class ProjectParam extends BaseParam implements Serializable {
    private String projectName;
    private Integer projectState;
    private Integer projectType;
    private String productLineId;

    public String getProjectName() {
        return projectName;
    }

    public Integer getProjectState() {
        return projectState;
    }

    public Integer getProjectType() {
        return projectType;
    }

    public String getProductLineId() {
        return productLineId;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public void setProjectState(Integer projectState) {
        this.projectState = projectState;
    }

    public void setProjectType(Integer projectType) {
        this.projectType = projectType;
    }

    public void setProductLineId(String productLineId) {
        this.productLineId = productLineId;
    }

    public ProjectParam(Integer pageNum, Integer pageSize, String projectName, Integer projectState, Integer projectType, String productLineId) {
        super(pageNum, pageSize);
        this.projectName = projectName;
        this.projectState = projectState;
        this.projectType = projectType;
        this.productLineId = productLineId;
    }

    public ProjectParam(String projectName, Integer projectState, Integer projectType, String productLineId) {
        this.projectName = projectName;
        this.projectState = projectState;
        this.projectType = projectType;
        this.productLineId = productLineId;
    }

    public ProjectParam() {
    }

}
