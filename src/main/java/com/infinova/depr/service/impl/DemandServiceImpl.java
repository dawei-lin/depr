package com.infinova.depr.service.impl;

import com.infinova.depr.dao.DemandCategoryDao;
import com.infinova.depr.dao.DemandDao;
import com.infinova.depr.dao.DemandNormsRelationDao;
import com.infinova.depr.dao.DemandOverallDesignRuleRelationDao;
import com.infinova.depr.dao.NormsDao;
import com.infinova.depr.dao.OverallDesignRuleDao;
import com.infinova.depr.entity.*;
import com.infinova.depr.service.DemandService;
import com.infinova.depr.utils.OrderUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author ldw
 * @date 2019/7/22 16:08
 */
@Service
public class DemandServiceImpl implements DemandService {
    @Autowired
    private DemandDao demandDao;
    @Autowired
    private DemandCategoryDao demandCategoryDao;
    @Autowired
    private NormsDao normsDao;
    @Autowired
    private OverallDesignRuleDao overallDesignRuleDao;
    @Autowired
    private DemandNormsRelationDao demandNormsRelationDao;
    @Autowired
    private DemandOverallDesignRuleRelationDao demandOverallDesignRuleRelationDao;
    private static Pattern FIGURE_PATTERN = Pattern.compile("[0-9]+");

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int saveDemand(Demand demand) {
        String maxOrder = "";
        //获取大分类的序号,即00X的序号
        String categoryOrder = demandCategoryDao.getOredrById(demand.getDemandCategoryId());
        //根据大分类id和小分类id获取最大需求序号
        maxOrder = demandDao.getParentMaxOrderByProductId(demand.getDemandCategoryId(), demand.getDemandChildCategoryId(), demand.getProductId());
        int curMax = 1;
        String prefix = "";
        /**
         *先判断最大的序号是否存在：存在则比较需求名称和子分类名称是否相同，相同则要生成规则为UF-00X-00Y-00Z，不同规则为UF-00X-00Y，
         * 根据最大的序号来决定生成规则，如果本身就是UF-00X-00Y-00Z这种，则只需要在最后的地方加一即可，不是则要对UF-00X-00Y这种加一，
         * 再在最后添加-001合成一个UF-00X-00Y-00Z，其他根据这种规则生成
         */
        if (StringUtils.isNotEmpty(maxOrder)) {
            if (demand.getDemandName().equals(demand.getDemandChildCategoryName())) {
                if (maxOrder.split("-").length > 1) {
                    prefix = maxOrder.substring(0, maxOrder.lastIndexOf("-"));
                    maxOrder = maxOrder.substring(maxOrder.lastIndexOf("-") + 1);
                } else {
                    prefix = OrderUtil.getStringOrder(Integer.parseInt(maxOrder) + 1, 3);
                    maxOrder = OrderUtil.getStringOrder(0, 3);
                }
            } else {
                if (maxOrder.split("-").length > 1) {
                    maxOrder = maxOrder.substring(0, maxOrder.lastIndexOf("-"));
                }
            }
        } else {
            String order = "";
            if (OrderUtil.nameToNum.containsKey(demand.getDemandCategoryName())) {
                order = demandDao.getMaxOrderByProductId(demand.getDemandCategoryId(), demand.getProductId());
            } else {
                order = demandDao.gettMaxOrder(demand.getDemandCategoryId());
            }
            if (demand.getDemandName().equals(demand.getDemandChildCategoryName())) {
                if (StringUtils.isNotEmpty(order)) {
                    if (order.split("-").length > 1) {
                        prefix = OrderUtil.getStringOrder(Integer.parseInt(order.substring(0, order.lastIndexOf("-"))) + 1, 3);
                        maxOrder = OrderUtil.getStringOrder(0, 3);
                    } else {
                        prefix = OrderUtil.getStringOrder(Integer.parseInt(order) + 1, 3);
                        maxOrder = OrderUtil.getStringOrder(0, 3);
                    }
                } else {
                    prefix = OrderUtil.getStringOrder(1, 3);
                    maxOrder = OrderUtil.getStringOrder(0, 3);
                }
            } else {
                if (StringUtils.isNotEmpty(order)) {
                    if (order.split("-").length > 1) {
                        maxOrder = order.substring(0, order.lastIndexOf("-"));
                    } else {
                        maxOrder = order;
                    }
                } else {
                    maxOrder = OrderUtil.getStringOrder(0, 3);
                }
            }
        }
        if (StringUtils.isNotEmpty(maxOrder)) {
            curMax = Integer.parseInt(maxOrder) + 1;
        }
        maxOrder = OrderUtil.getStringOrder(curMax, 3);
        if (StringUtils.isNotEmpty(prefix)) {
            demand.setDemandOrder(prefix + "-" + maxOrder);
        } else {
            demand.setDemandOrder(maxOrder);
        }
        demand.setDemandNum(OrderUtil.getNum(OrderUtil.getPrefix(demand.getDemandCategoryName()), categoryOrder, prefix, maxOrder));
        return demandDao.saveDemand(demand);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateDemand(Demand demand) {
        //根据父子目录id确定该需求编号是否需要更新
        String demandId = demandDao.getDemandIdByIds(demand.getDemandId(), demand.getDemandCategoryId(), demand.getDemandChildCategoryId());
        //需要更新
        if (!StringUtils.isNotEmpty(demandId)) {
            Demand demandTemp = demandDao.getDemandById(demand.getDemandId());
            String demandNum = "";
            if (demandTemp != null) {
                demandNum = demandTemp.getDemandNum();
            }
            //确定需求编号的长度，如果为UF-00X-00Y-OOZ这种四段式的
            if (demandNum.split("-") != null && demandNum.split("-").length > 3) {
                int count = demandDao.getCountByCategoryIds(demandTemp.getDemandCategoryId(), demandTemp.getDemandChildCategoryId());
                //确定该父子目录下的需求数量是多少如果为1，那么需求所有比它大的编号数量都减一
                if (count == 1) {
                    List<Demand> demandUpdateList = demandDao.getDemandListByDemandNum(demandTemp.getProductId(), demandTemp.getDemandNum(), demandTemp.getDemandCategoryId(), null);
                    if (demandUpdateList != null && demandUpdateList.size() > 0) {
                        for (Demand temp : demandUpdateList) {
                            String demandNumTemp = temp.getDemandNum();
                            if (StringUtils.isNotEmpty(demandNumTemp)) {
                                String[] strs = demandNumTemp.split("-");
                                if (strs.length > 2) {
                                    strs[2] = OrderUtil.getStringOrder(Integer.parseInt(strs[2]) - 1, 3);
                                }
                                String newDemandNum = "";
                                for (String str : strs) {
                                    if (StringUtils.isNotEmpty(newDemandNum)) {
                                        newDemandNum += "-" + str;
                                    } else {
                                        newDemandNum += str;
                                    }
                                }
                                String newDemandOrder = "";
                                for (int i = 2; i < strs.length; i++) {
                                    if (StringUtils.isNotEmpty(newDemandOrder)) {
                                        newDemandOrder += "-" + strs[i];
                                    } else {
                                        newDemandOrder += strs[i];
                                    }
                                }
                                temp.setDemandNum(newDemandNum);
                                temp.setDemandOrder(newDemandOrder);
                            }
                        }
                        demandDao.updateDemandNumList(demandUpdateList);
                    }
                } else {
                    List<Demand> demandUpdateList = demandDao.getDemandListByDemandNum(demandTemp.getProductId(), demandTemp.getDemandNum(), demandTemp.getDemandCategoryId(), demandTemp.getDemandChildCategoryId());
                    if (demandUpdateList != null && demandUpdateList.size() > 0) {
                        for (Demand temp : demandUpdateList) {
                            String demandNumTemp = temp.getDemandNum();
                            if (StringUtils.isNotEmpty(demandNumTemp)) {
                                String[] strs = demandNumTemp.split("-");
                                if (strs.length > 3) {
                                    strs[3] = OrderUtil.getStringOrder(Integer.parseInt(strs[3]) - 1, 3);
                                }
                                String newDemandNum = "";
                                for (String str : strs) {
                                    if (StringUtils.isNotEmpty(newDemandNum)) {
                                        newDemandNum += "-" + str;
                                    } else {
                                        newDemandNum += str;
                                    }
                                }
                                String newDemandOrder = "";
                                for (int i = 2; i < strs.length; i++) {
                                    if (StringUtils.isNotEmpty(newDemandOrder)) {
                                        newDemandOrder += "-" + strs[i];
                                    } else {
                                        newDemandOrder += strs[i];
                                    }
                                }
                                temp.setDemandNum(newDemandNum);
                                temp.setDemandOrder(newDemandOrder);
                            }
                        }
                        demandDao.updateDemandNumList(demandUpdateList);
                    }
                }
            } else if (demandNum.split("-") != null && demandNum.split("-").length <= 3 && demandNum.split("-").length > 0) {
                List<Demand> demandUpdateList = demandDao.getDemandListByDemandNum(demandTemp.getProductId(), demandTemp.getDemandNum(), demandTemp.getDemandCategoryId(), null);
                if (demandUpdateList != null && demandUpdateList.size() > 0) {
                    for (Demand temp : demandUpdateList) {
                        String demandNumTemp = temp.getDemandNum();
                        if (StringUtils.isNotEmpty(demandNumTemp)) {
                            String[] strs = demandNumTemp.split("-");
                            if (strs.length > 2) {
                                strs[2] = OrderUtil.getStringOrder(Integer.parseInt(strs[2]) - 1, 3);
                            }
                            String newDemandNum = "";
                            for (String str : strs) {
                                if (StringUtils.isNotEmpty(newDemandNum)) {
                                    newDemandNum += "-" + str;
                                } else {
                                    newDemandNum += str;
                                }
                            }
                            String newDemandOrder = "";
                            for (int i = 2; i < strs.length; i++) {
                                if (StringUtils.isNotEmpty(newDemandOrder)) {
                                    newDemandOrder += "-" + strs[i];
                                } else {
                                    newDemandOrder += strs[i];
                                }
                            }
                            temp.setDemandNum(newDemandNum);
                            temp.setDemandOrder(newDemandOrder);
                        }
                    }
                    demandDao.updateDemandNumList(demandUpdateList);
                }
            }
            //先更改原来所属父子类的编号，再以将这条需求编号以新需求的形式更新
            String maxOrder = "";
            //获取大分类的序号,即00X的序号
            String categoryOrder = demandCategoryDao.getOredrById(demand.getDemandCategoryId());
            //根据大分类id和小分类id获取最大需求序号
            if (OrderUtil.nameToNum.containsKey(demand.getDemandCategoryName())) {
                maxOrder = demandDao.getParentMaxOrderByProductId(demand.getDemandCategoryId(), demand.getDemandChildCategoryId(), demand.getProductId());
            } else {
                maxOrder = demandDao.getParentMaxOrder(demand.getDemandCategoryId(), demand.getDemandChildCategoryId());
            }
            int curMax = 1;
            String prefix = "";
            /**
             *先判断最大的序号是否存在：存在则比较需求名称和子分类名称是否相同，相同则要生成规则为UF-00X-00Y-00Z，不同规则为UF-00X-00Y，
             * 根据最大的序号来决定生成规则，如果本身就是UF-00X-00Y-00Z这种，则只需要在最后的地方加一即可，不是则要对UF-00X-00Y这种加一，
             * 再在最后添加-001合成一个UF-00X-00Y-00Z，其他根据这种规则生成
             */
            if (StringUtils.isNotEmpty(maxOrder)) {
                if (demand.getDemandName().equals(demand.getDemandChildCategoryName())) {
                    if (maxOrder.split("-").length > 1) {
                        prefix = maxOrder.substring(0, maxOrder.lastIndexOf("-"));
                        maxOrder = maxOrder.substring(maxOrder.lastIndexOf("-") + 1);
                    } else {
                        prefix = OrderUtil.getStringOrder(Integer.parseInt(maxOrder) + 1, 3);
                        maxOrder = OrderUtil.getStringOrder(0, 3);
                    }
                } else {
                    if (maxOrder.split("-").length > 1) {
                        maxOrder = maxOrder.substring(0, maxOrder.lastIndexOf("-"));
                    }
                }
            } else {
                String order = "";
                if (OrderUtil.nameToNum.containsKey(demand.getDemandCategoryName())) {
                    order = demandDao.getMaxOrderByProductId(demand.getDemandCategoryId(), demand.getProductId());
                } else {
                    order = demandDao.gettMaxOrder(demand.getDemandCategoryId());
                }
                if (demand.getDemandName().equals(demand.getDemandChildCategoryName())) {
                    if (StringUtils.isNotEmpty(order)) {
                        if (order.split("-").length > 1) {
                            prefix = OrderUtil.getStringOrder(Integer.parseInt(order.substring(0, order.lastIndexOf("-"))) + 1, 3);
                            maxOrder = OrderUtil.getStringOrder(0, 3);
                        } else {
                            prefix = OrderUtil.getStringOrder(Integer.parseInt(order) + 1, 3);
                            maxOrder = OrderUtil.getStringOrder(0, 3);
                        }
                    } else {
                        prefix = OrderUtil.getStringOrder(1, 3);
                        maxOrder = OrderUtil.getStringOrder(0, 3);
                    }
                } else {
                    if (StringUtils.isNotEmpty(order)) {
                        if (order.split("-").length > 1) {
                            maxOrder = order.substring(0, order.lastIndexOf("-"));
                        } else {
                            maxOrder = order;
                        }
                    } else {
                        maxOrder = OrderUtil.getStringOrder(0, 3);
                    }
                }
            }
            if (StringUtils.isNotEmpty(maxOrder)) {
                curMax = Integer.parseInt(maxOrder) + 1;
            }
            maxOrder = OrderUtil.getStringOrder(curMax, 3);
            if (StringUtils.isNotEmpty(prefix)) {
                demand.setDemandOrder(prefix + "-" + maxOrder);
            } else {
                demand.setDemandOrder(maxOrder);
            }
            demand.setDemandNum(OrderUtil.getNum(OrderUtil.getPrefix(demand.getDemandCategoryName()), categoryOrder, prefix, maxOrder));
        } else {
            demand.setDemandNum(demandDao.getDemandNumByDemandId(demand.getDemandId()));
        }

        if (demand != null && StringUtils.isNotEmpty(demand.getNormsNum())) {
            demand.setNormsNum(demand.getNormsNum().replace(",", "\n"));
        }
        if (demand != null && StringUtils.isNotEmpty(demand.getOverallDesignRuleNum())) {
            demand.setOverallDesignRuleNum(demand.getOverallDesignRuleNum().replace(",", "\n"));
        }

        int count = demandDao.updateDemand(demand);
        //开始关联规格编号，先删除该需求关联的规格
        demandNormsRelationDao.deleteNormsByDemandId(demand.getDemandId());
        if (StringUtils.isNotEmpty(demand.getNormsNum())) {
            List<Norms> normsList = normsDao.getNormsIdToNum(demand.getProductId());
            List<DemandNormsRelation> demandNormsRelations = new ArrayList<>();
            if (normsList != null) {
                for (Norms norms : normsList) {
                    if (StringUtils.isNotEmpty(norms.getNormsId()) && StringUtils.isNotEmpty(norms.getNormsNum())) {
                        if (demand.getNormsNum().contains(norms.getNormsNum())) {
                            DemandNormsRelation demandNormsRelation = new DemandNormsRelation();
                            demandNormsRelation.setDemandId(demand.getDemandId());
                            demandNormsRelation.setNormsId(norms.getNormsId());
                            demandNormsRelations.add(demandNormsRelation);
                        }
                    }
                }
            }
            if (demandNormsRelations.size() > 0) {
                demandNormsRelationDao.saveDemandNormsRelationList(demandNormsRelations);
            }
        }

        demandOverallDesignRuleRelationDao.deleteOverallDesignRuleByDemandId(demand.getDemandId());
        if (StringUtils.isNotEmpty(demand.getOverallDesignRuleNum())) {
            List<OverallDesignRule> overallDesignRuleList = overallDesignRuleDao.getOverallDesignRuleIdToNum(demand.getProductId());
            List<DemandOverallDesignRuleRelation> demandOverallDesignRuleRelations = new ArrayList<>();
            if (overallDesignRuleList != null) {
                for (OverallDesignRule overallDesignRule : overallDesignRuleList) {
                    if (StringUtils.isNotEmpty(overallDesignRule.getOverallDesignRuleId()) && StringUtils.isNotEmpty(overallDesignRule.getOverallDesignRuleNum())) {
                        if (demand.getOverallDesignRuleNum().contains(overallDesignRule.getOverallDesignRuleNum())) {
                            DemandOverallDesignRuleRelation demandOverallDesignRuleRelation = new DemandOverallDesignRuleRelation();
                            demandOverallDesignRuleRelation.setDemandId(demand.getDemandId());
                            demandOverallDesignRuleRelation.setOverallDesignRuleId(overallDesignRule.getOverallDesignRuleId());
                            demandOverallDesignRuleRelations.add(demandOverallDesignRuleRelation);
                        }
                    }
                }
            }
            if (demandOverallDesignRuleRelations.size() > 0) {
                demandOverallDesignRuleRelationDao.saveDemandOverallDesignRuleRelationList(demandOverallDesignRuleRelations);
            }
        }
        return count;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteDemand(String demandId) {
        return demandDao.deleteDemand(demandId);
    }

    @Override
    public Demand getDemandById(String demandId) {
        Demand demand = demandDao.getDemandById(demandId);
        if (demand != null && StringUtils.isNotEmpty(demand.getDemandCategoryId())) {
            demand.setDemandCategoryName(demandCategoryDao.getDemandCategoryNameById(demand.getDemandCategoryId()));
        }
        if (demand != null && StringUtils.isNotEmpty(demand.getDemandChildCategoryId())) {
            demand.setDemandChildCategoryName(demandCategoryDao.getDemandCategoryNameById(demand.getDemandChildCategoryId()));
        }
        if (demand != null && StringUtils.isNotEmpty(demand.getNormsNum())) {
            demand.setNormsNum(demand.getNormsNum().replace("\n", ","));
        }
        if (demand != null && StringUtils.isNotEmpty(demand.getOverallDesignRuleNum())) {
            demand.setOverallDesignRuleNum(demand.getOverallDesignRuleNum().replace("\n", ","));
        }
        return demand;
    }

    @Override
    public List<Demand> getDemandListByParams(DemandParam demandParam) {
        List<Demand> demandList = demandDao.getDemandListByParams(demandParam);
        Collections.sort(demandList, new Comparator<Demand>() {
            @Override
            public int compare(Demand o1, Demand o2) {
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
        return demandList;
    }

    @Override
    public int getDemandCount(String productId) {
        return demandDao.getDemandCount(productId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void importExcel(String productId, List<Demand> demandList) {
        /**
         *分为两类进行导入，UF编号开头的要把需求的大类和小类也导入到表中，而其他的就只需要导入该需求就可以
         */
        for (int i = 0; i < demandList.size(); i++) {
            Demand demand = demandList.get(i);
            String demandNum = demand.getDemandNum();
            demand.setProductId(productId);
            if (demandNum.startsWith("UF")) {
                /**
                 *先检查大类是否存在，不存在则开始插入，并返回大类的id，然后开始插入小类，如果该大类下的小类也不存在，则开始导入小类并返回id
                 */
                String demandCategoryId = demandCategoryDao.getDemandCategoryIdByNameAndProductId(demand.getDemandCategoryName(), productId);
                if (!StringUtils.isNotEmpty(demandCategoryId)) {
                    DemandCategory demandCategory = new DemandCategory();
                    demandCategory.setProductId(demand.getProductId());
                    demandCategory.setDemandCategoryName(demand.getDemandCategoryName());
                    demandCategory.setDemandCategoryOrder(demandNum.substring(demandNum.indexOf("-") + 1, demandNum.indexOf("-", 3)));
                    demandCategoryDao.addDemandCategory(demandCategory);
                    demandCategoryId = demandCategoryDao.getDemandCategoryIdByNameAndProductId(demand.getDemandCategoryName(), productId);
                }
                demand.setDemandCategoryId(demandCategoryId);
                if (StringUtils.isNotEmpty(demand.getDemandChildCategoryName())) {
                    String demandChildCategoryId = demandCategoryDao.getDemandCategoryIdByNameAndCategoryId(demand.getDemandChildCategoryName(), demandCategoryId, productId);
                    if (!StringUtils.isNotEmpty(demandChildCategoryId)) {
                        DemandCategory demandCategory = new DemandCategory();
                        demandCategory.setProductId(demand.getProductId());
                        demandCategory.setDemandCategoryName(demand.getDemandChildCategoryName());
                        demandCategory.setDemandParentCategoryId(demandCategoryId);
                        demandCategoryDao.addDemandCategory(demandCategory);
                        demandChildCategoryId = demandCategoryDao.getDemandCategoryIdByNameAndCategoryId(demand.getDemandChildCategoryName(), demandCategoryId, productId);
                    }
                    demand.setDemandChildCategoryId(demandChildCategoryId);
                }
            } else {
                String demandCategoryId = demandCategoryDao.getDemandCategoryIdByName(demand.getDemandCategoryName());
                demand.setDemandCategoryId(demandCategoryId);
                if (StringUtils.isNotEmpty(demand.getDemandChildCategoryName())) {
                    String demandChildCategoryId = demandCategoryDao.getDemandCategoryIdByNameAndCategoryId(demand.getDemandChildCategoryName(), demandCategoryId, productId);
                    if (!StringUtils.isNotEmpty(demandChildCategoryId)) {
                        DemandCategory demandCategory = new DemandCategory();
                        demandCategory.setProductId(demand.getProductId());
                        demandCategory.setDemandCategoryName(demand.getDemandChildCategoryName());
                        demandCategory.setDemandParentCategoryId(demandCategoryId);
                        demandCategoryDao.addDemandCategory(demandCategory);
                        demandChildCategoryId = demandCategoryDao.getDemandCategoryIdByNameAndCategoryId(demand.getDemandChildCategoryName(), demandCategoryId, productId);
                    }
                    demand.setDemandChildCategoryId(demandChildCategoryId);
                }
            }
            //根据num生成需求的order
            if (StringUtils.isNotEmpty(demand.getDemandNum())) {
                String[] strs = demand.getDemandNum().split("-");
                String demandOrderTemp = "";
                for (int j = 2; j < strs.length; j++) {
                    if (StringUtils.isNotEmpty(demandOrderTemp)) {
                        demandOrderTemp += "-" + strs[j];
                    } else {
                        demandOrderTemp += strs[j];
                    }
                }
                demand.setDemandOrder(demandOrderTemp);
            }
        }
        if (demandList.size() > 0) {
            demandDao.saveDemandList(demandList);

            //保存完需求，关联规格编号和总体设计说明书编号
            demandList = demandDao.getDemandNorms(productId);
            Map<String, List<String>> numToId = new HashMap<>();
            for (Demand demand : demandList) {
                String normsNum = demand.getNormsNum();
                String demandId = demand.getDemandId();
                if (StringUtils.isNotEmpty(normsNum)) {
                    String[] strs = normsNum.split("\n");
                    for (String str : strs) {
                        List<String> demandIds = numToId.get(str);
                        if (demandIds == null) {
                            demandIds = new ArrayList<>();
                        }
                        demandIds.add(demandId);
                        numToId.put(str, demandIds);
                    }
                }
            }
            List<Norms> normsIdToNum = normsDao.getNormsIdToNum(productId);
            List<DemandNormsRelation> demandNormsRelations = new ArrayList<>();
            if (normsIdToNum != null) {
                for (Norms norms : normsIdToNum) {
                    if (StringUtils.isNotEmpty(norms.getNormsId()) && StringUtils.isNotEmpty(norms.getNormsNum())) {
                        if (numToId.get(norms.getNormsNum()) != null) {
                            List<String> demandIds = numToId.get(norms.getNormsNum());
                            for (String demandId : demandIds) {
                                DemandNormsRelation demandNormsRelation = new DemandNormsRelation();
                                demandNormsRelation.setDemandId(demandId);
                                demandNormsRelation.setNormsId(norms.getNormsId());
                                if (!demandNormsRelations.contains(demandNormsRelation)) {
                                    demandNormsRelations.add(demandNormsRelation);
                                }
                            }
                        }
                    }
                }
            }
            if (demandNormsRelations.size() > 0) {
                demandNormsRelationDao.saveDemandNormsRelationList(demandNormsRelations);
            }


            demandList = demandDao.getDemandOverallDesignRule(productId);
            numToId = new HashMap<>();
            for (Demand demand : demandList) {
                String overallDesignRuleNum = demand.getOverallDesignRuleNum();
                String demandId = demand.getDemandId();
                if (StringUtils.isNotEmpty(overallDesignRuleNum)) {
                    String[] strs = overallDesignRuleNum.split("\n");
                    for (String str : strs) {
                        List<String> demandIds = numToId.get(str);
                        if (demandIds == null) {
                            demandIds = new ArrayList<>();
                        }
                        demandIds.add(demandId);
                        numToId.put(str, demandIds);
                    }
                }
            }

            List<OverallDesignRule> overallDesignRuleIdToNum = overallDesignRuleDao.getOverallDesignRuleIdToNum(productId);
            List<DemandOverallDesignRuleRelation> demandOverallDesignRuleRelations = new ArrayList<>();
            if (overallDesignRuleIdToNum != null) {
                for (OverallDesignRule designRule : overallDesignRuleIdToNum) {
                    if (StringUtils.isNotEmpty(designRule.getOverallDesignRuleId()) && StringUtils.isNotEmpty(designRule.getOverallDesignRuleNum())) {
                        if (numToId.get(designRule.getOverallDesignRuleNum()) != null) {
                            List<String> demandIds = numToId.get(designRule.getOverallDesignRuleNum());
                            for (String demandId : demandIds) {
                                DemandOverallDesignRuleRelation demandOverallDesignRuleRelation = new DemandOverallDesignRuleRelation();
                                demandOverallDesignRuleRelation.setDemandId(demandId);
                                demandOverallDesignRuleRelation.setOverallDesignRuleId(designRule.getOverallDesignRuleId());
                                if (!demandOverallDesignRuleRelations.contains(demandOverallDesignRuleRelation)) {
                                    demandOverallDesignRuleRelations.add(demandOverallDesignRuleRelation);
                                }
                            }
                        }
                    }
                }
            }
            if (demandOverallDesignRuleRelations.size() > 0) {
                demandOverallDesignRuleRelationDao.saveDemandOverallDesignRuleRelationList(demandOverallDesignRuleRelations);
            }
        }
    }

    @Override
    public List<String> getDemandNums(String productId) {
        return demandDao.getDemandNums(productId);
    }
}
