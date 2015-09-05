package com.caliven.blog.db.entity;

/**
 * 博文、类别\Tag关系pojo
 */
public class BlogRelCategory {
    private Integer id;

    private Integer blogId;

    private Integer categoryTagId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getBlogId() {
        return blogId;
    }

    public void setBlogId(Integer blogId) {
        this.blogId = blogId;
    }

    public Integer getCategoryTagId() {
        return categoryTagId;
    }

    public void setCategoryTagId(Integer categoryTagId) {
        this.categoryTagId = categoryTagId;
    }
}