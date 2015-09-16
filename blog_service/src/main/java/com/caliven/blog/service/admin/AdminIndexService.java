package com.caliven.blog.service.admin;

import com.caliven.blog.db.entity.Blog;
import com.caliven.blog.db.entity.Comment;
import com.caliven.blog.service.shiro.ShiroUtils;
import com.caliven.blog.service.vo.NumberVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Caliven on 2015/7/1.
 */
@Service
@Transactional
public class AdminIndexService {


    @Autowired
    private BlogService blogService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private CategoryTagService categoryTagService;

    public NumberVo findNumber() {
        NumberVo num = new NumberVo();
        Integer userId = ShiroUtils.getCurrUserId();
        num.setBlogNum(blogService.findBlogCountByUserId(userId));
        num.setCommentNum(commentService.findCommentCountByUserId(userId));
        num.setCategoryNum(categoryTagService.findCategoryCount());
        // 管理员查询未审核文章数量，用户查询未审核评论数
        if (ShiroUtils.isAdmin()) {
            num.setNoAuditNum(blogService.findNoAuditBlogCount());
        } else {
            num.setNoAuditNum(commentService.findNoAuditCommentCountByUserId(userId));
        }
        return num;
    }

    public List<Blog> findsRecentBlog() {
        Integer userId = ShiroUtils.getCurrUserId();
        return blogService.findsRecentBlog(userId);
    }

    public List<Comment> findsRecentComment() {
        Integer userId = ShiroUtils.getCurrUserId();
        return commentService.findsRecentCommentByUserId(userId);
    }
}

