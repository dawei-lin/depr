package com.infinova.depr.message;

public class CommonResult {

    private String code = "0";
    private String desc = "success";

    public CommonResult success() {
        return this;
    }

    public CommonResult fail() {
        this.setCode("-1");
        this.setDesc("fail");
        return this;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public CommonResult() {
    }

    public CommonResult(String code, String desc) {
        this.code = code;
        this.desc = desc;
    }
}
