package com.infinova.depr.controller;

import com.infinova.depr.entity.DemandCategory;
import com.infinova.depr.message.CommonResult;
import com.infinova.depr.message.MessageResult;
import com.infinova.depr.service.DemandCategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * @author ldw
 * @date 2019/7/20 15:21
 */
@RestController
@RequestMapping("/demandCategory")
@Api("需求分类")
public class DemandCategoryController {
    @Autowired
    private DemandCategoryService demandCategoryService;

    @GetMapping("/parentCategory/{productId}")
    @ApiOperation("根据产品id获取父分类")
    public MessageResult<List<DemandCategory>> getDemandParentCategory(@PathVariable String productId) {
        List<DemandCategory> demandParentCategory = demandCategoryService.getDemandParentCategory(productId);
        return new MessageResult<>(demandParentCategory);
    }

    @GetMapping("{productId}/{demandCategoryId}")
    @ApiOperation("根据id获取子分类")
    public MessageResult<List<DemandCategory>> getDemandCategoryById(@PathVariable String demandCategoryId, @PathVariable String productId) {
        List<DemandCategory> demandParentCategory = demandCategoryService.getDemandCategoryById(demandCategoryId, productId);
        return new MessageResult<>(demandParentCategory);
    }

    @PostMapping("")
    @ApiOperation("添加一条分类")
    public CommonResult addDemandCategory(@RequestBody @Valid DemandCategory demandCategory) {
        if (demandCategoryService.addDemandCategory(demandCategory) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

}
