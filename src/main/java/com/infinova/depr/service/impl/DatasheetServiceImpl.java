package com.infinova.depr.service.impl;

import com.infinova.depr.dao.DatasheetDao;
import com.infinova.depr.entity.Datasheet;
import com.infinova.depr.service.DatasheetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author ldw
 * @date 2019/8/1 10:59
 */
@Service
public class DatasheetServiceImpl implements DatasheetService {
    @Autowired
    private DatasheetDao datasheetDao;

    @Override
    @Transactional(rollbackFor = Exception.class,propagation =Propagation.)
    public int saveDocUrl(Datasheet datasheet) {
        return datasheetDao.saveDocUrl(datasheet);
    }

    @Override
    public String getdatasheetUrlById(String productId) {
        return datasheetDao.getdatasheetUrlById(productId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateDatasheetUrl(String datasheetUrl, String newFileMd5, String productId) {
        return datasheetDao.updateDatasheetUrl(datasheetUrl, newFileMd5, productId);
    }

    @Override
    public String getfileMd5ByProductId(String productId) {
        return datasheetDao.getfileMd5ByProductId(productId);
    }

}
