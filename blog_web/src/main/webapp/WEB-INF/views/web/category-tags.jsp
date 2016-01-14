<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>

<html>
<head>
    <title>标签 | 闲想录</title>
    <link type="text/css" rel="stylesheet" href="${qiniu}/statics/styles/web/blog.css"/>
    <link type="text/css" rel="stylesheet" href="${qiniu}/statics/styles/web/category-tags.css"/>
</head>

<body>

<div class="demo-blog mdl-layout has-drawer is-upgraded">
    <main class="mdl-layout__content article-blog">
        <div class="demo-blog--blogpost">
            <div class="demo-blog__posts mdl-tags mdl-grid">
                <div class="tags-div">
                    <h5><c:if test="${navnum==3}">标签</c:if><c:if test="${navnum==4}">分类</c:if></h5>
                    <c:forEach items="${ctMap}" var="t">
                        <a href="#${t.key.slug}" class="tag">${t.key.name}</a>
                    </c:forEach>
                </div>
                <div class="mdl-card mdl-shadow--2dp mdl-shadow--4dp mdl-cell mdl-cell--12-col">
                    <div class="mdl-card__section__text mdl-grid mdl-grid--no-spacing">
                        <c:forEach items="${ctMap}" var="t">
                            <div id="${t.key.slug}"
                                 class="section__text mdl-cell mdl-cell--12-col">
                                <h5>
                                    <button class="mdl-button mdl-js-button mdl-button--icon">
                                        <i class="material-icons">
                                            <c:if test="${navnum==3}">loyalty</c:if>
                                            <c:if test="${navnum==4}">class</c:if>
                                        </i>
                                    </button>
                                    ${t.key.name}
                                </h5>
                            </div>
                            <div class="section__text mdl-cell mdl-cell--12-col">
                                <c:forEach items="${t.value}" var="b">
                                    <div class="item-div">
                                        <a href="${ctx}/article/${b.id}" target="_blank">${b.title}</a>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>