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
        <a class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon" href="${ctx}/index/list2"
           title="返回" role="button">
            <i class="material-icons" role="presentation">arrow_back</i>
        </a>
    </div>
    <div class="demo-blog__posts mdl-grid">
        <div class="mdl-card mdl-shadow--4dp mdl-cell mdl-cell--12-col">
            <div class="mdl-card__media mdl-color-text--grey-50">
                <h3>${blog.title}</h3>
            </div>
            <div class="mdl-color-text--grey-700 mdl-card__supporting-text meta">
                <div class="minilogo"></div>
                <div>
                    <strong>${blog.user.nickname}</strong>
                        <span><fmt:formatDate value="${blog.createdDate}" pattern="yyyy-MM-dd"
                                              dateStyle="default"/></span>
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
                <div id="editormd-view-${blog.id}" class="editormd-content" bid="${blog.id}">
                <textarea style="display: none;" id="content-${blog.id}">
                    <c:out value="${blog.content}" escapeXml="true"/>
                </textarea>
                </div>
            </div>
            <div class="mdl-color-text--primary-contrast mdl-card__supporting-text comments">
                <!-- 多说评论框 start -->
                <div class="ds-thread" data-thread-key="${blog.id}" data-title="${blog.title}"
                     data-url="${ctx}/detail/${blog.id}"></div>
                <!-- 多说评论框 end -->
                <!-- 多说公共JS代码 start (一个网页只需插入一次) -->
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
                <!-- 多说公共JS代码 end -->
                <%--
                <form>
                  <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                    <textarea rows=1 class="mdl-textfield__input" id="comment"></textarea>
                    <label for="comment" class="mdl-textfield__label">Join the discussion</label>
                  </div>
                  <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
                    <i class="material-icons" role="presentation">check</i><span class="visuallyhidden">add comment</span>
                  </button>
                </form>
                <div class="comment mdl-color-text--grey-700">
                  <header class="comment__header">
                    <img src="images/co1.jpg" class="comment__avatar">
                    <div class="comment__author">
                      <strong>James Splayd</strong>
                      <span>2 days ago</span>
                    </div>
                  </header>
                  <div class="comment__text">
                    In in culpa nulla elit esse. Ex cillum enim aliquip sit sit ullamco ex eiusmod fugiat. Cupidatat ad minim officia mollit laborum magna dolor tempor cupidatat mollit. Est velit sit ad aliqua ullamco laborum excepteur dolore proident incididunt in labore elit.
                  </div>
                  <nav class="comment__actions">
                    <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
                      <i class="material-icons" role="presentation">thumb_up</i><span class="visuallyhidden">like comment</span>
                    </button>
                    <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
                      <i class="material-icons" role="presentation">thumb_down</i><span class="visuallyhidden">dislike comment</span>
                    </button>
                    <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
                      <i class="material-icons" role="presentation">share</i><span class="visuallyhidden">share comment</span>
                    </button>
                  </nav>
                  <div class="comment__answers">
                    <div class="comment">
                      <header class="comment__header">
                        <img src="images/co2.jpg" class="comment__avatar">
                        <div class="comment__author">
                          <strong>John Dufry</strong>
                          <span>2 days ago</span>
                        </div>
                      </header>
                      <div class="comment__text">
                        Yep, agree!
                      </div>
                      <nav class="comment__actions">
                        <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
                          <i class="material-icons" role="presentation">thumb_up</i><span class="visuallyhidden">like comment</span>
                        </button>
                        <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
                          <i class="material-icons" role="presentation">thumb_down</i><span class="visuallyhidden">dislike comment</span>
                        </button>
                        <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon">
                          <i class="material-icons" role="presentation">share</i><span class="visuallyhidden">share comment</span>
                        </button>
                      </nav>
                    </div>
                  </div>
                </div>
                --%>
            </div>
        </div>

        <nav class="demo-nav mdl-color-text--grey-50 mdl-cell mdl-cell--12-col">
            <a href="${ctx}/index" class="demo-nav__button" title="老的一遍文章">
                <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-color--white mdl-color-text--grey-900"
                        role="presentation">
                    <i class="material-icons">arrow_back</i>
                </button>
                Older
            </a>

            <div class="section-spacer"></div>
            <a href="${ctx}/index" class="demo-nav__button" title="新的一遍文章">
                Newer
                <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon mdl-color--white mdl-color-text--grey-900"
                        role="presentation">
                    <i class="material-icons">arrow_forward</i>
                </button>
            </a>
        </nav>
    </div>
</div>
</body>
</html>
