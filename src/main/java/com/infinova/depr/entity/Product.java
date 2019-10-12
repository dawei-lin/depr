package com.infinova.depr.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.List;

/**
 * @author ldw
 * @date 2019/7/18 14:14
 */
@ApiModel("产品")
public class Product implements Serializable {
    private static final long serialVersionUID = -7949243755032293694L;
    @ApiModelProperty("产品id")
    private String productId;
    @ApiModelProperty("产品名称")
    @NotNull(message = "非空")
    @Size(min = 1, max = 100, message = "名字长度不符合")
    private String productName;
    @ApiModelProperty("产品编号")
    private String productNum;
    @ApiModelProperty("产品型号")
    @Size(max = 500, message = "产品型号长度不符合")
    private String productDesignation;
    @ApiModelProperty("产品类别")
    @NotNull(message = "非空")
    private Integer productType;
    @ApiModelProperty("产品负责人id")
    @NotNull(message = "非空")
    private String productManagerId;
    @ApiModelProperty("产品负责人名称")
    @NotNull(message = "非空")
    private String productManagerName;
    @ApiModelProperty("产品线ID")
    @NotNull
    private String productLineId;
    @ApiModelProperty("产品线名字")
    private String productLineName;
    @ApiModelProperty("产品描述")
    @Size(max = 500, message = "产品描述长度不符合")
    private String productDescribe;
    @ApiModelProperty("产品状态")
    private Integer productState;
    @ApiModelProperty("产品次序")
    private String productOrder;
    @ApiModelProperty("项目名字")
    private List<String> projectNames;
    @ApiModelProperty("项目次序")
    private String projectOrder;

    public String getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getProductNum() {
        return productNum;
    }

    public String getProductDesignation() {
        return productDesignation;
    }

    public Integer getProductType() {
        return productType;
    }

    public String getProductManagerId() {
        return productManagerId;
    }

    public String getProductManagerName() {
        return productManagerName;
    }

    public String getProductLineId() {
        return productLineId;
    }

    public String getProductLineName() {
        return productLineName;
    }

    public String getProductDescribe() {
        return productDescribe;
    }

    public Integer getProductState() {
        return productState;
    }

    public String getProductOrder() {
        return productOrder;
    }


    public String getProjectOrder() {
        return projectOrder;
    }

    public List<String> getProjectNames() {
        return projectNames;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setProductNum(String productNum) {
        this.productNum = productNum;
    }

    public void setProductDesignation(String productDesignation) {
        this.productDesignation = productDesignation;
    }

    public void setProductType(Integer productType) {
        this.productType = productType;
    }

    public void setProductManagerId(String productManagerId) {
        this.productManagerId = productManagerId;
    }

    public void setProductManagerName(String productManagerName) {
        this.productManagerName = productManagerName;
    }

    public void setProductLineId(String productLineId) {
        this.productLineId = productLineId;
    }

    public void setProductLineName(String productLineName) {
        this.productLineName = productLineName;
    }

    public void setProductDescribe(String productDescribe) {
        this.productDescribe = productDescribe;
    }

    public void setProductState(Integer productState) {
        this.productState = productState;
    }

    public void setProductOrder(String productOrder) {
        this.productOrder = productOrder;
    }


    public void setProjectOrder(String projectOrder) {
        this.projectOrder = projectOrder;
    }

    public void setProjectNames(List<String> projectNames) {
        this.projectNames = projectNames;
    }

    public Product(String productId, @NotNull(message = "非空") @Size(min = 1, max = 100, message = "长度不符合") String productName, String productNum, String productDesignation, @NotNull Integer productType, @NotNull String productManagerId, String productManagerName, @NotNull String productLineId, String productLineName, String productDescribe, Integer productState, String productOrder, List<String> projectNames, String projectOrder) {
        this.productId = productId;
        this.productName = productName;
        this.productNum = productNum;
        this.productDesignation = productDesignation;
        this.productType = productType;
        this.productManagerId = productManagerId;
        this.productManagerName = productManagerName;
        this.productLineId = productLineId;
        this.productLineName = productLineName;
        this.productDescribe = productDescribe;
        this.productState = productState;
        this.productOrder = productOrder;
        this.projectNames = projectNames;
        this.projectOrder = projectOrder;
    }

    public Product() {
    }
}
