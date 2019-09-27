package com.infinova.depr.service.impl;

import com.google.common.base.Throwables;
import com.infinova.depr.DeprApplication;
import com.infinova.depr.dao.DatasheetDao;
import com.infinova.depr.dao.OverallDesignDao;
import com.infinova.depr.dao.ProductDao;
import com.infinova.depr.dao.ProjectDao;
import com.infinova.depr.entity.Product;
import com.infinova.depr.entity.ProductIdAndName;
import com.infinova.depr.entity.ProductParam;
import com.infinova.depr.service.ProductService;
import com.infinova.depr.utils.OrderUtil;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author ldw
 * @date 2019/7/18 17:59
 */
@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDao productDao;
    @Autowired
    private DatasheetDao datasheetDao;
    @Autowired
    private OverallDesignDao overallDesignDao;
    @Autowired
    private ProjectDao projectDao;
    static Logger logger = LoggerFactory.getLogger(DeprApplication.class);

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int saveProduct(Product product) {
        String maxOrder = productDao.getMaxOrder();
        int curMax = 1;
        if (StringUtils.isNotEmpty(maxOrder)) {
            curMax = Integer.parseInt(maxOrder) + 1;
        }
        String productOrder = OrderUtil.getStringOrder(curMax, 10);
        product.setProductNum(OrderUtil.getNum("VF", productOrder, "", ""));
        product.setProductOrder(productOrder);
        return productDao.saveProduct(product);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateProduct(Product product) {
        return productDao.updateProduct(product);
    }

    @Override
    public Product getProductById(String productId) {
        return productDao.getProductById(productId);
    }

    @Override
    public List<Product> getProductByParams(ProductParam productParam) {
        List<Product> productList = productDao.getProductByParams(productParam);
        for (Product product : productList) {
            product.setProjectNames(projectDao.getProjectNameByProductId(product.getProductId()));
        }
        return productList;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteProductById(String productId) {
        List<String> urlList = new ArrayList<>();
        String datasheetUrl = datasheetDao.getdatasheetUrlById(productId);
        if (StringUtils.isNotEmpty(datasheetUrl)) {
            urlList.add(datasheetUrl);
            urlList.add(datasheetUrl.substring(0, datasheetUrl.lastIndexOf(".")) + ".pdf");
        }
        String overallDesignUrl = overallDesignDao.getOverallDesignUrlById(productId);
        if (StringUtils.isNotEmpty(overallDesignUrl)) {
            urlList.add(overallDesignUrl);
            urlList.add(overallDesignUrl.substring(0, overallDesignUrl.lastIndexOf(".")) + ".pdf");
        }
        for (String url : urlList) {
            if (StringUtils.isNotEmpty(url)) {
                File file = new File(url);
                if (file.exists()) {
                    try {
                        FileUtils.forceDelete(file);
                    } catch (IOException e) {
                        e.printStackTrace();
                        logger.error(Throwables.getStackTraceAsString(e));
                    }
                }
            }
        }
        return productDao.deleteProductById(productId);
    }

    @Override
    public int getProductCount(ProductParam productParam) {
        return productDao.getProductCount(productParam);
    }

    @Override
    public List<ProductIdAndName> getProductIdAndNameByParams(ProductParam productParam) {
        if (productParam == null) {
            productParam = new ProductParam();
        }
        if (productParam.getShowNoClose() != null && productParam.getShowNoClose()) {
            productParam.setProductState(-1);
        }
        if (StringUtils.isNotEmpty(productParam.getProductLineId())) {
            return productDao.getProductIdAndNameById(productParam);
        } else if (productParam.getProductLineIds() != null && productParam.getProductLineIds().length > 0) {
            return productDao.getProductIdAndNameByParams(productParam);
        }
        return null;
    }

    @Override
    public int getProductByName(String productName) {
        return productDao.getProductByName(productName);
    }

    @Override
    public int getProductByNameAndProductId(String productName, String productId) {
        return productDao.getProductByNameAndProductId(productName, productId);
    }

    @Override
    public int changeDept(String oldDeptId, String newDeptId, String newDeptName) {
        return productDao.changeDept(oldDeptId, newDeptId, newDeptName);
    }

}
