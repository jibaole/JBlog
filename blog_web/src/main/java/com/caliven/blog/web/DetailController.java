package com.caliven.blog.web;

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

import java.util.List;

/**
 * 博客管理Controller，使用Restful风格的Urls
 *
 * @author caliven
 * @version v1.0
 */
@Controller
@RequestMapping(value = "/detail")
public class DetailController {

    @Autowired
    private BlogService blogService;

    @RequestMapping(value = "{id}", method = RequestMethod.GET)
    public String detail(Model model, @PathVariable("id") Integer id) {
        Blog blog = blogService.findBlogById(id);
        String[] last12Months = DateUtils.getLast12Months();
        model.addAttribute("last12Months", last12Months);
        model.addAttribute("blog", blog);
        return "web/detail";
    }

}
