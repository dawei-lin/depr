package com.infinova.depr.entity;

/**
 * @author ldw
 * @date 2019/7/20 17:46
 */
public class DemandParam extends BaseParam {
    private String demandName;
    private Integer demandPriority;
    private Integer demandState;
    private String productId;
    private String demandNum;

    public String getDemandName() {
        return demandName;
    }

    public Integer getDemandPriority() {
        return demandPriority;
    }

    public Integer getDemandState() {
        return demandState;
    }

    public String getProductId() {
        return productId;
    }

    public String getDemandNum() {
        return demandNum;
    }

    public void setDemandName(String demandName) {
        this.demandName = demandName;
    }

    public void setDemandPriority(Integer demandPriority) {
        this.demandPriority = demandPriority;
    }

    public void setDemandState(Integer demandState) {
        this.demandState = demandState;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public void setDemandNum(String demandNum) {
        this.demandNum = demandNum;
    }

    public DemandParam(Integer pageNum, Integer pageSize, String demandName, Integer demandPriority, Integer demandState, String productId, String demandNum) {
        super(pageNum, pageSize);
        this.demandName = demandName;
        this.demandPriority = demandPriority;
        this.demandState = demandState;
        this.productId = productId;
        this.demandNum = demandNum;
    }

    public DemandParam(String demandName, Integer demandPriority, Integer demandState, String productId, String demandNum) {
        this.demandName = demandName;
        this.demandPriority = demandPriority;
        this.demandState = demandState;
        this.productId = productId;
        this.demandNum = demandNum;
    }

    public DemandParam() {

    }

}
