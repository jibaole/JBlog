package com.caliven.blog.db.repository;

import com.caliven.blog.db.entity.BlogRelCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisRepository
public interface BlogRelCategoryMapper {

    int deleteById(Integer id);

    int deleteByCategoryTagId(Integer categoryTagId);

    int deleteByBlogId(Integer blogId);

    int insert(BlogRelCategory record);

    int insertSelective(BlogRelCategory record);

    int updateByIdSelective(BlogRelCategory record);

    int updateById(BlogRelCategory record);

    BlogRelCategory selectById(Integer id);

    List<BlogRelCategory> selectByBlogId(@Param("blogId") Integer blogId, @Param("type") Integer type);

    List<Integer> selectCateIdByBlogId(@Param("blogId") Integer blogId, @Param("type") Integer type);

   /* List<BlogRelCategory> selectCategoryByCategoryId(Integer categoryId);

    List<BlogRelCategory> selectTagByCategoryId(Integer categoryId);*/

}