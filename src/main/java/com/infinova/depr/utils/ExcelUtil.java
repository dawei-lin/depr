package com.infinova.depr.utils;

import com.infinova.depr.entity.Demand;
import com.infinova.depr.enums.DemandCategoryType;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * excel工具类
 *
 * @author ldw
 */
public class ExcelUtil {
    private static Pattern FIGURE_PATTERN = Pattern.compile("[0-9]+");
    public static String demandChildCategoryName;
    public static List<String> numList = new ArrayList<>();
    public static List<String> nameList = new ArrayList<>();

    static {
        numList.add(DemandCategoryType.UQ_SD.getNum());
        numList.add(DemandCategoryType.UQ_ENVI.getNum());
        numList.add(DemandCategoryType.UQ_INTF.getNum());
        numList.add(DemandCategoryType.UQ_UI.getNum());
        numList.add(DemandCategoryType.UQ_SA.getNum());
        numList.add(DemandCategoryType.UQ_PERF.getNum());
        numList.add(DemandCategoryType.UQ_CA.getNum());
        numList.add(DemandCategoryType.UQ_TA.getNum());
        numList.add(DemandCategoryType.UQ_PA.getNum());
        numList.add(DemandCategoryType.UQ_MT.getNum());
        numList.add(DemandCategoryType.UQ_EXT.getNum());
        numList.add(DemandCategoryType.UQ_TRP.getNum());
        numList.add(DemandCategoryType.UQ_CER.getNum());
        numList.add(DemandCategoryType.UQ_QMS.getNum());
        numList.add(DemandCategoryType.UQ_MEC.getNum());
        numList.add(DemandCategoryType.UQ_LAR.getNum());
        numList.add(DemandCategoryType.UQ_OTH.getNum());

        nameList.add(DemandCategoryType.UQ_SD.getName());
        nameList.add(DemandCategoryType.UQ_ENVI.getName());
        nameList.add(DemandCategoryType.UQ_INTF.getName());
        nameList.add(DemandCategoryType.UQ_UI.getName());
        nameList.add(DemandCategoryType.UQ_SA.getName());
        nameList.add(DemandCategoryType.UQ_PERF.getName());
        nameList.add(DemandCategoryType.UQ_CA.getName());
        nameList.add(DemandCategoryType.UQ_TA.getName());
        nameList.add(DemandCategoryType.UQ_PA.getName());
        nameList.add(DemandCategoryType.UQ_MT.getName());
        nameList.add(DemandCategoryType.UQ_EXT.getName());
        nameList.add(DemandCategoryType.UQ_TRP.getName());
        nameList.add(DemandCategoryType.UQ_CER.getName());
        nameList.add(DemandCategoryType.UQ_QMS.getName());
        nameList.add(DemandCategoryType.UQ_MEC.getName());
        nameList.add(DemandCategoryType.UQ_LAR.getName());
        nameList.add(DemandCategoryType.UQ_OTH.getName());
    }


    /**
     * @param headers 列头
     * @param datas   数据
     * @return
     */
    public static Workbook getWorkbook(String[] headers, List<Object[]> datas) {
        Workbook workbook = new XSSFWorkbook();

        Sheet sheet = workbook.createSheet();
        Row row = null;
        Cell cell = null;
        CellStyle style = workbook.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER_SELECTION);

        Font font = workbook.createFont();

        int line = 0, maxColumn = 0;
        if (headers != null && headers.length > 0) {// 设置列头
            row = sheet.createRow(line++);
            row.setHeightInPoints(23);
            font.setBold(true);
            font.setFontHeightInPoints((short) 10);
            style.setFont(font);

            maxColumn = headers.length;
            for (int i = 0; i < maxColumn; i++) {
                cell = row.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(style);
            }
        }

        if (datas != null && datas.size() > 0) {// 渲染数据
            for (int index = 0, size = datas.size(); index < size; index++) {
                Object[] data = datas.get(index);
                if (data != null && data.length > 0) {
                    row = sheet.createRow(line++);
                    row.setHeightInPoints(20);

                    int length = data.length;
                    if (length > maxColumn) {
                        maxColumn = length;
                    }

                    for (int i = 0; i < length; i++) {
                        cell = row.createCell(i);
                        cell.setCellValue(data[i] == null ? null : data[i].toString());
                    }
                }
            }
        }

        for (int i = 0; i < maxColumn; i++) {
            sheet.autoSizeColumn(i);
        }

        return workbook;
    }

    public static void demandExcelExport(HttpServletRequest request, String filePath, String fileName, List<Demand> demandList, HttpServletResponse response) {
        File path = new File(filePath);
        if (!path.exists()) {
            path.mkdirs();
        }
        if (!filePath.endsWith(File.separator)) {
            filePath = filePath + File.separator;
        }
        FileInputStream fis = null;
        Workbook workbook = null;
        try {
            fis = new FileInputStream(filePath + "muban.xlsx");
            workbook = new XSSFWorkbook(fis);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Sheet sheet = workbook.getSheetAt(0);
        Row row = null;
        Cell cell = null;
        CellStyle style = workbook.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER_SELECTION);

        Font font = workbook.createFont();

        int line = 9;
        String header = "需求编号,需求名称,需求描述,需求备注,需求等级,是否为核心需求,实现的产品版本,产品规格编号,需求来源,来源简述,验收标准,总体设计说明书编号";
        int[] width = {120, 180, 450, 180, 60, 60, 100, 120, 180, 180, 180, 120};
        //创建表头行
        row = sheet.createRow(line++);
        row.setHeightInPoints(23);
        font.setBold(true);
        font.setFontHeightInPoints((short) 13);
        style.setFont(font);
        row.setRowStyle(style);
        String[] headers = header.split(",");
        for (int i = 0; i < headers.length; i++) {
            cell = row.createCell(i);
            cell.setCellValue(headers[i]);
        }

        row = sheet.createRow(line++);
        row.setHeightInPoints(23);
        font.setBold(true);
        font.setFontHeightInPoints((short) 13);
        style.setFont(font);
        row.setRowStyle(style);
        cell = row.createCell(0);
        cell.setCellValue("1、功能性需求");
        String demandCategoryName = "";
        boolean flag = false;
        int functionLineIndex = 0;
        int curLineIndex = 0;
        for (Demand demand : demandList) {
            if (!StringUtils.isNotEmpty(demandCategoryName) && !demand.getDemandCategoryName().startsWith("2")) {
                demandCategoryName = demand.getDemandCategoryName();
                row = sheet.createRow(line++);
                row.setHeightInPoints(20);
                cell = row.createCell(0);
                cell.setCellValue(demandCategoryName);
                CellRangeAddress region = new CellRangeAddress(line - 1, line - 1, 0, headers.length - 1);
                sheet.addMergedRegion(region);
            } else if (!demandCategoryName.equals(demand.getDemandCategoryName())) {
                if (!flag && demand.getDemandCategoryName().startsWith("2")) {
                    //创建空行
                    row = sheet.createRow(line++);
                    row.setHeightInPoints(20);

                    row = sheet.createRow(line++);
                    row.setHeightInPoints(20);
                    cell = row.createCell(0);
                    cell.setCellValue("2、非功能性需求");
                    flag = true;
                }
                if (flag) {
                    functionLineIndex++;
                }
                demandCategoryName = demand.getDemandCategoryName();
                Matcher matcher = FIGURE_PATTERN.matcher(demand.getDemandCategoryName());
                if (matcher.find()) {
                }
                if (matcher.find()) {
                    curLineIndex = Integer.parseInt(matcher.group(0));
                }
                //curLineIndex = Integer.parseInt(demandCategoryName.substring(demandCategoryName.indexOf(".") + 1, demandCategoryName.indexOf("、")));
                while (flag && curLineIndex > functionLineIndex) {
                    //创建一行标题行
                    row = sheet.createRow(line++);
                    row.setHeightInPoints(20);
                    cell = row.createCell(0);
                    cell.setCellValue(nameList.get(functionLineIndex - 1));
                    //创建一行不涉及行
                    row = sheet.createRow(line++);
                    row.setHeightInPoints(20);
                    cell = row.createCell(0);
                    cell.setCellValue(numList.get(functionLineIndex - 1) + "-001");
                    cell = row.createCell(1);
                    cell.setCellValue("不涉及");
                    functionLineIndex++;
                }
                row = sheet.createRow(line++);
                row.setHeightInPoints(20);
                cell = row.createCell(0);
                cell.setCellValue(demandCategoryName);
                CellRangeAddress region = new CellRangeAddress(line - 1, line - 1, 0, headers.length - 1);
                sheet.addMergedRegion(region);
            }
            //创建一行数据
            writeDemand(demand, sheet, line++);
        }
        //如果非功能需求的数据都为空，也应该生成非功能的标题行
        if (functionLineIndex == 0) {
            //创建空行
            row = sheet.createRow(line++);
            row.setHeightInPoints(20);
            cell = row.createCell(0);

            row = sheet.createRow(line++);
            row.setHeightInPoints(20);
            cell = row.createCell(0);
            cell.setCellValue("2、非功能性需求");
        }
        while (functionLineIndex < 17) {
            //创建一行标题行
            row = sheet.createRow(line++);
            row.setHeightInPoints(20);
            cell = row.createCell(0);
            cell.setCellValue(nameList.get(functionLineIndex));
            //创建一行不涉及行
            row = sheet.createRow(line++);
            row.setHeightInPoints(20);
            cell = row.createCell(0);
            cell.setCellValue(numList.get(functionLineIndex) + "-001");
            cell = row.createCell(1);
            cell.setCellValue("不涉及");
            functionLineIndex++;
        }
        for (int i = 0; i < width.length; i++) {
            sheet.setColumnWidth(i, (256 * width[i] + 184) / 8);
        }

        String userAgent = request.getHeader("User-Agent");
        if (workbook != null) {
            ByteArrayOutputStream byteArrayOutputStream = null;
            try {
                byteArrayOutputStream = new ByteArrayOutputStream();
                workbook.write(byteArrayOutputStream);
                response.setContentType("application/vnd.ms-excel;charset=utf-8");
                if (request.getHeader("User-Agent").toLowerCase().indexOf("firefox") > 0) {
                    fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1"); // firefox浏览器
                } else if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {
                    fileName = URLEncoder.encode(fileName, "UTF-8");// IE浏览器
                } else if (request.getHeader("User-Agent").toUpperCase().indexOf("CHROME") > 0) {
                    fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");// 谷歌
                }
                response.setHeader("Content-Disposition",
                        "attachment;filename=" + fileName);

                OutputStream outputStream = response.getOutputStream();
                outputStream.write(byteArrayOutputStream.toByteArray());
                outputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (byteArrayOutputStream != null) {
                        byteArrayOutputStream.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }

                try {
                    workbook.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static List<Demand> demandExcelImport(InputStream in, String fileName) {
        Workbook wb = null;
        Row row = null;
        Cell cell = null;
        try {
            if (fileName.toLowerCase().endsWith("xls")) {
                wb = new HSSFWorkbook(in);
            } else {
                wb = new XSSFWorkbook(in);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        Sheet sheet = wb.getSheetAt(0);
        int line = 0;
        List<Demand> demandList = new ArrayList<>();
        String demandCategoryName = "";
        String functionName = "";
        while (true) {
            row = sheet.getRow(line++);
            cell = row.getCell(0);
            functionName = cell.getStringCellValue();
            if (StringUtils.isNotEmpty(functionName) && functionName.contains("功能性需求")) {
                break;
            }
        }
        while (true) {
            row = sheet.getRow(line++);
            //跳过空行
            if (row.getCell(0) == null) {
                continue;
            }
            int index = 0;
            cell = row.getCell(index++);
            if (cell != null) {
                functionName = cell.getStringCellValue();
            }
            //遇到非功能需求跳转读取，换另一种读取方式
            if (StringUtils.isNotEmpty(functionName) && functionName.contains("非功能性需求")) {
                break;
            }

            //读取开始的第一个大分类
            if (!StringUtils.isNotEmpty(demandCategoryName)) {
                if (row != null && row.getCell(0) != null) {
                    demandCategoryName = row.getCell(0).getStringCellValue();
                }
                continue;
            }

            //跳过空行
            if (cell != null && !StringUtils.isNotEmpty(cell.getStringCellValue())) {
                continue;
            } else if (cell != null && cell.getStringCellValue().startsWith("UF")) {
                //读取每行的数据
                readDemand(demandList, demandCategoryName, cell, row, index);
            } else if (cell != null && !cell.getStringCellValue().equals(demandCategoryName)) {
                //更新父类名称
                demandCategoryName = cell.getStringCellValue();
            }
        }
        while (true) {
            row = sheet.getRow(line++);
            cell = row.getCell(0);
            demandCategoryName = cell.getStringCellValue();
            if (StringUtils.isNotEmpty(demandCategoryName) && demandCategoryName.contains("标准与规范需求")) {
                break;
            }
        }
        line--;
        demandCategoryName = "";
        while (true) {
            row = sheet.getRow(line++);
            //遇到空行则完成读取
            if (row == null) {
                break;
            }
            if (!StringUtils.isNotEmpty(demandCategoryName)) {
                demandCategoryName = row.getCell(0).getStringCellValue();
                continue;
            }
            int index = 0;
            cell = row.getCell(index++);
            Cell cellTemp = row.getCell(1);
            if (cellTemp != null && "不涉及".equals(cellTemp.getStringCellValue())) {
                continue;
            }
            //跳过空行
            if (cell != null && !StringUtils.isNotEmpty(cell.getStringCellValue())) {
                //遇到读取完最后一个需求完成读取
                if (StringUtils.isNotEmpty(demandCategoryName) && demandCategoryName.contains("其他需求")) {
                    break;
                }
                continue;
            } else if (cell != null && cell.getStringCellValue().indexOf("-", 4) > 0 && numList.contains(cell.getStringCellValue().substring(0, cell.getStringCellValue().indexOf("-", 4)))) {
                //读取每行的数据,如果需求中名字为不涉及，则跳过该行的输入
                readDemand(demandList, demandCategoryName, cell, row, index);
            } else if (cell != null && !cell.getStringCellValue().equals(demandCategoryName)) {
                demandCategoryName = cell.getStringCellValue();
            }
        }
        return demandList;
    }

    public static void demandMatrixExcelExport(String fileName, String[] headers, List<Object[]> datas, String[] headers2, List<Object[]> datas2,
                                               HttpServletResponse response) {
        Workbook workbook = getWorkbook(headers, datas);
        workbook = getWorkbook(headers2, datas2, workbook);
        if (workbook != null) {
            ByteArrayOutputStream byteArrayOutputStream = null;
            try {
                byteArrayOutputStream = new ByteArrayOutputStream();
                workbook.write(byteArrayOutputStream);

                String suffix = ".xlsx";
                response.setContentType("application/vnd.ms-excel;charset=utf-8");
                response.setHeader("Content-Disposition",
                        "attachment;filename=" + new String((fileName + suffix).getBytes(), "iso-8859-1"));

                OutputStream outputStream = response.getOutputStream();
                outputStream.write(byteArrayOutputStream.toByteArray());
                outputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (byteArrayOutputStream != null) {
                        byteArrayOutputStream.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }

                try {
                    workbook.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public static Workbook getWorkbook(String[] headers, List<Object[]> datas, Workbook workbook) {
        Sheet sheet = workbook.createSheet();
        Row row = null;
        Cell cell = null;
        CellStyle style = workbook.createCellStyle();
        style.setAlignment(HorizontalAlignment.CENTER_SELECTION);

        Font font = workbook.createFont();

        int line = 0, maxColumn = 0;
        if (headers != null && headers.length > 0) {// 设置列头
            row = sheet.createRow(line++);
            row.setHeightInPoints(23);
            font.setBold(true);
            font.setFontHeightInPoints((short) 10);
            style.setFont(font);

            maxColumn = headers.length;
            for (int i = 0; i < maxColumn; i++) {
                cell = row.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(style);
            }
        }

        if (datas != null && datas.size() > 0) {// 渲染数据
            for (int index = 0, size = datas.size(); index < size; index++) {
                Object[] data = datas.get(index);
                if (data != null && data.length > 0) {
                    row = sheet.createRow(line++);
                    row.setHeightInPoints(20);

                    int length = data.length;
                    if (length > maxColumn) {
                        maxColumn = length;
                    }

                    for (int i = 0; i < length; i++) {
                        cell = row.createCell(i);
                        cell.setCellValue(data[i] == null ? null : data[i].toString());
                    }
                }
            }
        }

        for (int i = 0; i < maxColumn; i++) {
            sheet.autoSizeColumn(i);
        }

        return workbook;
    }

    public static void readDemand(List<Demand> demandList, String demandCategoryName, Cell cell, Row row, Integer index) {
        //读取每行的数据
        Demand demand = new Demand();
        demand.setDemandCategoryName(demandCategoryName);
        if (cell != null && cell.getStringCellValue().split("-").length > 3) {
            String temp = row.getCell(index).getStringCellValue();
            if (StringUtils.isNotEmpty(temp)) {
                demandChildCategoryName = temp;
            }
            demand.setDemandChildCategoryName(demandChildCategoryName);
        }
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            demand.setDemandNum(cell.getStringCellValue());
        }
        cell = row.getCell(index++);
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            demand.setDemandName(cell.getStringCellValue());
        } else {
            demand.setDemandName(demandChildCategoryName);
        }
        cell = row.getCell(index++);
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            demand.setDemandDescribe(cell.getStringCellValue());
        }
        cell = row.getCell(index++);
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            demand.setDemandRemarks(cell.getStringCellValue());
        }
        cell = row.getCell(index++);
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            switch (cell.getStringCellValue()) {
                case "B":
                    demand.setDemandPriority(1);
                    break;
                case "A":
                    demand.setDemandPriority(2);
                    break;
                case "S":
                    demand.setDemandPriority(3);
                    break;
                default:
                    demand.setDemandPriority(1);
            }
        }
        cell = row.getCell(index++);
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            if ("Y".equals(cell.getStringCellValue())) {
                demand.setIsCore(1);
            } else {
                demand.setIsCore(0);
            }
        }
        cell = row.getCell(index++);
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            demand.setRealizeEdition(cell.getStringCellValue());
        }
        cell = row.getCell(index++);
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            demand.setNormsNum(cell.getStringCellValue());
        }
        cell = row.getCell(index++);
        //1代表产品管理，2代表技术标准和规范，3代表技术服务，4代表测试，5代表友商，6代表直接客户，7代表商业需求(应该用枚举类)
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            switch (cell.getStringCellValue()) {
                case "产品管理":
                    demand.setDemandOrigin(1);
                    break;
                case "技术标准和规范":
                    demand.setDemandOrigin(2);
                    break;
                case "技术服务":
                    demand.setDemandOrigin(3);
                    break;
                case "测试":
                    demand.setDemandOrigin(4);
                    break;
                case "友商":
                    demand.setDemandOrigin(5);
                    break;
                case "客户":
                    demand.setDemandOrigin(6);
                    break;
                case "商业需求":
                    demand.setDemandOrigin(7);
                    break;
                default:
                    demand.setDemandOrigin(1);
            }
        }
        cell = row.getCell(index++);
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            demand.setDemandResume(cell.getStringCellValue());
        }
        cell = row.getCell(index++);
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            demand.setDemandAcceptCriteria(cell.getStringCellValue());
        }

        cell = row.getCell(index++);
        if (cell != null && StringUtils.isNotEmpty(cell.getStringCellValue())) {
            demand.setOverallDesignRuleNum(cell.getStringCellValue());
        }
        demandList.add(demand);
    }

    public static void writeDemand(Demand demand, Sheet sheet, Integer line) {
        Row row = sheet.createRow(line);
        row.setHeightInPoints(20);
        int index = 0;
        Cell cell = row.createCell(index++);
        if (StringUtils.isNotEmpty(demand.getDemandNum())) {
            cell.setCellValue(demand.getDemandNum());
        }
        cell = row.createCell(index++);
        if (StringUtils.isNotEmpty(demand.getDemandName())) {
            cell.setCellValue(demand.getDemandName());
        }
        cell = row.createCell(index++);
        if (StringUtils.isNotEmpty(demand.getDemandDescribe())) {
            cell.setCellValue(demand.getDemandDescribe());
        }
        cell = row.createCell(index++);
        if (StringUtils.isNotEmpty(demand.getDemandRemarks())) {
            cell.setCellValue(demand.getDemandRemarks());
        }
        cell = row.createCell(index++);
        if (demand.getDemandPriority() != null) {
            switch (demand.getDemandPriority()) {
                case 1:
                    cell.setCellValue("B");
                    break;
                case 2:
                    cell.setCellValue("A");
                    break;
                case 3:
                    cell.setCellValue("S");
                    break;
            }
        }
        cell = row.createCell(index++);
        if (demand.getIsCore() != null) {
            if (demand.getIsCore() == 1) {
                cell.setCellValue("Y");
            } else {
                cell.setCellValue("N");
            }
        }
        cell = row.createCell(index++);
        if (StringUtils.isNotEmpty(demand.getRealizeEdition())) {
            cell.setCellValue(demand.getRealizeEdition());
        }
        cell = row.createCell(index++);
        if (StringUtils.isNotEmpty(demand.getNormsNum())) {
            cell.setCellValue(demand.getNormsNum());
        }
        cell = row.createCell(index++);
        if (demand.getDemandOrigin() != null) {
            //1代表产品管理，2代表技术标准和规范，3代表技术服务，4代表测试，5代表友商，6代表直接客户，7代表商业需求
            switch (demand.getDemandOrigin()) {
                case (1):
                    cell.setCellValue("产品管理");
                    break;
                case (2):
                    cell.setCellValue("技术标准和规范");
                    break;
                case (3):
                    cell.setCellValue("技术服务");
                    break;
                case (4):
                    cell.setCellValue("测试");
                    break;
                case (5):
                    cell.setCellValue("友商");
                    break;
                case (6):
                    cell.setCellValue("直接客户");
                    break;
                case (7):
                    cell.setCellValue("商业需求");
                    break;
            }
        }
        cell = row.createCell(index++);
        if (StringUtils.isNotEmpty(demand.getDemandResume())) {
            cell.setCellValue(demand.getDemandResume());
        }
        cell = row.createCell(index++);
        if (StringUtils.isNotEmpty(demand.getDemandAcceptCriteria())) {
            cell.setCellValue(demand.getDemandAcceptCriteria());
        }
        cell = row.createCell(index++);
        if (StringUtils.isNotEmpty(demand.getOverallDesignRuleNum())) {
            cell.setCellValue(demand.getOverallDesignRuleNum());
        }
    }

    public static void excelExport(String fileName, String[] headers, List<Object[]> datas,
                                   HttpServletResponse response) {
        Workbook workbook = getWorkbook(headers, datas);
        if (workbook != null) {
            ByteArrayOutputStream byteArrayOutputStream = null;
            try {
                byteArrayOutputStream = new ByteArrayOutputStream();
                workbook.write(byteArrayOutputStream);

                String suffix = ".xlsx";
                response.setContentType("application/vnd.ms-excel;charset=utf-8");
                response.setHeader("Content-Disposition",
                        "attachment;filename=" + new String((fileName + suffix).getBytes(), "iso-8859-1"));

                OutputStream outputStream = response.getOutputStream();
                outputStream.write(byteArrayOutputStream.toByteArray());
                outputStream.close();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (byteArrayOutputStream != null) {
                        byteArrayOutputStream.close();
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }

                try {
                    workbook.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
