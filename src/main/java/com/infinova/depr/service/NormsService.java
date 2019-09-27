package com.infinova.depr.service;

import com.infinova.depr.entity.Norms;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

/**
 * @author ldw
 * @date 2019/8/3 11:13
 */
public interface NormsService {
    List<String> saveNormsList(FileInputStream fis, String fileName, String productId, String filePath, String newFileMd5, File newFile) throws Exception;

    String checkNormsNum(String normsNum, String productId);

    List<Norms> getNormsList(List<String> normsIds);
}
