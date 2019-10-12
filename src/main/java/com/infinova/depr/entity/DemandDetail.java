package com.infinova.depr.entity;

import java.io.Serializable;
import java.util.List;

/**
 * @author ldw
 * @date 2019/8/13 14:30
 */
public class DemandDetail implements Serializable {
    private static final long serialVersionUID = -4180726433424488421L;
    private Demand demand;
    private List<Norms> normsList;
    private List<OverallDesignRule> overallDesignRuleList;
    private Boolean functionDemand;

    public Demand getDemand() {
        return demand;
    }

    public List<Norms> getNormsList() {
        return normsList;
    }

    public List<OverallDesignRule> getOverallDesignRuleList() {
        return overallDesignRuleList;
    }

    public Boolean getFunctionDemand() {
        return functionDemand;
    }

    public void setDemand(Demand demand) {
        this.demand = demand;
    }

    public void setNormsList(List<Norms> normsList) {
        this.normsList = normsList;
    }

    public void setOverallDesignRuleList(List<OverallDesignRule> overallDesignRuleList) {
        this.overallDesignRuleList = overallDesignRuleList;
    }

    public void setFunctionDemand(Boolean functionDemand) {
        this.functionDemand = functionDemand;
    }

    public DemandDetail(Demand demand, List<Norms> normsList, List<OverallDesignRule> overallDesignRuleList, Boolean functionDemand) {
        this.demand = demand;
        this.normsList = normsList;
        this.overallDesignRuleList = overallDesignRuleList;
        this.functionDemand = functionDemand;
    }

    public DemandDetail() {
    }
}
