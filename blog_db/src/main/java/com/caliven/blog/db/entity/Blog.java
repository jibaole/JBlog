package com.caliven.blog.db.entity;

import com.caliven.blog.db.vo.CategoryVo;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 * 博文pojo
 * <p/>
 * Created by Caliven on 2015/6/24.
 */
public class Blog {

    private Integer id;

    private Integer userId;

    private User user;

    private String title;

    private Integer status; //状态【0待审核、1公开、2影藏、3密码保护、4私密】

    private String password;

    private Integer type;

    private String pageUrl;

    private Integer viewNum;

    private Integer commentNum;

    private Boolean allowComment;

    private Boolean allowQuote;

    private Boolean allowFeed;

    private Boolean isDraft;

    private Integer bannerImgId;

    private Boolean isDeleted;

    private Date createdDate;

    private Timestamp updatedDate;

    private String content;

    private List<Comment> comments;
    private List<CategoryVo> categorys;
    private List<CategoryTag> categoryList;
    private List<CategoryTag> tagList;
    private Integer categroyId;
    private String relativeTime;
    private String publishTime;
    private String categoryNames;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getPageUrl() {
        return pageUrl;
    }

    public void setPageUrl(String pageUrl) {
        this.pageUrl = pageUrl;
    }

    public Integer getViewNum() {
        return viewNum;
    }

    public void setViewNum(Integer viewNum) {
        this.viewNum = viewNum;
    }

    public Integer getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(Integer commentNum) {
        this.commentNum = commentNum;
    }

    public Boolean getAllowComment() {
        return allowComment;
    }

    public void setAllowComment(Boolean allowComment) {
        this.allowComment = allowComment;
    }

    public Boolean getAllowQuote() {
        return allowQuote;
    }

    public void setAllowQuote(Boolean allowQuote) {
        this.allowQuote = allowQuote;
    }

    public Boolean getAllowFeed() {
        return allowFeed;
    }

    public void setAllowFeed(Boolean allowFeed) {
        this.allowFeed = allowFeed;
    }

    public Boolean getIsDraft() {
        return isDraft;
    }

    public void setIsDraft(Boolean isDraft) {
        this.isDraft = isDraft;
    }

    public Integer getBannerImgId() {
        return bannerImgId;
    }

    public void setBannerImgId(Integer bannerImgId) {
        this.bannerImgId = bannerImgId;
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Timestamp getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Timestamp updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public List<CategoryVo> getCategorys() {
        return categorys;
    }

    public void setCategorys(List<CategoryVo> categorys) {
        this.categorys = categorys;
    }

    public List<CategoryTag> getCategoryList() {
        return categoryList;
    }

    public void setCategoryList(List<CategoryTag> categoryList) {
        this.categoryList = categoryList;
    }

    public List<CategoryTag> getTagList() {
        return tagList;
    }

    public void setTagList(List<CategoryTag> tagList) {
        this.tagList = tagList;
    }

    public Integer getCategroyId() {
        return categroyId;
    }

    public void setCategroyId(Integer categroyId) {
        this.categroyId = categroyId;
    }

    public String getRelativeTime() {
        return relativeTime;
    }

    public void setRelativeTime(String relativeTime) {
        this.relativeTime = relativeTime;
    }

    public String getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(String publishTime) {
        this.publishTime = publishTime;
    }

    public String getCategoryNames() {
        return categoryNames;
    }

    public void setCategoryNames(String categoryNames) {
        this.categoryNames = categoryNames;
    }
}