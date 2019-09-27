package com.infinova.depr.service;

import com.infinova.depr.entity.Project;
import com.infinova.depr.entity.ProjectParam;

import java.util.List;

/**
 * @author ldw
 * @date 2019/8/15 17:10
 */
public interface ProjectService {
    int saveProject(Project project);

    int deleteProject(String projectId);

    int updateProject(Project project);

    List<Project> getProjectListByParams(ProjectParam projectParam);

    Project getProjectByProjectId(String projectId);

    int getProjectByName(String projectName);

    int getProjectByNameAndProjectId(String projectName, String projectId);

    int changeDept(String oldDeptId, String newDeptId, String newDeptName);
}
