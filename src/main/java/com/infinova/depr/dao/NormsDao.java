package com.infinova.depr.dao;

import com.infinova.depr.entity.Norms;
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
public interface NormsDao {
    int saveNormsList(List<Norms> normsList);

    @Delete("delete from norms where product_id=#{productId}")
    int deleteByProductId(String productId);

    @Select("select norms_id,norms_num from norms where product_id=#{productId}")
    List<Norms> getNormsIdToNum(String productId);

    @Select("select distinct norms_num from norms where product_id=#{productId}")
    List<String> getNormsNum(String productId);

    List<Norms> getNormsList(List<String> normsIds);
}
