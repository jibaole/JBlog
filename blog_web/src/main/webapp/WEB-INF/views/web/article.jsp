<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>

<html>
<head>
    <title>${blog.title} | 闲想录</title>
    <link type="text/css" rel="stylesheet" href="${qiniu}/statics/styles/web/blog.css"/>
</head>

<body>
<div class="demo-blog mdl-layout has-drawer is-upgraded">
    <main class="mdl-layout__content article-blog">
        <div class="demo-blog--blogpost">
            <div class="demo-blog__posts mdl-grid">
                <%--
                <div class="demo-back">
                    <a class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon" href="javascript:;"
                       onclick="javascript:history.go(-1);" title="返回" role="button">
                        <i class="material-icons" role="presentation">arrow_back</i>
                    </a>
                </div>
                --%>
                <div class="mdl-card mdl-shadow--2dp <c:if test="${blog!=null && blog.bannerImgId==null}">amazing</c:if> mdl-shadow--4dp mdl-cell mdl-cell--12-col">
                    <div class="<c:if test="${blog==null}">mdl-card__media mdl-card-banner-img</c:if><c:if test="${blog!=null && blog.bannerImgId==null}">mdl-card__title</c:if><c:if test="${blog.bannerImgId!=null}">mdl-card__media mdl-card-banner-img${blog.bannerImgId}</c:if> mdl-color-text--grey-50">
                        <h3 <c:if test="${blog!=null && blog.bannerImgId==null}">class="quote"</c:if>>${blog.title}</h3>
                    </div><%--
                    <div class="mdl-card__menu" style="color: #fff;">
                        <button class="mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect"
                                onclick="javascript:history.go(-1);" title="返回">
                            <i class="material-icons">arrow_back</i>
                        </button>
                    </div>--%>
                    <c:if test="${blog == null}">
                        <div class="mdl-color-text--grey-700 mdl-card__supporting-text">
                            不存的文章！<a href="${ctx}/">首页</a>
                        </div>
                    </c:if>
                    <c:if test="${blog != null}">
                        <div class="mdl-color-text--grey-700 mdl-card__supporting-text meta">
                            <div class="minilogo"></div>
                            <div>
                                <strong>发表于</strong>
                                <span><fmt:formatDate value="${blog.createdDate}" pattern="yyyy.MM.dd"/></span>
                            </div>
                            <div class="section-spacer"></div>
                            <%--<div class="meta__favorites">
                                425 <i class="material-icons" role="presentation">favorite</i>
                                <span class="visuallyhidden">favorites</span>
                            </div>
                            <div>
                                <i class="material-icons" role="presentation">bookmark</i>
                                <span class="visuallyhidden">bookmark</span>
                            </div>
                            <div>
                                <i class="material-icons" role="presentation">share</i>
                                <span class="visuallyhidden">share</span>
                            </div>--%>
                        </div>
                        <div class="blog-content mdl-color-text--grey-700 mdl-card__supporting-text">
                            <div id="editormd-view-${blog.id}" class="editormd-content">
                                <textarea style="display: none;"><c:out value="${blog.content}" escapeXml="true"/></textarea>
                            </div>
                        </div>

                        <div class="mdl-color-text--grey-700 mdl-card__supporting-text">
                            <div class="text-category-tag">
                                <c:if test="${blog.categoryList.size() > 0}">
                                    <div>
                                        <strong>分类：</strong>
                                        <span>
                                            <c:forEach items="${blog.categoryList}" var="c" varStatus="v">
                                                <a href="${ctx}/categorys/${c.slug}">${c.name}</a><c:if
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
                                                <a href="${ctx}/tags/${t.slug}">${t.name}</a><c:if
                                                    test="${(v.index+1) != blog.tagList.size()}">&nbsp;,&nbsp;</c:if>
                                            </c:forEach>
                                        </span>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        <jsp:include page="/WEB-INF/views/common/comment.jsp" flush="true"/>
                    </c:if>
                </div>

                <c:if test="${blog != null}">
                    <nav class="demo-nav mdl-color-text--grey-50 mdl-cell mdl-cell--12-col">
                        <c:if test="${prevBlog != null}">
                            <a href="${ctx}/article/${prevBlog.id}" id="prev-blog" class="demo-nav__button">
                                <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-color--white mdl-color-text--grey-900"
                                        role="presentation">
                                    <i class="material-icons">arrow_back</i>
                                </button>
                                上一篇
                            </a>

                            <div class="mdl-tooltip" for="prev-blog">下一篇<br>${prevBlog.title}</div>
                        </c:if>

                        <div class="section-spacer"></div>
                        <c:if test="${nextBlog != null}">
                            <a href="${ctx}/article/${nextBlog.id}" id="next-blog" class="demo-nav__button">
                                下一篇
                                <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-color--white mdl-color-text--grey-900"
                                        role="presentation">
                                    <i class="material-icons">arrow_forward</i>
                                </button>
                            </a>

                            <div class="mdl-tooltip" for="next-blog">下一篇<br>${nextBlog.title}</div>
                        </c:if>
                    </nav>
                </c:if>
            </div>
        </div>
    </main>
</div>
<%@include file="/WEB-INF/views/common/markdown.jsp" %>
</body>
</html>