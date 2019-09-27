package com.infinova.depr.dao;

import com.infinova.depr.entity.Log;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author ldw
 * @date 2019/9/9 15:39
 */
@Mapper
public interface LogDao {
    @Insert("insert into log(log_id,log_name,log_content,log_operator,log_operation_time) values(replace(uuid(),'-',''),#{logName},#{logContent},#{logOperator},#{logOperationTime})")
    int saveLog(Log log);
}
