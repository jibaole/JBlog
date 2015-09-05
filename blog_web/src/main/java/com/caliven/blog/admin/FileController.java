package com.caliven.blog.admin;

import com.caliven.blog.db.entity.BlogFile;
import com.caliven.blog.model.FileMeta;
import com.caliven.blog.service.admin.BlogFileService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedList;

@Controller
@RequestMapping("/admin/file")
public class FileController {

    @Autowired
    private BlogFileService blogFileService;

    /**
     * 文件上传
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
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
                String filePath = "D:/temp/files/" + fileName;
                //2.3 create new fileMeta
                fileMeta = new FileMeta();
                fileMeta.setFileName(fileName);
                fileMeta.setFileRealName(originalFilename);
                fileMeta.setFileSize(Double.valueOf(mpf.getSize() / 1024));
                fileMeta.setFileType(mpf.getContentType());
                fileMeta.setFilePath("/admin/file/detail/" + fileName);

                fileMeta.setBytes(mpf.getBytes());
                // copy file to local disk (make sure the path "e.g. D:/temp/files" exists)
                FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(filePath));

                // save db
                BlogFile file = new BlogFile();
                BeanUtils.copyProperties(fileMeta, file);
                file.setEntityId(blogId);
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

    /***************************************************
     * URL: /rest/controller/get/{value}
     * get(): get file as an attachment
     *
     * @param response : passed by the server
     * @param value    : value from the URL
     * @return void
     ****************************************************/
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

    @ResponseBody
    @RequestMapping(value = "/del", method = RequestMethod.POST)
    public Object del(Integer id) {
        String json = "{\"status\":\"success\"}";
        try {
            blogFileService.delFile(id);
        } catch (Exception e) {
            e.printStackTrace();
            json = "{\"status\":\"fail\"}";
        }
        return json;
    }
}
