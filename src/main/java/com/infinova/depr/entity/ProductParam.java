package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/7/19 11:20
 */
public class ProductParam extends BaseParam implements Serializable {
    private static final long serialVersionUID = -800376611180051116L;
    private String productName;
    private Integer productType;
    private Integer productState;
    private String productLineId;
    private String[] productLineIds;
    private Boolean showNoClose;

    public String getProductName() {
        return productName;
    }

    public Integer getProductType() {
        return productType;
    }

    public Integer getProductState() {
        return productState;
    }

    public String getProductLineId() {
        return productLineId;
    }

    public String[] getProductLineIds() {
        return productLineIds;
    }

    public Boolean getShowNoClose() {
        return showNoClose;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setProductType(Integer productType) {
        this.productType = productType;
    }

    public void setProductState(Integer productState) {
        this.productState = productState;
    }

    public void setProductLineId(String productLineId) {
        this.productLineId = productLineId;
    }

    public void setProductLineIds(String[] productLineIds) {
        this.productLineIds = productLineIds;
    }

    public void setShowNoClose(Boolean showNoClose) {
        this.showNoClose = showNoClose;
    }

    public ProductParam(Integer pageNum, Integer pageSize, String productName, Integer productType, Integer productState, String productLineId, String[] productLineIds, Boolean showNoClose) {
        super(pageNum, pageSize);
        this.productName = productName;
        this.productType = productType;
        this.productState = productState;
        this.productLineId = productLineId;
        this.productLineIds = productLineIds;
        this.showNoClose = showNoClose;
    }

    public ProductParam(String productName, Integer productType, Integer productState, String productLineId, String[] productLineIds, Boolean showNoClose) {
        this.productName = productName;
        this.productType = productType;
        this.productState = productState;
        this.productLineId = productLineId;
        this.productLineIds = productLineIds;
        this.showNoClose = showNoClose;
    }

    public ProductParam() {
    }
}
