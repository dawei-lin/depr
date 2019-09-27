package com.infinova.depr.service.impl;

import com.infinova.depr.dao.DemandNormsRelationDao;
import com.infinova.depr.service.DemandNormsRelationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ldw
 * @date 2019/9/5 16:10
 */
@Service
public class DemandNormsRelationServiceImpl implements DemandNormsRelationService {
    @Autowired
    private DemandNormsRelationDao demandNormsRelationDao;

    @Override
    public List<String> getNormsIdsByDemandId(String demandId) {
        return demandNormsRelationDao.getNormsIdsByDemandId(demandId);
    }
}
