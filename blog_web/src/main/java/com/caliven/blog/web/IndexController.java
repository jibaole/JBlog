package com.caliven.blog.web;

import java.util.List;

import com.caliven.blog.db.entity.Blog;
import com.caliven.blog.service.admin.BlogService;
import com.caliven.blog.service.shiro.ShiroUtils;
import com.caliven.blog.utils.DateUtils;
import com.caliven.blog.utils.Page;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 博客管理Controller，使用Restful风格的Urls
 *
 * @author caliven
 * @version v1.0
 */
@Controller
@RequestMapping(value = "/index")
public class IndexController {

    @Autowired
    private BlogService blogService;

    /**
     * 获取所有博客列表
     *
     * @param model
     * @param page
     * @return
     */
    @RequestMapping( method = RequestMethod.GET)
    public String list(Model model, Page page) {
        Integer userId = ShiroUtils.getCurrUserId();
        List<Blog> blogs = blogService.findsBlogByUserAndPage(userId, page);
        PageInfo info = new PageInfo(blogs);
        BeanUtils.copyProperties(info, page);
        String[] last12Months = DateUtils.getLast12Months();
        model.addAttribute("last12Months", last12Months);
        model.addAttribute("blogs", blogs);
        model.addAttribute("page", page);
        return "web/index";
    }

    @RequestMapping(value = "detail/{id}", method = RequestMethod.GET)
    public String detail(Model model, @PathVariable("id") Integer id) {
        Blog blog = blogService.findBlogById(id);
        String[] last12Months = DateUtils.getLast12Months();
        model.addAttribute("last12Months", last12Months);
        model.addAttribute("blog", blog);
        return "web/detail";
    }

}
