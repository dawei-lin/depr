package com.infinova.depr.enums;

public enum ReturnCodeType {

    //系统通用返回值
    NORMAL_STATE(0),
    SERVER_ERROR(-1, "服务器错误"),
    PARAMETER_INVALID(-2, "参数无效"),
    ACCESS_DENIED(-3, "访问被拒绝"),
    REPEAT_NAME(-4, "名称重复"),
    DEMAND_NUM_REPEAT(-5, "需求编号重复"),
    REPEAT_UPLOAD(-6, "重复上传"),
    NUM_ERROR(-7, "编号和表格数量不匹配或者编号不规范"),
    FORM_INCORRECT(-8, "后缀名不是docx或者xlsx或者xls"),
    NUM_NON_EXISTENT(-9, "编号不存在"),
    DEMAND_CATEGORY_NAME_MISMATCHING(-10, "需求大类名字不存在或者不规范"),
    DEMAND_NUM_MISMATCHING(-11, "需求编号不存在或者不规范"),
    EXCEL_ERROR(-12, "excel错误"),
    DEMAND_NAME_ERROR(-13, "选择子类时需求名字需和子类相同");

    private int code;
    private String desc;

    ReturnCodeType(int code) {
        this.code = code;
    }

    ReturnCodeType(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public int getCode() {
        return code;
    }

    public String getStringCode() {
        return String.valueOf(code);
    }

    public String getDesc() {
        return desc;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public static ReturnCodeType getByCode(int code) {
        for (ReturnCodeType type : ReturnCodeType.values()) {
            if (type.getCode() == code) {
                return type;
            }
        }
        return ReturnCodeType.NORMAL_STATE;
    }


}
