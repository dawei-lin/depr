package com.infinova.depr.service;

import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ldw
 * @date 2019/9/5 20:07
 */
@Service
public interface DemandOverallDesignRuleRelationService {
    List<String> getOverallDesignRuleIdsByDemandId(String demandId);
}
