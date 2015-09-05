package com.caliven.blog.db.repository;

import com.caliven.blog.db.entity.User;
import com.caliven.blog.db.search.Search;

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

    User selectById(Integer id);

    List<User> selectAll(Search search);

    User selectByEmail(String email);

    User selectByUsername(String username);

    int updateByIdSelective(User record);

    int updateById(User record);
}