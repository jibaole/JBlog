package com.caliven.blog.utils;

/**
 * 分页page
 * Created by Caliven on 2015/7/5.
 */
public class Page {
    /**
     * 当前页
     */
    private int pageNum = 1;
    /**
     * 每页条数
     */
    private int pageSize = 20;
    /**
     * 记录总数
     */
    private int recondCount = 0;
/*
    private int offset;
    private int limit;*/


    public Page() {
    }

    public Page(int pageNum, int pageSize) {
        setPageNum(pageNum);
        setPageSize(pageSize);
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        if (pageNum < 1) {
            this.pageNum = 1;
            return;
        }
        this.pageNum = pageNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        if (pageSize < 1) {
            this.pageSize = 1;
            return;
        }
        this.pageSize = pageSize;
    }

    public int getRecondCount() {
        return recondCount;
    }

    public void setRecondCount(int recondCount) {
        this.recondCount = recondCount;
    }

    /**
     * 总页数
     */
    public int getPageCount() {
        int pageCount = recondCount / pageSize;
        if (pageCount == 0 || recondCount % pageSize != 0) {
            pageCount++;
        }
        return pageCount;
    }

    public int getOffset() {
        return (pageNum - 1) * pageSize;
    }


    public int getLimit() {
        return pageSize;
    }

}
