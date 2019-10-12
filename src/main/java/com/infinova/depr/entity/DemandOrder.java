package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/7/23 16:46
 */
public class DemandOrder implements Serializable {
    private static final long serialVersionUID = 698038242802181767L;
    private String demandOrder;
    private String demandCategoryOrder;

    public String getDemandOrder() {
        return demandOrder;
    }

    public String getDemandCategoryOrder() {
        return demandCategoryOrder;
    }

    public void setDemandOrder(String demandOrder) {
        this.demandOrder = demandOrder;
    }

    public void setDemandCategoryOrder(String demandCategoryOrder) {
        this.demandCategoryOrder = demandCategoryOrder;
    }

    public DemandOrder(String demandOrder, String demandCategoryOrder) {
        this.demandOrder = demandOrder;
        this.demandCategoryOrder = demandCategoryOrder;
    }

    public DemandOrder() {
    }
}
