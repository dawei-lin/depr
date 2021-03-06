package com.infinova.depr.advice;


import com.infinova.depr.enums.ReturnCodeType;
import com.infinova.depr.message.MessageResult;
import com.infinova.depr.vo.ResponseInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.UnsatisfiedServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import javax.servlet.http.HttpServletRequest;
import java.nio.file.AccessDeniedException;

/**
 * springmvc异常处理
 *
 * @author ldw
 */
@RestControllerAdvice
public class ExceptionHandlerAdvice {

    private static final Logger log = LoggerFactory.getLogger(ExceptionHandlerAdvice.class);


    @ExceptionHandler({IllegalArgumentException.class})
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ResponseInfo badRequestException(IllegalArgumentException exception) {
        return new ResponseInfo(HttpStatus.BAD_REQUEST.value() + "", exception.getMessage());
    }

    @ExceptionHandler({AccessDeniedException.class})
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public ResponseInfo badRequestException(AccessDeniedException exception) {
        return new ResponseInfo(HttpStatus.FORBIDDEN.value() + "", exception.getMessage());
    }

    @ExceptionHandler({MissingServletRequestParameterException.class, HttpMessageNotReadableException.class,
            UnsatisfiedServletRequestParameterException.class, MethodArgumentTypeMismatchException.class})
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ResponseInfo badRequestException(Exception exception) {
        return new ResponseInfo(HttpStatus.BAD_REQUEST.value() + "", exception.getMessage());
    }

    @ExceptionHandler(Throwable.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ResponseInfo exception(Throwable throwable) {
        log.error("系统异常", throwable);
        return new ResponseInfo(HttpStatus.INTERNAL_SERVER_ERROR.value() + "", throwable.getMessage());
    }

    /**
     * 功能描述 后面两个方法有查库操作，待改
     *
     * @param req
     * @param e
     * @return com.infinova.depr.message.MessageResult<java.lang.Object>
     * @author ldw
     * @date 2019/7/12
     */
    @ExceptionHandler(value = BindException.class)
    @ResponseBody
    public MessageResult<Object> handleBindException(HttpServletRequest req, BindException e) throws MethodArgumentNotValidException {
        MessageResult<Object> data = new MessageResult<Object>();
        FieldError fieldError = e.getBindingResult().getFieldError();
        data.setCode(ReturnCodeType.PARAMETER_INVALID.getStringCode());
        data.setDesc(fieldError.getDefaultMessage());
        return data;
    }

    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    @ResponseBody
    public MessageResult<Object> handleMethodArgumentNotValidException(HttpServletRequest req, MethodArgumentNotValidException e) throws MethodArgumentNotValidException {
        MessageResult<Object> data = new MessageResult<Object>();
        FieldError fieldError = e.getBindingResult().getFieldError();
        data.setCode(ReturnCodeType.PARAMETER_INVALID.getStringCode());
        data.setDesc(fieldError.getDefaultMessage());
        return data;
    }


}
