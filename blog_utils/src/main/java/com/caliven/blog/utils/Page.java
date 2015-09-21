package com.caliven.blog.utils;

/**
 * 分页工具
 *
 * @author caliven
 */
public class Page {

    /**
     * 网站首页显示条数
     */
    public static final int WEB_PAGE_SIZE = 5;

    /**
     * 当前页
     */
    private int pn = 1;
    /**
     * 每页条数
     */
    private int ps = 10;
    /**
     * 总条数
     */
    private int rct = 0;
    /**
     * 总页数
     */
    private int pc = 0;

    public Page() {
    }

    public Page(int pn) {
        setPn(pn);
    }

    public Page(int pn, int ps) {
        setPn(pn);
        setPs(ps);
    }

    public int getPn() {
        return pn;
    }

    public void setPn(int pn) {
        if (pn < 1) {
            this.pn = 1;
            return;
        }
        this.pn = pn;
    }

    public int getPs() {
        return ps;
    }

    public void setPs(int ps) {
        if (ps < 1) {
            this.ps = 1;
            return;
        }
        if (ps > 20) {
            this.ps = 20;
            return;
        }
        this.ps = ps;
    }

    public int getRct() {
        return rct;
    }

    public void setRct(int rct) {
        this.rct = rct;
    }

    public void setPc(int pc) {
        this.pc = pc;
    }

    public int getPc() {
        int pct = rct / ps;
        if (pct == 0 || rct % ps != 0) {
            pct++;
        }
        return pct;
    }

    /**
     * mysql limit
     */
    public int getLimit() {
        return ps;
    }

    /**
     * mysql offset
     */
    public int getOffset() {
        return (pn - 1) * ps;
    }
}
