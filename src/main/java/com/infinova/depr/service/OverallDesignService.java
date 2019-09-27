package com.infinova.depr.service;

import com.infinova.depr.entity.OverallDesign;

/**
 * @author ldw
 * @date 2019/8/5 17:28
 */
public interface OverallDesignService {
    int saveDocUrl(OverallDesign overalldesign);

    String getOverallDesignUrlById(String productId);

    int updateOverallDesignUrl(String ovarallDesignUrl, String newFileMd5, String productId);

    String getfileMd5ByProductId(String productId);

}
