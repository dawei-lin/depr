package com.infinova.depr.service.impl;

import com.infinova.depr.dao.DemandDao;
import com.infinova.depr.dao.DemandMatrixDao;
import com.infinova.depr.entity.BroadwiseDemandMatrixId;
import com.infinova.depr.entity.Demand;
import com.infinova.depr.entity.DemandMatrix;
import com.infinova.depr.entity.DemandParam;
import com.infinova.depr.service.DemandMatrixService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author ldw
 * @date 2019/8/13 17:27
 */
@Service
public class DemandMatrixServiceImpl implements DemandMatrixService {
    @Autowired
    private DemandDao demandDao;
    @Autowired
    private DemandMatrixDao demandMatrixDao;
    private static Pattern FIGURE_PATTERN = Pattern.compile("[0-9]+");

    @Override
    public List<DemandMatrix> getDemandMatrixListByParams(DemandParam demandParam) {
        List<DemandMatrix> demandMatrixList = demandDao.getDemandMatrixListByParams(demandParam);
        Collections.sort(demandMatrixList, new Comparator<DemandMatrix>() {
            @Override
            public int compare(DemandMatrix o1, DemandMatrix o2) {
                String demandCategoryName1 = o1.getDemandCategoryName();
                String demandCategoryName2 = o2.getDemandCategoryName();
                String demandNum1 = o1.getDemandNum().substring(o1.getDemandNum().indexOf("-", 3) + 1);
                String demandNum2 = o2.getDemandNum().substring(o2.getDemandNum().indexOf("-", 3) + 1);
                int border1 = 0;
                int sorder1 = 0;
                int border2 = 0;
                int sorder2 = 0;
                Matcher matcher1 = FIGURE_PATTERN.matcher(demandCategoryName1);
                if (matcher1.find()) {
                    border1 = Integer.parseInt(matcher1.group(0));
                }
                if (matcher1.find()) {
                    sorder1 = Integer.parseInt(matcher1.group(0));
                }
                Matcher matcher2 = FIGURE_PATTERN.matcher(demandCategoryName2);
                if (matcher2.find()) {
                    border2 = Integer.parseInt(matcher2.group(0));
                }
                if (matcher2.find()) {
                    sorder2 = Integer.parseInt(matcher2.group(0));
                }
                /*int border1 = Integer.parseInt(demandCategoryName1.substring(0, demandCategoryName1.indexOf(".")));
                int border2 = Integer.parseInt(demandCategoryName2.substring(0, demandCategoryName1.indexOf(".")));
                int sorder1 = Integer.parseInt(demandCategoryName1.substring(demandCategoryName1.indexOf(".") + 1, demandCategoryName1.indexOf("、")));
                int sorder2 = Integer.parseInt(demandCategoryName2.substring(demandCategoryName1.indexOf(".") + 1, demandCategoryName2.indexOf("、")));*/
                if (border1 == border2) {
                    if (sorder1 == sorder2) {
                        return demandNum1.compareTo(demandNum2);
                    }
                    return sorder1 - sorder2;
                }
                return border1 - border2;
            }
        });
        return demandMatrixList;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateBroadwiseDemandMatrix(BroadwiseDemandMatrixId broadwiseDemandMatrixId, String productId) {
        int count = 0;
        String regulationIds = "";
        if (StringUtils.isNotEmpty(broadwiseDemandMatrixId.getAchieveStageId())) {
            regulationIds = demandMatrixDao.getRegulationIdByProductIdAndAchieveStageId(productId, broadwiseDemandMatrixId.getAchieveStageId());
        }
        if (StringUtils.isNotEmpty(regulationIds)) {
            if (broadwiseDemandMatrixId.getTick() != null && broadwiseDemandMatrixId.getTick() && !regulationIds.contains(broadwiseDemandMatrixId.getRegulationId())) {
                regulationIds += "," + broadwiseDemandMatrixId.getRegulationId();
            } else if (broadwiseDemandMatrixId.getTick() != null && !broadwiseDemandMatrixId.getTick() && regulationIds.contains(broadwiseDemandMatrixId.getRegulationId())) {
                if (regulationIds.contains("," + broadwiseDemandMatrixId.getRegulationId())) {
                    regulationIds = regulationIds.replace("," + broadwiseDemandMatrixId.getRegulationId(), "");
                } else {
                    regulationIds = regulationIds.replace(broadwiseDemandMatrixId.getRegulationId(), "");
                }
                if (regulationIds.startsWith(",")) {
                    regulationIds = regulationIds.substring(1);
                }
            }
        } else {
            if (broadwiseDemandMatrixId.getTick() != null && broadwiseDemandMatrixId.getTick()) {
                if (regulationIds == null) {
                    regulationIds = "";
                }
                regulationIds += broadwiseDemandMatrixId.getRegulationId();
            }
        }
        if (StringUtils.isNotEmpty(demandMatrixDao.getIdByProductIdAndAchieveStageId(productId, broadwiseDemandMatrixId.getAchieveStageId()))) {
            count = demandMatrixDao.updateBroadwiseDemandMatrix(regulationIds, broadwiseDemandMatrixId.getAchieveStageId(), productId);
        } else {
            count = demandMatrixDao.addBroadwiseDemandMatrix(regulationIds, broadwiseDemandMatrixId.getAchieveStageId(), productId);
        }
        return count;
    }

    @Override
    public List<BroadwiseDemandMatrixId> getBroadwiseDemandMatrixIdByProductId(String productId) {
        return demandMatrixDao.getBroadwiseDemandMatrixIdByProductId(productId);
    }

}
