package com.caliven.blog.db.repository;

import com.caliven.blog.db.entity.CategoryTag;
import com.caliven.blog.utils.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@MyBatisRepository
public interface CategoryTagMapper {

    int deleteById(Integer id);

    int insert(CategoryTag record);

    int insertSelective(CategoryTag record);

    int updateByIdSelective(CategoryTag record);

    int updateById(CategoryTag record);

    CategoryTag selectById(Integer id);

    CategoryTag selectByCon(CategoryTag ct);

    /**
     * 通过用户查询根节点类别
     *
     * @param userId
     * @return
     */
    CategoryTag selectRootCategory(Integer userId);

    /**
     * 根据用户 ID 、父节点 ID 查询类别
     *
     * @param userId
     * @param parentId
     * @return
     */
    List<CategoryTag> selectTreeCategory(@Param("userId") Integer userId, @Param("parentId") Integer parentId);


    /**
     * 查询类别
     *
     * @param ct
     * @param page
     * @return
     */
    List<CategoryTag> selectCategoryByParams(@Param("category") CategoryTag ct, @Param("page") Page page);

    /**
     * 通过缩略名查询 id
     *
     * @param slug
     * @param type
     * @return
     */
    List<Integer> selectIdBySlug(@Param("userId") Integer userId, @Param("slug") String slug, @Param("type") Integer type);

    /**
     * 查询总数
     *
     * @param ct
     * @return
     */
    int selectCountCategoryByParams(@Param("category") CategoryTag ct);


    /**
     * 查询用户类别总数
     *
     * @param userId
     * @return
     */
    int selectCategoryCountByUserId(Integer userId);

    /**
     * 通过用户 ID 查询标签
     *
     * @param userId 如果为空则查所有
     * @return
     */
    List<CategoryTag> selectTagByUserId(Integer userId);

    /**
     * 查询用户标签总数
     *
     * @param userId
     * @return
     */
    int selectTagCountByUserId(Integer userId);

}