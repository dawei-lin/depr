package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/8/7 13:44
 */
public class OverallDesignPicture implements Serializable {
    private static final long serialVersionUID = -501839984676963013L;
    private String overallDesignPictureId;
    private byte[] overallDesignPictureContext;
    private String overallDesignRuleId;

    public String getOverallDesignPictureId() {
        return overallDesignPictureId;
    }

    public byte[] getOverallDesignPictureContext() {
        return overallDesignPictureContext;
    }

    public String getOverallDesignRuleId() {
        return overallDesignRuleId;
    }

    public void setOverallDesignPictureId(String overallDesignPictureId) {
        this.overallDesignPictureId = overallDesignPictureId;
    }

    public void setOverallDesignPictureContext(byte[] overallDesignPictureContext) {
        this.overallDesignPictureContext = overallDesignPictureContext;
    }

    public void setOverallDesignRuleId(String overallDesignRuleId) {
        this.overallDesignRuleId = overallDesignRuleId;
    }

    public OverallDesignPicture(String overallDesignPictureId, byte[] overallDesignPictureContext, String overallDesignRuleId) {
        this.overallDesignPictureId = overallDesignPictureId;
        this.overallDesignPictureContext = overallDesignPictureContext;
        this.overallDesignRuleId = overallDesignRuleId;
    }

    public OverallDesignPicture() {
    }
}
