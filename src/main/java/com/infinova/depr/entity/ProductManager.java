package com.infinova.depr.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * @author ldw
 * @date 2019/7/18 14:27
 */
@ApiModel("产品负责人")
public class ProductManager implements Serializable {
    @ApiModelProperty("产品负责人id")
    @NotNull
    @Length(min = 32, max = 32)
    private String productManagerId;
    @ApiModelProperty("产品负责人名称")
    private String productManagerName;

    public String getProductManagerId() {
        return productManagerId;
    }

    public String getProductManagerName() {
        return productManagerName;
    }

    public void setProductManagerId(String productManagerId) {
        this.productManagerId = productManagerId;
    }

    public void setProductManagerName(String productManagerName) {
        this.productManagerName = productManagerName;
    }

    public ProductManager(String productManagerId, String productManagerName) {
        this.productManagerId = productManagerId;
        this.productManagerName = productManagerName;
    }

    public ProductManager() {
    }
}
