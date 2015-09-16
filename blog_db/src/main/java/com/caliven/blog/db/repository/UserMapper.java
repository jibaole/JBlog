package com.caliven.blog.db.repository;

import com.caliven.blog.db.entity.User;
import com.caliven.blog.db.search.Search;
import com.caliven.blog.utils.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 通过@MapperScannerConfigurer扫描目录中的所有接口, 动态在Spring Context中生成实现.
 * 方法名称必须与Mapper.xml中保持一致.
 *
 * @author caliven
 */
@MyBatisRepository
public interface UserMapper {

    int deleteById(Integer id);

    int insert(User record);

    int insertSelective(User record);

    int updateByIdSelective(User record);

    int updateById(User record);

    User selectById(Integer id);

    /**
     * 查询用户
     *
     * @param user
     * @param page
     * @return
     */
    List<User> selectByParams(@Param("user") User user, @Param("page") Page page);

    /**
     * 通过 email 查询
     *
     * @param email
     * @return
     */
    User selectByEmail(String email);

    /**
     * 通过用户名查询
     *
     * @param username
     * @return
     */
    User selectByUsername(String username);
}