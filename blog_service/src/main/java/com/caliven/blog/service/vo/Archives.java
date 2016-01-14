package com.caliven.blog.service.vo;

import com.caliven.blog.db.entity.Blog;

import java.util.List;

/**
 * 归档列表vo
 * Created by Caliven on 15/11/20.
 */
public class Archives {

    private String yearMonth;
    private List<Blog> blogList;

    public String getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth(String yearMonth) {
        this.yearMonth = yearMonth;
    }

    public List<Blog> getBlogList() {
        return blogList;
    }

    public void setBlogList(List<Blog> blogList) {
        this.blogList = blogList;
    }
}
