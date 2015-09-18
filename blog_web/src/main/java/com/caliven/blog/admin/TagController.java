package com.caliven.blog.admin;

import com.caliven.blog.db.entity.CategoryTag;
import com.caliven.blog.service.admin.CategoryTagService;
import com.caliven.blog.service.shiro.ShiroUtils;
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
 * 标签Controller
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

    /**
     * 列表
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
    public String list(Model model) {
        Integer userId = ShiroUtils.getCurrUserId();
        List<CategoryTag> list = categoryTagService.findsTag(userId);
        model.addAttribute("tags", list);
        return "admin/tag/tag";
    }

    /**
     * 保存标签
     *
     * @param model
     * @param tag
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(Model model, CategoryTag tag) {
        try {
            if (StringUtils.isBlank(tag.getSlug())) {
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

    /**
     * 检测标签名称是否唯一
     *
     * @param name
     * @param id
     * @return
     */
    @RequestMapping(value = "check_name", method = RequestMethod.GET)
    public @ResponseBody Object checkUsername(String name, Integer id) {
        boolean flag = categoryTagService.checkName(2, name, id);
        String status = flag ? "false" : "true";
        // 配合 bootstrapValidator 框架验证，返回json数据格式必须为 {"valid": true/false} 格式
        String json = "{\"valid\":" + status + "}";
        return json;
    }

    /**
     * 检测缩略名是否唯一
     *
     * @param slug
     * @param id
     * @return
     */
    @RequestMapping(value = "check_slug", method = RequestMethod.GET)
    public @ResponseBody Object checkSlug(String slug, Integer id) {
        boolean flag = categoryTagService.checkSlug(2, slug, id);
        String status = flag ? "false" : "true";
        String json = "{\"valid\":" + status + "}";
        return json;
    }

    /**
     * 删除标签
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "del", method = RequestMethod.POST)
    public @ResponseBody Object del(Integer id) {
        try {
            categoryTagService.deleteTag(id);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
}
