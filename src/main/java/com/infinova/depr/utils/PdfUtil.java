package com.infinova.depr.utils;

import org.apache.pdfbox.pdmodel.interactive.action.PDActionGoTo;
import org.apache.pdfbox.pdmodel.interactive.documentnavigation.destination.PDPageDestination;
import org.apache.pdfbox.pdmodel.interactive.documentnavigation.outline.PDOutlineItem;
import org.apache.pdfbox.pdmodel.interactive.documentnavigation.outline.PDOutlineNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author ldw
 * @date 2019/8/6 14:21
 */
public class PdfUtil {
    private static final Logger log = LoggerFactory.getLogger(PdfUtil.class);
    private static Pattern CN_PATTERN = Pattern.compile("[\\u4e00-\\u9fa5_a-zA-Z]+$");

    public static void executeLibreOfficeCommand(String command) throws Exception {
        long beginTime = System.currentTimeMillis();
        log.info("开始进行转化.......");
        Process process;// Process可以控制该子进程的执行或获取该子进程的信息
        try {
            log.debug("convertOffice2PDF cmd : {}", command);
            // exec()方法指示Java虚拟机创建一个子进程执行指定的可执行程序，并返回与该子进程对应的Process对象实例。
            process = Runtime.getRuntime().exec(command);
        } catch (IOException e) {
            log.error(" convertOffice2PDF {} error", command, e);
            throw new IOException();
        }
        int exitStatus = 0;
        try {
            // 等待子进程完成再往下执行，返回值是子线程执行完毕的返回值,返回0表示正常结束
            exitStatus = process.waitFor();
            // 第二种接受返回值的方法
            int i = process.exitValue();
            log.debug("i----" + i);
        } catch (InterruptedException e) {
            log.error("InterruptedException  convertOffice2PDF {}", command, e);
            throw new InterruptedException();
        }
        if (exitStatus != 0) {
            log.error("convertOffice2PDF cmd exitStatus {}", exitStatus);
            throw new Exception();
        } else {
            log.debug("convertOffice2PDF cmd exitStatus {}", exitStatus);
        }
        process.destroy(); // 销毁子进程
        log.info("转化结束.......");
        log.info(System.currentTimeMillis() - beginTime + "");
    }

    public static void getBookmarks(PDOutlineNode bookmark, HashMap<String, Integer> nameToPage) throws IOException {
        PDOutlineItem current = bookmark.getFirstChild();
        while (current != null) {
            int pages = 0;
            if (current.getDestination() instanceof PDPageDestination) {
                PDPageDestination pd = (PDPageDestination) current.getDestination();
                pages = pd.retrievePageNumber() + 1;
            }
            if (current.getAction() instanceof PDActionGoTo) {
                PDActionGoTo gta = (PDActionGoTo) current.getAction();
                if (gta.getDestination() instanceof PDPageDestination) {
                    PDPageDestination pd = (PDPageDestination) gta.getDestination();
                    pages = pd.retrievePageNumber() + 1;
                }
            }
            if (pages != 0) {
                Matcher matcher = CN_PATTERN.matcher(current.getTitle());
                if (matcher.find()) {
                    nameToPage.put(matcher.group(0), pages);
                }
            }
            getBookmarks(current, nameToPage);
            current = current.getNextSibling();
        }
    }
}
