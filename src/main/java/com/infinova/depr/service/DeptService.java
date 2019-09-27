package com.infinova.depr.service;

import com.infinova.depr.entity.Dept;
import com.infinova.depr.message.AjaxMessageResult;
import com.infinova.depr.service.impl.DeptServiceHystric;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author ldw
 * @date 2019/8/26 11:53
 */
@FeignClient(value = "auth-service", fallback = DeptServiceHystric.class)
public interface DeptService {
    @RequestMapping(value = "auth/department/tree")
    AjaxMessageResult<Dept> getDeptTreeList();
}
