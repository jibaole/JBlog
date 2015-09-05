<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>JBlog Java 专注Java高性能程序开发</title>
    <link href="${ctx}/static/styles/web/index.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${ctx}/static/bootstrap/markdown/js/markdown.js"></script>
    <script type="text/javascript" src="${ctx}/static/bootstrap/markdown/js/to-markdown.js"></script>
</head>

<body>
<jsp:include page="top.jsp" flush="true"/>

<div class="container">
    <div class="blog-header">
        <h2 class="blog-title">技术与人生</h2>
        <p class="lead blog-description">技术与人文与人生即在此.</p>
    </div>

    <div class="row">
        <div class="col-sm-8 blog-main">
            <c:forEach items="${blogs}" var="blog" varStatus="v">
                <div class="blog-post">
                    <h2 class="blog-post-title"><a href="${ctx}/detail/${blog.id}">${blog.title}</a></h2>

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
                        &nbsp;&nbsp;<a href="${ctx}/comment?blogId=${blog.id}"><c:if
                            test="${blog.commentNum > 0}">${blog.commentNum}条</c:if>评论</a>
                    </p>

                    <p id="html_${v.index}" class="content" style="display: none;">
                        ${blog.content}
                        <%--
                        <c:if test="${fn:length(blog.content)>200}">${fn:substring(blog.content ,0,200)}</c:if>
                        <c:if test="${fn:length(blog.content)<=200}">${blog.content}</c:if>
                        --%>
                    </p>
                </div>
                <hr>
            </c:forEach>
            <ul class="pager"><%--
                <li <c:if test="${page.prePage==1}"> class="disabled" </c:if>>
                    <a href="${ctx}/web/blog?pageNum=${page.prePage}">上一页</a>
                </li>
                <li>
                    <a href="${ctx}/web/blog?pageNum=${page.nextPage}">下一页</a>
                </li>--%>
            </ul>
        </div>

        <div class="col-sm-3 col-sm-offset-1 blog-sidebar">
            <jsp:include page="right.jsp" flush="true"/>
        </div>
        <!-- /.blog-sidebar -->

    </div>
    <!-- /.row -->

</div>
<!-- /.container -->
<script type="text/javascript">
    $(function(){
        $('.content').each(function(){
            var c = $(this).text();
            var content = markdown.toHTML(c);
            $(this).html(content).show();
        });
    });
</script>
</body>
</html>
