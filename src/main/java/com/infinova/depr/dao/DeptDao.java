package com.infinova.depr.dao;

import com.infinova.depr.entity.Dept;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * @author ldw
 * @date 2019/8/26 11:44
 */
@Mapper
public interface DeptDao {
    @Insert("insert into dept(dept_id,dept_name,dept_order,parent_dept_id,dept_num,dept_remarks) values(replace(uuid(),'-',''),#{deptName},#{deptOrder},#{parentDeptId},#{deptNum},#{deptRemarks})")
    int saveDept(Dept dept);

    @Select("select max(dept_order) from dept where parent_dept_id=#{parentDeptId}")
    String getMaxOrderById(String parentDeptId);

    @Select("select max(dept_order) from dept where parent_dept_id is null")
    String getMaxOrder();

    @Select("select dept_num from dept where dept_id=#{parentDeptId}")
    String getDeptNum(String parentDeptId);

    @Delete("delete from dept where dept_id=#{deptId}")
    int deleteDept(String deptId);

    @Select("select * from dept where dept_id=#{deptId}")
    Dept getDeptById(String deptId);

    @Update("update set dept_name=#{deptName},parent_dept_id=#{parentDeptId},dept_remarks=#{deptRemarks}")
    int updateDept(Dept dept);

    @Select("SELECT d.dept_id dept_id,d.dept_name dept_name,d.dept_num dept_num,dp.dept_name parent_dept_name from dept d LEFT JOIN dept dp on d.parent_dept_id=dp.dept_id")
    List<Dept> getAllDept();

    @Select("SELECT d.dept_id dept_id,d.dept_name dept_name,d.dept_num dept_num,dp.dept_name parent_dept_name from " +
            "dept d LEFT JOIN dept dp on d.parent_dept_id=dp.dept_id where d.dept_name like concat('%',#{deptName},'%')")
    List<Dept> getDeptListByName(String deptName);

    @Select("select dept_id,dept_name from dept where parent_dept_id is null")
    List<Dept> getParentDeptList();

    @Select("select * from dept where parent_dept_id=#{parentDeptId}")
    List<Dept> getDeptListByParentDeptId(String parentDeptId);
}
