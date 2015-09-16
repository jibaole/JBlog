package com.caliven.blog.service.admin;

import com.caliven.blog.db.entity.User;
import com.caliven.blog.db.repository.UserMapper;
import com.caliven.blog.db.search.Search;
import com.caliven.blog.utils.BlogUtils;
import com.caliven.blog.utils.Digests;
import com.caliven.blog.utils.Encodes;
import com.caliven.blog.utils.Page;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

/**
 * 用户管理Service
 * Created by Caliven on 2015/7/2.
 */
@Service
@Transactional
public class UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 设置作料salt和加密密码
     *
     * @param user
     */
    private void entryptPassword(User user) {
        byte[] salt = Digests.generateSalt(BlogUtils.SALT_SIZE);
        user.setSalt(Encodes.encodeHex(salt));
        byte[] hashPassword = Digests.sha1(user.getPassword().getBytes(), salt, BlogUtils.HASH_INTERATIONS);
        user.setPassword(Encodes.encodeHex(hashPassword));
    }

    /**
     * 保存用户
     *
     * @param user
     */
    public void saveUser(User user) {
        // 昵称为空则默认为用户名
        if (StringUtils.isBlank(user.getNickname())) {
            user.setNickname(user.getUsername());
        }
        Timestamp time = new Timestamp(System.currentTimeMillis());
        if (user.getId() == null) {
            this.entryptPassword(user);
            user.setStatus(true);
            user.setCreatedDate(time);
            userMapper.insertSelective(user);
        } else {
            user.setUpdatedDate(time);
            userMapper.updateByIdSelective(user);
        }
    }

    /**
     * 查询用户
     *
     * @param user
     * @param page
     * @return
     */
    public List<User> findsUserByParams(User user, Page page) {
        /**
         * 分页查询，在查询之前(必须在查询之前)调用MyBatis分页插件pagehelper
         * 的PageHelper.startPage()方法,即可实现分页(物理分页)
         * http://git.oschina.net/free/Mybatis_PageHelper/blob/master/wikis/HowToUse.markdown
         */
        //PageHelper.startPage(page2.getPageNum(), page2.getPageSize());
        return userMapper.selectByParams(user, page);
    }

    /**
     * 查询某个用户
     *
     * @param id
     * @return
     */
    public User findUserById(Integer id) {
        return userMapper.selectById(id);
    }

    /**
     * 更改用户状态（禁用、启用）
     *
     * @param ids
     * @param status
     */
    public void operateUser(String ids, Integer status) {
        String[] userIds = ids.split(",");
        for (int i = 0; i < userIds.length; i++) {
            if (StringUtils.isBlank(userIds[i])) {
                continue;
            }
            Integer id = Integer.valueOf(userIds[i]);
            User user = userMapper.selectById(id);
            user.setStatus(status == 1 ? true : false);
            userMapper.updateByIdSelective(user);
        }
    }

    /**
     * 通过用户名查找
     *
     * @param username
     * @return
     */
    public boolean findUserByUsername(String username) {
        if (StringUtils.isEmpty(username)) {
            return false;
        }
        User user = userMapper.selectByUsername(username);
        if (user != null) {
            return true;
        } else {
            return false;
        }
    }

}
