package com.infinova.depr.service;

import java.util.List;

/**
 * @author ldw
 * @date 2019/9/5 16:09
 */
public interface DemandNormsRelationService {
    List<String> getNormsIdsByDemandId(String demandId);
}
