package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/7/20 10:15
 */
public class ProductIdAndName implements Serializable {
    private String productId;
    private String productName;

    public String getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public ProductIdAndName(String productId, String productName) {
        this.productId = productId;
        this.productName = productName;
    }

    public ProductIdAndName() {
    }
}
