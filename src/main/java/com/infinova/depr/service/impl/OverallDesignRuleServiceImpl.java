package com.infinova.depr.service.impl;

import com.google.common.base.Throwables;
import com.infinova.depr.DeprApplication;
import com.infinova.depr.dao.DemandDao;
import com.infinova.depr.dao.DemandOverallDesignRuleRelationDao;
import com.infinova.depr.dao.OverallDesignPictureDao;
import com.infinova.depr.dao.OverallDesignRuleDao;
import com.infinova.depr.entity.Demand;
import com.infinova.depr.entity.DemandNormsRelation;
import com.infinova.depr.entity.DemandOverallDesignRuleRelation;
import com.infinova.depr.entity.Norms;
import com.infinova.depr.entity.OverallDesign;
import com.infinova.depr.entity.OverallDesignRule;
import com.infinova.depr.service.OverallDesignRuleService;
import com.infinova.depr.service.OverallDesignService;
import com.infinova.depr.utils.PdfUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.pdfbox.io.RandomAccessBuffer;
import org.apache.pdfbox.pdfparser.PDFParser;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.interactive.documentnavigation.outline.PDDocumentOutline;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
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
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author ldw
 * @date 2019/8/7 16:07
 */
@Service
public class OverallDesignRuleServiceImpl implements OverallDesignRuleService {
    @Autowired
    private DemandDao demandDao;
    @Autowired
    private OverallDesignRuleDao overallDesignRuleDao;
    @Autowired
    private OverallDesignPictureDao overallDesignPictureDao;
    @Autowired
    private OverallDesignService overallDesignService;
    @Autowired
    private DemandOverallDesignRuleRelationDao demandOverallDesignRuleRelationDao;
    private static Pattern NUM_PATTERN = Pattern.compile("[A-Za-z0-9]{1,100}([-_][A-Za-z0-9]{1,100}){1,100}");
    static Logger logger = LoggerFactory.getLogger(DeprApplication.class);

    @Override
    @Transactional(rollbackFor = Exception.class)
    public List<String> saveOverallDesignRuleList(FileInputStream fis, String fileName, String productId, String filePath, String newFileMd5, File newFile) throws Exception {
        List<String> infoMessage = new ArrayList<>();
        if (fileName.toLowerCase().endsWith("docx")) {
            XWPFDocument xwpf = null;
            try {
                xwpf = new XWPFDocument(fis);
            } catch (IOException e) {
                e.printStackTrace();
                logger.error(Throwables.getStackTraceAsString(e));
                throw new IOException();
            }

            List<XWPFParagraph> paragraphList = xwpf.getParagraphs();
            List<OverallDesignRule> overallDesignRuleList = new ArrayList<>();
            OverallDesignRule overallDesignRule = null;
            List<String> numList = new ArrayList<>();
            List<String> repeatNumList = new ArrayList<>();
            //只保存编号和名字
            for (int i = 0; i < paragraphList.size(); i++) {
                XWPFParagraph paragraph = paragraphList.get(i);
                try {
                    Matcher m = NUM_PATTERN.matcher(paragraph.getText());
                    if (paragraph.getCTP().getPPr().getOutlineLvl() != null && m.find()) {
                        if (numList.contains(m.group(0))) {
                            if (!repeatNumList.contains(m.group(0))) {
                                repeatNumList.add(m.group(0));
                            }
                        }
                        numList.add(m.group(0));
                        //判断该段落是否设置了大纲级别
                        overallDesignRule = new OverallDesignRule();
                        overallDesignRule.setOverallDesignRuleNum(m.group(0));
                        String text = paragraph.getText();
                        overallDesignRule.setOverallDesignRuleName(text.substring(text.lastIndexOf(m.group(0)) + m.group(0).length()).trim());
                        overallDesignRule.setProductId(productId);
                        overallDesignRuleList.add(overallDesignRule);
                    } else if (xwpf.getStyles().getStyle(paragraph.getStyle()).getCTStyle().getPPr().getOutlineLvl() != null && m.find()) {
                        if (numList.contains(m.group(0))) {
                            if (!repeatNumList.contains(m.group(0))) {
                                repeatNumList.add(m.group(0));
                            }
                        }
                        numList.add(m.group(0));
                        //判断该段落的样式是否设置了大纲级别
                        overallDesignRule = new OverallDesignRule();
                        overallDesignRule.setOverallDesignRuleNum(m.group(0));
                        String text = paragraph.getText();
                        overallDesignRule.setOverallDesignRuleName(text.substring(text.lastIndexOf(m.group(0)) + m.group(0).length()).trim());
                        overallDesignRule.setProductId(productId);
                        overallDesignRuleList.add(overallDesignRule);
                    } else if (xwpf.getStyles().getStyle(xwpf.getStyles().getStyle(paragraph.getStyle()).getCTStyle().getBasedOn().getVal())
                            .getCTStyle().getPPr().getOutlineLvl() != null && m.find()) {
                        if (numList.contains(m.group(0))) {
                            if (!repeatNumList.contains(m.group(0))) {
                                repeatNumList.add(m.group(0));
                            }
                        }
                        numList.add(m.group(0));
                        //判断该段落的样式的基础样式是否设置了大纲级别
                        overallDesignRule = new OverallDesignRule();
                        overallDesignRule.setOverallDesignRuleNum(m.group(0));
                        String text = paragraph.getText();
                        overallDesignRule.setOverallDesignRuleName(text.substring(text.lastIndexOf(m.group(0)) + m.group(0).length()).trim());
                        overallDesignRule.setProductId(productId);
                        overallDesignRuleList.add(overallDesignRule);
                    }
                } catch (Exception e) {
                }
            }
            for (String repeatNum : repeatNumList) {
                infoMessage.add("总体设计编号为" + repeatNum + "重复出现");
            }
            if (infoMessage.size() > 0) {
                return infoMessage;
            }


            //备用方案，如果pdf不能跳转不成功，保存内容
            /*Set<String> numSet = new TreeSet<>(new Comparator<String>() {
                @Override
                public int compare(String o1, String o2) {
                    return o1.compareTo(o2);
                }
            });
            for (int i = 0; i < paragraphList.size(); i++) {
                XWPFParagraph paragraph = paragraphList.get(i);

                Matcher m = NUM_PATTERN.matcher(paragraph.getText());
                if (m.find()) {
                    numSet.add(m.group(0));
                }
            }
            List<String> numList = new ArrayList<>();
            for (String str : numSet) {
                numList.add(str);
            }
            int index = 0;
            boolean beginFlag = false;
            String num = "";
            String context = "";
            List<OverallDesignRule> overallDesignRuleList = new ArrayList<>();
            OverallDesignRule overallDesignRule = null;
            for (int i = 0; i < paragraphList.size(); i++) {
                XWPFParagraph paragraph = paragraphList.get(i);
                String style = paragraph.getStyle();
                int styleNum = 0;
                if (StringUtils.isNotEmpty(style) && StringUtils.isNumeric(style)) {
                    styleNum = Integer.parseInt(style);
                }
                if (beginFlag && styleNum <= 3 && index < numList.size() && paragraph.getText().contains(numList.get(index))) {
                    beginFlag = false;
                    overallDesignRule.setOverallDesignRuleContext(context);
                    overallDesignRuleList.add(overallDesignRule);
                    context = "";
                }
                if (beginFlag && "2".equals(style)) {
                    beginFlag = false;
                    overallDesignRule.setOverallDesignRuleContext(context);
                    overallDesignRuleList.add(overallDesignRule);
                    context = "";
                }
                if (beginFlag) {
                    context += paragraph.getText();
                }
                if (styleNum <= 3 && index < numList.size() && paragraph.getText().contains(numList.get(index))) {
                    String title = paragraph.getText();
                    num = numList.get(index);
                    beginFlag = true;
                    index++;
                    overallDesignRule = new OverallDesignRule();
                    overallDesignRule.setOverallDesignRuleNum(num);
                    overallDesignRule.setOverallDesignRuleName(title.substring(title.lastIndexOf(num) + 10).trim());
                    overallDesignRule.setProductId(productId);
                }
            }
            if (overallDesignRule != null) {
                overallDesignRule.setOverallDesignRuleContext(context);
                overallDesignRuleList.add(overallDesignRule);
            }*/
            //选转换成pdf，再读pdf页数
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

            for (int i = 0; i < overallDesignRuleList.size(); i++) {
                OverallDesignRule rule = overallDesignRuleList.get(i);
                rule.setPdfPage(nameToPage.get(rule.getOverallDesignRuleName()));
            }

            overallDesignRuleDao.deleteByProductId(productId);
            if (overallDesignRuleList.size() > 0) {
                overallDesignRuleDao.saveOverallDesignRuleList(overallDesignRuleList);
            }

            //备用方案，如果pdf不能跳转，保存图片
            /*List<OverallDesignPicture> overallDesignPictureList = new ArrayList<>();
            for (int i = 0; i < paragraphList.size(); i++) {
                List<String> imageBundleList = XWPFUtil.readImageInParagraph(paragraphList.get(i));
                if (CollectionUtils.isNotEmpty(imageBundleList)) {
                    for (String pictureId : imageBundleList) {
                        OverallDesignPicture overallDesignPicture = new OverallDesignPicture();
                        XWPFPictureData pictureData = xwpf.getPictureDataByID(pictureId);
                        byte[] data = pictureData.getData();
                        overallDesignPicture.setOverallDesignPictureContext(data);
                        for (int j = i - 1; j >= 0; j--) {
                            String paragraphText = paragraphList.get(j).getParagraphText();
                            Matcher m = NUM_PATTERN.matcher(paragraphText);
                            if (m.find()) {
                                String overallDesignRuleId = overallDesignRuleDao.getOverallDesignRuleIdByNum(m.group(0));
                                overallDesignPicture.setOverallDesignRuleId(overallDesignRuleId);
                                break;
                            }
                        }
                        if (StringUtils.isNotEmpty(overallDesignPicture.getOverallDesignRuleId())) {
                            overallDesignPictureList.add(overallDesignPicture);
                        }
                    }
                }
            }
            overallDesignPictureDao.saveOverallDesignPictureList(overallDesignPictureList);*/


            List<Demand> demandList = demandDao.getDemandOverallDesignRule(productId);
            Map<String, List<String>> numToId = new HashMap<>();
            for (Demand demand : demandList) {
                String overallDesignRuleNum = demand.getOverallDesignRuleNum();
                String demandId = demand.getDemandId();
                if (StringUtils.isNotEmpty(overallDesignRuleNum)) {
                    String[] strs = overallDesignRuleNum.split("\n");
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

            List<OverallDesignRule> overallDesignRuleIdToNum = overallDesignRuleDao.getOverallDesignRuleIdToNum(productId);
            List<DemandOverallDesignRuleRelation> demandOverallDesignRuleRelations = new ArrayList<>();
            if (overallDesignRuleIdToNum != null) {
                for (OverallDesignRule designRule : overallDesignRuleIdToNum) {
                    if (StringUtils.isNotEmpty(designRule.getOverallDesignRuleId()) && StringUtils.isNotEmpty(designRule.getOverallDesignRuleNum())) {
                        if (numToId.get(designRule.getOverallDesignRuleNum()) != null) {
                            List<String> demandIds = numToId.get(designRule.getOverallDesignRuleNum());
                            for (String demandId : demandIds) {
                                DemandOverallDesignRuleRelation demandOverallDesignRuleRelation = new DemandOverallDesignRuleRelation();
                                demandOverallDesignRuleRelation.setDemandId(demandId);
                                demandOverallDesignRuleRelation.setOverallDesignRuleId(designRule.getOverallDesignRuleId());
                                if (!demandOverallDesignRuleRelations.contains(demandOverallDesignRuleRelation)) {
                                    demandOverallDesignRuleRelations.add(demandOverallDesignRuleRelation);
                                }
                            }
                        }
                    }
                }
            }
            if (demandOverallDesignRuleRelations.size() > 0) {
                demandOverallDesignRuleRelationDao.saveDemandOverallDesignRuleRelationList(demandOverallDesignRuleRelations);
            }

            if (StringUtils.isNotEmpty(overallDesignService.getOverallDesignUrlById(productId))) {
                overallDesignService.updateOverallDesignUrl(filePath + fileName, newFileMd5, productId);
            } else {
                OverallDesign overallDesign = new OverallDesign();
                overallDesign.setOvarallDesignUrl(filePath + fileName);
                overallDesign.setProductId(productId);
                overallDesign.setFileMd5(newFileMd5);
                overallDesignService.saveDocUrl(overallDesign);
            }
        }
        return infoMessage;
    }

    @Override
    public String checkOverallDesignRuleNum(String overallDesignRuleNum, String productId) {
        String info = "";
        List<String> overallDesignRuleNumList = overallDesignRuleDao.getOverallDesignRuleNum(productId);
        String[] overallDesignRuleNums = overallDesignRuleNum.split(",");
        if (overallDesignRuleNums.length != 0) {
            for (String overallDesignRuleNumTemp : overallDesignRuleNums) {
                if (!overallDesignRuleNumList.contains(overallDesignRuleNumTemp)) {
                    if (StringUtils.isNotEmpty(info)) {
                        info += "<br/>编号" + overallDesignRuleNumTemp + "不存在";
                    } else {
                        info = "编号" + overallDesignRuleNumTemp + "不存在";
                    }
                }
            }
        } else {
            info = "编号" + overallDesignRuleNum + "不存在";
        }
        return info;
    }

    @Override
    public List<OverallDesignRule> getOverallDesignRuleList(List<String> overallDesignRuleIds) {
        return overallDesignRuleDao.getOverallDesignRuleList(overallDesignRuleIds);
    }
}
