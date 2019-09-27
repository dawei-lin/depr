package com.infinova.depr.message;


import com.infinova.depr.enums.ReturnCodeType;
import com.infinova.depr.exception.ApplicationException;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.nio.file.AccessDeniedException;

/**
 * @ClassName:AjaxExceptionResult
 * @Description:异常提示
 * @author:ldw
 * @date:2019年6月14日 上午11:41:10
 */
public class ExceptionResult extends MessageResult<Object> {
    // 必须是静态属性，否则json化异常  note by ldw 20190523
    public final static Logger logger = LogManager.getLogger(ExceptionResult.class);

    public ExceptionResult() {
        this.setCode(ReturnCodeType.SERVER_ERROR.getStringCode());
        this.setDesc(ReturnCodeType.SERVER_ERROR.getDesc());
    }

    public ExceptionResult(Exception ex) {
        this();
        logger.error(this.getDesc(), ex);

        if (ex instanceof AccessDeniedException) {
            this.setCode(ReturnCodeType.ACCESS_DENIED.getStringCode());
            this.setDesc(ReturnCodeType.ACCESS_DENIED.getDesc());
        } else if (ex instanceof ApplicationException) {
            ApplicationException ape = (ApplicationException) ex;
            this.setCode(ape.getErrorCode());
        }
    }

}
