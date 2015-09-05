package com.caliven.blog.db.repository;

import com.caliven.blog.db.entity.BlogFile;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisRepository
public interface BlogFileMapper {
    int deleteById(Integer id);

    int insert(BlogFile record);

    int insertSelective(BlogFile record);

    BlogFile selectById(Integer id);

    List<BlogFile> selectByEntityId(String entityId);

    int updateByIdSelective(BlogFile record);

    int updateById(BlogFile record);

    int updateBlogId(@Param("oldBlogId") String oldBlogId, @Param("newBlogId") String newBlogId);
}