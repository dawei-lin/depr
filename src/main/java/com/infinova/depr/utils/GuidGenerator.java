package com.infinova.depr.utils;

import java.util.UUID;

/**
 * 
* @ClassName:GuidGenerator
* @Description:UUID生成器
* @author:ldw
* @date:2019年6月21日 下午4:07:06
*
 */
public abstract class GuidGenerator {

    /**
     * private constructor
     */
    private GuidGenerator() {
    }

    public static String generate() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
