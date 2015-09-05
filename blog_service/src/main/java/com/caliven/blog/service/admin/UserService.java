package com.caliven.blog.service.admin;

import com.caliven.blog.db.entity.User;
import com.caliven.blog.db.repository.UserMapper;
import com.caliven.blog.db.search.Search;
import com.caliven.blog.utils.BlogUtils;
import com.caliven.blog.utils.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

/**
 * 用户管理Service
 * Created by Caliven on 2015/7/2.
 */
@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    public List<User> findsUserByPage(Search search, Page page) {
        /**
         * 分页查询，在查询之前(必须在查询之前)调用MyBatis分页插件pagehelper
         * 的PageHelper.startPage()方法,即可实现分页(物理分页)
         * http://git.oschina.net/free/Mybatis_PageHelper/blob/master/wikis/HowToUse.markdown
         */
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        List<User> list = userMapper.selectAll(search);
        return list;
    }

    public User findUserById(Integer id) {
        return userMapper.selectById(id);
    }

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

    public void saveUser(User user) {
        if (StringUtils.isBlank(user.getNickname())) {
            user.setNickname(user.getUsername());
        }
        Timestamp time = new Timestamp(System.currentTimeMillis());
        if (user.getId() == null) {
            user.setPassword(BlogUtils.entryptPwd(user.getPassword()));
            user.setSalt(BlogUtils.entryptSalt());
            user.setStatus(true);
            user.setCreatedDate(time);
            userMapper.insertSelective(user);
        } else {
            user.setUpdatedDate(time);
            userMapper.updateByIdSelective(user);
        }
    }
}
