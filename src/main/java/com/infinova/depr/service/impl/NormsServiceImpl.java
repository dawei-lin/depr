package com.infinova.depr.service.impl;

import com.google.common.base.Throwables;
import com.infinova.depr.DeprApplication;
import com.infinova.depr.dao.DemandDao;
import com.infinova.depr.dao.DemandNormsRelationDao;
import com.infinova.depr.dao.NormsDao;
import com.infinova.depr.entity.Datasheet;
import com.infinova.depr.entity.Demand;
import com.infinova.depr.entity.DemandNormsRelation;
import com.infinova.depr.entity.Norms;
import com.infinova.depr.service.DatasheetService;
import com.infinova.depr.service.NormsService;
import com.infinova.depr.utils.PdfUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.pdfbox.io.RandomAccessBuffer;
import org.apache.pdfbox.pdfparser.PDFParser;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.interactive.documentnavigation.outline.PDDocumentOutline;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author ldw
 * @date 2019/8/3 11:15
 */
@Service
public class NormsServiceImpl implements NormsService {
    @Autowired
    private NormsDao normsDao;
    @Autowired
    private DemandDao demandDao;
    @Autowired
    private DatasheetService datasheetService;
    @Autowired
    private DemandNormsRelationDao demandNormsRelationDao;
    private static Pattern NUM_PATTERN = Pattern.compile("[A-Za-z0-9]{1,100}([-_][A-Za-z0-9]{1,100}){1,100}");
    private static Pattern CN_PATTERN = Pattern.compile("[\\u4E00-\\u9FA5]{1,50}");
    static Logger logger = LoggerFactory.getLogger(DeprApplication.class);

    @Override
    @Transactional(rollbackFor = Exception.class)
    public List<String> saveNormsList(FileInputStream fis, String fileName, String productId, String filePath, String newFileMd5, File newFile) throws Exception {
        List<String> infoMessage = new ArrayList<>();
        if (fileName.toLowerCase().endsWith("docx")) {
            //word 2007 图片不会被读取， 表格中的数据会被放在字符串的最后
            XWPFDocument xwpf = null;//得到word文档的信息
            try {
                xwpf = new XWPFDocument(fis);
            } catch (IOException e) {
                e.printStackTrace();
                logger.error(Throwables.getStackTraceAsString(e));
                throw new IOException();
            }
            Iterator<XWPFTable> it = xwpf.getTablesIterator();//得到word中的表格
            XWPFTable table = null;
            XWPFTableRow row = null;
            List<String> numList = new ArrayList<>();
            List<String> nameList = new ArrayList<>();
            List<Integer> titleIndex = new ArrayList<>();
            List<Integer> tableIndex = new ArrayList<>();
            List<String> unFunctionName = new ArrayList<>();
            List<String> repeatNumList = new ArrayList<>();
            int index = -1;
            List<XWPFParagraph> paragraphList = xwpf.getParagraphs();
            for (int i = 0; i < paragraphList.size(); i++) {
                XWPFParagraph paragraph = paragraphList.get(i);
                try {
                    //判断该段落是否设置了大纲级别
                    if (paragraph.getCTP().getPPr().getOutlineLvl() != null) {
                        Matcher m = NUM_PATTERN.matcher(paragraph.getText());
                        if (m.find()) {
                            if (numList.contains(m.group(0))) {
                                if (!repeatNumList.contains(m.group(0))) {
                                    repeatNumList.add(m.group(0));
                                }
                            }
                            numList.add(m.group(0));
                            String text = paragraph.getText();
                            nameList.add(text.substring(text.lastIndexOf(m.group(0)) + m.group(0).length()).trim());
                            titleIndex.add(xwpf.getPosOfParagraph(paragraph));
                        }
                        if (paragraph.getText().contains("非功能性需求")) {
                            index++;
                        }
                        if (index >= 0 && index < 16) {
                            Matcher matcher = CN_PATTERN.matcher(paragraph.getText());
                            if (matcher.find()) {
                                unFunctionName.add(matcher.group(0).trim());
                                index++;
                            }
                        }
                    } else //判断该段落的样式是否设置了大纲级别
                        if (xwpf.getStyles().getStyle(paragraph.getStyle()).getCTStyle().getPPr().getOutlineLvl() != null) {
                            Matcher m = NUM_PATTERN.matcher(paragraph.getText());
                            if (m.find()) {
                                if (numList.contains(m.group(0))) {
                                    if (!repeatNumList.contains(m.group(0))) {
                                        repeatNumList.add(m.group(0));
                                    }
                                }
                                numList.add(m.group(0));
                                String text = paragraph.getText();
                                nameList.add(text.substring(text.lastIndexOf(m.group(0)) + m.group(0).length()).trim());
                                titleIndex.add(xwpf.getPosOfParagraph(paragraph));
                            }
                            if (paragraph.getText().contains("非功能性需求")) {
                                index++;
                            }
                            if (index >= 0 && index < 16) {
                                Matcher matcher = CN_PATTERN.matcher(paragraph.getText());
                                if (matcher.find()) {
                                    unFunctionName.add(matcher.group(0).trim());
                                    index++;
                                }
                            }
                        } else //判断该段落的样式的基础样式是否设置了大纲级别
                            if (xwpf.getStyles().getStyle(xwpf.getStyles().getStyle(paragraph.getStyle()).getCTStyle().getBasedOn().getVal())
                                    .getCTStyle().getPPr().getOutlineLvl() != null) {
                                Matcher m = NUM_PATTERN.matcher(paragraph.getText());
                                if (m.find()) {
                                    if (numList.contains(m.group(0))) {
                                        if (!repeatNumList.contains(m.group(0))) {
                                            repeatNumList.add(m.group(0));
                                        }
                                    }
                                    numList.add(m.group(0));
                                    String text = paragraph.getText();
                                    nameList.add(text.substring(text.lastIndexOf(m.group(0)) + m.group(0).length()).trim());
                                    titleIndex.add(xwpf.getPosOfParagraph(paragraph));
                                }
                                if (paragraph.getText().contains("非功能性需求")) {
                                    index++;
                                }
                                if (index >= 0 && index < 16) {
                                    Matcher matcher = CN_PATTERN.matcher(paragraph.getText());
                                    if (matcher.find()) {
                                        unFunctionName.add(matcher.group(0).trim());
                                        index++;
                                    }
                                }
                            }
                } catch (Exception e) {
                    //该异常不能抛出
                }
            }

            while (it.hasNext()) {
                table = it.next();
                row = table.getRow(0);
                if (row != null && row.getCell(0) != null && row.getCell(0).getText().contains("用户") && row.getCell(2) != null && row.getCell(2).getText().contains("版本")) {
                    tableIndex.add(xwpf.getPosOfTable(table));
                }
            }
            List<Integer> errorLine = new ArrayList<>();
            //如果标题和表格位置不对，返回第几个表格
            int tableCurIndex = 0, titleCurIndex = 0;
            while (tableCurIndex < tableIndex.size() && titleCurIndex < titleIndex.size()) {
                if (tableIndex.get(tableCurIndex) > titleIndex.get(titleCurIndex) && titleCurIndex < titleIndex.size() - 1 && tableIndex.get(tableCurIndex) < titleIndex.get(titleCurIndex + 1)) {
                    //如果一个表格的位置在两个相邻小标题之间，那么该表格匹配前一个小标题
                    tableCurIndex++;
                    titleCurIndex++;
                } else if (tableIndex.get(tableCurIndex) <= titleIndex.get(titleCurIndex)) {
                    //如果一个表格的位置位于当前小标题前面（即该表格没有小标题，应该提示）
                    errorLine.add(tableCurIndex);
                    tableCurIndex++;
                } else if (titleCurIndex < titleIndex.size() - 1 && tableIndex.get(tableCurIndex) >= titleIndex.get(titleCurIndex + 1)) {
                    //如果一个表格前面有多个小标题，应该提示
                    errorLine.add(tableCurIndex);
                    while (titleCurIndex < titleIndex.size() - 1 && tableIndex.get(tableCurIndex) >= titleIndex.get(titleCurIndex + 1)) {
                        titleCurIndex++;
                    }
                    tableCurIndex++;
                } else if (tableIndex.get(tableCurIndex) > titleIndex.get(titleCurIndex) && titleCurIndex == titleIndex.size() - 1) {
                    //最后一个表格和标题
                    tableCurIndex++;
                    titleCurIndex++;
                }
            }
            //经上面的循环，应该会有三种情况，第一种即两种都匹配成功，第二种即标题读完，第三种即表格读完。处理标题读完的情况，即剩下的表格前面都没有标题
            while (tableCurIndex < tableIndex.size()) {
                errorLine.add(tableCurIndex++);
            }
            Iterator<XWPFTable> iterator = xwpf.getTablesIterator();
            List<Norms> normsList = new ArrayList<>();
            int curIndex = 0;
            while (iterator.hasNext()) {
                table = iterator.next();
                row = table.getRow(0);
                if (row != null && row.getCell(0) != null && row.getCell(0).getText().contains("用户") && row.getCell(2) != null && row.getCell(2).getText().contains("版本")) {
                    if (errorLine.size() == 0) {
                        Norms norms = new Norms();
                        if (table.getRow(0) != null && table.getRow(0).getCell(1) != null) {
                            norms.setNormsUser(table.getRow(0).getCell(1).getText());
                        }
                        if (table.getRow(0) != null && table.getRow(0).getCell(3) != null) {
                            norms.setNormsVersion(table.getRow(0).getCell(3).getText());
                        }
                        if (table.getRow(1) != null && table.getRow(1).getCell(1) != null) {
                            norms.setNormsDescribe(table.getRow(1).getCell(1).getText());
                        }
                        if (table.getRow(2) != null && table.getRow(2).getCell(1) != null) {
                            norms.setNormsEvent(table.getRow(2).getCell(1).getText());
                        }
                        if (table.getRow(3) != null && table.getRow(3).getCell(1) != null) {
                            norms.setNormsPrecondition(table.getRow(3).getCell(1).getText());
                        }
                        if (table.getRow(4) != null && table.getRow(4).getCell(2) != null) {
                            norms.setNormsBaseflow(table.getRow(4).getCell(2).getText());
                        }
                        if (table.getRow(5) != null && table.getRow(5).getCell(2) != null) {
                            norms.setNormsExtflow(table.getRow(5).getCell(2).getText());
                        }
                        if (table.getRow(6) != null && table.getRow(6).getCell(2) != null) {
                            norms.setNormsExcflow(table.getRow(6).getCell(2).getText());
                        }
                        if (table.getRow(7) != null && table.getRow(7).getCell(1) != null) {
                            norms.setNormsPostcondition(table.getRow(7).getCell(1).getText());
                        }
                        if (table.getRow(8) != null && table.getRow(8).getCell(1) != null) {
                            norms.setNormsRule(table.getRow(8).getCell(1).getText());
                        }
                        if (table.getRow(9) != null && table.getRow(9).getCell(1) != null) {
                            norms.setNormsOther(table.getRow(9).getCell(1).getText());
                        }
                        norms.setProductId(productId);
                        normsList.add(norms);
                    } else {
                        if (errorLine.contains(curIndex)) {
                            if (table.getRow(1) != null && table.getRow(1).getCell(1) != null) {
                                infoMessage.add("描述信息为" + table.getRow(1).getCell(1).getText() + "的表格前面的编号可能有误，请检查后再上传");
                            }
                        }
                    }
                    curIndex++;
                }
            }
            while (titleCurIndex < titleIndex.size()) {
                infoMessage.add("标题中编号为" + numList.get(titleCurIndex++) + "下面可能没有表格或者表格不规范");
            }
            for (String repeatNum : repeatNumList) {
                infoMessage.add("规格编号为" + repeatNum + "重复出现");
            }
            if (infoMessage.size() > 0) {
                return infoMessage;
            }
            for (int i = 0; i < numList.size(); i++) {
                normsList.get(i).setNormsName(nameList.get(i));
                normsList.get(i).setNormsNum(numList.get(i));
            }
            iterator = xwpf.getTablesIterator();
            index = 0;
            while (iterator.hasNext()) {
                table = iterator.next();
                row = table.getRow(0);
                if (row != null && row.getCell(0) != null && row.getCell(0).getText().contains("编号") && row.getCell(1) != null && row.getCell(1).getText().contains("说明")) {
                    if (index >= unFunctionName.size()) {
                        break;
                    }
                    String normsName = unFunctionName.get(index++);
                    List<XWPFTableRow> rows = table.getRows();
                    for (int i = 1; i < rows.size(); i++) {
                        Norms norms = new Norms();
                        row = rows.get(i);
                        if (row.getCell(0) != null && StringUtils.isNotEmpty(row.getCell(0).getText().trim())) {
                            if (!StringUtils.isNotEmpty(row.getCell(0).getText().trim())) {
                                continue;
                            }
                            norms.setNormsNum(row.getCell(0).getText().trim());
                        }
                        if (row.getCell(1) != null && StringUtils.isNotEmpty(row.getCell(1).getText().trim())) {
                            norms.setNormsDescribe(row.getCell(1).getText().trim());
                        }
                        norms.setProductId(productId);
                        norms.setNormsName(normsName);
                        normsList.add(norms);
                    }
                }
            }

            //先转换pdf，再读pdf页数
            if (newFile.exists()) {
                String command = null;
                String osName = System.getProperty("os.name");
                if (osName.contains("Windows")) {
                    command = "cmd /c soffice --headless --invisible --convert-to pdf:writer_pdf_Export " + filePath + fileName + " --outdir " + filePath;
                } else {
                    command = "libreoffice --headless --invisible --convert-to pdf:writer_pdf_Export " + filePath + fileName + " --outdir " + filePath;
                }
                PdfUtil.executeLibreOfficeCommand(command);
            }

            HashMap<String, Integer> nameToPage = new HashMap<>();
            String pdfFileName = fileName.substring(0, fileName.lastIndexOf("docx")) + "pdf";
            File file = new File(filePath + pdfFileName);
            PDDocument doc = null;
            if (file.exists()) {
                try {
                    fis = new FileInputStream(file);
                    PDFParser parser = new PDFParser(new RandomAccessBuffer(fis));
                    parser.parse();
                    doc = parser.getPDDocument();
                    PDDocumentOutline outline = doc.getDocumentCatalog().getDocumentOutline();
                    if (outline != null) {
                        PdfUtil.getBookmarks(outline, nameToPage);
                    }
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                    logger.error(Throwables.getStackTraceAsString(e));
                    throw new FileNotFoundException();
                } catch (IOException e) {
                    e.printStackTrace();
                    logger.error(Throwables.getStackTraceAsString(e));
                    throw new IOException();
                }
            }
            for (int i = 0; i < normsList.size(); i++) {
                Norms norms = normsList.get(i);
                norms.setPdfPage(nameToPage.get(norms.getNormsName()));
            }


            normsDao.deleteByProductId(productId);
            if (normsList.size() > 0) {
                normsDao.saveNormsList(normsList);
            }

            List<Demand> demandList = demandDao.getDemandNorms(productId);
            Map<String, List<String>> numToId = new HashMap<>();
            for (Demand demand : demandList) {
                String normsNum = demand.getNormsNum();
                String demandId = demand.getDemandId();
                if (StringUtils.isNotEmpty(normsNum)) {
                    String[] strs = normsNum.split("<br/>");
                    for (String str : strs) {
                        List<String> demandIds = numToId.get(str);
                        if (demandIds == null) {
                            demandIds = new ArrayList<>();
                        }
                        demandIds.add(demandId);
                        numToId.put(str, demandIds);
                    }
                }
            }

            //获取该产品下的规格编号和id的对应关系
            List<Norms> normsIdToNum = normsDao.getNormsIdToNum(productId);
            List<DemandNormsRelation> demandNormsRelations = new ArrayList<>();
            if (normsIdToNum != null) {
                for (Norms norms : normsIdToNum) {
                    if (StringUtils.isNotEmpty(norms.getNormsId()) && StringUtils.isNotEmpty(norms.getNormsNum())) {
                        if (numToId.get(norms.getNormsNum()) != null) {
                            List<String> demandIds = numToId.get(norms.getNormsNum());
                            for (String demandId : demandIds) {
                                DemandNormsRelation demandNormsRelation = new DemandNormsRelation();
                                demandNormsRelation.setDemandId(demandId);
                                demandNormsRelation.setNormsId(norms.getNormsId());
                                if (!demandNormsRelations.contains(demandNormsRelation)) {
                                    demandNormsRelations.add(demandNormsRelation);
                                }
                            }
                        }
                    }
                }
            }
            if (demandNormsRelations.size() > 0) {
                demandNormsRelationDao.saveDemandNormsRelationList(demandNormsRelations);
            }
            //保存完数据开始，开始保存url
            if (StringUtils.isNotEmpty(datasheetService.getdatasheetUrlById(productId))) {
                datasheetService.updateDatasheetUrl(filePath + fileName, newFileMd5, productId);
            } else {
                Datasheet datasheet = new Datasheet();
                datasheet.setDatasheetUrl(filePath + fileName);
                datasheet.setProductId(productId);
                datasheet.setFileMd5(newFileMd5);
                datasheetService.saveDocUrl(datasheet);
            }
        }
        return infoMessage;
    }

    @Override
    public String checkNormsNum(String normsNum, String productId) {
        String info = "";
        List<String> normsNumList = normsDao.getNormsNum(productId);
        String[] normsNums = normsNum.split(",");
        if (normsNums.length != 0) {
            for (String normsNumTemp : normsNums) {
                if (!normsNumList.contains(normsNumTemp)) {
                    if (StringUtils.isNotEmpty(info)) {
                        info += "<br/>编号" + normsNumTemp + "不存在";
                    } else {
                        info = "编号" + normsNumTemp + "不存在";
                    }
                }
            }
        } else {
            info = "编号" + normsNum + "不存在";
        }
        return info;
    }

    @Override
    public List<Norms> getNormsList(List<String> normsIds) {
        return normsDao.getNormsList(normsIds);
    }
}
