package com.caliven.blog.db.repository;

import com.caliven.blog.db.entity.CategoryTag;
import com.caliven.blog.db.search.Search;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisRepository
public interface CategoryTagMapper {

    int deleteById(Integer id);

    int insert(CategoryTag record);

    int insertSelective(CategoryTag record);

    CategoryTag selectById(Integer id);
    CategoryTag selectByCon(CategoryTag ct);
    CategoryTag selectRootCategory(Integer userId);


    int updateByIdSelective(CategoryTag record);

    int updateById(CategoryTag record);

    List<CategoryTag> selectCategoryTag(CategoryTag ct);

    List<CategoryTag> selectTreeCategory(@Param("userId")Integer userId, @Param("parentId")Integer parentId);

    int selectCategoryCountByUserId(Integer userId);

    int selectTagCountByUserId(Integer userId);

}