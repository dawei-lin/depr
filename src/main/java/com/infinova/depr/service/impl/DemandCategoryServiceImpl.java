package com.infinova.depr.service.impl;

import com.infinova.depr.dao.DemandCategoryDao;
import com.infinova.depr.entity.DemandCategory;
import com.infinova.depr.service.DemandCategoryService;
import com.infinova.depr.utils.OrderUtil;
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
 * @date 2019/7/20 15:19
 */
@Service
public class DemandCategoryServiceImpl implements DemandCategoryService {
    @Autowired
    private DemandCategoryDao demandCategoryDao;
    private static Pattern FIGURE_PATTERN = Pattern.compile("[0-9]+");

    /**
     * 功能描述 获取父分类
     *
     * @param
     * @return java.util.List<com.infinova.depr.entity.DemandCategory>
     * @author ldw
     * @date 2019/7/25
     */
    @Override
    public List<DemandCategory> getDemandParentCategory(String productId) {
        List<DemandCategory> demandCategoryList = demandCategoryDao.getDemandParentCategory();
        demandCategoryList.addAll(demandCategoryDao.getDemandParentCategoryByProductId(productId));
        Collections.sort(demandCategoryList, new Comparator<DemandCategory>() {
            @Override
            public int compare(DemandCategory o1, DemandCategory o2) {
                String demandCategoryName1 = o1.getDemandCategoryName();
                String demandCategoryName2 = o2.getDemandCategoryName();
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
                    return sorder1 - sorder2;
                }
                return border1 - border2;
            }
        });
        return demandCategoryList;
    }

    /**
     * 功能描述 获取某父分类下的子分类
     *
     * @param categoryId
     * @return java.util.List<com.infinova.depr.entity.DemandCategory>
     * @author ldw
     * @date 2019/7/25
     */
    @Override
    public List<DemandCategory> getDemandCategoryById(String categoryId, String productId) {
        List<DemandCategory> demandCategoryList = demandCategoryDao.getDemandCategoryById(categoryId, productId);
        return demandCategoryList;
    }

    /**
     * 功能描述 添加一个分类
     *
     * @param demandCategory
     * @return int
     * @author ldw
     * @date 2019/7/25
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int addDemandCategory(DemandCategory demandCategory) {
        String maxOrder = "";
        if (!StringUtils.isNotEmpty(demandCategory.getDemandParentCategoryId())) {
            maxOrder = demandCategoryDao.getParentMaxOrder(demandCategory.getProductId());
            int curMax = 1;
            if (StringUtils.isNotEmpty(maxOrder)) {
                curMax = Integer.parseInt(maxOrder) + 1;
            }
            demandCategory.setDemandCategoryOrder(OrderUtil.getStringOrder(curMax, 3));
            demandCategory.setDemandCategoryName("1." + Integer.parseInt(demandCategory.getDemandCategoryOrder()) + "、" + demandCategory.getDemandCategoryName());
        }
        if (demandCategory.getDemandParentCategoryId() != null && "".equals(demandCategory.getDemandParentCategoryId())) {
            demandCategory.setDemandParentCategoryId(null);
        }
        return demandCategoryDao.addDemandCategory(demandCategory);
    }

    @Override
    public String getProductIdByDemandCategoryId(String demandCategoryId) {
        return demandCategoryDao.getProductIdByDemandCategoryId(demandCategoryId);
    }
}
