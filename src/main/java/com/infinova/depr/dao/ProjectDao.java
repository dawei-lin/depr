package com.infinova.depr.dao;

import com.infinova.depr.entity.Project;
import com.infinova.depr.entity.ProjectParam;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * @author ldw
 * @date 2019/8/15 16:05
 */
@Mapper
public interface ProjectDao {
    @Insert("insert into project(project_id,project_name,project_num,project_time,project_manager_id,project_manager_name," +
            "project_type,product_id,project_importance,project_urgency,project_describe,project_state,product_line_id,product_line_name) " +
            "values(replace(uuid(),'-',''),#{projectName},#{projectNum},#{projectDate},#{projectManagerId},#{projectManagerName}," +
            "#{projectType},#{productId},#{projectImportance},#{projectUrgency},#{projectDescribe},#{projectState},#{productLineId},#{productLineName})")
    int saveProject(Project project);

    @Delete("delete from project where project_id=#{projectId}")
    int deleteProject(String projectId);

    @Update("update project set project_name=#{projectName},project_num=#{projectNum},project_time=#{projectDate}," +
            "project_manager_id=#{projectManagerId},project_manager_name=#{projectManagerName},project_type=#{projectType}," +
            "product_id=#{productId},project_importance=#{projectImportance},project_urgency=#{projectUrgency}," +
            "project_describe=#{projectDescribe},project_state=#{projectState},product_line_name=#{productLineName} where project_id=#{projectId}")
    int updateProject(Project project);

    List<Project> getProjectListByParams(ProjectParam projectParam);

    @Select("select project_id,project_name,project_num,UNIX_TIMESTAMP(project_time)*1000 project_time,project_manager_id,project_manager_name," +
            "project_type,product_id,project_importance,project_urgency,project_describe,project_state," +
            "product_line_id from project where project_id=#{projectId}")
    Project getProjectByProjectId(String projectId);

    @Select("select count(project_id) from project where project_name=#{projectName}")
    int getProjectByName(String projectName);

    @Select("select count(project_id) from project where project_name=#{projectName} and project_id!=#{projectId}")
    int getProjectByNameAndProjectId(String projectName, String projectId);

    @Select("select project_name from project where product_id=#{productId}")
    List<String> getProjectNameByProductId(String productId);

    @Update("update project set product_line_id=#{newDeptId},product_line_name=#{newDeptName} where product_line_id=#{oldDeptId}")
    int changeDept(String oldDeptId, String newDeptId, String newDeptName);
}
