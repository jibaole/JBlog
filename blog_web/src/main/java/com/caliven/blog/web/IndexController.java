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

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 网站首页Controller
 *
 * @author caliven
 * @version v1.0
 */
@Controller
@RequestMapping(value = "")
public class IndexController {

    @Autowired
    private BlogService blogService;
    @Autowired
    private CategoryTagService categoryTagService;

    @ModelAttribute
    private void initCommonData(Model model) {
        // 前台默认显示管理员的数据
        Integer userId = ShiroUtils.getAdminId();
        // 随机10篇文章
        List<Blog> rencentBlog = blogService.findsRecentBlog(userId);
        // 标签
        List<CategoryTag> tagList = categoryTagService.findsTag(userId);
        // 分类
        List<CategoryTag> categoryList = categoryTagService.findsAllCategoryByUserId(userId);
        categoryList.remove(0);
        // 最近12个月
        String[] last12Months = DateUtils.getLast12Months();
        model.addAttribute("last12Months", last12Months);
        model.addAttribute("rencentBlog", rencentBlog);
        model.addAttribute("categoryList", categoryList);
        model.addAttribute("tagList", tagList);
    }

    /**
     * 首页
     *
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model) {
        this.searchBlog(model, new Blog(), new Page(1, Page.WEB_PAGE_SIZE));
        model.addAttribute("navnum", 1);
        return "web/index";
    }

    /**
     * 归档列表
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/archives", method = RequestMethod.GET)
    public String archives(Model model) {
        Map<String, List<Blog>> archivesMap = blogService.findsArchives();
        model.addAttribute("archivesMap", archivesMap);
        model.addAttribute("navnum", 2);
        return "web/archives";
    }

    /**
     * 所有标签
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/tags", method = RequestMethod.GET)
    public String all(Model model) {
        Map<CategoryTag, List<Blog>> tagsMap = blogService.findsTags();
        model.addAttribute("ctMap", tagsMap);
        model.addAttribute("navnum", 3);
        return "web/category-tags";
    }

    /**
     * 分类
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/category", method = RequestMethod.GET)
    public String category(Model model) {
        Map<CategoryTag, List<Blog>> categoryMap = blogService.findsCategory();
        model.addAttribute("ctMap", categoryMap);
        model.addAttribute("navnum", 4);
        return "web/category-tags";
    }

    /**
     * 留言板
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/msgboard", method = RequestMethod.GET)
    public String msgboard(Model model) {
        model.addAttribute("blog", blogService.findMsgboardBlog());
        model.addAttribute("navnum", 5);
        return "web/msgboard";
    }

    /**
     * 关于我
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/about", method = RequestMethod.GET)
    public String about(Model model) {
        model.addAttribute("blog", blogService.findAboutBlog());
        model.addAttribute("navnum", 6);
        return "web/about";
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
        blog.setIsDraft(false); // 网站不查询草稿数据
        blog.setType(1);        // 网站只查询博文类型文章
        List<Blog> blogs = blogService.findsBlogByParams(blog, page);
        model.addAttribute("blogs", blogs);
        model.addAttribute("page", page);
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
        model.addAttribute("navnum", 1);
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
        Blog blog = blogService.findEffectiveBlogById(id);
        if (blog != null) {
            Blog prevBlog = blogService.findPrevOrNextBlog(blog, 1);
            Blog nextBlog = blogService.findPrevOrNextBlog(blog, 2);
            model.addAttribute("blog", blog);
            model.addAttribute("prevBlog", prevBlog);
            model.addAttribute("nextBlog", nextBlog);
        }
        model.addAttribute("navnum", 1);
        return "web/article";
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
        model.addAttribute("navnum", 1);
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
        model.addAttribute("navnum", 1);
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
        model.addAttribute("navnum", 1);
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