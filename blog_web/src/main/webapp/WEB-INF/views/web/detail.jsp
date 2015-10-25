<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>${blog.title} | 闲想录</title>
</head>

<body>
<div class="demo-blog--blogpost">
    <div class="demo-back">
        <a class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon" href="${ctx}/"
           title="返回首页" role="button">
            <i class="material-icons" role="presentation">arrow_back</i>
        </a>
    </div>
    <div class="demo-blog__posts mdl-grid">

        <div class="mdl-card <c:if test="${blog!=null && blog.bannerImgId==null}">amazing</c:if> mdl-shadow--4dp mdl-cell mdl-cell--12-col">
            <div class="<c:if test="${blog==null}">mdl-card__media mdl-card-banner-img</c:if><c:if test="${blog!=null && blog.bannerImgId==null}">mdl-card__title</c:if><c:if test="${blog.bannerImgId!=null}">mdl-card__media mdl-card-banner-img${blog.bannerImgId}</c:if> mdl-color-text--grey-50">
                <h3 <c:if test="${blog!=null && blog.bannerImgId==null}">class="quote"</c:if>>${blog.title}</h3>
            </div>
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
                    <div class="meta__favorites">
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
                    </div>
                </div>
                <div class="mdl-color-text--grey-700 mdl-card__supporting-text">
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

                <div class="mdl-color-text--primary-contrast mdl-card__supporting-text comments">
                        <%-- 多说评论框 start --%>
                    <div class="ds-thread" data-thread-key="${blog.id}" data-title="${blog.title}"
                         data-url="${ctx}/detail/${blog.id}"></div>
                        <%-- 多说评论框 end --%>
                        <%-- 多说公共JS代码 start (一个网页只需插入一次) --%>
                    <script type="text/javascript">
                        var duoshuoQuery = {short_name: "caliven"};
                        (function () {
                            var ds = document.createElement('script');
                            ds.type = 'text/javascript';
                            ds.async = true;
                            ds.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//static.duoshuo.com/embed.js';
                            ds.charset = 'UTF-8';
                            (document.getElementsByTagName('head')[0]
                            || document.getElementsByTagName('body')[0]).appendChild(ds);
                        })();
                    </script>
                        <%-- 多说公共JS代码 end --%>
                </div>
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
</body>
</html>