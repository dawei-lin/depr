package com.infinova.depr.service.impl;

import com.infinova.depr.dao.OverallDesignDao;
import com.infinova.depr.entity.OverallDesign;
import com.infinova.depr.service.OverallDesignService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author ldw
 * @date 2019/8/5 17:29
 */
@Service
public class OverallDesignServiceImpl implements OverallDesignService {
    @Autowired
    private OverallDesignDao overallDesignDao;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int saveDocUrl(OverallDesign overalldesign) {
        return overallDesignDao.saveDocUrl(overalldesign);
    }

    @Override
    public String getOverallDesignUrlById(String productId) {
        return overallDesignDao.getOverallDesignUrlById(productId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateOverallDesignUrl(String ovarallDesignUrl, String newFileMd5, String productId) {
        return overallDesignDao.updateOverallDesignUrl(ovarallDesignUrl, newFileMd5, productId);
    }

    @Override
    public String getfileMd5ByProductId(String productId) {
        return overallDesignDao.getfileMd5ByProductId(productId);
    }
}
