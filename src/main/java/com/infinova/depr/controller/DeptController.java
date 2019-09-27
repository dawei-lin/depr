package com.infinova.depr.controller;

import com.infinova.depr.DeprApplication;
import com.infinova.depr.dao.DeptDao;
import com.infinova.depr.entity.Dept;
import com.infinova.depr.message.AjaxMessageResult;
import com.infinova.depr.message.MessageResult;
import com.infinova.depr.service.CheckService;
import com.infinova.depr.service.DeptService;
import com.infinova.depr.service.ProductService;
import com.infinova.depr.service.ProjectService;
import com.infinova.depr.service.SchedualServiceHi;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * @author ldw
 * @date 2019/8/26 11:48
 */
@RestController
@RequestMapping("/dept")
@Api("部门管理")
public class DeptController {
    @Autowired
    private DeptService deptService;
    @Autowired
    private DeptDao deptDao;
    @Autowired
    private ProductService productService;
    @Autowired
    private ProjectService projectService;
    @Autowired
    private SchedualServiceHi schedualServiceHi;
    @Autowired
    private CheckService checkService;
    static Logger logger = LoggerFactory.getLogger(DeprApplication.class);

    /*@PostMapping("")
    @ApiOperation("添加部门")
    public CommonResult saveDept(@RequestBody Dept dept) {
        if (deptService.saveDept(dept) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @PutMapping("")
    @ApiOperation("更新部门")
    public CommonResult updateDept(@RequestBody Dept dept) {
        if (deptService.updateDept(dept) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @DeleteMapping("/{deptId}")
    @ApiOperation("删除部门")
    public CommonResult deleteDept(@PathVariable String deptId) {
        if (deptService.deleteDept(deptId) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @GetMapping("/{deptId}")
    @ApiOperation("根据id获取部门")
    public MessageResult<Dept> getDeptById(@PathVariable String deptId) {
        Dept dept = deptService.getDeptById(deptId);
        MessageResult<Dept> messageResult = new MessageResult<>();
        messageResult.setMsg(dept);
        return messageResult;
    }

    @GetMapping("/excel")
    @ApiOperation("导出excel")
    public void exportExcel(HttpServletResponse response) {
        List<Dept> deptList = deptDao.getAllDept();
        List<Object[]> objects = new ArrayList<>();
        for (Dept dept : deptList) {
            Object[] object = new Object[3];
            object[0] = dept.getDeptName();
            object[1] = dept.getDeptNum();
            object[2] = dept.getParentDeptName();
            objects.add(object);
        }
        String headers = "部门名称,部门编号,所属部门";
        ExcelUtil.excelExport("组织架构表", headers.split(","), objects, response);
    }

    @GetMapping("/parentDeptList")
    @ApiOperation("获取一级部门列表")
    public MessageResult<List<Dept>> getParentDeptList() {
        MessageResult<List<Dept>> messageResult = new MessageResult<>();
        messageResult.setMsg(deptService.getParentDeptList());
        return messageResult;
    }

    @GetMapping("listByName")
    @ApiOperation("获取部门列表")
    public MessageResult<List<Dept>> getDeptListByName(String deptName) {
        MessageResult<List<Dept>> messageResult = new MessageResult<>();
        messageResult.setMsg(deptService.getDeptListByName(deptName));
        return messageResult;
    }

    @GetMapping("deptTreeList")
    @ApiOperation("获取层级关系的部门")
    public MessageResult<List<Dept>> getDeptTreeList() {
        MessageResult<List<Dept>> messageResult = new MessageResult<>();
        messageResult.setMsg(deptService.getDeptTreeList());
        return messageResult;
    }*/

    @PutMapping("/changeDept")
    @ApiOperation("更改产品的部门id")
    public void changeDept(String oldDeptId, String newDeptId, String newDeptName) {
        productService.changeDept(oldDeptId, newDeptId, newDeptName);
        projectService.changeDept(oldDeptId, newDeptId, newDeptName);
    }

    @GetMapping("/getDeptTreeList")
    public MessageResult<Dept> getDeptTreeList() {
        MessageResult<Dept> messageResult = new MessageResult<>();
        AjaxMessageResult<Dept> treeList = deptService.getDeptTreeList();
        Dept dept = treeList.getMsg();
        if (dept != null) {
            List<Dept> children = new ArrayList<>();
            getProductLineList(dept, children);
            dept.setChildren(children);
        }
        messageResult.setMsg(dept);
        return messageResult;
    }

    @GetMapping("/getProductLines")
    public MessageResult<List<Dept>> getProductLines() {
        MessageResult<List<Dept>> messageResult = new MessageResult<>();
        AjaxMessageResult<Dept> treeList = deptService.getDeptTreeList();
        Dept dept = treeList.getMsg();
        List<Dept> children = null;
        if (dept != null) {
            children = new ArrayList<>();
            getProductLineList(dept, children);
        }
        messageResult.setMsg(children);
        return messageResult;
    }

    public void getProductLineList(Dept dept, List<Dept> productLines) {
        if (dept != null) {
            List<Dept> children = dept.getChildren();
            if (children != null) {
                for (Dept temp : children) {
                    getProductLineList(temp, productLines);
                }
            }
            if (StringUtils.isNotEmpty(dept.getRemark()) && dept.getRemark().contains("需求矩阵")) {
                dept.setChildren(null);
                productLines.add(dept);
            }
        }
    }
}
