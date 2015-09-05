package com.caliven.blog.admin;

import com.caliven.blog.db.entity.CategoryTag;
import com.caliven.blog.service.admin.CategoryTagService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by Caliven on 2015/7/8.
 */
@Controller
@RequestMapping("/admin/tag")
public class TagController {

    @Autowired
    private CategoryTagService categoryTagService;

    @ModelAttribute
    private void initNavbar(Model model) {
        model.addAttribute("navbar", 3);
    }

    @RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
    public String list(Model model) {
        List<CategoryTag> list = categoryTagService.findsTag();
        model.addAttribute("tags", list);
        return "admin/tag/tag";
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(Model model, CategoryTag tag) {
        try {
            if (StringUtils.isNotBlank(tag.getSlug())) {
                tag.setSlug(tag.getName());
            }
            categoryTagService.saveTag(tag);
            return "redirect:/admin/tag/list";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("tag", tag);
            model.addAttribute("error", e.getMessage());
            return "admin/tag/tag";
        }
    }

    @ResponseBody
    @RequestMapping(value = "check_name", method = RequestMethod.GET)
    public Object checkUsername(String name, Integer id) {
        boolean flag = categoryTagService.checkName(2, name, id);
        String status = flag ? "false" : "true";
        // 配合 bootstrapValidator 框架验证，返回json数据格式必须为 {"valid": true/false} 格式
        String json = "{\"valid\":" + status + "}";
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "check_slug", method = RequestMethod.GET)
    public Object checkSlug(String slug, Integer id) {
        boolean flag = categoryTagService.checkSlug(2, slug, id);
        String status = flag ? "false" : "true";
        String json = "{\"valid\":" + status + "}";
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "del", method = RequestMethod.POST)
    public Object del(Integer id) {
        try {
            categoryTagService.deleteTag(id);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
}
