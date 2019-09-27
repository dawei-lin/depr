package com.infinova.depr.service.impl;

import com.infinova.depr.dao.ProductDao;
import com.infinova.depr.dao.ProjectDao;
import com.infinova.depr.entity.Project;
import com.infinova.depr.entity.ProjectParam;
import com.infinova.depr.service.ProjectService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.List;

/**
 * @author ldw
 * @date 2019/8/15 17:12
 */
@Service
public class ProjectServiceImpl implements ProjectService {
    @Autowired
    private ProjectDao projectDao;
    @Autowired
    private ProductDao productDao;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int saveProject(Project project) {
        if (project != null && !StringUtils.isNotEmpty(project.getProductId())) {
            project.setProductId(null);
        }
        return projectDao.saveProject(project);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteProject(String projectId) {
        return projectDao.deleteProject(projectId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int updateProject(Project project) {
        if (project != null && !StringUtils.isNotEmpty(project.getProductId())) {
            project.setProductId(null);
        }
        return projectDao.updateProject(project);
    }

    @Override
    public List<Project> getProjectListByParams(ProjectParam projectParam) {
        List<Project> projectList = projectDao.getProjectListByParams(projectParam);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for (Project project : projectList) {
            if (project.getProjectDate() != null) {
                project.setProjectTimeStr(sdf.format(project.getProjectDate()));
            }
            String quadrantRule = "";
            if (project.getProjectUrgency() != null && project.getProjectUrgency() == 1) {
                quadrantRule += "紧急";
            } else {
                quadrantRule += "不紧急";
            }
            if (project.getProjectImportance() != null && project.getProjectImportance() == 1) {
                quadrantRule += "重要";
            } else {
                quadrantRule += "不重要";
            }
            project.setQuadrantRule(quadrantRule);
        }
        return projectList;
    }

    @Override
    public Project getProjectByProjectId(String projectId) {
        Project project = projectDao.getProjectByProjectId(projectId);
        if (project != null && StringUtils.isNotEmpty(project.getProductId())) {
            project.setProductName(productDao.getProductNameById(project.getProductId()));
        }
        return project;
    }

    @Override
    public int getProjectByName(String projectName) {
        return projectDao.getProjectByName(projectName);
    }

    @Override
    public int getProjectByNameAndProjectId(String projectName, String projectId) {
        return projectDao.getProjectByNameAndProjectId(projectName, projectId);
    }

    @Override
    public int changeDept(String oldDeptId, String newDeptId, String newDeptName) {
        return projectDao.changeDept(oldDeptId, newDeptId, newDeptName);
    }
}
