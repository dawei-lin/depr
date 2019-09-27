package com.infinova.depr.dao;

import com.infinova.depr.entity.DemandNormsRelation;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author ldw
 * @date 2019/9/5 15:43
 */
@Mapper
public interface DemandNormsRelationDao {
    int saveDemandNormsRelationList(List<DemandNormsRelation> demandNormsRelations);

    @Select("select norms_id from demand_norms_relation where demand_id=#{demandId}")
    List<String> getNormsIdsByDemandId(String demandId);

    @Delete("delete from demand_norms_relation where demand_id=#{demandId}")
    int deleteNormsByDemandId(String demandId);
}
