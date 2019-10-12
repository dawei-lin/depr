package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/8/1 10:52
 */
public class Datasheet implements Serializable {
    private static final long serialVersionUID = 4542329613661005987L;
    private String datasheetId;
    private String datasheetUrl;
    private String productId;
    private String fileMd5;

    public String getDatasheetId() {
        return datasheetId;
    }

    public String getDatasheetUrl() {
        return datasheetUrl;
    }

    public String getProductId() {
        return productId;
    }

    public String getFileMd5() {
        return fileMd5;
    }

    public void setDatasheetId(String datasheetId) {
        this.datasheetId = datasheetId;
    }

    public void setDatasheetUrl(String datasheetUrl) {
        this.datasheetUrl = datasheetUrl;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setFileMd5(String fileMd5) {
        this.fileMd5 = fileMd5;
    }

    public Datasheet(String datasheetId, String datasheetUrl, String productId, String fileMd5) {
        this.datasheetId = datasheetId;
        this.datasheetUrl = datasheetUrl;
        this.productId = productId;
        this.fileMd5 = fileMd5;
    }

    public Datasheet() {
    }
}
