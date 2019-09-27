package com.infinova.depr.utils;

import com.infinova.depr.enums.DemandCategoryType;
import org.apache.commons.lang3.StringUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * @author ldw
 * @date 2019/7/23 10:19
 */
public class OrderUtil {
    public static Map<String, String> nameToNum = new HashMap<>();

    static {
        nameToNum.put(DemandCategoryType.UQ_SD.getName(), DemandCategoryType.UQ_SD.getNum());
        nameToNum.put(DemandCategoryType.UQ_ENVI.getName(), DemandCategoryType.UQ_ENVI.getNum());
        nameToNum.put(DemandCategoryType.UQ_INTF.getName(), DemandCategoryType.UQ_INTF.getNum());
        nameToNum.put(DemandCategoryType.UQ_UI.getName(), DemandCategoryType.UQ_UI.getNum());
        nameToNum.put(DemandCategoryType.UQ_SA.getName(), DemandCategoryType.UQ_SA.getNum());
        nameToNum.put(DemandCategoryType.UQ_PERF.getName(), DemandCategoryType.UQ_PERF.getNum());
        nameToNum.put(DemandCategoryType.UQ_CA.getName(), DemandCategoryType.UQ_CA.getNum());
        nameToNum.put(DemandCategoryType.UQ_TA.getName(), DemandCategoryType.UQ_TA.getNum());
        nameToNum.put(DemandCategoryType.UQ_PA.getName(), DemandCategoryType.UQ_PA.getNum());
        nameToNum.put(DemandCategoryType.UQ_MT.getName(), DemandCategoryType.UQ_MT.getNum());
        nameToNum.put(DemandCategoryType.UQ_EXT.getName(), DemandCategoryType.UQ_EXT.getNum());
        nameToNum.put(DemandCategoryType.UQ_TRP.getName(), DemandCategoryType.UQ_TRP.getNum());
        nameToNum.put(DemandCategoryType.UQ_CER.getName(), DemandCategoryType.UQ_CER.getNum());
        nameToNum.put(DemandCategoryType.UQ_QMS.getName(), DemandCategoryType.UQ_QMS.getNum());
        nameToNum.put(DemandCategoryType.UQ_MEC.getName(), DemandCategoryType.UQ_MEC.getNum());
        nameToNum.put(DemandCategoryType.UQ_LAR.getName(), DemandCategoryType.UQ_LAR.getNum());
        nameToNum.put(DemandCategoryType.UQ_OTH.getName(), DemandCategoryType.UQ_OTH.getNum());
    }

    public static String getStringOrder(Integer order) {
        String result = "";
        result = getStringOrder(order, 10);
        return result;
    }

    public static String getStringOrder(Integer order, int size) {
        String result = order + "";
        for (int i = result.length(); i < size; i++) {
            result = "0" + result;
        }
        return result;
    }

    public static String getNum(String prefix, String oneOrder, String twoOrder, String thirdOrder) {
        String result = prefix;
        if (StringUtils.isNotEmpty(oneOrder)) {
            result += "-" + oneOrder;
        }
        if (StringUtils.isNotEmpty(twoOrder)) {
            result += "-" + twoOrder;
        }
        if (StringUtils.isNotEmpty(thirdOrder)) {
            result += "-" + thirdOrder;
        }
        return result;
    }

    public static String getPrefix(String demandCategoryName) {
        String result = "UF";
        if (nameToNum.containsKey(demandCategoryName)) {
            result = nameToNum.get(demandCategoryName);
        }
        return result;
    }
}
