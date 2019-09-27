package com.infinova.depr.dao;

import com.infinova.depr.entity.Datasheet;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

/**
 * @author ldw
 * @date 2019/8/1 10:49
 */
@Mapper
public interface DatasheetDao {
    @Insert("insert into datasheet(datasheet_id,datasheet_url,product_id,file_md5) values(replace(uuid(),'-',''),#{datasheetUrl},#{productId},#{fileMd5})")
    int saveDocUrl(Datasheet datasheet);

    @Select("select datasheet_url from datasheet where product_id=#{productId}")
    String getdatasheetUrlById(String productId);

    @Update("update datasheet set datasheet_url=#{datasheetUrl},file_md5=#{newFileMd5} where product_id=#{productId}")
    int updateDatasheetUrl(String datasheetUrl, String newFileMd5, String productId);

    @Select("select file_md5 from datasheet where product_id=#{productId}")
    String getfileMd5ByProductId(String productId);
}
