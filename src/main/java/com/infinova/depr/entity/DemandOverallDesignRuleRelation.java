package com.infinova.depr.entity;

import java.io.Serializable;
import java.util.Objects;

/**
 * @author ldw
 * @date 2019/9/5 19:11
 */
public class DemandOverallDesignRuleRelation implements Serializable {
    private String demandId;
    private String overallDesignRuleId;

    public String getDemandId() {
        return demandId;
    }

    public String getOverallDesignRuleId() {
        return overallDesignRuleId;
    }

    public void setDemandId(String demandId) {
        this.demandId = demandId;
    }

    public void setOverallDesignRuleId(String overallDesignRuleId) {
        this.overallDesignRuleId = overallDesignRuleId;
    }

    public DemandOverallDesignRuleRelation(String demandId, String overallDesignRuleId) {
        this.demandId = demandId;
        this.overallDesignRuleId = overallDesignRuleId;
    }

    public DemandOverallDesignRuleRelation() {
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        DemandOverallDesignRuleRelation that = (DemandOverallDesignRuleRelation) o;
        return Objects.equals(demandId, that.demandId) &&
                Objects.equals(overallDesignRuleId, that.overallDesignRuleId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(demandId, overallDesignRuleId);
    }
}
