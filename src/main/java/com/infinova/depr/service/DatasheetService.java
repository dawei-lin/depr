package com.infinova.depr.service;

import com.infinova.depr.entity.Datasheet;

/**
 * @author ldw
 * @date 2019/8/1 10:59
 */
public interface DatasheetService {
    int saveDocUrl(Datasheet datasheet);

    String getdatasheetUrlById(String productId);

    int updateDatasheetUrl(String datasheetUrl, String newFileMd5, String productId);

    String getfileMd5ByProductId(String productId);

}
