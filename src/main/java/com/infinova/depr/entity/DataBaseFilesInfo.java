package com.infinova.depr.entity;

import java.util.Date;

/**
 * 数据库备份文件信息
 *
 * @author ldw
 */
public class DataBaseFilesInfo {

    //文件名
    private String fileName;

    //文件大小(kb)
    private String fileSize;

    //备份时间
    private Date backupTime;

    //备份方式
    private String backupType;
    //操作者
    private String operator;

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileSize() {
        return fileSize;
    }

    public void setFileSize(String fileSize) {
        this.fileSize = fileSize;
    }

    public Date getBackupTime() {
        return backupTime;
    }

    public void setBackupTime(Date backupTime) {
        this.backupTime = backupTime;
    }

    public String getBackupType() {
        return backupType;
    }

    public void setBackupType(String backupType) {
        this.backupType = backupType;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public DataBaseFilesInfo(String fileName, String fileSize, Date backupTime, String backupType, String operator) {
        this.fileName = fileName;
        this.fileSize = fileSize;
        this.backupTime = backupTime;
        this.backupType = backupType;
        this.operator = operator;
    }

    public DataBaseFilesInfo() {
    }
}
