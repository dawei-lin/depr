package com.infinova.depr.entity;

import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/8/14 10:38
 */
public class Regulation implements Serializable {
    private String regulationId;
    private String regulationName;
    private Boolean tick;

    public String getRegulationId() {
        return regulationId;
    }

    public String getRegulationName() {
        return regulationName;
    }

    public Boolean getTick() {
        return tick;
    }

    public void setRegulationId(String regulationId) {
        this.regulationId = regulationId;
    }

    public void setRegulationName(String regulationName) {
        this.regulationName = regulationName;
    }

    public void setTick(Boolean tick) {
        this.tick = tick;
    }

    public Regulation(String regulationId, String regulationName, Boolean tick) {
        this.regulationId = regulationId;
        this.regulationName = regulationName;
        this.tick = tick;
    }

    public Regulation() {
    }
}
