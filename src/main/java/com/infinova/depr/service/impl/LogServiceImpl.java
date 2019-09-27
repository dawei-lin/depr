package com.infinova.depr.service.impl;

import com.infinova.depr.dao.LogDao;
import com.infinova.depr.entity.Log;
import com.infinova.depr.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author ldw
 * @date 2019/9/9 15:45
 */
@Service
public class LogServiceImpl implements LogService {
    @Autowired
    private LogDao logDao;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int saveLog(Log log) {
        return logDao.saveLog(log);
    }
}
