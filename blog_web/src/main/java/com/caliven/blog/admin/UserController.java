package com.caliven.blog.admin;

import com.caliven.blog.db.entity.User;
import com.caliven.blog.service.admin.UserService;
import com.caliven.blog.utils.Page;
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
 * 用户管理Controller
 * Created by Caliven on 2015/6/30.
 */
@Controller
@RequestMapping("/admin/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 列表
     *
     * @param model
     * @param user
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
    public String list(Model model, User user, Page page) {
        List<User> list = userService.findsUserByParams(user, page);
        String roleName = "角色";
        if (user != null) {
            roleName = User.getRoleName(user.getRoles());
        }
        model.addAttribute("search", user);
        model.addAttribute("roleName", roleName);
        model.addAttribute("users", list);
        model.addAttribute("page", page);
        return "admin/user/user-list";
    }

    /**
     * 跳转编辑
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "edit", method = RequestMethod.GET)
    public String edit(Model model, Integer id) {
        User user = userService.findUserById(id);
        model.addAttribute("user", user);
        return "admin/user/user-edit";
    }

    /**
     * 删除用户
     *
     * @param ids
     * @param status
     * @return
     */
    @RequestMapping(value = "del", method = RequestMethod.POST)
    public @ResponseBody Object del(String ids, Integer status) {
        try {
            userService.operateUser(ids, status);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    /**
     * 检测用户名是否唯一
     *
     * @param username
     * @return
     */
    @RequestMapping(value = "check_username", method = RequestMethod.POST)
    public @ResponseBody Object checkUsername(String username) {
        boolean flag = userService.findUserByUsername(username);
        String status = flag ? "false" : "true";
        // 配合 bootstrapValidator 框架验证，返回json数据格式必须为 {"valid": true/false} 格式
        return "{\"valid\":" + status + "}";
    }

    /**
     * 保存用户
     *
     * @param model
     * @param user
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(Model model, User user) {
        try {
            userService.saveUser(user);
            return "redirect:/admin/user/list";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("user", user);
            model.addAttribute("error", e.getMessage());
            return "admin/user/user-edit";
        }
    }

}
