package com.infinova.depr.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * @author ldw
 * @date 2019/9/9 15:37
 */
public class Log implements Serializable {
    private String logId;
    private String logName;
    private String logContent;
    private String logOperator;
    private Date logOperationTime;

    public String getLogId() {
        return logId;
    }

    public String getLogName() {
        return logName;
    }

    public String getLogContent() {
        return logContent;
    }

    public String getLogOperator() {
        return logOperator;
    }

    public Date getLogOperationTime() {
        return logOperationTime;
    }

    public void setLogId(String logId) {
        this.logId = logId;
    }

    public void setLogName(String logName) {
        this.logName = logName;
    }

    public void setLogContent(String logContent) {
        this.logContent = logContent;
    }

    public void setLogOperator(String logOperator) {
        this.logOperator = logOperator;
    }

    public void setLogOperationTime(Date logOperationTime) {
        this.logOperationTime = logOperationTime;
    }

    public Log(String logId, String logName, String logContent, String logOperator, Date logOperationTime) {
        this.logId = logId;
        this.logName = logName;
        this.logContent = logContent;
        this.logOperator = logOperator;
        this.logOperationTime = logOperationTime;
    }

    public Log() {
    }
}
