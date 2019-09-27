package com.infinova.depr.service.impl;

import com.infinova.depr.entity.Dept;
import com.infinova.depr.message.AjaxMessageResult;
import com.infinova.depr.service.DeptService;
import org.springframework.stereotype.Component;

/**
 * @author ldw
 * @date 2019/8/26 11:54
 */
@Component
public class DeptServiceHystric implements DeptService {
    @Override
    public AjaxMessageResult<Dept> getDeptTreeList() {
        System.out.println("16541894165165156");
        return new AjaxMessageResult<>();
    }
}
