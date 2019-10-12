package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/8/14 11:13
 */
public class BroadwiseDemandMatrixId implements Serializable {
    private static final long serialVersionUID = 338790616072653797L;
    private String achieveStageId;
    private String[] regulationIds;
    private String regulationId;
    private Boolean tick;

    public String getAchieveStageId() {
        return achieveStageId;
    }

    public String[] getRegulationIds() {
        return regulationIds;
    }

    public String getRegulationId() {
        return regulationId;
    }

    public Boolean getTick() {
        return tick;
    }

    public void setAchieveStageId(String achieveStageId) {
        this.achieveStageId = achieveStageId;
    }

    public void setRegulationIds(String[] regulationIds) {
        this.regulationIds = regulationIds;
    }

    public void setRegulationId(String regulationId) {
        this.regulationId = regulationId;
    }

    public void setTick(Boolean tick) {
        this.tick = tick;
    }

    public BroadwiseDemandMatrixId(String achieveStageId, String[] regulationIds, String regulationId, Boolean tick) {
        this.achieveStageId = achieveStageId;
        this.regulationIds = regulationIds;
        this.regulationId = regulationId;
        this.tick = tick;
    }

    public BroadwiseDemandMatrixId() {
    }
}
