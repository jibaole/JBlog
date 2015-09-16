package com.caliven.blog.service.admin;

import com.caliven.blog.db.entity.Comment;
import com.caliven.blog.db.repository.CommentMapper;
import com.caliven.blog.service.shiro.ShiroUtils;
import com.caliven.blog.utils.Page;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * 评论管理Service
 * Created by Caliven on 2015/7/1.
 */
@Component
@Transactional
public class CommentService {

    @Autowired
    private CommentMapper commentMapper;

    /**
     * 查询评论
     *
     * @param comment
     * @param page2
     * @return
     */
    public List<Comment> findsCommentByPage(Comment comment, Page page) {
        //PageHelper.startPage(page2.getPageNum(), page2.getPageSize());
        return commentMapper.selectComment(comment);
    }

    /**
     * 查询待审核评论数
     * @return
     */
    public int findWaitAuditCount(){
        Integer userId = ShiroUtils.getCurrUserId();
        return commentMapper.selectWaitAuditCount(userId);
    }

    /**
     * 更新评论状态
     *
     * @param id
     * @param status
     */
    public void updateStatus(Integer id, Integer status) {
        Comment comment = new Comment();
        comment.setId(id);
        comment.setStatus(status);
        commentMapper.updateByIdSelective(comment);
    }

    /**
     * 删除评论
     *
     * @param ids
     */
    public void delComment(String ids) {
        String[] cIds = ids.split(",");
        for (int i = 0; i < cIds.length; i++) {
            if (StringUtils.isBlank(cIds[i])) {
                continue;
            }
            Integer id = Integer.valueOf(cIds[i]);
            Comment comment = new Comment();
            comment.setId(id);
            comment.setIsDeleted(true);
            commentMapper.updateByIdSelective(comment);
        }
    }

    /**
     * 保存编辑评论
     *
     * @param comment
     */
    public void saveComment(Comment comment) {
        Timestamp time = new Timestamp(System.currentTimeMillis());
        comment.setUpdatedDate(time);
        if (comment.getId() != null) {
            commentMapper.updateByIdSelective(comment);
        } else {
            comment.setIsDeleted(false);
            comment.setCreatedDate(new Date());
            commentMapper.insertSelective(comment);
        }
    }

    /**
     * 通过用户ID查询评论总数
     *
     * @param userId 用户ID
     * @return 评论总数
     */
    public int findCommentCountByUserId(Integer userId) {
        if (userId == null) {
            return 0;
        }
        return commentMapper.selectCommentCountByUserId(userId);
    }

    /**
     * 通过用户ID查询未审核评论总数
     *
     * @param userId 用户ID
     * @return 评论总数
     */
    public int findNoAuditCommentCountByUserId(Integer userId) {
        if (userId == null) {
            return 0;
        }
        return commentMapper.selectNoAuditCommentCountByUserId(userId);
    }

    /**
     * 查询最近10条评论
     * @param userId
     * @return
     */
    public List<Comment> findsRecentCommentByUserId(Integer userId) {
        if (userId == null) {
            return null;
        }
        return commentMapper.selectRecentCommentByUserId(userId);
    }


}
