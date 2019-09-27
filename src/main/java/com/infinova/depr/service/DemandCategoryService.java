package com.infinova.depr.service;

import com.infinova.depr.entity.DemandCategory;

import java.util.List;

/**
 * @author ldw
 * @date 2019/7/20 15:18
 */
public interface DemandCategoryService {
    List<DemandCategory> getDemandParentCategory(String productId);

    List<DemandCategory> getDemandCategoryById(String categoryId, String productId);

    int addDemandCategory(DemandCategory demandCategory);

    String getProductIdByDemandCategoryId(String demandCategoryId);

}
