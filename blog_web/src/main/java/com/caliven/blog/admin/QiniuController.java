package com.caliven.blog.admin;

import com.caliven.blog.db.entity.BlogFile;
import com.caliven.blog.service.admin.BlogFileService;
import com.caliven.blog.service.admin.QiniuService;
import com.caliven.blog.service.shiro.ShiroUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;

/**
 * 七牛文件上传Controller
 * Created by Caliven on 2015/11/01.
 */
@Controller
@RequestMapping("/admin/qiniu")
public class QiniuController {

    @Autowired
    private QiniuService qiniuService;
    @Autowired
    private BlogFileService blogFileService;

    /**
     * 单个上传
     *
     * @param request
     * @param blogId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public Object upload(MultipartHttpServletRequest request, String blogId) {
        Map<String, Object> json = new HashMap<>();
        json.put("message", "上传失败");
        json.put("success", 0);
        try {
            Iterator<String> itr = request.getFileNames();
            MultipartFile mpf = request.getFile(itr.next());
            BlogFile file = this.getBlogFile(mpf, blogId);
            String filePath = qiniuService.upload(mpf.getBytes(), file.getFileName());
            if (!StringUtils.isEmpty(filePath)) {
                file.setFilePath(filePath);
                blogFileService.saveFile(file);

                json.put("success", 1);
                json.put("message", "上传成功");
                json.put("url", filePath);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 批量上传
     *
     * @param request
     * @param blogId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/batch-upload", method = RequestMethod.POST)
    public Object batchUpload(MultipartHttpServletRequest request, String blogId) {
        try {
            LinkedList<BlogFile> files = new LinkedList<>();
            MultipartFile mpf;
            Iterator<String> itr = request.getFileNames();
            while (itr.hasNext()) {
                mpf = request.getFile(itr.next());
                BlogFile file = this.getBlogFile(mpf, blogId);
                String filePath = qiniuService.upload(mpf.getBytes(), file.getFileName());
                if (!StringUtils.isEmpty(filePath)) {
                    file.setFilePath(filePath);
                    int id = blogFileService.saveFile(file);
                    file.setId(id);
                    files.add(file);
                }
            }
            return files;
        } catch (IOException e) {
            e.printStackTrace();
            Map<String, Object> json = new HashMap<>();
            json.put("error", "error");
            return json;
        }
    }

    /**
     * 删除图片
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public Object delete(Integer id) {
        Map<String, Object> json = new HashMap<>();
        json.put("status", "fail");
        try {
            blogFileService.deleteFile(id);
            json.put("status", "success");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 组装BlogFile
     *
     * @param mpf
     * @param blogId
     * @return
     */
    private BlogFile getBlogFile(MultipartFile mpf, String blogId) {
        String fileRealName = mpf.getOriginalFilename();
        Double fileSize = Double.valueOf(mpf.getSize() / 1024);
        String suffix = (fileRealName.split("\\.")[1]).toLowerCase();
        String fileName = System.currentTimeMillis() + "." + suffix;

        BlogFile file = new BlogFile();
        file.setUserId(ShiroUtils.getCurrUserId());
        file.setEntityId(blogId);
        file.setFileName(fileName);
        file.setFileSize(fileSize);
        file.setFileRealName(fileRealName);
        file.setFileType(mpf.getContentType());
        return file;
    }
}