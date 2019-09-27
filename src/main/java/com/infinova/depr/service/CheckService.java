package com.infinova.depr.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author ldw
 * @date 2019/9/3 10:46
 */
@FeignClient(value = "auth-service")
public interface CheckService {

    @RequestMapping(value = "auth/department/treetest")
    void test();

}
