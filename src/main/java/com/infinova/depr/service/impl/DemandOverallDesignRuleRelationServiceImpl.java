package com.infinova.depr.service.impl;

import com.infinova.depr.dao.DemandOverallDesignRuleRelationDao;
import com.infinova.depr.service.DemandOverallDesignRuleRelationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ldw
 * @date 2019/9/5 20:09
 */
@Service
public class DemandOverallDesignRuleRelationServiceImpl implements DemandOverallDesignRuleRelationService {
    @Autowired
    private DemandOverallDesignRuleRelationDao demandOverallDesignRuleRelationDao;

    @Override
    public List<String> getOverallDesignRuleIdsByDemandId(String demandId) {
        return demandOverallDesignRuleRelationDao.getOverallDesignRuleIdsByDemandId(demandId);
    }
}
