package com.infinova.depr.controller;

import com.github.pagehelper.PageHelper;
import com.infinova.depr.entity.Product;
import com.infinova.depr.entity.ProductIdAndName;
import com.infinova.depr.entity.ProductParam;
import com.infinova.depr.enums.ReturnCodeType;
import com.infinova.depr.message.CommonResult;
import com.infinova.depr.message.MessageResult;
import com.infinova.depr.service.ProductService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import javax.validation.Valid;
import java.util.List;

/**
 * @author ldw
 * @date 2019/7/18 18:47
 */
@RestController
@RequestMapping("/product")
@Api("产品模块")
public class ProductController {
    @Autowired
    private ProductService productService;

    @PostMapping("")
    @ApiOperation("增加产品")
    public CommonResult addProduct(@RequestBody @Valid Product product) {
        if (productService.getProductByName(product.getProductName()) > 0) {
            return new CommonResult(ReturnCodeType.REPEAT_NAME.getStringCode(), ReturnCodeType.REPEAT_NAME.getDesc());
        }
        if (productService.saveProduct(product) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @PutMapping("")
    @ApiOperation("更新产品")
    public CommonResult updateProduct(@RequestBody @Valid Product product) {
        if (productService.getProductByNameAndProductId(product.getProductName(), product.getProductId()) > 0) {
            return new CommonResult(ReturnCodeType.REPEAT_NAME.getStringCode(), ReturnCodeType.REPEAT_NAME.getDesc());
        }
        if (productService.updateProduct(product) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @GetMapping("{productId}")
    @ApiOperation("根据id查找产品")
    public MessageResult<Product> getProductById(@PathVariable String productId) {
        MessageResult<Product> messageResult = new MessageResult<>();
        if (StringUtils.isNotEmpty(productId)) {
            messageResult.setMsg(productService.getProductById(productId));
        }
        return messageResult;
    }

    @GetMapping("/list")
    @ApiOperation("根据属性查找产品")
    public MessageResult<List<Product>> getProductList(ProductParam productParam) {
        MessageResult<List<Product>> messageResult = new MessageResult<>();
        if (productParam.getPageNum() != null && productParam.getPageSize() != null) {
            PageHelper.startPage(productParam.getPageNum(), productParam.getPageSize());
        }
        messageResult.setMsg(productService.getProductByParams(productParam));
        return messageResult;
    }

    @DeleteMapping("{productId}")
    @ApiOperation("根据id删除产品")
    public CommonResult deleteProductById(@PathVariable String productId) {
        if (productService.deleteProductById(productId) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @GetMapping("/pageCount")
    @ApiOperation("获取总页数")
    public MessageResult<Integer> getPageCount(ProductParam productParam) {
        int productCount = productService.getProductCount(productParam);
        int productPageSize = 0;
        if (productParam.getPageSize() == null) {
            productParam.setPageSize(20);
        }
        if (productCount > 0) {
            productPageSize = productCount / productParam.getPageSize() + 1;
        }
        return new MessageResult<>(productPageSize);
    }

    @GetMapping("/productIdAndName")
    @ApiOperation("根据属性查找产品的id和name")
    public MessageResult<List<ProductIdAndName>> getProductIdAndName(ProductParam productParam) {
        MessageResult<List<ProductIdAndName>> messageResult = new MessageResult<>();
        messageResult.setMsg(productService.getProductIdAndNameByParams(productParam));
        return messageResult;
    }
}
