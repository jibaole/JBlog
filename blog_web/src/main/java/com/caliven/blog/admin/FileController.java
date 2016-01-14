package com.caliven.blog.admin;

import com.caliven.blog.db.entity.BlogFile;
import com.caliven.blog.service.admin.BlogFileService;
import com.caliven.blog.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 文件Controller
 * Created by Caliven on 2015/7/8.
 */
@Controller
@RequestMapping("/admin/file")
public class FileController {

    @Autowired
    private BlogFileService blogFileService;

    /**
     * 列表
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "list")
    public String list(Model model, BlogFile file, Page page) {
        List<BlogFile> list = blogFileService.findsAll(file, page);
        model.addAttribute("file", file);
        model.addAttribute("files", list);
        model.addAttribute("page", page);
        return "admin/file/file-list";
    }

    /**
     * 删除
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "delete", method = RequestMethod.GET)
    public String delete(String ids) {
        try {
            blogFileService.batchDeleteFile(ids);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "error";
    }

    /**
     * 恢复文件
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "recovery", method = RequestMethod.GET)
    public String recovery(String ids) {
        try {
            blogFileService.batchRecoveryFile(ids);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "error";
    }
}