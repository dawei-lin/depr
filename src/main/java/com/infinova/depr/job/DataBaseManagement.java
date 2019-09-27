package com.infinova.depr.job;

import com.alibaba.druid.pool.DruidDataSource;
import com.infinova.depr.dao.DbBackupDao;
import com.infinova.depr.entity.DataBaseFilesInfo;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 数据库备份管理
 *
 * @author ldw
 */
@Service
@PropertySource("classpath:db_config.properties")
public class DataBaseManagement {
    static Logger logger = LogManager.getLogger(DataBaseManagement.class);

    @Autowired
    private DruidDataSource mainDs;
    @Autowired
    private DbBackupDao dbBackupDao;
    public static final String manual = "manual";

    public static final String auto = "auto";

    public static final Integer autoNum = 10;

    /**
     * 数据库服务器地址
     */
    @Value("${hostIP}")
    private String hostIP;

    /**
     * 服务器数据库端口号
     */
    @Value("${port}")
    private String port;

    /**
     * 数据库名
     */
    @Value("${dbName}")
    private String dbName;

    /**
     * 数据库用户名
     */
    @Value("${mysqlUsername}")
    private String username;

    /**
     * 数据库用户密码
     */
    @Value("${password}")
    private String password;

    /**
     * 数据库备份路径
     */
    @Value("${backupPath}")
    private String backupPath;

    /**
     * 数据库备份路径
     */
    /*@Value("${dbServiceName}")
    private String dbServiceName;*/

    /**
     * mysql/bin文件夹路径
     */
    @Value("${mysqlBinPath}")
    private String mysqlBinPath;

    /**
     * 数据库备份
     *
     * @param type 手动 or 自动
     */
    @Transactional(rollbackFor = Exception.class)
    public int dbBackup(String type, String operator) throws Exception {
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String fileName = dbName + "_" + sdf.format(now) + "_" + type + ".sql";
        fileName = fileName.replaceAll(":", "_");
        fileName = fileName.replaceAll(" ", "_");

        String backpath = backupPath;

        if (!backpath.endsWith(File.separator)) {
            backpath += File.separator;
        }
        backpath = backpath + type + File.separator;
        backpath = backpath.replaceAll(" ", "");

        File saveFile = new File(backpath);
        if (!saveFile.exists()) {
            saveFile.mkdirs();
        }

        String binPath = mysqlBinPath.replaceAll("\"", "");
        binPath = "\"" + binPath + File.separator + "mysqldump.exe\"";

        StringBuffer command = new StringBuffer();
        command.append(binPath);
        command.append(" -h ").append(hostIP).append(" -P").append(port);
        command.append(" --user=").append(username).append(" --password=").append(password).append(" --lock-tables=true");
        command.append(" --result-file=").append(backpath + fileName).append(" --default-character-set=utf8 ").append(dbName);
        int result = dbBackupDao.saveDbBackup(fileName, operator);
        if (result <= 0) {
            return result;
        }
        try {
            logger.info(" database backup filepath: " + backpath + fileName);
            logger.info(" database backup excute command: " + command.toString());

            Process process = Runtime.getRuntime().exec(command.toString());
            //打印执行cmd后返回的结果
            InputStream input = process.getInputStream();
            InputStreamReader reader = new InputStreamReader(input, "utf-8");
            BufferedReader br = new BufferedReader(reader);
            while (br.readLine() != null) {
                logger.error(br.readLine());
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new Exception();
        }
        return result;
    }


    /**
     * 数据库还原
     */
    public Boolean restore(String fileName) throws Exception {
        String bpath = backupPath;
        if (!bpath.endsWith(File.separator)) {
            bpath += File.separator;
        }
        bpath = bpath.replace(" ", "");
        if (fileName.contains(auto)) {
            fileName = bpath + auto + File.separator + fileName;
        } else if (fileName.contains(manual)) {
            fileName = bpath + manual + File.separator + fileName;
        }

        logger.info("database restore backupFilePath: " + fileName);

        File file = new File(fileName);

        if (file.exists()) {
            try {
                // close database connection
                mainDs.setEnable(false);
                //subDs.setEnable(false);

                InputStream input = new FileInputStream(file);
                restore(input);
                /*DBRestoreEvent dbRestoreEvent = new DBRestoreEvent();
    			eventService.pubEvent(dbRestoreEvent);*/
                return true;
            } catch (FileNotFoundException e) {
                logger.info("database restore failed , cause by FileNotFoundException!");
                logger.error(e.getMessage(), e);
            } finally {
                // open database connection
                mainDs.setEnable(true);
                //subDs.setEnable(true);
            }
        }
        return false;
    }

    /**
     * 返回数据库备份文件信息列表
     *
     * @return
     */
    public List<DataBaseFilesInfo> getBackupFiles(String fileName) {
        List<DataBaseFilesInfo> dataBaseFilesInfos = null;
        if (StringUtils.isNotEmpty(fileName)) {
            dataBaseFilesInfos = dbBackupDao.getDbBackupByFileName(fileName);
        } else {
            dataBaseFilesInfos = dbBackupDao.getDbBackup();
        }
        if (dataBaseFilesInfos != null) {
            for (DataBaseFilesInfo dataBaseFilesInfo : dataBaseFilesInfos) {
                String bpath = backupPath;
                if (!bpath.endsWith(File.separator)) {
                    bpath += File.separator;
                }
                bpath = bpath.replace(" ", "");
                if (StringUtils.isNotEmpty(dataBaseFilesInfo.getFileName())) {
                    if (dataBaseFilesInfo.getFileName().contains(manual) || dataBaseFilesInfo.getFileName().contains(auto)) {
                        //根据文件名截取备份时间与备份方式
                        if (dataBaseFilesInfo.getFileName().contains(manual)) {
                            bpath = bpath + manual;
                            if (!bpath.endsWith(File.separator)) {
                                bpath += File.separator;
                            }
                            bpath = bpath.replace(" ", "");
                            dataBaseFilesInfo.setFileSize(getFileSize(new File(bpath + dataBaseFilesInfo.getFileName())));
                            dataBaseFilesInfo.setBackupType("手动");
                        } else if (dataBaseFilesInfo.getFileName().contains(auto)) {
                            bpath = bpath + auto;
                            if (!bpath.endsWith(File.separator)) {
                                bpath += File.separator;
                            }
                            bpath = bpath.replace(" ", "");
                            dataBaseFilesInfo.setFileSize(getFileSize(new File(bpath + dataBaseFilesInfo.getFileName())));
                            dataBaseFilesInfo.setBackupType("自动");
                        }
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd_HH_mm_ss");
                        try {
                            dataBaseFilesInfo.setBackupTime(sdf.parse(dataBaseFilesInfo.getFileName().substring(dbName.length() + 1, dbName.length() + 20)));
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        return dataBaseFilesInfos;
    }

    /**
     * 删除备份文件（只能删除手动备份文件）
     *
     * @param fileName
     */
    @Transactional(rollbackFor = Exception.class)
    public int delFile(String fileName) {
        int result = 0;
        if (fileName.endsWith(manual + ".zip") || fileName.endsWith(manual + ".sql")) {
            String bpath = backupPath;
            if (!bpath.endsWith(File.separator)) {
                bpath += File.separator;
            }
            bpath = bpath.replace(" ", "");
            String filePath = bpath + manual + File.separator + fileName;
            File file = new File(filePath);
            if (file.exists()) {
                result = dbBackupDao.deleteDbBackupByFileName(fileName);
                if (result <= 0) {
                    return result;
                }
                file.delete();
            }
        }
        return result;
    }

    // 获取数据库备份文件信息
    private List<DataBaseFilesInfo> getBackupFiles(File file, List<DataBaseFilesInfo> filesInfos) {
        File[] files = file.listFiles();
        if (files != null) {
            for (int i = 0; i < files.length; i++) {
                if (files[i].isFile()) {
                    DataBaseFilesInfo info = new DataBaseFilesInfo();
                    String fileName = files[i].getName();
                    if (fileName.contains(manual) || fileName.contains(auto)) {
                        info.setFileName(fileName);
                        info.setFileSize(getFileSize(files[i]));
                        //根据文件名截取备份时间与备份方式
                        if (fileName.contains(manual)) {
                            info.setBackupType("手动");
                        } else if (fileName.contains(auto)) {
                            info.setBackupType("自动");
                        }
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd_HH_mm_ss");
                        try {
                            info.setBackupTime(sdf.parse(fileName.substring(dbName.length() + 1, dbName.length() + 20)));
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }
                        filesInfos.add(info);
                    }
                } else if (files[i].isDirectory()) {
                    getBackupFiles(files[i], filesInfos);
                }
            }
        }
        return filesInfos;
    }

    // 获取文件大小（kb）
    private String getFileSize(File file) {
        DecimalFormat df = new DecimalFormat("#.00");
        String fileSize = df.format((double) file.length() / 1024) + "kb";
        if (fileSize.startsWith(".")) {
            fileSize = "0" + fileSize;
        }
        return fileSize;
    }

    private void restore(InputStream input) {

        String binPath = mysqlBinPath.replaceAll("\"", "");
        binPath = "\"" + binPath + File.separator + "mysql.exe\"";
        StringBuffer sbBuffer = new StringBuffer();
        sbBuffer.append(binPath).append(" -h ").append(hostIP).append(" -P").append(port)
                .append(" --user=").append(username).append(" --password=")
                .append(password).append(" --default-character-set=utf8 ")
                .append(dbName);
        String command = sbBuffer.toString();
        try {
            logger.info(" database restore excute command: " + command.toString());

            Process process = Runtime.getRuntime().exec(command);
            OutputStream out = process.getOutputStream();
            String line = null;
            String outStr = null;
            StringBuffer sb = new StringBuffer("");
            BufferedReader br = new BufferedReader(new InputStreamReader(input, "utf8"));
            while ((line = br.readLine()) != null) {
                sb.append(line + "\r\n");
            }
            outStr = sb.toString();

            OutputStreamWriter writer = new OutputStreamWriter(out, "utf8");
            writer.write(outStr);
            writer.flush();
            out.close();
            br.close();
            writer.close();

            InputStream info = process.getInputStream();
            InputStreamReader reader = new InputStreamReader(info, "utf-8");
            BufferedReader infoReader = new BufferedReader(reader);
            while (infoReader.readLine() != null) {
                logger.error(infoReader.readLine());
            }
            logger.info("database restore success!");
        } catch (UnsupportedEncodingException e) {
            logger.info("database restore failed , cause by UnsupportedEncodingException!");
            logger.error(e.getMessage(), e);
        } catch (IOException e) {
            logger.info("database restore failed , cause by IOException!");
            logger.error(e.getMessage(), e);
        }

    }

    public String getHostIP() {
        return hostIP;
    }

    public void setHostIP(String hostIP) {
        this.hostIP = hostIP;
    }

    public String getDbName() {
        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getBackupPath() {
        return backupPath;
    }

    public void setBackupPath(String backupPath) {
        this.backupPath = backupPath;
    }

    public String getMysqlBinPath() {
        return mysqlBinPath;
    }

    public void setMysqlBinPath(String mysqlBinPath) {
        this.mysqlBinPath = mysqlBinPath;
    }

    /**
     * 数据库脚本下载
     *
     * @param response
     * @param fileName
     */
    public void downLoadDataBaseSql(HttpServletResponse response, String fileName, String backupType) throws Exception {
        InputStream in = null;
        try {
            //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
            response.setContentType("multipart/form-data");
            response.setHeader("Content-disposition", "attachment; filename=" + fileName);
            //通过文件路径获得File对象(假如此路径中有一个 zms.jpg 文件)
            String path = backupPath + "/" + backupType + "/" + fileName;
            File file = new File(path);
            in = new FileInputStream(file);
            //3.通过response获取ServletOutputStream对象(out)
            int b = 0;
            byte[] buffer = new byte[512];
            while (b != -1) {
                b = in.read(buffer);
                if (b != -1) {
                    response.getOutputStream().write(buffer, 0, b);//4.写到输出流(out)中
                }
            }
        } catch (Exception e) {
        } finally {
            try {
                if (in != null) {
                    in.close();
                }
                response.getOutputStream().flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 对数据库脚本进行上传操作
     *
     * @param file
     */
    public void uploadDataBaseSql(MultipartFile file) throws Exception {
        try {
            //获取输出流
            OutputStream os = new FileOutputStream(backupPath + "/manual/" + file.getOriginalFilename());
            //获取输入流 CommonsMultipartFile 中可以直接得到文件的流
            InputStream is = file.getInputStream();
            int temp;
            //一个一个字节的读取并写入
            while ((temp = is.read()) != (-1)) {
                os.write(temp);
            }
            os.flush();
            os.close();
            is.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

}
