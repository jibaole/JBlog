<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>闲想录</title>
</head>

<body>
<div class="demo-blog__posts mdl-grid">
    <div class="mdl-card coffee-pic mdl-cell mdl-cell--8-col">
        <div class="mdl-card__media mdl-color-text--grey-50">
            <h3><a href="${ctx}/index/detail/12">Coffee Pic</a></h3>
        </div>
        <div class="mdl-card__supporting-text meta mdl-color-text--grey-600">
            <div class="minilogo"></div>
            <div>
                <strong>The Newist</strong>
                <span>2 days ago</span>
            </div>
        </div>
    </div>
    <div class="mdl-card something-else mdl-cell mdl-cell--8-col mdl-cell--4-col-desktop">
        <button class="mdl-button mdl-js-ripple-effect mdl-js-button mdl-button--fab mdl-color--accent">
            <i class="material-icons mdl-color-text--white" role="presentation">add</i>
            <span class="visuallyhidden">add</span>
        </button>
        <div class="mdl-card__media mdl-color--white mdl-color-text--grey-600">
            <h3>闲想录</h3>源于技术不止于技术
        </div>
        <div class="mdl-card__supporting-text meta meta--fill mdl-color-text--grey-600">
            <div>
                <strong></strong>
            </div>
            <ul class="mdl-menu mdl-js-menu mdl-menu--top-right" for="menubtn">
                <li class="mdl-menu__item mdl-js-ripple-effect">关于</li>
                <li class="mdl-menu__item mdl-js-ripple-effect">分类</li>
                <li class="mdl-menu__item mdl-js-ripple-effect">标签</li>
                <li class="mdl-menu__item mdl-js-ripple-effect" onclick="javascript:location.href='${ctx}/login'">登录
                </li>
            </ul>
            <button id="menubtn" class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
                <i class="material-icons" role="presentation">more_vert</i>
                <span class="visuallyhidden">show menu</span>
            </button>
        </div>
    </div>

    <c:forEach items="${blogs}" var="blog" varStatus="v">
        <div class="mdl-card on-the-road-again mdl-cell mdl-cell--12-col">
            <div class="mdl-card__media mdl-color-text--grey-50">
                <h3><a href="${ctx}/article/${blog.id}">${blog.title}</a></h3>
            </div>
            <div class="mdl-color-text--grey-600 mdl-card__supporting-text">
                <div id="editormd-view-${blog.id}" class="editormd-content">
                    <textarea style="display: none;"><c:out value="${blog.content}" escapeXml="true"/></textarea>
                </div>
            </div>

            <div class="mdl-card__supporting-text meta mdl-color-text--grey-600">
                <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect"
                   href="${ctx}/article/${blog.id}">
                    Read More
                </a>
                <div class="minilogo"></div>
                <div>
                    <strong>${blog.user.nickname}</strong>
                    <span><fmt:formatDate value="${blog.createdDate}" pattern="yyyy-MM-dd"/></span>
                </div>
            </div>
        </div>
    </c:forEach>

    <nav class="demo-nav mdl-cell mdl-cell--12-col">
        <div class="section-spacer"></div>
        <a href="${ctx}/?pn=${page.pn+1}" class="demo-nav__button" title="show more">
            More
            <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
                <i class="material-icons" role="presentation">arrow_forward</i>
            </button>
        </a>
    </nav>
</div>
</body>

</html>
