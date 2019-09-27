package com.infinova.depr.dao;

import com.infinova.depr.entity.OverallDesignRule;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author ldw
 * @date 2019/8/3 10:50
 */
@Mapper
public interface OverallDesignRuleDao {
    int saveOverallDesignRuleList(List<OverallDesignRule> overallDesignRuleList);

    @Delete("delete from overall_design_rule where product_id=#{productId}")
    int deleteByProductId(String productId);

    @Select("select overall_design_rule_id from overall_design_rule where overall_design_rule_num=#{overallDesignRuleNum}")
    String getOverallDesignRuleIdByNum(String overallDesignRuleNum);

    @Select("select overall_design_rule_id,overall_design_rule_num from overall_design_rule where product_id=#{productId}")
    List<OverallDesignRule> getOverallDesignRuleIdToNum(String productId);

    @Select("select distinct overall_design_rule_num from overall_design_rule where product_id=#{productId}")
    List<String> getOverallDesignRuleNum(String productId);

    List<OverallDesignRule> getOverallDesignRuleList(List<String> overallDesignRuleIds);
}
