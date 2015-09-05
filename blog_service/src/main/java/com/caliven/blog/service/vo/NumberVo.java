package com.caliven.blog.service.vo;

/**
 * Created by Caliven on 2015/7/1.
 */
public class NumberVo {

    private int blogNum;
    private int commentNum;
    private int categoryNum;
    private int noAuditNum;

    public int getBlogNum() {
        return blogNum;
    }

    public void setBlogNum(int blogNum) {
        this.blogNum = blogNum;
    }

    public int getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(int commentNum) {
        this.commentNum = commentNum;
    }

    public int getCategoryNum() {
        return categoryNum;
    }

    public void setCategoryNum(int categoryNum) {
        this.categoryNum = categoryNum;
    }

    public int getNoAuditNum() {
        return noAuditNum;
    }

    public void setNoAuditNum(int noAuditNum) {
        this.noAuditNum = noAuditNum;
    }
}
