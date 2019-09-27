package com.infinova.depr.controller;

import com.github.pagehelper.PageHelper;
import com.infinova.depr.entity.Project;
import com.infinova.depr.entity.ProjectParam;
import com.infinova.depr.enums.ReturnCodeType;
import com.infinova.depr.message.CommonResult;
import com.infinova.depr.message.MessageResult;
import com.infinova.depr.service.ProjectService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * @author ldw
 * @date 2019/8/15 17:15
 */
@RestController
@RequestMapping("/project")
@Api("项目")
public class ProjectController {
    @Autowired
    private ProjectService projectService;

    @PostMapping()
    @ApiOperation("增加项目")
    public CommonResult saveProject(@RequestBody @Valid Project project) {
        if (projectService.getProjectByName(project.getProjectName()) > 0) {
            return new CommonResult(ReturnCodeType.REPEAT_NAME.getStringCode(), ReturnCodeType.REPEAT_NAME.getDesc());
        }
        if (projectService.saveProject(project) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @PutMapping()
    @ApiOperation("更新项目")
    public CommonResult updateProject(@RequestBody @Valid Project project) {
        if (projectService.getProjectByNameAndProjectId(project.getProjectName(), project.getProjectId()) > 0) {
            return new CommonResult(ReturnCodeType.REPEAT_NAME.getStringCode(), ReturnCodeType.REPEAT_NAME.getDesc());
        }
        if (projectService.updateProject(project) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @DeleteMapping("{projectId}")
    @ApiOperation("删除项目")
    public CommonResult deleteProject(@PathVariable String projectId) {
        if (projectService.deleteProject(projectId) > 0) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @GetMapping("{projectId}")
    @ApiOperation("根据id获取项目")
    public MessageResult<Project> getProjectByProjectId(@PathVariable String projectId) {
        MessageResult<Project> messageResult = new MessageResult<>();
        messageResult.setMsg(projectService.getProjectByProjectId(projectId));
        return messageResult;
    }

    @GetMapping("/listByParams")
    @ApiOperation("根据参数获取项目列表")
    public MessageResult<List<Project>> getProjectListByParams(ProjectParam projectParam) {
        MessageResult<List<Project>> messageResult = new MessageResult<>();
        if (projectParam.getPageNum() != null && projectParam.getPageSize() != null) {
            PageHelper.startPage(projectParam.getPageNum(), projectParam.getPageSize());
        }
        messageResult.setMsg(projectService.getProjectListByParams(projectParam));
        return messageResult;
    }


}
