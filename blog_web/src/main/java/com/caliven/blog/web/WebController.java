package com.caliven.blog.web;

import com.caliven.blog.db.entity.Blog;
import com.caliven.blog.db.entity.CategoryTag;
import com.caliven.blog.service.admin.BlogService;
import com.caliven.blog.service.admin.CategoryTagService;
import com.caliven.blog.service.shiro.ShiroUtils;
import com.caliven.blog.utils.DateUtils;
import com.caliven.blog.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * 博客管理Controller，使用Restful风格的Urls
 *
 * @author caliven
 * @version v1.0
 */
@Controller
@RequestMapping(value = "/")
public class WebController {

    @Autowired
    private BlogService blogService;
    @Autowired
    private CategoryTagService categoryTagService;

    @ModelAttribute
    private void initNavbar(Model model) {
        // 前台默认显示管理员的数据
        Integer adminId = ShiroUtils.getAdminId();
        List<CategoryTag> tagList = categoryTagService.findsTag(adminId);
        List<CategoryTag> categoryList = categoryTagService.findsAllCategoryByUserId(adminId);
        List<Blog> blogList = blogService.findsBlogByPage(new Blog(), new Page());
        String[] last12Months = DateUtils.getLast12Months();
        model.addAttribute("last12Months", last12Months);

        model.addAttribute("categoryList", categoryList);
        model.addAttribute("tagList", tagList);
        model.addAttribute("blogList", blogList);
    }


    /**
     * 所有文章列表
     *
     * @param model
     * @param page
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model, Blog blog, Page page) {
        // 前台默认显示管理员的数据
        blog.setUserId(ShiroUtils.getAdminId());
        List<Blog> blogs = blogService.findsBlogByPage(blog, page);
        model.addAttribute("blogs", blogs);
        model.addAttribute("page", page);
        return "web-mdl/index";
    }

    /**
     * 文章详情
     *
     * @param model
     * @param id
     * @return
     */

    @RequestMapping(value = "article/{id}", method = RequestMethod.GET)
    public String detail2(Model model, @PathVariable("id") Integer id) {
        Blog blog = blogService.findBlogById(id);
        model.addAttribute("blog", blog);
        return "web-mdl/detail";
    }

}
