<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<html>
<head>
    <title>${blog.title} | 闲想录</title>
</head>

<body>
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

    <div id="editormd"><textarea style="display: none;" id="content"><c:out value="${blog.content}"
                                                                            escapeXml="true"/></textarea></div>
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
<%--
<div>
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
</div>
--%>
<script type="text/javascript">
    $(function () {
        var content = $('#content').text();
        editormd.markdownToHTML('editormd', {
            markdown: content,//+"\r\n" + $("#append-test").text(),
            //htmlDecode      : true,       // 开启 HTML 标签解析，为了安全性，默认不开启
            htmlDecode: "style,script,iframe",  // you can filter tags decode
            //toc             : false,
            tocm: true,    // Using [TOCM]
            //tocContainer    : "#custom-toc-container", // 自定义 ToC 容器层
            //gfm             : false,
            //tocDropdown     : true,
            // markdownSourceCode : true, // 是否保留 Markdown 源码，即是否删除保存源码的 Textarea 标签
            emoji: true,
            taskList: true,
            tex: true,  // 默认不解析
            flowChart: true,  // 默认不解析
            sequenceDiagram: true  // 默认不解析

        });
    });
</script>
</body>
</html>
