package com.caliven.blog.db.repository;

import com.caliven.blog.db.entity.Blog;
import com.caliven.blog.utils.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisRepository
public interface BlogMapper {
    int deleteById(Integer id);

    int insert(Blog record);

    int insertSelective(Blog record);

    Blog selectById(Integer id);

    int updateByIdSelective(Blog record);

    int updateByIdWithBLOBs(Blog record);

    int updateById(Blog record);

    List<Blog> selectBlog(@Param("blog") Blog blog, @Param("page")Page page);

    List<Blog> selectBlogByUserId(@Param("userId")Integer userId, @Param("type")Integer type);

    List<Blog> selectRecentBlogByUserId(Integer userId);

    int selectBlogCountByUserId(Integer userId);

    int selectNoAuditBlogCount();
}