<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<footer class="mdl-mega-footer footer-div">
    <div class="mdl-mega-footer__middle-section">

        <div class="mdl-mega-footer__drop-down-section">
            <input class="mdl-mega-footer__heading-checkbox" type="checkbox" checked>

            <h1 class="mdl-mega-footer__heading">文章归档</h1>
            <ul class="mdl-mega-footer__link-list">
                <c:forEach items="${last12Months}" var="month">
                    <li><a href="#">${month}</a></li>
                </c:forEach>
            </ul>
        </div>

        <div class="mdl-mega-footer__drop-down-section">
            <input class="mdl-mega-footer__heading-checkbox" type="checkbox" checked>

            <h1 class="mdl-mega-footer__heading">分类</h1>
            <ul class="mdl-mega-footer__link-list">
                <c:forEach items="${categoryList}" var="c">
                    <li><a href="#">${c.name}</a></li>
                </c:forEach>
            </ul>
        </div>

        <div class="mdl-mega-footer__drop-down-section">
            <input class="mdl-mega-footer__heading-checkbox" type="checkbox" checked>

            <h1 class="mdl-mega-footer__heading">标签</h1>
            <ul class="mdl-mega-footer__link-list">
                <c:forEach items="${tagList}" var="t">
                    <li><a href="#">${t.name}</a></li>
                </c:forEach>
            </ul>
        </div>

        <div class="mdl-mega-footer__drop-down-section">
            <input class="mdl-mega-footer__heading-checkbox" type="checkbox" checked>

            <h1 class="mdl-mega-footer__heading">最近文章</h1>
            <ul class="mdl-mega-footer__link-list">
                <c:forEach items="${blogList}" var="b">
                    <li><a href="${ctx}/index/detail2/${b.id}">${b.title}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <div class="mdl-mega-footer__bottom-section">
        <ul class="mdl-mega-footer__link-list">
            <li>
                Powered by <a href="http://www.caliven.com">Caliven</a>&nbsp;&nbsp;
                Design by <a href="http://www.getmdl.io" target="_blank">Material Design Lite</a>
            </li>
            <li>
                © 2015&nbsp;Caliven.com&nbsp;All Rights Reserved.&nbsp;
                <a href="http://www.miibeian.gov.cn" target="_blank">沪ICP备15025543号-1</a>
            </li>
        </ul>
    </div>
</footer>

<%--
<footer class="mdl-mini-footer">
    <div class="mdl-mini-footer--left-section">
        <button class="mdl-mini-footer--social-btn social-btn social-btn__twitter">
            <span class="visuallyhidden">Twitter</span>
        </button>
        <button class="mdl-mini-footer--social-btn social-btn social-btn__blogger">
            <span class="visuallyhidden">Facebook</span>
        </button>
        <button class="mdl-mini-footer--social-btn social-btn social-btn__gplus">
            <span class="visuallyhidden">Google Plus</span>
        </button>
    </div>
    <div class="mdl-mini-footer--right-section">
        <button class="mdl-mini-footer--social-btn social-btn__share">
            <i class="material-icons" role="presentation">share</i>
            <span class="visuallyhidden">share</span>
        </button>
    </div>
</footer>--%>
<%--
<div class="blog-footer">
	<p>
		Powered by <a href="http://weibo.com/liuzhihuil" target="_blank">Caliven</a>&nbsp;&nbsp;
		Design by <a href="http://getbootstrap.com/" target="_blank">Bootstrap</a>
	</p>
	<p style="font-size: 12px;">
		© 2015&nbsp;Caliven.com&nbsp;All Rights Reserved.&nbsp; 
		<a href="http://www.miibeian.gov.cn" target="_blank">沪ICP备15025543号-1</a>
	</p>
	<!-- <p>最后更新：2015年6月03日 19:23</p> -->
</div>
--%>