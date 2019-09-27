package com.infinova.depr.entity;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/7/20 14:57
 */
public class DemandCategory implements Serializable {
    private String demandCategoryId;
    @NotNull(message = "非空")
    @Size(min = 1, max = 200, message = "名字长度不符合")
    private String demandCategoryName;
    @Size(max = 300, message = "描述长度不符合")
    private String demandCategoryDescribe;
    private String demandParentCategoryId;
    private String demandParentCategoryName;
    private String demandCategoryOrder;
    private String productId;

    public String getDemandCategoryId() {
        return demandCategoryId;
    }

    public String getDemandCategoryName() {
        return demandCategoryName;
    }

    public String getDemandCategoryDescribe() {
        return demandCategoryDescribe;
    }

    public String getDemandParentCategoryId() {
        return demandParentCategoryId;
    }

    public String getDemandParentCategoryName() {
        return demandParentCategoryName;
    }

    public String getDemandCategoryOrder() {
        return demandCategoryOrder;
    }

    public String getProductId() {
        return productId;
    }

    public void setDemandCategoryId(String demandCategoryId) {
        this.demandCategoryId = demandCategoryId;
    }

    public void setDemandCategoryName(String demandCategoryName) {
        this.demandCategoryName = demandCategoryName;
    }

    public void setDemandCategoryDescribe(String demandCategoryDescribe) {
        this.demandCategoryDescribe = demandCategoryDescribe;
    }

    public void setDemandParentCategoryId(String demandParentCategoryId) {
        this.demandParentCategoryId = demandParentCategoryId;
    }

    public void setDemandParentCategoryName(String demandParentCategoryName) {
        this.demandParentCategoryName = demandParentCategoryName;
    }

    public void setDemandCategoryOrder(String demandCategoryOrder) {
        this.demandCategoryOrder = demandCategoryOrder;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public DemandCategory(String demandCategoryId, String demandCategoryName, String demandCategoryDescribe, String demandParentCategoryId, String demandParentCategoryName, String demandCategoryOrder, String productId) {
        this.demandCategoryId = demandCategoryId;
        this.demandCategoryName = demandCategoryName;
        this.demandCategoryDescribe = demandCategoryDescribe;
        this.demandParentCategoryId = demandParentCategoryId;
        this.demandParentCategoryName = demandParentCategoryName;
        this.demandCategoryOrder = demandCategoryOrder;
        this.productId = productId;
    }

    public DemandCategory() {
    }
}
