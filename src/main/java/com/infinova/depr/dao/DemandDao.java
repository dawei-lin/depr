package com.infinova.depr.dao;

import com.infinova.depr.entity.Demand;
import com.infinova.depr.entity.DemandMatrix;
import com.infinova.depr.entity.DemandParam;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

/**
 * @author ldw
 * @date 2019/7/20 16:42
 */
@Mapper
public interface DemandDao {
    @Insert("insert into demand(demand_id,demand_name,demand_num,demand_category_id,demand_child_category_id,demand_resume," +
            "demand_describe,demand_priority,demand_accept_criteria,demand_remarks,product_id,demand_origin,demand_order,is_core,realize_edition) " +
            "values(replace(uuid(),'-',''),#{demandName},#{demandNum},#{demandCategoryId},#{demandChildCategoryId},#{demandResume},#{demandDescribe}," +
            "#{demandPriority},#{demandAcceptCriteria},#{demandRemarks},#{productId},#{demandOrigin},#{demandOrder},#{isCore},#{realizeEdition})")
    int saveDemand(Demand demand);

    @Update("update demand set demand_name=#{demandName},demand_category_id=#{demandCategoryId},demand_num=#{demandNum},demand_order=#{demandOrder}," +
            "demand_child_category_id=#{demandChildCategoryId},demand_resume=#{demandResume},demand_describe=#{demandDescribe}," +
            "demand_priority=#{demandPriority},demand_accept_criteria=#{demandAcceptCriteria},demand_remarks=#{demandRemarks}," +
            "product_id=#{productId},demand_state=#{demandState},demand_origin=#{demandOrigin},is_core=#{isCore}," +
            "realize_edition=#{realizeEdition},norms_num=#{normsNum},overall_design_rule_num=#{overallDesignRuleNum} where demand_id=#{demandId}")
    int updateDemand(Demand demand);

    @Delete("delete from demand where demand_id=#{demandId}")
    int deleteDemand(String demandId);

    @Select("select * from demand where demand_id=#{demandId}")
    Demand getDemandById(String demandId);

    List<Demand> getDemandListByParams(DemandParam demandParam);

    @Select("select count(demand_id) from demand where product_id=#{productId}")
    int getDemandCount(String productId);

    String getParentMaxOrder(String demandCategoryId, String demandChildCategoryId);

    @Select("select max(demand_order) from demand where demand_category_id=#{demandCategoryId}")
    String gettMaxOrder(String demandCategoryId);

    List<Demand> getAllDemand(String productId);

    int saveDemandList(List<Demand> demandList);

    @Select("select demand_id,norms_num from demand where norms_num is not null and product_id=#{productId}")
    List<Demand> getDemandNorms(String productId);

    @Select("select demand_num from demand where product_id=#{productId}")
    List<String> getDemandNums(String productId);

    @Select("select demand_id,overall_design_rule_num from demand where overall_design_rule_num is not null and product_id=#{productId}")
    List<Demand> getDemandOverallDesignRule(String productId);

    List<DemandMatrix> getDemandMatrixListByParams(DemandParam demandParam);

    @Select("select demand_num,demand_state,demand_priority,norms_num,overall_design_rule_num from demand where product_id=#{productId}")
    List<DemandMatrix> getAllDemandMatrix(String productId);

    String getParentMaxOrderByProductId(String demandCategoryId, String demandChildCategoryId, String productId);

    @Select("select max(demand_order) from demand where demand_category_id=#{demandCategoryId} and product_id=#{productId}")
    String getMaxOrderByProductId(String demandCategoryId, String productId);

    String getDemandIdByIds(String demandId, String demandCategoryId, String demandChildCategoryId);

    @Select("select demand_num from demand where demand_id=#{demandId}")
    String getDemandNumByDemandId(String demandId);

    @Select("select count(demand_id) from demand where demand_category_id=#{demandCategoryId} and demand_child_category_id=#{demandChildCategoryId}")
    int getCountByCategoryIds(String demandCategoryId, String demandChildCategoryId);

    List<Demand> getDemandListByDemandNum(String productId, String demandNum, String demandCategoryId, String demandChildCategoryId);

    int updateDemandNumList(List<Demand> demandUpdateList);
}
