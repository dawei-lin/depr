package com.infinova.depr.dao;

import com.infinova.depr.entity.DemandNormsRelation;
import com.infinova.depr.entity.DemandOverallDesignRuleRelation;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author ldw
 * @date 2019/9/5 19:14
 */
@Mapper
public interface DemandOverallDesignRuleRelationDao {
    int saveDemandOverallDesignRuleRelationList(List<DemandOverallDesignRuleRelation> demandOverallDesignRuleRelations);

    @Select("select overall_design_rule_id from demand_overall_design_rule_relation where demand_id=#{demandId}")
    List<String> getOverallDesignRuleIdsByDemandId(String demandId);

    @Delete("delete from demand_overall_design_rule_relation where demand_id=#{demandId}")
    int deleteOverallDesignRuleByDemandId(String demandId);
}
