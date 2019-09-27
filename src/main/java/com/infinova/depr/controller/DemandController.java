package com.infinova.depr.controller;

import com.github.pagehelper.PageHelper;
import com.infinova.depr.dao.DemandDao;
import com.infinova.depr.dao.ProductDao;
import com.infinova.depr.entity.Demand;
import com.infinova.depr.entity.DemandDetail;
import com.infinova.depr.entity.DemandParam;
import com.infinova.depr.entity.Product;
import com.infinova.depr.enums.ReturnCodeType;
import com.infinova.depr.message.CommonResult;
import com.infinova.depr.message.MessageResult;
import com.infinova.depr.service.DemandCategoryService;
import com.infinova.depr.service.DemandNormsRelationService;
import com.infinova.depr.service.DemandOverallDesignRuleRelationService;
import com.infinova.depr.service.DemandService;
import com.infinova.depr.service.NormsService;
import com.infinova.depr.service.OverallDesignRuleService;
import com.infinova.depr.utils.ExcelUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import net.bytebuddy.asm.Advice;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author ldw
 * @date 2019/7/20 16:42
 */
@RestController
@RequestMapping("/demand")
@Api("需求管理")
public class DemandController {
    @Autowired
    private DemandService demandService;
    @Autowired
    private NormsService normsService;
    @Autowired
    private OverallDesignRuleService overallDesignRuleService;
    @Autowired
    private DemandCategoryService demandCategoryService;
    @Autowired
    private DemandDao demandDao;
    @Autowired
    private ProductDao productDao;
    @Autowired
    private DemandNormsRelationService demandNormsRelationService;
    @Autowired
    private DemandOverallDesignRuleRelationService demandOverallDesignRuleRelationService;
    @Value("${file.store.commonPath}")
    private String commonPath;
    private static Pattern FUNCTION_NUM_PATTERN = Pattern.compile("^[U][F]([-][0-9]{3}){2,3}$");
    private static Pattern UNFUNCTION_NUM_PATTERN = Pattern.compile("^[U][Q][-][A-Z]{1,10}([-][0-9]{3}){1,2}$");
    private static Pattern CATEGORY_PATTERN = Pattern.compile("[1-2][.][0-9]+[、]");
    private static Pattern FIGURE_PATTERN = Pattern.compile("[0-9]+");

    @PostMapping()
    @ApiOperation("保存需求")
    public CommonResult saveDemand(@Valid @RequestBody Demand demand) {
        if (demand != null && StringUtils.isNotEmpty(demand.getDemandName()) && StringUtils.isNotEmpty(demand.getDemandChildCategoryName())) {
            if (!demand.getDemandName().equals(demand.getDemandChildCategoryName())) {
                return new CommonResult(ReturnCodeType.DEMAND_NAME_ERROR.getStringCode(), ReturnCodeType.DEMAND_NAME_ERROR.getDesc());
            }
        }
        if (demandService.saveDemand(demand) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @PutMapping()
    @ApiOperation("更新需求")
    public CommonResult updateDemand(@Valid @RequestBody Demand demand) {
        if (demand != null && StringUtils.isNotEmpty(demand.getNormsNum()) && StringUtils.isNotEmpty(demand.getProductId())) {
            String info = normsService.checkNormsNum(demand.getNormsNum(), demand.getProductId());
            if (StringUtils.isNotEmpty(info)) {
                return new CommonResult(ReturnCodeType.NUM_NON_EXISTENT.getStringCode(), info);
            }
        }

        if (demand != null && StringUtils.isNotEmpty(demand.getOverallDesignRuleNum()) && StringUtils.isNotEmpty(demand.getProductId())) {
            String info = overallDesignRuleService.checkOverallDesignRuleNum(demand.getOverallDesignRuleNum(), demand.getProductId());
            if (StringUtils.isNotEmpty(info)) {
                return new CommonResult(ReturnCodeType.NUM_NON_EXISTENT.getStringCode(), info);
            }
        }

        if (demandService.updateDemand(demand) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @DeleteMapping("{demandId}")
    @ApiOperation("删除需求")
    public CommonResult deleteDemand(@PathVariable String demandId) {
        if (demandService.deleteDemand(demandId) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @GetMapping("{demandId}")
    @ApiOperation("根据id获取需求")
    public MessageResult<Demand> getDemandById(@PathVariable String demandId) {
        MessageResult<Demand> messageResult = new MessageResult<>();
        messageResult.setMsg(demandService.getDemandById(demandId));
        return messageResult;
    }

    @GetMapping("/detailById/{demandId}")
    @ApiOperation("根据id获取需求详细信息")
    public MessageResult<DemandDetail> getDemandDetailById(@PathVariable String demandId) {
        MessageResult<DemandDetail> messageResult = new MessageResult<>();
        DemandDetail demandDetail = new DemandDetail();
        Demand demand = demandService.getDemandById(demandId);
        demandDetail.setDemand(demand);
        List<String> normsIds = demandNormsRelationService.getNormsIdsByDemandId(demandId);
        if (normsIds != null && normsIds.size() > 0) {
            demandDetail.setNormsList(normsService.getNormsList(normsIds));
        }
        List<String> overallDesignRuleIds = demandOverallDesignRuleRelationService.getOverallDesignRuleIdsByDemandId(demandId);
        if (overallDesignRuleIds != null && overallDesignRuleIds.size() > 0) {
            demandDetail.setOverallDesignRuleList(overallDesignRuleService.getOverallDesignRuleList(overallDesignRuleIds));
        }
        if (demand != null && StringUtils.isNotEmpty(demandCategoryService.getProductIdByDemandCategoryId(demand.getDemandCategoryId()))) {
            demandDetail.setFunctionDemand(true);
        } else {
            demandDetail.setFunctionDemand(false);
        }
        messageResult.setMsg(demandDetail);
        return messageResult;
    }


    @GetMapping("/listByParams")
    @ApiOperation("根据参数获取需求")
    public MessageResult<List<Demand>> getDemandListByParams(DemandParam demandParam) {
        if (demandParam.getPageNum() != null && demandParam.getPageSize() != null) {
            PageHelper.startPage(demandParam.getPageNum(), demandParam.getPageSize());
        }
        MessageResult<List<Demand>> messageResult = new MessageResult<>();
        List<Demand> demandList = demandService.getDemandListByParams(demandParam);
        messageResult.setMsg(demandList);
        return messageResult;
    }

    @GetMapping("/count")
    @ApiOperation("获取需求总数")
    public MessageResult<Integer> getDemandCount(String productId) {
        MessageResult<Integer> messageResult = new MessageResult<>();
        messageResult.setMsg(demandService.getDemandCount(productId));
        return messageResult;
    }

    @GetMapping("/excel")
    @ApiOperation("导出excel")
    public void exportExcel(HttpServletRequest request, HttpServletResponse response, String productId) {
        List<Demand> demandList = demandDao.getAllDemand(productId);
        Collections.sort(demandList, new Comparator<Demand>() {
            @Override
            public int compare(Demand o1, Demand o2) {
                String demandCategoryName1 = o1.getDemandCategoryName();
                String demandCategoryName2 = o2.getDemandCategoryName();
                String demandNum1 = o1.getDemandNum().substring(o1.getDemandNum().indexOf("-", 3) + 1);
                String demandNum2 = o2.getDemandNum().substring(o2.getDemandNum().indexOf("-", 3) + 1);
                int border1 = 0;
                int sorder1 = 0;
                int border2 = 0;
                int sorder2 = 0;
                Matcher matcher1 = FIGURE_PATTERN.matcher(demandCategoryName1);
                if (matcher1.find()) {
                    border1 = Integer.parseInt(matcher1.group(0));
                }
                if (matcher1.find()) {
                    sorder1 = Integer.parseInt(matcher1.group(0));
                }
                Matcher matcher2 = FIGURE_PATTERN.matcher(demandCategoryName2);
                if (matcher2.find()) {
                    border2 = Integer.parseInt(matcher2.group(0));
                }
                if (matcher2.find()) {
                    sorder2 = Integer.parseInt(matcher2.group(0));
                }
                /*int border1 = Integer.parseInt(demandCategoryName1.substring(0, demandCategoryName1.indexOf(".")));
                int border2 = Integer.parseInt(demandCategoryName2.substring(0, demandCategoryName1.indexOf(".")));
                int sorder1 = Integer.parseInt(demandCategoryName1.substring(demandCategoryName1.indexOf(".") + 1, demandCategoryName1.indexOf("、")));
                int sorder2 = Integer.parseInt(demandCategoryName2.substring(demandCategoryName1.indexOf(".") + 1, demandCategoryName2.indexOf("、")));*/
                if (border1 == border2) {
                    if (sorder1 == sorder2) {
                        return demandNum1.compareTo(demandNum2);
                    }
                    return sorder1 - sorder2;
                }
                return border1 - border2;
            }
        });
        String productName = "";
        Product product = productDao.getProductById(productId);
        if (product != null) {
            productName = product.getProductName();
        }
        ExcelUtil.demandExcelExport(request, commonPath, productName + "_需求表.xlsx", demandList, response);
    }

    @PostMapping(value = "/excel")
    @ApiOperation("导入excel")
    public CommonResult importExcel(MultipartFile file, String productId) {
        String fileName = file.getOriginalFilename();
        if (!(fileName.toLowerCase().endsWith(".xls") || fileName.toLowerCase().endsWith(".xlsx"))) {
            return new CommonResult(ReturnCodeType.FORM_INCORRECT.getStringCode(), ReturnCodeType.FORM_INCORRECT.getDesc());
        }
        if (fileName.contains("/")) {
            fileName = fileName.substring(fileName.lastIndexOf("/"));
        }
        List<Demand> demandList = null;
        try {
            demandList = ExcelUtil.demandExcelImport(file.getInputStream(), fileName);
        } catch (IOException e) {
            e.printStackTrace();
        }
        List<String> demandNames = demandService.getDemandNums(productId);
        String demandNumMismatchingStr = "";
        String demandCategoryNameMismatchingStr = "";
        String demandNumRepeatStr = "";
        for (Demand demand : demandList) {
            if (!StringUtils.isNotEmpty(demand.getDemandNum()) || demand.getDemandNum().startsWith("UF") && !FUNCTION_NUM_PATTERN.matcher(demand.getDemandNum()).find() || demand.getDemandNum().startsWith("UQ") && !UNFUNCTION_NUM_PATTERN.matcher(demand.getDemandNum()).find()) {
                if (!demandNumMismatchingStr.contains(demand.getDemandNum())) {
                    if (!StringUtils.isNotEmpty(demandNumMismatchingStr)) {
                        demandNumMismatchingStr += "编号（" + demand.getDemandNum() + "）不存在或者不规范";
                    } else {
                        demandNumMismatchingStr += "<br/>" + "编号（" + demand.getDemandNum() + "）不存在或者不规范";
                    }
                }
                //return new CommonResult(ReturnCodeType.DEMAND_NUM_MISMATCHING.getStringCode(), ReturnCodeType.DEMAND_NUM_MISMATCHING.getDesc());
            }
            if (!demand.getDemandNum().startsWith("UF") && demand.getDemandNum().split("-").length > 2 && !ExcelUtil.numList.contains(demand.getDemandNum().substring(0, demand.getDemandNum().indexOf("-", demand.getDemandNum().indexOf("-") + 1)))) {
                if (!demandNumMismatchingStr.contains(demand.getDemandNum())) {
                    if (!StringUtils.isNotEmpty(demandNumMismatchingStr)) {
                        demandNumMismatchingStr += "编号（" + demand.getDemandNum() + "）不存在或者不规范";
                    } else {
                        demandNumMismatchingStr += "<br/>" + "编号（" + demand.getDemandNum() + "）不存在或者不规范";
                    }
                }
            }
            if (StringUtils.isNotEmpty(demand.getDemandCategoryName())) {
                demand.setDemandCategoryName(demand.getDemandCategoryName().replace(" ", "").trim());
            }
            if (!StringUtils.isNotEmpty(demand.getDemandCategoryName()) || !CATEGORY_PATTERN.matcher(demand.getDemandCategoryName()).find()) {
                if (!demandCategoryNameMismatchingStr.contains(demand.getDemandCategoryName())) {
                    if (!StringUtils.isNotEmpty(demandCategoryNameMismatchingStr)) {
                        demandCategoryNameMismatchingStr += "父类（" + demand.getDemandCategoryName() + "）不存在或者不规范，形如：1.1、中文";
                    } else {
                        demandCategoryNameMismatchingStr += "<br/>" + "父类（" + demand.getDemandCategoryName() + "）不存在或者不规范，形如：1.1、中文";
                    }
                }
                //return new CommonResult(ReturnCodeType.DEMAND_CATEGORY_NAME_MISMATCHING.getStringCode(), ReturnCodeType.DEMAND_CATEGORY_NAME_MISMATCHING.getDesc());
            }
            if (!demand.getDemandNum().startsWith("UF") && !ExcelUtil.nameList.contains(demand.getDemandCategoryName())) {
                if (!demandCategoryNameMismatchingStr.contains(demand.getDemandCategoryName())) {
                    if (!StringUtils.isNotEmpty(demandCategoryNameMismatchingStr)) {
                        demandCategoryNameMismatchingStr += "父类（" + demand.getDemandCategoryName() + "）不存在或者不规范，形如：1.1、中文";
                    } else {
                        demandCategoryNameMismatchingStr += "<br/>" + "父类（" + demand.getDemandCategoryName() + "）不存在或者不规范，形如：1.1、中文";
                    }
                }
                // return new CommonResult(ReturnCodeType.DEMAND_CATEGORY_NAME_MISMATCHING.getStringCode(), ReturnCodeType.DEMAND_CATEGORY_NAME_MISMATCHING.getDesc());
            }
            if (demandNames.contains(demand.getDemandNum())) {
                if (!StringUtils.isNotEmpty(demandNumRepeatStr)) {
                    demandNumRepeatStr += "编号（" + demand.getDemandNum() + ")重复";
                } else {
                    demandNumRepeatStr += "<br/>" + "编号（" + demand.getDemandNum() + ")重复";
                }
                //return new CommonResult(ReturnCodeType.DEMAND_NUM_REPEAT.getStringCode(), ReturnCodeType.DEMAND_NUM_REPEAT.getDesc());
            }
        }
        String info = "";
        if (StringUtils.isNotEmpty(demandNumMismatchingStr)) {
            if (StringUtils.isNotEmpty(info)) {
                info += "<br/>" + demandNumMismatchingStr;
            } else {
                info += demandNumMismatchingStr;
            }
        }
        if (StringUtils.isNotEmpty(demandCategoryNameMismatchingStr)) {
            if (StringUtils.isNotEmpty(info)) {
                info += "<br/>" + demandCategoryNameMismatchingStr;
            } else {
                info += demandCategoryNameMismatchingStr;
            }
        }
        if (StringUtils.isNotEmpty(demandNumRepeatStr)) {
            if (StringUtils.isNotEmpty(info)) {
                info += "<br/>" + demandNumRepeatStr;
            } else {
                info += demandNumRepeatStr;
            }
        }
        if (StringUtils.isNotEmpty(info)) {
            return new CommonResult(ReturnCodeType.EXCEL_ERROR.getStringCode(), info);
        }

        demandService.importExcel(productId, demandList);
        return new CommonResult().success();
    }

    @GetMapping("/checkNormsNum")
    @ApiOperation("校验规格编号")
    public CommonResult checkNormsNum(String normsNum, String productId) {
        if (StringUtils.isNotEmpty(normsNum) && StringUtils.isNotEmpty(productId)) {
            String info = normsService.checkNormsNum(normsNum, productId);
            if (StringUtils.isNotEmpty(info)) {
                return new CommonResult(ReturnCodeType.NUM_NON_EXISTENT.getStringCode(), info);
            }
        }
        return new CommonResult().success();
    }

    @GetMapping("/checkOverallDesignRuleNum")
    @ApiOperation("校验总体设计编号")
    public CommonResult checkOverallDesignRuleNum(String overallDesignRuleNum, String productId) {
        if (StringUtils.isNotEmpty(overallDesignRuleNum) && StringUtils.isNotEmpty(productId)) {
            String info = overallDesignRuleService.checkOverallDesignRuleNum(overallDesignRuleNum, productId);
            if (StringUtils.isNotEmpty(info)) {
                return new CommonResult(ReturnCodeType.NUM_NON_EXISTENT.getStringCode(), info);
            }
        }
        return new CommonResult().success();
    }
}
