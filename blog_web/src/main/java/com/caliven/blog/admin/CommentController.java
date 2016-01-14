package com.caliven.blog.admin;

import com.caliven.blog.db.entity.*;
import com.caliven.blog.service.admin.CommentService;
import com.caliven.blog.service.admin.UserService;
import com.caliven.blog.service.shiro.ShiroUtils;
import com.caliven.blog.utils.IPUtils;
import com.caliven.blog.utils.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Caliven on 2015/7/20.
 */
@Controller
@RequestMapping("/admin/comment")
public class CommentController {

    @Autowired
    private UserService userService;
    @Autowired
    private CommentService commentService;


    @RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
    public String list(Model model, Comment comment, Page page) {
        searchComment(model, comment, page);
        return "admin/comment/comment-list";
    }

    @RequestMapping(value = "audits", method = RequestMethod.GET)
    public String audits(Model model, Page page) {
        Comment comment = new Comment();
        comment.setStatus(0);
        searchComment(model, comment, page);
        return "admin/comment/comment-list";
    }

    private void searchComment(Model model, Comment comment, Page page) {
        if (comment.getStatus() == null) {
            comment.setStatus(1);
        }
        List<Comment> list = commentService.findsCommentByPage(comment, page);
        int waitAuditCount = commentService.findWaitAuditCount();
        model.addAttribute("comments", list);
        model.addAttribute("page", page);
        model.addAttribute("comment", comment);
        model.addAttribute("waitAuditCount", waitAuditCount);
    }

    @RequestMapping(value = "reply", method = RequestMethod.POST)
    public String reply(HttpServletRequest request, Comment comment) {
        Integer userId = ShiroUtils.getCurrUserId();
        User user = userService.findUserById(userId);
        if (user != null) {
            comment.setUserId(userId);
            comment.setAuthor(user.getNickname());
            comment.setEmail(user.getEmail());
            comment.setUrl(user.getUrl());
        }
        comment.setStatus(1);
        comment.setIp(IPUtils.getIP(request));
        commentService.saveComment(comment);
        return "redirect:/admin/comment/list";
    }

    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public String edit(Comment comment) {
        commentService.saveComment(comment);
        return "redirect:/admin/comment/list";
    }

    @ResponseBody
    @RequestMapping(value = "audit", method = RequestMethod.GET)
    public Object audit(Integer id, Integer status) {
        try {
            commentService.updateStatus(id, status);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    @ResponseBody
    @RequestMapping(value = "del", method = RequestMethod.GET)
    public Object del(String ids) {
        try {
            commentService.delComment(ids);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

}
