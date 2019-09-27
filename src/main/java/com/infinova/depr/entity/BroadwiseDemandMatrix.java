package com.infinova.depr.entity;

import java.io.Serializable;
import java.util.List;

/**
 * @author ldw
 * @date 2019/8/14 10:35
 */
public class BroadwiseDemandMatrix implements Serializable {
    private String achieveStageId;
    private String achieveStageName;
    private List<Regulation> regulationList;

    public String getAchieveStageId() {
        return achieveStageId;
    }

    public String getAchieveStageName() {
        return achieveStageName;
    }

    public List<Regulation> getRegulationList() {
        return regulationList;
    }

    public void setAchieveStageId(String achieveStageId) {
        this.achieveStageId = achieveStageId;
    }

    public void setAchieveStageName(String achieveStageName) {
        this.achieveStageName = achieveStageName;
    }

    public void setRegulationList(List<Regulation> regulationList) {
        this.regulationList = regulationList;
    }

    public BroadwiseDemandMatrix(String achieveStageId, String achieveStageName, List<Regulation> regulationList) {
        this.achieveStageId = achieveStageId;
        this.achieveStageName = achieveStageName;
        this.regulationList = regulationList;
    }

    public BroadwiseDemandMatrix() {
    }
}
