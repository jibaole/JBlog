package com.caliven.blog.utils;

/**
 * 分页工具
 * @author caliven
 */
public class Page {
    /** page number */
    private int pn  = 1;
    /** page size */
    private int ps  = 10;
    /** recond count */
    private int rct = 0;

    public Page() {}

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

    /** 返回总页数 */
    public int getPct() {
        int pct = rct / ps;
        if (pct == 0 || rct % ps != 0) {
            pct++;
        }
        return pct;
    }

    /** mysql limit */
    public int getLimit() {
        return ps;
    }

    /** mysql offset */
    public int getOffset() {
        return (pn - 1) * ps;
    }
}
