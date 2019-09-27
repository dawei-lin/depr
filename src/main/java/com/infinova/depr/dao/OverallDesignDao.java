package com.infinova.depr.dao;

import com.infinova.depr.entity.OverallDesign;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 * @author ldw
 * @date 2019/8/5 16:58
 */
@Mapper
public interface OverallDesignDao {
    @Insert("insert into overall_design(overall_design_id,overall_design_url,product_id,file_md5) values(replace(uuid(),'-',''),#{ovarallDesignUrl},#{productId},#{fileMd5})")
    int saveDocUrl(OverallDesign overalldesign);

    @Select("select overall_design_url from overall_design where product_id=#{productId}")
    String getOverallDesignUrlById(String productId);

    @Update("update overall_design set overall_design_url=#{ovarallDesignUrl},file_md5=#{newFileMd5} where product_id=#{productId}")
    int updateOverallDesignUrl(String ovarallDesignUrl, String newFileMd5, String productId);

    @Select("select file_md5 from overall_design where product_id=#{productId}")
    String getfileMd5ByProductId(String productId);
}
