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
        Integer userId = ShiroUtils.getAdminId();
        List<Blog> rencentBlog = blogService.findsRecentBlog(userId);
        List<CategoryTag> tagList = categoryTagService.findsTag(userId);
        List<CategoryTag> categoryList = categoryTagService.findsAllCategoryByUserId(userId);
        String[] last12Months = DateUtils.getLast12Months();
        model.addAttribute("last12Months", last12Months);

        model.addAttribute("rencentBlog", rencentBlog);
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("tagList", tagList);
    }


    /**
     * 查询博文
     *
     * @param model
     * @param blog
     * @param page
     */
    private void searchBlog(Model model, Blog blog, Page page) {
        blog.setUserId(ShiroUtils.getAdminId());
        List<Blog> blogs = blogService.findsBlogByParams(blog, page);
        model.addAttribute("blogs", blogs);
        model.addAttribute("page", page);
    }

    /**
     * 所有博文列表
     *
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) {
        this.searchBlog(model, new Blog(), new Page(1, 3));
        return "web-mdl/index";
    }

    /**
     * 分页查询
     *
     * @param model
     * @param blog
     * @param pn
     * @return
     */
    @RequestMapping(value = "/{pn}", method = RequestMethod.GET)
    public String page(Model model, Blog blog, @PathVariable("pn") Integer pn) {
        if (pn == null) {
            pn = 1;
        }
        Page page = new Page(pn, 3);
        this.searchBlog(model, blog, page);
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
        if (blog != null) {
            Blog prevBlog = blogService.findPrevOrNextBlog(blog, 1);
            Blog nextBlog = blogService.findPrevOrNextBlog(blog, 2);
            model.addAttribute("blog", blog);
            model.addAttribute("prevBlog", prevBlog);
            model.addAttribute("nextBlog", nextBlog);
        }
        return "web-mdl/detail";
    }

}
