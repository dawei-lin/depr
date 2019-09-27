package com.infinova.depr.service;

import com.infinova.depr.entity.OverallDesignRule;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;

/**
 * @author ldw
 * @date 2019/8/3 11:13
 */
public interface OverallDesignRuleService {
    List<String> saveOverallDesignRuleList(FileInputStream fis, String fileName, String productId, String filePath, String newFileMd5, File newFile) throws Exception;

    String checkOverallDesignRuleNum(String overallDesignRuleNum, String productId);

    List<OverallDesignRule> getOverallDesignRuleList(List<String> overallDesignRuleIds);
}
