package com.caliven.blog.account;

import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;

/**
 * LoginController负责打开登录页面(GET请求)和登录出错页面(POST请求)
 * 真正登录的POST请求由 ShiroDbRealm Filter完成
 *
 * @author caliven
 * @version v1.0
 * @date 2015年6月20日
 */
@Controller
@RequestMapping(value = "/login")
public class LoginController {

    @RequestMapping(method = RequestMethod.GET)
    public String login() {
        return "account/login";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String fail(HttpServletRequest request, @RequestParam(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM) String userName, Model model) {
        String error;
        String className = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
        if (UnknownAccountException.class.getName().equals(className)) {
            error = "用户名不存在";
        } else if (IncorrectCredentialsException.class.getName().equals(className)) {
            error = "用户名或密码错误";
        } else if (DisabledAccountException.class.getName().equals(className)) {
            error = "用户已被禁用，请联系管理员";
        } else {
            error = "登录失败，请联系管理员";
        }
        model.addAttribute("error", error);
        model.addAttribute(FormAuthenticationFilter.DEFAULT_USERNAME_PARAM, userName);
        return "account/login";
    }
}
