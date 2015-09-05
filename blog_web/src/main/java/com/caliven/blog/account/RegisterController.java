package com.caliven.blog.account;

import com.caliven.blog.db.entity.User;
import com.caliven.blog.service.account.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 用户管理Controller
 *
 * @author caliven
 * @version v1.0
 * @date 2014年7月20日
 */
@Controller
@RequestMapping(value = "/register")
public class RegisterController {

    @Autowired
    private AccountService userService;

    /**
     * 跳转至注册页面
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String registerForm() {
        return "account/reg";
    }

    /**
     * 注册用户
     *
     * @param user
     * @param attributes
     * @return
     */
    @RequestMapping(method = RequestMethod.POST)
    public String register(User user, RedirectAttributes attributes) {
        userService.registerUser(user);
        attributes.addFlashAttribute("userEmail", user.getEmail());
        return "redirect:/login";
    }

    /**
     * Ajax 检查Email是否重复
     *
     * @param email
     * @return
     */
    @RequestMapping(value = "checkExistEmails")
    @ResponseBody
    public String checkExistEmail(@RequestParam("userEmail") String email) {
        if (userService.findByUserEmail(email) == null) {
            return "true";
        } else {
            return "false";
        }
    }
}
