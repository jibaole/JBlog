package com.caliven.blog.utils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 分页标签类
 *
 * @author Caliven
 */
public class PageTag extends TagSupport {

    private static final long serialVersionUID = 2925244112086923329L;

    /**
     * 当前页
     */
    private int pn = 1;
    /**
     * 每页要显示的条数
     */
    private int ps = 10;
    /**
     * 总记录数
     */
    private int rct;

    public int doStartTag() throws JspException {
        StringBuilder sb = new StringBuilder();
        //计算总页数
        int pageCount = (rct + ps - 1) / ps;
        if (rct == 0) {
            sb.append("<div class=\"text-center\">暂无数据!</div>");
        } else {
            //页号越界处理
            if (pn > pageCount) {
                pn = pageCount;
            }
            if (pn < 1) {
                pn = 1;
            }

            // 当前页参数隐藏域
            sb.append("<input type=\"hidden\" id=\"pn\" name=\"pn\" value=\"" + pn + "\">");

            // 分页样式(bootstrap样式)
            // 输出统计数据
            sb.append("<div class=\"page-total\"><label>共" + rct + "条，" + pageCount + "页</label></div>");

            sb.append("<nav class=\"text-right\">");
            sb.append("<ul class=\"pagination\">");

            //上一页
            if (pn != 1) {
                //sb.append("<li><a href=\"javascript:toPage(1)\" aria-label=\"Home\" title=\"首页\"><span aria-hidden=\"true\">&laquo;</span></a></li>");
                sb.append("<li><a href=\"javascript:toPage(" + (pn - 1) + ")\" aria-label=\"Previous\" title=\"上一页\"><span aria-hidden=\"true\">&laquo;</span></a></li>");
            }
            //如果总页数小于等于10页，则全显示，否则断开显示
            if (pageCount <= 10) {
                for (int i = 1; i <= pageCount; i++) {
                    if (pn == i) {
                        //当前页号不需要点击事件
                        sb.append("<li class=\"active\"><span>" + i + "</span></li>");
                    } else {
                        sb.append("<li><a href=\"javascript:toPage(" + i + ");\"><span>" + i + "</span></a></li>");
                    }
                }
            } else {
                //如果前面页数超过5页,前面显示3页，后面显示"..."
                int start = 1;
                if (this.pn > 5) {
                    start = this.pn;
                    for (int i = 1; i <= 3; i++) {
                        sb.append("<li><a href=\"javascript:toPage(" + i + ")\"><span>" + i + "</span></a></li>");
                    }
                    // ...时取两个数的中位数进行点击
                    int middle = this.getMiddleNum(3, this.pn);
                    sb.append("<li><a href=\"javascript:toPage(" + middle + ")\" title=\"中间第" + middle + "页\"><span>&hellip;</span></a></li>");
                }
                //显示当前页附近的页
                int end = this.pn + 3;
                if (end > pageCount) {
                    end = pageCount;
                }
                for (int i = start; i <= end; i++) {
                    if (pn == i) {
                        //当前页号不需要点击事件
                        sb.append("<li class=\"active\"><span>" + i + "</span></li>");
                    } else {
                        sb.append("<li><a href=\"javascript:toPage(" + i + ");\"><span>" + i + "</span></a></li>");
                    }
                }
                //如果后面页数过多,显示"..."
                if (end < pageCount - 3) {
                    // ...时取两个数的中位数进行点击
                    int middle = this.getMiddleNum(end, (pageCount - 3));
                    sb.append("<li><a href=\"javascript:toPage(" + middle + ")\" title=\"中间第" + middle + "页\"><span>&hellip;</span></a></li>");
                    //sb.append("<li><span>&hellip;</span></li>");
                }
                if (end < pageCount - 2) {
                    sb.append("<li><a href=\"javascript:toPage(" + (pageCount - 2) + ")\"><span>" + (pageCount - 2) + "</span></a></li>");
                }
                if (end < pageCount - 1) {
                    sb.append("<li><a href=\"javascript:toPage(" + (pageCount - 1) + ")\"><span>" + (pageCount - 1) + "</span></a></li>");
                }
                if (end < pageCount) {
                    sb.append("<li><a href=\"javascript:toPage(" + pageCount + ")\"><span>" + pageCount + "</span></a></li>");
                }

            }
            //下一页
            if (pn != pageCount) {
                sb.append("<li><a href=\"javascript:toPage(" + (pn + 1) + ")\" aria-label=\"Next\" title=\"下一页\"><span aria-hidden=\"true\">&raquo;</span></a></li>");
                //sb.append("<li><a href=\"javascript:toPage("+pageCount+")\" aria-label=\"Last\" title=\"末页\"><span aria-hidden=\"true\">&raquo;</span></a></li>");
            }

            sb.append("</ul>");
            sb.append("</nav>");

            // 生成提交表单的js，页面上的<p:page>标签需要用id为searchForm的表单包住
            sb.append("<script type=\"text/javascript\">");
            sb.append("  function toPage(pn){");
            sb.append("    if(pn > " + pageCount + "){");
            sb.append("       pn = " + pageCount + ";");
            sb.append("    }");
            sb.append("    if(pn < 1){pn = 1;}");
            sb.append("    document.getElementById('searchForm').pn.value=pn;");
            sb.append("    document.getElementById('searchForm').submit();");
            sb.append("  }");
            sb.append("</script>");
        }
        try {
            //把生成的HTML输出到页面
            pageContext.getOut().println(sb.toString());
        } catch (IOException e) {
            throw new JspException(e);
        }
        //本标签主体为空,直接跳过主体
        return SKIP_BODY;
    }

    /**
     * 取两个数的中位数
     *
     * @param min
     * @param max
     * @return
     */
    private int getMiddleNum(int min, int max) {
        ArrayList<Integer> arr = new ArrayList<Integer>();
        int mi = min;
        int count = (max - min) + 1;
        int[] arr2 = new int[count];
        for (int i = 0; i < count; i++) {
            arr2[i] = mi++;
        }
        for (int i = 0; i < arr2.length; i++) {
            arr.add(arr2[i]);
        }
        Integer j;
        Collections.sort(arr);
        if (arr2.length > 2 && arr2.length % 2 == 0) {
            j = (arr.get(arr2.length / 2) + arr.get(arr2.length / 2 + 1)) / 2;
        } else {
            j = arr.get(arr2.length / 2);
        }
        return j == null ? min : j;
    }

    public void setPn(int pn) {
        this.pn = pn;
    }

    public void setPs(int ps) {
        this.ps = ps;
    }

    public void setRct(int rct) {
        this.rct = rct;
    }
}