package com.caliven.blog.admin;

import com.caliven.blog.db.entity.CategoryTag;
import com.caliven.blog.service.admin.CategoryTagService;
import com.caliven.blog.utils.Page;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by Caliven on 2015/6/30.
 */
@Controller
@RequestMapping("/admin/category")
public class CategoryController {

    @Autowired
    private CategoryTagService categoryTagService;

    @ModelAttribute
    private void initNavbar(Model model) {
        model.addAttribute("navbar", 3);
    }

    @RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
    public String list(Model model, CategoryTag ct, Page page) {
        List<CategoryTag> list = categoryTagService.findsCategory(ct, page);
        PageInfo pageInfo = new PageInfo(list);
        BeanUtils.copyProperties(pageInfo, page);
        if (ct.getParentId() != null) {
            CategoryTag parent = categoryTagService.findCategoryTagById(ct.getParentId());
            if (0 != parent.getParentId()) {
                model.addAttribute("parentCategroy", parent);
            }
        }
        model.addAttribute("categroys", list);
        model.addAttribute("categroy", ct);
        model.addAttribute("page", page);
        return "admin/categroy/categroy-list";
    }

    @RequestMapping(value = "edit", method = RequestMethod.GET)
    public String edit(Model model, Integer id, Integer parentId) {
        CategoryTag ct = categoryTagService.findCategoryTagById(id);
        List<CategoryTag> treeList = categoryTagService.findsAllCategory();
        model.addAttribute("category", ct);
        model.addAttribute("treeList", treeList);
        model.addAttribute("parentId", parentId);
        return "admin/categroy/categroy-edit";
    }

    @ResponseBody
    @RequestMapping(value = "del", method = RequestMethod.GET)
    public Object del(String ids) {
        try {
            categoryTagService.deleteCategory(ids);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    @ResponseBody
    @RequestMapping(value = "check_name", method = RequestMethod.GET)
    public Object checkUsername(String name, Integer id) {
        boolean flag = categoryTagService.checkName(1, name, id);
        String status = flag ? "false" : "true";
        // 配合 bootstrapValidator 框架验证，返回json数据格式必须为 {"valid": true/false} 格式
        String json = "{\"valid\":" + status + "}";
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "check_slug", method = RequestMethod.GET)
    public Object checkSlug(String slug, Integer id) {
        boolean flag = categoryTagService.checkSlug(1, slug, id);
        String status = flag ? "false" : "true";
        String json = "{\"valid\":" + status + "}";
        return json;
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(Model model, CategoryTag category) {
        try {
            categoryTagService.saveCategory(category);
            return "redirect:/admin/category/list?parentId=" + category.getParentId();
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("category", category);
            model.addAttribute("error", e.getMessage());
            return "admin/categroy/categroy-edit";
        }
    }

}
