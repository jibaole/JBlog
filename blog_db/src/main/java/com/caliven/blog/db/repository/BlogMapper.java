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

    int updateByIdSelective(Blog record);

    int updateByIdWithBLOBs(Blog record);

    int updateById(Blog record);

    Blog selectById(Integer id);

    /**
     * 查询上一篇或下一篇博文
     *
     * @param blog
     * @param type 1：上一篇、2：下一篇
     * @return
     */
    Blog selectPrevOrNextBlog(@Param("blog") Blog blog, @Param("type") Integer type);


    /**
     * 查询博文
     *
     * @param blog  查询参数
     * @param page  分页
     * @param isAll 是否所有博文(创建时间在当前时候的不查询)
     * @return
     */
    List<Blog> selectByParams(@Param("blog") Blog blog, @Param("page") Page page, @Param("isAll") Boolean isAll);

    /**
     * 查询总数
     *
     * @param blog
     * @param isAll
     * @return
     */
    int selectCountByParams(@Param("blog") Blog blog, @Param("isAll") Boolean isAll);

    /**
     * 查询某个用户博文
     *
     * @param userId 用户 ID
     * @param isAll  是否查询所有博文(创建时间在当前时候的不查询)
     * @return
     */
    List<Blog> selectByUserId(@Param("userId") Integer userId, @Param("isAll") Boolean isAll);

    /**
     * 查询最近博文
     *
     * @param userId 用户 ID
     * @return
     */
    List<Blog> selectRecentBlog(Integer userId);

    /**
     * 查询用户博文总数
     *
     * @param userId
     * @return
     */
    int selectCountByUserId(Integer userId);

    /**
     * 查询未审核博文数
     *
     * @param userId 用户 id 为空则查询所有
     * @return
     */
    int selectNoAuditCount(Integer userId);
}