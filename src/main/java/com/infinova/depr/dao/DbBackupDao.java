package com.infinova.depr.dao;

import com.infinova.depr.entity.DataBaseFilesInfo;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author ldw
 * @date 2019/9/5 10:38
 */
@Mapper
public interface DbBackupDao {
    @Insert("insert into db_backup(db_backup_id,file_name,operator) values(replace(uuid(),'-',''),#{fileName},#{operator})")
    int saveDbBackup(String fileName, String operator);

    @Select("select file_name,operator from db_backup where file_name like concat('%',#{fileName},'%')")
    List<DataBaseFilesInfo> getDbBackupByFileName(String fileName);

    @Select("select file_name,operator from db_backup")
    List<DataBaseFilesInfo> getDbBackup();

    @Delete("delete from db_backup where file_name=#{fileName}")
    int deleteDbBackupByFileName(String fileName);
}
