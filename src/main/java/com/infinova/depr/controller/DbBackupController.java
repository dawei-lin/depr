package com.infinova.depr.controller;

import com.infinova.depr.job.DataBaseManagement;
import com.infinova.depr.message.CommonResult;
import com.infinova.depr.message.ExceptionResult;
import com.infinova.depr.message.MessageResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.TriggerContext;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.support.CronTrigger;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.concurrent.ScheduledFuture;

/**
 * @author ldw
 * @date 2019/9/4 14:11
 */
@RestController
@RequestMapping("/dbBackup")
@Api("数据库备份")
public class DbBackupController {
    @Autowired
    private DataBaseManagement dataBaseManagement;
    @Value("${cron}")
    private String cron;
    @Autowired
    private ThreadPoolTaskScheduler threadPoolTaskScheduler;
    private ScheduledFuture<?> scheduledFuture;

    @PostMapping("/manual")
    @ApiOperation("手动备份数据库")
    public CommonResult manual(HttpServletRequest request) {
        try {
            int result = dataBaseManagement.dbBackup(DataBaseManagement.manual, (String) request.getAttribute("userName"));
            if (result > 0) {
                return new CommonResult().success();
            } else {
                return new CommonResult().fail();
            }
        } catch (Exception e) {
            return new ExceptionResult(e);
        }
    }

    @PutMapping("{fileName}")
    @ApiOperation(value = "数据库还原")
    public CommonResult dbRestore(@PathVariable String fileName) {
        try {
            dataBaseManagement.restore(fileName);
            return new CommonResult().success();
        } catch (Exception e) {
            return new ExceptionResult(e);
        }
    }

    @PutMapping("/openAuto")
    @ApiOperation("开启定时任务")
    public CommonResult openAuto() {
        try {
            scheduledFuture = threadPoolTaskScheduler.schedule(new Runnable() {
                @Override
                public void run() {
                    try {
                        dataBaseManagement.dbBackup(DataBaseManagement.auto, "自动备份");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }, new Trigger() {
                @Override
                public Date nextExecutionTime(TriggerContext triggerContext) {
                    return new CronTrigger(cron).nextExecutionTime(triggerContext);
                }
            });
            return new CommonResult().success();
        } catch (Exception e) {
            return new ExceptionResult(e);
        }
    }

    @PutMapping("/closeAuto")
    @ApiOperation("关闭定时任务")
    public CommonResult closeAuto() {
        try {
            if (scheduledFuture != null) {
                scheduledFuture.cancel(true);
            }
            return new CommonResult().success();
        } catch (Exception e) {
            return new ExceptionResult(e);
        }
    }

    @GetMapping("/listBackups")
    @ApiOperation(value = "备份列表")
    public MessageResult<Object> listBackups(String fileName) {
        try {
            return new MessageResult<Object>(dataBaseManagement.getBackupFiles(fileName));
        } catch (Exception e) {
            return new ExceptionResult(e);
        }
    }

    /**
     * 只能删除手动备份的文件
     *
     * @param fileName
     * @return
     */
    @DeleteMapping("{fileName}")
    @ApiOperation(value = "删除备份")
    public MessageResult<Object> deleteBackup(@PathVariable String fileName) {
        try {
            int result = dataBaseManagement.delFile(fileName);
            if (result > 0) {
                return new MessageResult<>("0", "success");
            } else {
                return new MessageResult<>("-1", "fail");
            }
        } catch (Exception e) {
            return new ExceptionResult(e);
        }
    }

    @Bean
    public ThreadPoolTaskScheduler threadPoolTaskScheduler() {
        return new ThreadPoolTaskScheduler();
    }
}
