package com.infinova.depr.dao;

import com.infinova.depr.entity.DemandCategory;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author ldw
 * @date 2019/7/20 15:06
 */
@Mapper
public interface DemandCategoryDao {
    @Select("select demand_category_id,demand_category_name from demand_category where demand_parent_category_id is null and product_id  is null")
    List<DemandCategory> getDemandParentCategory();

    @Select("select demand_category_id,demand_category_name from demand_category where demand_parent_category_id is null and product_id=#{productId}")
    List<DemandCategory> getDemandParentCategoryByProductId(String productId);

    @Select("select demand_category_id,demand_category_name from demand_category where demand_parent_category_id=#{categoryId} and product_id=#{productId}")
    List<DemandCategory> getDemandCategoryById(String categoryId, String productId);

    @Insert("insert into demand_category(demand_category_id,demand_category_name,demand_category_describe,demand_parent_category_id,demand_category_order,product_id)" +
            " values(replace(uuid(),'-',''),#{demandCategoryName},#{demandCategoryDescribe},#{demandParentCategoryId},#{demandCategoryOrder},#{productId})")
    int addDemandCategory(DemandCategory demandCategory);

    @Select("select max(demand_category_order) from demand_category where demand_parent_category_id is null and product_id=#{productId}")
    String getParentMaxOrder(String productId);

    @Select("select demand_category_order from demand_category where demand_category_id=#{demandCategoryId}")
    String getOredrById(String demandCategoryId);

    @Select("select demand_category_id from demand_category where demand_category_name=#{demandCategoryName}")
    String getDemandCategoryIdByName(String demandCategoryName);

    @Select("select demand_category_id from demand_category where demand_category_name=#{demandCategoryName} and product_id=#{productId}")
    String getDemandCategoryIdByNameAndProductId(String demandCategoryName, String productId);

    @Select("select demand_category_id from demand_category where demand_category_name=#{demandCategoryName} and demand_parent_category_id=#{demandCategoryId} and product_id=#{productId}")
    String getDemandCategoryIdByNameAndCategoryId(String demandCategoryName, String demandCategoryId, String productId);

    @Select("select product_id from demand_category where demand_category_id=#{demandCategoryId}")
    String getProductIdByDemandCategoryId(String demandCategoryId);

    @Select("select demand_category_name from demand_category where demand_category_id=#{demandCategoryId}")
    String getDemandCategoryNameById(String demandCategoryId);
}
