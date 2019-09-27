package com.infinova.depr.message;

import java.util.ArrayList;

public class MessageResult<T> extends CommonResult {

    // 返回对象，或者object, 或者list
    private T msg;

    public MessageResult(T t) {
        this.msg = t;
    }

    public MessageResult() {
    }

    public MessageResult(String code, String desc) {
        super(code, desc);
    }

    public T getMsg() {
        return msg;
    }

    @SuppressWarnings("unchecked")
    public void setMsg(T msg) {
        if (null == msg) {
            msg = (T) new ArrayList<>();
        }
        this.msg = msg;
    }

}
