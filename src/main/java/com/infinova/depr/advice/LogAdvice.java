package com.infinova.depr.advice;

import com.infinova.depr.entity.Log;
import com.infinova.depr.service.LogService;
import io.swagger.annotations.ApiOperation;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.Date;

/**
 * 统一日志处理
 */
@Aspect
@Component
public class LogAdvice {
    @Autowired
    private LogService logService;


    @Around(value = "@annotation(io.swagger.annotations.ApiOperation)")
    public Object logSave(ProceedingJoinPoint joinPoint) throws Throwable {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
        if (request != null && !"GET".equals(request.getMethod())) {
            // 新建一个Log对象
            Log loginfo = new Log();

            Method method = ((MethodSignature) joinPoint.getSignature()).getMethod();
            String description = "";
            ApiOperation apiOperation = method.getDeclaredAnnotation(ApiOperation.class);
            if (apiOperation != null) {
                description = apiOperation.value();
            }
            loginfo.setLogName(description);
            loginfo.setLogOperator((String) request.getAttribute("userName"));
            loginfo.setLogOperationTime(new Date());

            try {
                Object object = joinPoint.proceed();
                return object;
            } catch (Exception e) {
                throw e;
            } finally {
                logService.saveLog(loginfo);
            }
        } else {
            try {
                Object object = joinPoint.proceed();
                return object;
            } catch (Exception e) {
                throw e;
            }
        }

    }

}
