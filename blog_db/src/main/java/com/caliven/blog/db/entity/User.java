package com.caliven.blog.db.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.ImmutableList;
import org.apache.commons.lang3.StringUtils;

import java.sql.Timestamp;
import java.util.List;

/**
 * 用户 pojo
 * Created by Caliven on 2015/6/24.
 */
public class User {

    private Integer id;

    private String username;

    private String nickname;

    private String password;

    private String email;

    private String salt;

    private String url;

    private Integer roles;

    private Integer imgId;

    private Boolean status;

    private Timestamp lastLoginDate;

    private String lastLoginIp;

    private Timestamp createdDate;

    private Timestamp updatedDate;

    /******
     * 非数据库字段 start
     ******/
    private String search;

    private Integer blogNum;
    /******
     * 非数据库字段 end
     ******/

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getRoles() {
        return roles;
    }

    public void setRoles(Integer roles) {
        this.roles = roles;
    }

    public Integer getImgId() {
        return imgId;
    }

    public void setImgId(Integer imgId) {
        this.imgId = imgId;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Timestamp getLastLoginDate() {
        return lastLoginDate;
    }

    public void setLastLoginDate(Timestamp lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }

    public String getLastLoginIp() {
        return lastLoginIp;
    }

    public void setLastLoginIp(String lastLoginIp) {
        this.lastLoginIp = lastLoginIp;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public Timestamp getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }

    public Integer getBlogNum() {
        return blogNum;
    }

    public void setBlogNum(Integer blogNum) {
        this.blogNum = blogNum;
    }



    // @JsonIgnore用于属性或者方法上（最好是属性上），作用是json序列化时将java bean中的一些属性忽略掉，序列化和反序列化都受影响。
    @JsonIgnore
    public List<String> getRoleList() {
        // 角色列表在数据库中实际以逗号分隔字符串存储，因此返回不能修改的List.
        return ImmutableList.copyOf(StringUtils.split(this.roleCd(roles), ","));
    }
    @JsonIgnore
    public static String getRoleName(Integer role) {
        String roleName = User.roleName(role);
        return StringUtils.isNotBlank(roleName) ? roleName : "角色";
    }
    @JsonIgnore
    private String roleCd(Integer role) {
        String roleCd = "";
        if (role == null) {
            return roleCd;
        }
        //角色组【1管理员、2贡献者、3编辑、4关注者】
        if (1 == role) {
            roleCd = "admin";
        } else if (2 == role) {
            roleCd = "gongxian";
        } else if (3 == role) {
            roleCd = "bianji";
        } else if (4 == role) {
            roleCd = "guanzhu";
        }
        return roleCd;
    }
    @JsonIgnore
    private static String roleName(Integer role) {
        String roleName = "";
        if (role == null) {
            return roleName;
        }
        //角色组【1管理员、2贡献者、3编辑、4关注者】
        if (1 == role) {
            roleName = "管理员";
        } else if (2 == role) {
            roleName = "贡献者";
        } else if (3 == role) {
            roleName = "编辑";
        } else if (4 == role) {
            roleName = "关注者";
        }
        return roleName;
    }
}
