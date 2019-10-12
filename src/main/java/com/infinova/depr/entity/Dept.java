package com.infinova.depr.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * @author ldw
 * @date 2019/8/26 11:37
 */
public class Dept implements Serializable {
    private static final long serialVersionUID = 8671387672322284436L;
    private Integer id;
    private String departmentName;
    private String departmentCode;
    private String parentId;
    private String parentName;
    private String remark;
    private Date creatTime;
    private Integer lever;
    private List<Dept> children;
    private String sort;
    private String title;
    private String key;
    private String value;

    public Integer getId() {
        return id;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public String getDepartmentCode() {
        return departmentCode;
    }

    public String getParentId() {
        return parentId;
    }

    public String getParentName() {
        return parentName;
    }

    public String getRemark() {
        return remark;
    }

    public Date getCreatTime() {
        return creatTime;
    }

    public Integer getLever() {
        return lever;
    }

    public List<Dept> getChildren() {
        return children;
    }

    public String getSort() {
        return sort;
    }

    public String getTitle() {
        return title;
    }

    public String getKey() {
        return key;
    }

    public String getValue() {
        return value;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public void setDepartmentCode(String departmentCode) {
        this.departmentCode = departmentCode;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setCreatTime(Date creatTime) {
        this.creatTime = creatTime;
    }

    public void setLever(Integer lever) {
        this.lever = lever;
    }

    public void setChildren(List<Dept> children) {
        this.children = children;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Dept(Integer id, String departmentName, String departmentCode, String parentId, String parentName, String remark, Date creatTime, Integer lever, List<Dept> children, String sort, String title, String key, String value) {
        this.id = id;
        this.departmentName = departmentName;
        this.departmentCode = departmentCode;
        this.parentId = parentId;
        this.parentName = parentName;
        this.remark = remark;
        this.creatTime = creatTime;
        this.lever = lever;
        this.children = children;
        this.sort = sort;
        this.title = title;
        this.key = key;
        this.value = value;
    }

    public Dept() {
    }

}
