package com.infinova.depr.controller;

import com.github.pagehelper.PageHelper;
import com.infinova.depr.dao.DemandDao;
import com.infinova.depr.dao.ProductDao;
import com.infinova.depr.entity.*;
import com.infinova.depr.enums.AchieveStageType;
import com.infinova.depr.enums.RegulationType;
import com.infinova.depr.message.CommonResult;
import com.infinova.depr.message.MessageResult;
import com.infinova.depr.service.DemandMatrixService;
import com.infinova.depr.utils.ExcelUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * @author ldw
 * @date 2019/8/13 17:12
 */
@RestController
@RequestMapping("/demandMatrix")
@Api("需求跟踪矩阵")
public class DemandMatrixController {
    @Autowired
    private DemandMatrixService demandMatrixService;
    @Autowired
    private DemandDao demandDao;
    @Autowired
    private ProductDao productDao;

    @GetMapping("/listByParams")
    @ApiOperation("根据参数获取需求跟踪矩阵")
    public MessageResult<List<DemandMatrix>> getDemandMatrixListByParams(DemandParam demandParam) {
        if (demandParam.getPageNum() != null && demandParam.getPageSize() != null) {
            PageHelper.startPage(demandParam.getPageNum(), demandParam.getPageSize());
        }
        MessageResult<List<DemandMatrix>> messageResult = new MessageResult<>();
        messageResult.setMsg(demandMatrixService.getDemandMatrixListByParams(demandParam));
        return messageResult;
    }

    @GetMapping("/excel")
    @ApiOperation("导出excel")
    public void exportExcel(HttpServletResponse response, String productId) {
        List<DemandMatrix> demandMatrixList = demandDao.getAllDemandMatrix(productId);
        List<Object[]> datas = new ArrayList<>();
        for (DemandMatrix demandMatrix : demandMatrixList) {
            Object[] data = new Object[10];
            if (demandMatrix.getDemandState() != null) {
                switch (demandMatrix.getDemandState()) {
                    case 0:
                        data[0] = "未确定";
                        break;
                    case 1:
                        data[0] = "已确定";
                        break;
                    case 2:
                        data[0] = "已计划";
                        break;
                    case 3:
                        data[0] = "已实现";
                        break;
                    case 4:
                        data[0] = "已验证";
                        break;
                    default:
                }
            }
            if (demandMatrix.getDemandPriority() != null) {
                switch (demandMatrix.getDemandPriority()) {
                    case 1:
                        data[1] = "B";
                        break;
                    case 2:
                        data[1] = "A";
                        break;
                    case 3:
                        data[1] = "S";
                        break;
                    default:
                }
            }
            data[2] = demandMatrix.getBusinessNum();
            data[3] = demandMatrix.getDemandNum();
            data[4] = demandMatrix.getNormsNum();
            data[5] = demandMatrix.getTestCaseNum();
            data[6] = demandMatrix.getOverallDesignRuleNum();
            data[7] = demandMatrix.getDetailDesignNum();
            data[8] = demandMatrix.getOperationManualNum();
            data[9] = demandMatrix.getChangeRecord();
            datas.add(data);
        }
        String headers = "需求状态,需求等级,商业需求编号,产品需求编号,需求规格编号,测试用例编号,总体设计编号,详细设计书章节,用户操作手册章节,变更记录";
        String productName = "";
        Product product = productDao.getProductById(productId);
        if (product != null) {
            productName = product.getProductName();
        }
        String headers2 = "";
        RegulationType[] regulationTypes = RegulationType.values();
        AchieveStageType[] achieveStageTypes = AchieveStageType.values();
        for (RegulationType regulationType : regulationTypes) {
            headers2 += "," + regulationType.getName();
        }

        List<BroadwiseDemandMatrixId> broadwiseDemandMatrixIdList = demandMatrixService.getBroadwiseDemandMatrixIdByProductId(productId);
        Map<String, Set<String>> idToId = new HashMap<>();
        for (BroadwiseDemandMatrixId broadwiseDemandMatrixId : broadwiseDemandMatrixIdList) {
            if (StringUtils.isNotEmpty(broadwiseDemandMatrixId.getRegulationId())) {
                Set<String> regulationIdSet = new HashSet<>();
                String[] regulationIds = broadwiseDemandMatrixId.getRegulationId().split(",");
                for (String str : regulationIds) {
                    regulationIdSet.add(str);
                }
                idToId.put(broadwiseDemandMatrixId.getAchieveStageId(), regulationIdSet);
            }
        }
        List<Object[]> datas2 = new ArrayList<>();
        for (AchieveStageType achieveStageType : achieveStageTypes) {
            Object[] data = new Object[regulationTypes.length + 1];
            int index = 0;
            data[index++] = achieveStageType.getName();
            Set<String> regulationIdSet = idToId.get(achieveStageType.getId());
            if (regulationIdSet != null) {
                for (RegulationType regulationType : regulationTypes) {
                    if (regulationIdSet.contains(regulationType.getId())) {
                        data[index++] = "√";
                    } else {
                        index++;
                    }
                }
            }
            datas2.add(data);
        }


        ExcelUtil.demandMatrixExcelExport(productName + "_需求矩阵表", headers.split(","), datas, headers2.split(","), datas2, response);
    }

    @GetMapping("/broadwiseDemandMatrix/{productId}")
    @ApiOperation("获取横向需求矩阵")
    public MessageResult<List<BroadwiseDemandMatrix>> getBroadwiseDemandMatrix(@PathVariable String productId) {
        List<BroadwiseDemandMatrixId> broadwiseDemandMatrixIdList = demandMatrixService.getBroadwiseDemandMatrixIdByProductId(productId);
        Map<String, Set<String>> idToId = new HashMap<>();
        for (BroadwiseDemandMatrixId broadwiseDemandMatrixId : broadwiseDemandMatrixIdList) {
            if (StringUtils.isNotEmpty(broadwiseDemandMatrixId.getRegulationId())) {
                Set<String> regulationIdSet = new HashSet<>();
                String[] regulationIds = broadwiseDemandMatrixId.getRegulationId().split(",");
                for (String str : regulationIds) {
                    regulationIdSet.add(str);
                }
                idToId.put(broadwiseDemandMatrixId.getAchieveStageId(), regulationIdSet);
            }
        }
        MessageResult<List<BroadwiseDemandMatrix>> messageResult = new MessageResult<>();
        List<BroadwiseDemandMatrix> broadwiseDemandMatrixList = new ArrayList<>();
        AchieveStageType[] achieveStageTypes = AchieveStageType.values();
        RegulationType[] regulationTypes = RegulationType.values();
        for (AchieveStageType achieveStageType : achieveStageTypes) {
            BroadwiseDemandMatrix broadwiseDemandMatrix = new BroadwiseDemandMatrix();
            broadwiseDemandMatrix.setAchieveStageId(achieveStageType.getId());
            broadwiseDemandMatrix.setAchieveStageName(achieveStageType.getName());
            List<Regulation> regulationList = new ArrayList<>();
            Set<String> regulationIdSet = idToId.get(achieveStageType.getId());
            for (RegulationType regulationType : regulationTypes) {
                Regulation regulation = new Regulation();
                regulation.setRegulationId(regulationType.getId());
                regulation.setRegulationName(regulationType.getName());
                if (regulationIdSet == null) {
                    regulation.setTick(false);
                } else {
                    if (regulationIdSet.contains(regulationType.getId())) {
                        regulation.setTick(true);
                    } else {
                        regulation.setTick(false);
                    }
                }
                regulationList.add(regulation);
            }
            broadwiseDemandMatrix.setRegulationList(regulationList);
            broadwiseDemandMatrixList.add(broadwiseDemandMatrix);
        }
        messageResult.setMsg(broadwiseDemandMatrixList);
        return messageResult;
    }

    /*@PutMapping("/broadwiseDemandMatrix/{productId}")
    @ApiOperation("更新横向需求矩阵")
    public CommonResult updateBroadwiseDemandMatrix(@PathVariable String productId, @RequestBody List<BroadwiseDemandMatrixId> broadwiseDemandMatrixIdList) {
        if (demandMatrixService.updateBroadwiseDemandMatrix(broadwiseDemandMatrixIdList, productId) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }*/
    @PutMapping("/broadwiseDemandMatrix/{productId}")
    @ApiOperation("更新横向需求矩阵")
    public CommonResult updateBroadwiseDemandMatrix(@PathVariable String productId, @RequestBody BroadwiseDemandMatrixId broadwiseDemandMatrixId) {
        if (demandMatrixService.updateBroadwiseDemandMatrix(broadwiseDemandMatrixId, productId) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }
}
