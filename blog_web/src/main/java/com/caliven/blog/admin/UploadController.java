package com.caliven.blog.admin;

import com.caliven.blog.db.entity.BlogFile;
import com.caliven.blog.model.FileMeta;
import com.caliven.blog.service.admin.BlogFileService;
import com.caliven.blog.service.shiro.ShiroUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.LinkedList;

/**
 * 上传文件Controller
 * Created by Caliven on 2015/7/30.
 */
@Controller
@RequestMapping("/admin/upload")
public class UploadController {

    @Autowired
    private BlogFileService blogFileService;

    /**
     * 文件保存路径
     */
    @Value("#{configProperties['file.path']}")
    private String fileSavePath;

    /**
     * 单个文件上传
     *
     * @param request
     * @param response
     * @param blogId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/upload-single", method = RequestMethod.POST)
    public String uploadSingle(MultipartHttpServletRequest request, HttpServletResponse response, String blogId) {
        Iterator<String> itr = request.getFileNames();
        String url = "";
        try {
            MultipartFile mpf = request.getFile(itr.next());
            String originalFilename = mpf.getOriginalFilename();
            String suffix = originalFilename.split("\\.")[1];
            String fileName = System.currentTimeMillis() + "." + suffix;
            String filePath = fileSavePath + fileName;

            // 复制文件到本地磁盘(文件夹必须存在)
            FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(filePath));

            // 保存数据库
            BlogFile file = new BlogFile();
            file.setFileName(fileName);
            file.setFileRealName(originalFilename);
            file.setFileSize(Double.valueOf(mpf.getSize() / 1024));
            file.setFileType(mpf.getContentType());
            file.setFilePath(filePath);
            file.setEntityId(blogId);
            file.setUserId(ShiroUtils.getCurrUserId());
            int fileId = blogFileService.saveFile(file);

            // 获取请求 URL
            String downloadUrl = request.getScheme() + "://" + request.getHeader("host");
            url = downloadUrl + "/admin/file/show/" + fileId;

        } catch (Exception e) {
            e.printStackTrace();
            return "{\"success\":0,\"message\":\"上传失败\"}";
        }
        return "{\"success\":1,\"message\":\"上传成功\",\"url\":\"" + url + "\"}";
    }

    /**
     * 预览图片
     *
     * @param response
     * @param value
     * @throws Exception
     */
    @RequestMapping(value = "/show/{value}")
    public void showImage(HttpServletResponse response, @PathVariable String value) throws Exception {
        response.setContentType("text/html; charset=UTF-8");
        response.setContentType("image/jpeg");

        BlogFile file = blogFileService.findBlogFile(Integer.parseInt(value));
        FileInputStream fis = new FileInputStream(file.getFilePath());
        OutputStream os = response.getOutputStream();
        try {
            int count = 0;
            byte[] buffer = new byte[1024 * 1024];
            while ((count = fis.read(buffer)) != -1)
                os.write(buffer, 0, count);
            os.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (os != null)
                os.close();
            if (fis != null)
                fis.close();
        }
    }


    /**
     * 多文件上传
     *
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public Object upload(MultipartHttpServletRequest request,
                         HttpServletResponse response, String blogId) {
        LinkedList<FileMeta> files = new LinkedList<FileMeta>();
        //1. build an iterator
        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf = null;
        FileMeta fileMeta = null;
        //2. get each file
        while (itr.hasNext()) {
            try {
                //2.1 get next MultipartFile
                mpf = request.getFile(itr.next());
                System.out.println(mpf.getOriginalFilename() + " uploaded! " + files.size());

                //2.2 if files > 10 remove the first from the list
                if (files.size() >= 10)
                    files.pop();

                String originalFilename = mpf.getOriginalFilename();
                String suffix = originalFilename.split("\\.")[1];
                String fileName = System.currentTimeMillis() + "." + suffix;
                String filePath = fileSavePath + fileName;
                //2.3 create new fileMeta
                fileMeta = new FileMeta();
                fileMeta.setFileName(fileName);
                fileMeta.setFileRealName(originalFilename);
                fileMeta.setFileSize(Double.valueOf(mpf.getSize() / 1024));
                fileMeta.setFileType(mpf.getContentType());
                fileMeta.setFilePath(filePath);

                fileMeta.setBytes(mpf.getBytes());
                // copy file to local disk (make sure the path "e.g. D:/temp/files" exists)
                FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(filePath));

                // save db
                BlogFile file = new BlogFile();
                BeanUtils.copyProperties(fileMeta, file);
                file.setEntityId(blogId);
                file.setUserId(ShiroUtils.getCurrUserId());
                int fileId = blogFileService.saveFile(file);
                fileMeta.setFileId(fileId);
                //2.4 add to files
                files.add(fileMeta);
            } catch (Exception e) {
                e.printStackTrace();
                return "{\"error\":\"error\"}";
            }
        }
        // result will be like this
        // [{"fileName":"app_engine-85x77.png","fileSize":"8 Kb","fileType":"image/png"},...]
        return files;

    }

    /**
     * 下载图片
     *
     * @param response
     * @param value
     */
    @RequestMapping(value = "/get/{value}", method = RequestMethod.GET)
    public void get(HttpServletResponse response, @PathVariable String value) {
        FileMeta getFile = new FileMeta();
        BlogFile file = blogFileService.findBlogFile(Integer.parseInt(value));
        BeanUtils.copyProperties(file, getFile);
        //FileMeta getFile = files.get(Integer.parseInt(value));
        try {
            response.setContentType(getFile.getFileType());
            response.setHeader("Content-disposition", "attachment; filename=\"" + getFile.getFileName() + "\"");
            FileCopyUtils.copy(getFile.getBytes(), response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除图片
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/del", method = RequestMethod.POST)
    public Object del(Integer id) {
        String json = "{\"status\":\"success\"}";
        try {
            blogFileService.deleteFile(id);
        } catch (Exception e) {
            e.printStackTrace();
            json = "{\"status\":\"fail\"}";
        }
        return json;
    }
}
