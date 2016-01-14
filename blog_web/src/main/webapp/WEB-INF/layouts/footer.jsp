<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<footer class="mdl-mega-footer">
    <%--<div class="mdl-mega-footer--top-section">
        <div class="mdl-mega-footer--right-section">
            <a class="mdl-typography--font-light" href="#top">
                Back to Top<i class="material-icons">expand_less</i>
            </a>
        </div>
    </div>--%>
    <div class="mdl-mega-footer__middle-section">

        <div class="mdl-mega-footer__drop-down-section">
            <input class="mdl-mega-footer__heading-checkbox" type="checkbox" checked>

            <h1 class="mdl-mega-footer__heading">文章归档</h1>
            <ul class="mdl-mega-footer__link-list">
                <c:forEach items="${last12Months}" var="month">
                    <li><a href="${ctx}/months/${month}/1">${month}</a></li>
                </c:forEach>
            </ul>
        </div>

        <div class="mdl-mega-footer__drop-down-section">
            <input class="mdl-mega-footer__heading-checkbox" type="checkbox" checked>

            <h1 class="mdl-mega-footer__heading">分类</h1>
            <ul class="mdl-mega-footer__link-list">
                <c:forEach items="${categoryList}" var="c">
                    <li><a href="${ctx}/categorys/${c.id}/1">${c.name}（${c.blogNum}）</a></li>
                </c:forEach>
            </ul>
        </div>

        <div class="mdl-mega-footer__drop-down-section">
            <input class="mdl-mega-footer__heading-checkbox" type="checkbox" checked>

            <h1 class="mdl-mega-footer__heading">标签</h1>
            <ul class="mdl-mega-footer__link-list">
                <c:forEach items="${tagList}" var="t">
                    <li><a href="${ctx}/tags/${t.id}/1">${t.name}（${t.blogNum}）</a></li>
                </c:forEach>
            </ul>
        </div>

        <div class="mdl-mega-footer__drop-down-section">
            <input class="mdl-mega-footer__heading-checkbox" type="checkbox" checked>

            <h1 class="mdl-mega-footer__heading">随机推荐</h1>
            <ul class="mdl-mega-footer__link-list">
                <c:forEach items="${rencentBlog}" var="b">
                    <li><a href="${ctx}/article/${b.id}">${b.title}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="mdl-mega-footer__bottom-section">
        <ul class="mdl-mega-footer__link-list">
            <li class="footer-tips">
                本站部分文章、源码来源于网络收集整理，如侵犯到您的权益，请联系站长删除！Email：support@caliven.com
            </li>
        </ul>
        <ul class="mdl-mega-footer__link-list">
            <li class="footer-tips">
                Powered by <a href="http://www.caliven.com">Caliven</a>&nbsp;&nbsp;
                Design by <a href="http://www.getmdl.io" target="_blank">Material Design Lite</a>&nbsp;&nbsp;
                静态存储托管于<a href="http://www.qiniu.com" target="_blank">「七牛云存储」</a>
            </li>
        </ul>
        <ul class="mdl-mega-footer__link-list">
            <li>
                Copyright © 2015&nbsp;Caliven&nbsp;
                本站采用<a href="http://creativecommons.org/licenses/by-nc-sa/3.0/cn/" target="_blank"
                       title="署名-非商业性使用-相同方式共享 3.0 中国大陆">「CC BY-NC-SA 3.0CN」</a>授权发布.
                <a href="http://www.miibeian.gov.cn" target="_blank">沪ICP备15025543号-1</a>
                <%--
                <script type="text/javascript" language="javascript">
                    <!--
                    document.write("本网页的最后更新时间为：" + document.lastModified);
                    //-->
                </script>
                <script language="JavaScript">
                    <!--
                    var lastModified = document.lastModified;
                    document.write("最后更新日期:" + (new Date(lastModified)).getYear()
                            + "-" + ((new Date(lastModified)).getMonth() + 1)
                            + "-" + (new Date(lastModified)).getDate() + "")
                    //-->
                </script>
                本站已安全运行了:
                <span class="smalltxt">
                   <script type="text/javascript" language=javascript>
                       <!--
                       BirthDay = new Date("may 30,2015");
                       today = new Date();
                       timeold = (today.getTime() - BirthDay.getTime());
                       sectimeold = timeold / 1000
                       secondsold = Math.floor(sectimeold);
                       msPerDay = 24 * 60 * 60 * 1000
                       e_daysold = timeold / msPerDay
                       daysold = Math.floor(e_daysold);
                       document.write(daysold + "天!");
                       //-->
                   </script>
                </span>
                --%>
            </li>
            <li>
                <%--CNZZ统计--%>
                <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
                document.write(unescape("%3Cspan id='cnzz_stat_icon_1256666242'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s11.cnzz.com/z_stat.php%3Fid%3D1256666242%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));</script>
            </li>
        </ul>
    </div>
</footer>