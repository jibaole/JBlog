package com.caliven.blog.admin;

import com.caliven.blog.service.admin.AdminIndexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 后台管理控制台Controller
 * Created by Caliven on 2015/6/23.
 */
@Controller
@RequestMapping(value = "/dashboard")
public class DashboardController {

    @Autowired
    private AdminIndexService adminIndexService;

    @ModelAttribute
    private void initNavbar(Model model) {
        model.addAttribute("navbar", 1);
    }

    /**
     * 后台控制台首页
     *
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index(Model model) {
        model.addAttribute("num", adminIndexService.findNumber());
        model.addAttribute("blogs", adminIndexService.findsRecentBlog());
        model.addAttribute("comments", adminIndexService.findsRecentComment());
        return "admin/dashboard";
    }

    /**
     * 控制台概要页面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "console", method = RequestMethod.GET)
    public String console(Model model) {
        return "admin/console";
    }

    @RequestMapping(value = "cpage", method = RequestMethod.GET)
    public String cpage(Model model) {
        return "admin/cpage";
    }

    @RequestMapping(value = "message", method = RequestMethod.GET)
    public String message(Model model) {
        return "admin/dashboard";
    }

    @RequestMapping(value = "setting", method = RequestMethod.GET)
    public String setting(Model model) {
        return "admin/dashboard";
    }
}
