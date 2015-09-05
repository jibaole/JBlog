package com.caliven.blog.db.repository;

import com.caliven.blog.db.entity.Comment;

import java.util.List;

@MyBatisRepository
public interface CommentMapper {
    int deleteById(Integer id);

    int insert(Comment record);

    int insertSelective(Comment record);

    Comment selectById(Integer id);

    int updateByIdSelective(Comment record);

    int updateByIdWithBLOBs(Comment record);

    int updateById(Comment record);

    int selectCommentCountByUserId(Integer userId);

    int selectNoAuditCommentCountByUserId(Integer userId);

    List<Comment> selectComment(Comment comment);

    List<Comment> selectRecentCommentByUserId(Integer userId);

    int selectWaitAuditCount(Integer userId);
}