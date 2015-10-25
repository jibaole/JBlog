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
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 首页Controller
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
        categoryList.remove(0);
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
        this.searchBlog(model, new Blog(), new Page(1, Page.WEB_PAGE_SIZE));
        return "web/index";
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
        Page page = new Page(pn, Page.WEB_PAGE_SIZE);
        this.searchBlog(model, blog, page);
        return "web/index";
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
        return "web/detail";
    }

    /**
     * 分类归档查询
     *
     * @param model
     * @param cId
     * @param pn
     * @return
     */
    @RequestMapping(value = "categorys/{cId}/{pn}", method = RequestMethod.GET)
    public String categorys(Model model, @PathVariable("cId") Integer cId, @PathVariable("pn") Integer pn) {
        this.searchByCategoryTag(model, cId, pn);
        model.addAttribute("pageType", 1);// 用于区分分页 url
        model.addAttribute("ctId", cId);
        return "web/index";
    }

    /**
     * 标签归档查询
     *
     * @param model
     * @param tId
     * @param pn
     * @return
     */
    @RequestMapping(value = "tags/{tId}/{pn}", method = RequestMethod.GET)
    public String tags(Model model, @PathVariable("tId") Integer tId, @PathVariable("pn") Integer pn) {
        this.searchByCategoryTag(model, tId, pn);
        model.addAttribute("pageType", 2);// 用于区分分页 url
        model.addAttribute("ctId", tId);
        return "web/index";
    }

    /**
     * 月份归档查询
     *
     * @param model
     * @param month
     * @param pn
     * @return
     */
    @RequestMapping(value = "months/{month}/{pn}", method = RequestMethod.GET)
    public String months(Model model, @PathVariable("month") String month, @PathVariable("pn") Integer pn) {
        Date date = DateUtils.getEnglishDate(month);
        if (date != null) {
            if (pn == null) {
                pn = 1;
            }
            Blog blog = new Blog();
            blog.setCreatedDate(date);
            Page page = new Page(pn, Page.WEB_PAGE_SIZE);
            this.searchBlog(model, blog, page);
            model.addAttribute("month", month);
        }
        model.addAttribute("pageType", 3);// 用于区分分页 url
        return "web/index";
    }

    /**
     * 类别、标签查询
     *
     * @param model
     * @param ctId
     * @param pn
     */
    private void searchByCategoryTag(Model model, Integer ctId, Integer pn) {
        if (pn == null) {
            pn = 1;
        }
        // 前台默认显示管理员的数据
        Integer userId = ShiroUtils.getAdminId();
        Page page = new Page(pn, Page.WEB_PAGE_SIZE);
        List<Blog> blogs = blogService.findsByCategoryTagId(userId, ctId, page);
        CategoryTag ct = categoryTagService.findCategoryTagById(ctId);
        if (ct != null) {
            model.addAttribute("ctName", ct.getName());
        }
        model.addAttribute("blogs", blogs);
        model.addAttribute("page", page);
    }

}
