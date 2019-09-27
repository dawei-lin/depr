package com.infinova.depr.service;

import com.infinova.depr.entity.BroadwiseDemandMatrixId;
import com.infinova.depr.entity.DemandMatrix;
import com.infinova.depr.entity.DemandParam;

import java.util.List;

/**
 * @author ldw
 * @date 2019/8/13 17:25
 */
public interface DemandMatrixService {
    List<DemandMatrix> getDemandMatrixListByParams(DemandParam demandParam);

    int updateBroadwiseDemandMatrix(BroadwiseDemandMatrixId broadwiseDemandMatrixId, String productId);

    List<BroadwiseDemandMatrixId> getBroadwiseDemandMatrixIdByProductId(String productId);
}
