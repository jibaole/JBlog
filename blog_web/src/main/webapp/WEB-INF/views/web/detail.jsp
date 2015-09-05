<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>${blog.title} - JBlog</title>
    <link href="${ctx}/static/styles/web/index.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${ctx}/static/bootstrap/markdown/js/markdown.js"></script>
    <script type="text/javascript" src="${ctx}/static/bootstrap/markdown/js/to-markdown.js"></script>
</head>
<%--
<script type="text/javascript">
  /* * * CONFIGURATION VARIABLES * * */
  var disqus_shortname = 'jcaliven';

  /* * * DON'T EDIT BELOW THIS LINE * * */
  (function () {
    var s = document.createElement('script'); s.async = true;
    s.type = 'text/javascript';
    s.src = '//' + disqus_shortname + '.disqus.com/count.js';
    (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
  }());
</script>--%>
<body>
<jsp:include page="top.jsp" flush="true"/>

<div class="container">
    <div class="blog-header">
        <h1 class="blog-title">技术与人生</h1>

        <p class="lead blog-description">技术与人文与人生即在此.</p>
    </div>

    <div class="row">
        <div class="col-sm-8 blog-main">
            <div class="blog-post">
                <h2 class="blog-post-title">${blog.title}</h2>

                <p class="blog-post-meta">
                    <fmt:formatDate value="${blog.createdDate}" pattern="yyyy-MM-dd" dateStyle="default"/> by
                    <a href="#">${blog.user.nickname}</a>
                    &nbsp;&nbsp;分类：
                    <c:if test="${blog.categorys.size() > 0}">
                        <c:forEach items="${blog.categorys}" var="cate" varStatus="c">
                            <a href="${ctx}/cate?cateId=${cate.categoryId}">${cate.categoryName}</a>
                            <c:if test="${blog.categorys.size() != (c.index+1)}">,&nbsp;</c:if>
                        </c:forEach>
                    </c:if>
                    <c:if test="${blog.categorys == null || fn:length(blog.categorys) == 0}">
                        <a href="#">默认分类</a>
                    </c:if>
                    &nbsp;&nbsp;&nbsp;${blog.viewNum}阅读
                </p>

                <p id="html_${v.index}" style="display: none;">${blog.content}</p>
                <script type="text/javascript">
                    var c = $('#html_${v.index}').text();
                    var content = markdown.toHTML(c);
                    $('#html_${v.index}').html(content).show();
                </script>
            </div>

            <div>
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
            </div>

            <%--<div>
              <div id="disqus_thread"></div>
              <script type="text/javascript">
                /* * * CONFIGURATION VARIABLES * * */
                var disqus_shortname = 'jcaliven';

                /* * * DON'T EDIT BELOW THIS LINE * * */
                (function() {
                  var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
                  dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
                  (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
                })();
              </script>
              <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
            </div>--%>
        </div>

        <div class="col-sm-3 col-sm-offset-1 blog-sidebar">
            <jsp:include page="right.jsp" flush="true"/>
        </div>
    </div>
</div>
</body>
</html>
