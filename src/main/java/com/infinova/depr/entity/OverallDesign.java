package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/8/5 17:05
 */
public class OverallDesign implements Serializable {
    private String overallDesignId;
    private String ovarallDesignUrl;
    private String productId;
    private String fileMd5;

    public String getOverallDesignId() {
        return overallDesignId;
    }

    public String getOvarallDesignUrl() {
        return ovarallDesignUrl;
    }

    public String getProductId() {
        return productId;
    }

    public String getFileMd5() {
        return fileMd5;
    }

    public void setOverallDesignId(String overallDesignId) {
        this.overallDesignId = overallDesignId;
    }

    public void setOvarallDesignUrl(String ovarallDesignUrl) {
        this.ovarallDesignUrl = ovarallDesignUrl;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setFileMd5(String fileMd5) {
        this.fileMd5 = fileMd5;
    }

    public OverallDesign(String overallDesignId, String ovarallDesignUrl, String productId, String fileMd5) {
        this.overallDesignId = overallDesignId;
        this.ovarallDesignUrl = ovarallDesignUrl;
        this.productId = productId;
        this.fileMd5 = fileMd5;
    }

    public OverallDesign() {
    }
}
