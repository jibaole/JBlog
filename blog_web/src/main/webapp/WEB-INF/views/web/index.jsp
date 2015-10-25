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
            <h3><a href="${ctx}/" title="试运行阶段">Caliven的个人博客</a></h3>
        </div>
        <%--<div class="mdl-card__supporting-text meta mdl-color-text--grey-600">
            <div class="minilogo"></div>
            <div>
                <strong></strong>
                <span></span>
            </div>
        </div>--%>
    </div>
    <div class="mdl-card something-else mdl-cell mdl-cell--8-col mdl-cell--4-col-desktop">
        <button class="mdl-button mdl-js-ripple-effect mdl-js-button mdl-button--fab mdl-color--accent">
            <i class="material-icons mdl-color-text--white" role="presentation">play_arrow</i>
            <span class="visuallyhidden">add</span>
        </button>
        <div class="mdl-card__media mdl-color--white mdl-color-text--grey-600">
            <h2><a href="${ctx}/">闲想录</a></h2>源于技术不止于技术
        </div>
        <div class="mdl-card__supporting-text meta meta--fill mdl-color-text--grey-600">
            <div>
                <strong></strong>
            </div>
            <ul class="mdl-menu mdl-js-menu mdl-menu--top-right" for="menubtn">
                <li class="mdl-menu__item mdl-js-ripple-effect">关于我</li>
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

    <c:if test="${blogs.size() <= 0}">
        <%-- 未查询到结果提示 div --%>
        <div class="mdl-section mdl-card mdl-shadow--4dp mdl-cell mdl-cell--12-col">
            <div class="mdl-color-text--grey-700 mdl-card__supporting-text">
                <h5>抱歉，没有符合您的文章！以下是您可能感兴趣的最新文章，你可以&nbsp;<a href="javascript:history.go(-1);">返回上页</a>。</h5>
            </div>
            <div class="mdl-color-text--grey-700 mdl-card__supporting-text">
                <section class="mdl-grid mdl-grid--no-spacing">
                    <c:forEach items="${rencentBlog}" var="b">
                        <div class="section__text mdl-cell mdl-cell--10-col-desktop mdl-cell--6-col-tablet mdl-cell--3-col-phone">
                            <a href="${ctx}/article/${b.id}">${b.title}</a>
                        </div>
                    </c:forEach>
                </section>
            </div>
        </div>
    </c:if>

    <c:if test="${blogs.size() > 0}">
        <c:if test="${pageType!=null}">
            <%-- 归档查询结果提示 div --%>
            <div class="mdl-cell something-else mdl-cell--12-col">
                <div class="mdl-search-title mdl-card__title mdl-card__media mdl-color-text--grey-50">
                    <h5>
                        <c:if test="${pageType==1}">“ ${ctName} ” 分类归档结果如下</c:if>
                        <c:if test="${pageType==2}">“ ${ctName} ” 标签归档结果如下</c:if>
                        <c:if test="${pageType==3}">“ ${month} ” 月份归档结果如下</c:if>
                    </h5>
                </div>
            </div>
        </c:if>

        <c:forEach items="${blogs}" var="blog" varStatus="v">
            <div class="mdl-card <c:if test="${blog.bannerImgId==null}">amazing</c:if><c:if test="${blog.bannerImgId!=null}">on-the-road-again</c:if> mdl-cell mdl-cell--12-col">
                <div class="<c:if test="${blog.bannerImgId==null}">mdl-card__title</c:if><c:if test="${blog.bannerImgId!=null}">mdl-card__media mdl-card-banner-img${blog.bannerImgId}</c:if> mdl-color-text--grey-50">
                    <h3 <c:if test="${blog.bannerImgId==null}">class="quote"</c:if>>
                        <a href="${ctx}/article/${blog.id}">${blog.title}</a>
                    </h3>
                </div>
                <div class="mdl-card__supporting-text mdl-color-text--grey-600">
                    <div id="editormd-view-${blog.id}" class="editormd-content">
                        <textarea style="display: none;"><c:out value="${blog.content}" escapeXml="true"/></textarea>
                    </div>
                </div>
                <div class="mdl-card__supporting-text meta mdl-color-text--grey-600">
                    <div class="minilogo"></div>
                    <div>
                        <strong>发表于</strong>
                        <span id="relativeTime${blog.id}">${blog.relativeTime}</span>

                        <div class="mdl-tooltip" for="relativeTime${blog.id}">
                            <fmt:formatDate value="${blog.createdDate}" pattern="yyyy/MM/dd hh:mm"/>
                        </div>
                    </div>

                    <c:if test="${blog.categoryList.size() > 0 || blog.tagList.size() > 0}">
                        <div class="text-category-tag">
                            <c:if test="${blog.categoryList.size() > 0}">
                                <div>
                                    <strong>分类：</strong>
                                <span>
                                    <c:forEach items="${blog.categoryList}" var="c" varStatus="v">
                                        <a href="${ctx}/categorys/${c.id}/1">${c.name}</a><c:if
                                            test="${(v.index+1) != blog.categoryList.size()}">&nbsp;,&nbsp;</c:if>
                                    </c:forEach>
                                </span>
                                </div>
                            </c:if>
                            <c:if test="${blog.tagList.size() > 0}">
                                <div>
                                    <strong>标签：</strong>
                                <span>
                                    <c:forEach items="${blog.tagList}" var="t" varStatus="v">
                                        <a href="${ctx}/tags/${t.id}/1">${t.name}</a><c:if
                                            test="${(v.index+1) != blog.tagList.size()}">&nbsp;,&nbsp;</c:if>
                                    </c:forEach>
                                </span>
                                </div>
                            </c:if>
                        </div>
                    </c:if>
                    <div class="section-spacer"></div>
                    <div class="text-more">
                        <a class="mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect"
                           href="${ctx}/article/${blog.id}">继续阅读</a>
                    </div>
                </div>
            </div>
        </c:forEach>

        <nav class="demo-nav mdl-color-text--grey-50 mdl-cell mdl-cell--12-col">
            <c:if test="${page.pn > 1}">
                <a id="prev-page" class="demo-nav__button"
                   <c:if test="${pageType==null}">href="${ctx}/${page.pn - 1}"</c:if>
                   <c:if test="${pageType==1}">href="${ctx}/categorys/${ctId}/${page.pn - 1}"</c:if>
                   <c:if test="${pageType==2}">href="${ctx}/tags/${ctId}/${page.pn - 1}"</c:if>
                   <c:if test="${pageType==3}">href="${ctx}/months/${month}/${page.pn - 1}"</c:if>>
                    <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-color--white mdl-color-text--grey-900"
                            role="presentation">
                        <i class="material-icons">arrow_back</i>
                    </button>
                </a>

                <div class="mdl-tooltip" for="prev-page">上一页</div>
            </c:if>
            <div class="section-spacer"></div>
            <c:if test="${page.pn < page.pc}">
                <a id="next-page" class="demo-nav__button"
                   <c:if test="${pageType==null}">href="${ctx}/${page.pn + 1}"</c:if>
                   <c:if test="${pageType==1}">href="${ctx}/categorys/${ctId}/${page.pn + 1}"</c:if>
                   <c:if test="${pageType==2}">href="${ctx}/tags/${ctId}/${page.pn + 1}"</c:if>
                   <c:if test="${pageType==3}">href="${ctx}/months/${month}/${page.pn + 1}"</c:if>>
                    <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-color--white mdl-color-text--grey-900"
                            role="presentation">
                        <i class="material-icons">arrow_forward</i>
                    </button>
                </a>

                <div class="mdl-tooltip" for="next-page">下一页</div>
            </c:if>
        </nav>
    </c:if>
</div>
</body>
</html>