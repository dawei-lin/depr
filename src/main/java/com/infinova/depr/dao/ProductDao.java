package com.infinova.depr.dao;

import com.infinova.depr.entity.Product;
import com.infinova.depr.entity.ProductIdAndName;
import com.infinova.depr.entity.ProductParam;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * @author ldw
 * @date 2019/7/18 15:08
 */
@Mapper
public interface ProductDao {
    @Insert("insert into product(product_id,product_name,product_num,product_designation,product_type,product_manager_id," +
            "product_line_id,product_describe,product_order,product_manager_name,product_line_name) values(replace(uuid(),'-',''),#{productName},#{productNum}," +
            "#{productDesignation},#{productType},#{productManagerId},#{productLineId},#{productDescribe},#{productOrder},#{productManagerName},#{productLineName})")
    int saveProduct(Product product);

    @Update("update product set product_name=#{productName},product_designation=#{productDesignation}," +
            "product_type=#{productType},product_manager_id=#{productManagerId},product_line_id=#{productLineId},product_line_name=#{productLineName}," +
            "product_describe=#{productDescribe},product_state=#{productState},product_manager_name=#{productManagerName} where product_id=#{productId}")
    int updateProduct(Product product);

    @Select("select product_id,product_name,product_num,product_designation,product_type,product_describe,product_state,product_manager_id,product_manager_name,product_line_id,product_line_name from product where product_id=#{productId}")
    Product getProductById(String productId);

    List<Product> getProductByParams(ProductParam productParam);

    @Delete("delete from product where product_id=#{productId}")
    int deleteProductById(String productId);

    int getProductCount(ProductParam productParam);

    List<ProductIdAndName> getProductIdAndNameByParams(ProductParam productParam);

    @Select("select max(product_order) from product")
    String getMaxOrder();

    @Select("select count(product_id) from product where product_name=#{productName}")
    int getProductByName(String productName);

    @Select("select count(product_id) from product where product_name=#{productName} and product_id!=#{productId}")
    int getProductByNameAndProductId(String productName, String productId);

    @Select("SELECT product_id,product_name FROM product where product_state != #{productState} and product_line_id=#{productLineId}")
    List<ProductIdAndName> getProductIdAndNameById(ProductParam productParam);

    @Select("select product_name from product where product_id=#{productId}")
    String getProductNameById(String productId);

    @Update("update product set product_line_id=#{newDeptId},product_line_name=#{newDeptName} where product_line_id=#{oldDeptId}")
    int changeDept(String oldDeptId, String newDeptId, String newDeptName);
}
