package com.caliven.blog.service.shiro;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;

/**
 * Apache Shiro工具类
 * Created by Caliven on 2015/7/1.
 */
public class ShiroUtils {

    /**
     * admin 账号 id
     */
    public static final Integer ADMIN_ID = 1;

    public static ShiroDbRealm.ShiroUser getCurrUser() {
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        PrincipalCollection principals = currentUser.getPrincipals();
        return (ShiroDbRealm.ShiroUser) principals.getPrimaryPrincipal();
    }


    public static Integer getAdminId() {
        // 默认写死 admin 账号 id 为1，与数据库 admin 账号 id 保持一致
        return ADMIN_ID;
    }

    public static boolean isAdmin() {
        Subject currentUser = SecurityUtils.getSubject();
        if (currentUser.hasRole("admin")) {
            return true;
        }
        return false;
    }

    public static Integer getCurrUserId() {
        try {
            ShiroDbRealm.ShiroUser user = ShiroUtils.getCurrUser();
            return user.getId();
        } catch (Exception e) {
            return null;
        }
    }

    public static String getCurrUsername() {
        try {
            ShiroDbRealm.ShiroUser user = ShiroUtils.getCurrUser();
            return user.getUsername();
        } catch (Exception e) {
            return null;
        }
    }

    public static String getCurrNickname() {
        try {
            ShiroDbRealm.ShiroUser user = ShiroUtils.getCurrUser();
            return user.getNickname();
        } catch (Exception e) {
            return null;
        }
    }
}
