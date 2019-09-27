package com.infinova.depr.service;

import com.infinova.depr.entity.Product;
import com.infinova.depr.entity.ProductIdAndName;
import com.infinova.depr.entity.ProductParam;

import java.io.IOException;
import java.util.List;

/**
 * @author ldw
 * @date 2019/7/18 17:55
 */
public interface ProductService {
    /**
     * 功能描述 保存产品
     *
     * @param product
     * @return int
     * @author ldw
     * @date 2019/7/19
     */
    int saveProduct(Product product);

    /**
     * 功能描述 更新产品
     *
     * @param product
     * @return int
     * @author ldw
     * @date 2019/7/19
     */
    int updateProduct(Product product);

    /**
     * 功能描述 根据id获取产品
     *
     * @param productId
     * @return com.infinova.depr.entity.Product
     * @author ldw
     * @date 2019/7/19
     */

    Product getProductById(String productId);

    /**
     * 功能描述 根据参数获取产品
     *
     * @param productParam
     * @return java.util.List<com.infinova.depr.entity.Product>
     * @author ldw
     * @date 2019/7/19
     */

    List<Product> getProductByParams(ProductParam productParam);

    /**
     * 功能描述 根据id删除产品
     *
     * @param productId
     * @return int
     * @author ldw
     * @date 2019/7/19
     */

    int deleteProductById(String productId);

    /**
     * 功能描述 根据产品参数获取总数
     *
     * @param productParam
     * @return int
     * @author ldw
     * @date 2019/7/19
     */
    int getProductCount(ProductParam productParam);

    /**
     * 功能描述 根据产品参数获取id和name
     *
     * @param productParam
     * @return java.util.List<com.infinova.depr.entity.ProductIdAndName>
     * @author ldw
     * @date 2019/7/20
     */
    List<ProductIdAndName> getProductIdAndNameByParams(ProductParam productParam);

    int getProductByName(String productName);

    int getProductByNameAndProductId(String productName, String productId);

    int changeDept(String oldDeptId, String newDeptId,String newDeptName);
}
