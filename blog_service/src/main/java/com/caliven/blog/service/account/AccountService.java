package com.caliven.blog.service.account;

import com.caliven.blog.db.entity.User;
import com.caliven.blog.db.repository.UserMapper;
import com.caliven.blog.utils.BlogUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

/**
 * 用户管理类
 *
 * @author caliven
 * @version v1.0
 * @date 2014年7月19日
 */
// Spring Service Bean的标识.
@Component
//类中所有public函数都纳入事务管理的标识.
@Transactional
public class AccountService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 获取所有用户
     *
     * @return
     */
    /*public List<User> getAllUser(User user) {
        return (List<User>) userMapper.selectAll(user);
    }*/

    /**
     * 获取某个ID用户
     *
     * @param id
     * @return
     */
    public User getUser(Integer id) {
        return userMapper.selectById(id);
    }

    /**
     * 注册用户
     *
     * @param user
     */
    public void registerUser(User user) {
        user.setPassword(BlogUtils.entryptPwd(user.getPassword()));
        user.setSalt(BlogUtils.entryptSalt());
        //user.setRoles("user");
        user.setStatus(true);
        user.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        user.setUpdatedDate(new Timestamp(System.currentTimeMillis()));
        userMapper.insert(user);
    }

    /**
     * 通过email查询用户
     *
     * @param email
     * @return
     */
    public User findByUserEmail(String email) {
        return userMapper.selectByEmail(email);
    }

    /**
     * 通过用户名查询用户
     *
     * @param username
     * @return
     */
    public User findByUserCd(String username) {
        return userMapper.selectByUsername(username);
    }
}