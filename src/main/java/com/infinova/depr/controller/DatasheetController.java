package com.infinova.depr.controller;

import com.infinova.depr.entity.Product;
import com.infinova.depr.enums.ReturnCodeType;
import com.infinova.depr.message.CommonResult;
import com.infinova.depr.message.ExceptionResult;
import com.infinova.depr.service.DatasheetService;
import com.infinova.depr.service.NormsService;
import com.infinova.depr.service.ProductService;
import com.infinova.depr.utils.FileUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

/**
 * @author ldw
 * @date 2019/7/30 19:57
 */
@RestController
@RequestMapping("/datasheet")
@Api("产品规格书")
public class DatasheetController {
    @Autowired
    private DatasheetService datasheetService;
    @Autowired
    private NormsService normsService;
    @Autowired
    private ProductService productService;
    @Value("${file.store.commonPath}")
    private String commonPath;
    static Logger logger = LoggerFactory.getLogger(DatasheetController.class);

    @PostMapping("/uploadDataSheet")
    @ApiOperation("上传文档")
    public CommonResult uploadDataSheet(MultipartFile file, String productId) {
        String newFileMd5 = "";
        try {
            newFileMd5 = FileUtil.fileMd5(file.getInputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        String fileMd5 = datasheetService.getfileMd5ByProductId(productId);
        if (StringUtils.isNotEmpty(fileMd5) && fileMd5.equals(newFileMd5)) {
            return new CommonResult(ReturnCodeType.REPEAT_UPLOAD.getStringCode(), ReturnCodeType.REPEAT_UPLOAD.getDesc());
        }
        String filePath = commonPath;
        File path = new File(filePath);
        if (!path.exists()) {
            path.mkdirs();
        }
        if (!filePath.endsWith(File.separator)) {
            filePath = filePath + File.separator;
        }
        String fileName = file.getOriginalFilename();
        if (!fileName.toLowerCase().endsWith(".docx")) {
            return new CommonResult(ReturnCodeType.FORM_INCORRECT.getStringCode(), ReturnCodeType.FORM_INCORRECT.getDesc());
        }
        //fileName用产品名字替代
        Product product = productService.getProductById(productId);
        if (product != null) {
            fileName = product.getProductName() + "_产品规格书.docx";
        }
        //把文件名中的中英文空格去掉，空格会导致转化失败
        fileName = fileName.replace(" ", "").trim();
        File newFile = new File(filePath + fileName);
        try {
            file.transferTo(newFile);
            //载入文档 //如果是office2007  docx格式
            FileInputStream fis = new FileInputStream(newFile);
            //该方法是长事务，可以把转换pdf的方法拿出来放到该方法前面，但是对于文档错误比较多的，保持该方法,该方法对于文档进了校验再转换pdf
            List<String> infoMessage = normsService.saveNormsList(fis, fileName, productId, filePath, newFileMd5, newFile);
            String infoStr = "";
            if (infoMessage.size() > 0) {
                for (String str : infoMessage) {
                    if (StringUtils.isNotEmpty(infoStr)) {
                        infoStr += "<br/>" + str;
                    } else {
                        infoStr += str;
                    }
                }
                return new CommonResult(ReturnCodeType.NUM_ERROR.getStringCode(), infoStr);
            }
        } catch (Exception e) {
            return new ExceptionResult(e);
        }
        return new CommonResult().success();
    }

    @GetMapping("/showDataSheet/{productId}")
    @ApiOperation("展示文档")
    public void showDataSheet(@PathVariable String productId, HttpServletResponse response) {
        String datasheetUrl = datasheetService.getdatasheetUrlById(productId);
        if (!StringUtils.isNotEmpty(datasheetUrl)) {
            return;
        }
        String pdfUrl = datasheetUrl.substring(0, datasheetUrl.lastIndexOf(".")) + ".pdf";
        response.setContentType("text/html; charset=UTF-8");
        response.setContentType("application/pdf");
        //将文件写入输出流, 显示在界面上, 实现预览效果
        try {
            FileInputStream fis = new FileInputStream(pdfUrl);
            OutputStream os = response.getOutputStream();
            int count = 0;
            byte[] buffer = new byte[1024 * 1024];
            while ((count = fis.read(buffer)) != -1) {
                os.write(buffer, 0, count);
            }
            os.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @GetMapping("/getDataSheet/{productId}")
    @ApiOperation("查看是否有文档")
    public CommonResult getDataSheet(@PathVariable String productId, HttpServletResponse response) {
        String datasheetUrl = datasheetService.getdatasheetUrlById(productId);
        if (StringUtils.isNotEmpty(datasheetUrl)) {
            return new CommonResult().success();
        }
        return new CommonResult().fail();
    }

    @GetMapping("/downloadDataSheet/{productId}")
    @ApiOperation("下载文档")
    public void downloadDataSheet(@PathVariable String productId, HttpServletRequest request, HttpServletResponse response) {
        String datasheetUrl = datasheetService.getdatasheetUrlById(productId);
        if (!StringUtils.isNotEmpty(datasheetUrl)) {
            return;
        }
        String fileName = datasheetUrl.substring(datasheetUrl.lastIndexOf(File.separator) + 1);
        response.setContentType("applicaiton/x-download");
        try {
            if (request.getHeader("User-Agent").toLowerCase().indexOf("firefox") > 0) {
                fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1"); // firefox浏览器
            } else if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {
                fileName = URLEncoder.encode(fileName, "UTF-8");// IE浏览器
            } else if (request.getHeader("User-Agent").toUpperCase().indexOf("CHROME") > 0) {
                fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");// 谷歌
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.addHeader("Content-Disposition", "attachment;filename=" + fileName);
        //将文件写入输出流, 显示在界面上, 实现预览效果
        try {
            FileInputStream fis = new FileInputStream(datasheetUrl);
            OutputStream os = response.getOutputStream();
            int count = 0;
            byte[] buffer = new byte[1024 * 1024];
            while ((count = fis.read(buffer)) != -1) {
                os.write(buffer, 0, count);
            }
            os.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
