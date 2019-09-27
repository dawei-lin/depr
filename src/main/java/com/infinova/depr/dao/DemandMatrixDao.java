package com.infinova.depr.dao;

import com.infinova.depr.entity.BroadwiseDemandMatrixId;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * @author ldw
 * @date 2019/8/13 17:15
 */
@Mapper
public interface DemandMatrixDao {
    @Update("update broadwise_demand_matrix set regulation_id=#{regulationId} where achieve_stage_id=#{achieveStageId} and product_id=#{productId}")
    int updateBroadwiseDemandMatrix(String regulationId, String achieveStageId, String productId);

    @Insert("insert into broadwise_demand_matrix(broadwise_demand_matrix_id,achieve_stage_id,regulation_id,product_id) " +
            "values(replace(uuid(),'-',''),#{achieveStageId},#{regulationId},#{productId})")
    int addBroadwiseDemandMatrix(String regulationId, String achieveStageId, String productId);

    @Select("select achieve_stage_id,regulation_id from broadwise_demand_matrix where product_id=#{productId}")
    List<BroadwiseDemandMatrixId> getBroadwiseDemandMatrixIdByProductId(String productId);

    @Select("select broadwise_demand_matrix_id from broadwise_demand_matrix where achieve_stage_id=#{achieveStageId} and product_id=#{productId}")
    String getIdByProductIdAndAchieveStageId(String productId, String achieveStageId);

    @Select("select regulation_id from broadwise_demand_matrix where achieve_stage_id=#{achieveStageId} and product_id=#{productId}")
    String getRegulationIdByProductIdAndAchieveStageId(String productId, String achieveStageId);
}
