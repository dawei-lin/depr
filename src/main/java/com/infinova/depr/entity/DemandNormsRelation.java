package com.infinova.depr.entity;

import java.io.Serializable;
import java.util.Objects;

/**
 * @author ldw
 * @date 2019/9/5 15:34
 */
public class DemandNormsRelation implements Serializable {
    private String demandId;
    private String normsId;

    public String getDemandId() {
        return demandId;
    }

    public String getNormsId() {
        return normsId;
    }

    public void setDemandId(String demandId) {
        this.demandId = demandId;
    }

    public void setNormsId(String normsId) {
        this.normsId = normsId;
    }

    public DemandNormsRelation(String demandId, String normsId) {
        this.demandId = demandId;
        this.normsId = normsId;
    }

    public DemandNormsRelation() {
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        DemandNormsRelation that = (DemandNormsRelation) o;
        return Objects.equals(demandId, that.demandId) &&
                Objects.equals(normsId, that.normsId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(demandId, normsId);
    }
}
