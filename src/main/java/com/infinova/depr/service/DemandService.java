package com.infinova.depr.service;

import com.infinova.depr.entity.Demand;
import com.infinova.depr.entity.DemandParam;

import java.util.List;
import java.util.Map;

/**
 * @author ldw
 * @date 2019/7/22 16:07
 */
public interface DemandService {
    int saveDemand(Demand demand);

    int updateDemand(Demand demand);

    int deleteDemand(String demandId);

    Demand getDemandById(String demandId);

    List<Demand> getDemandListByParams(DemandParam demandParam);

    int getDemandCount(String productId);

    void importExcel(String productId, List<Demand> demandList);

    List<String> getDemandNums(String productId);

}
