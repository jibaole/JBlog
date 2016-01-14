<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<html>
<head>
    <title>闲想录</title>
</head>

<body>
<c:forEach items="${blogs}" var="blog" varStatus="v">
    <div class="blog-post">
        <h3 class="blog-post-title"><a href="${ctx}/article/${blog.id}">${blog.title}</a></h3>

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
            &nbsp;&nbsp;&nbsp;${blog.viewNum}阅读<%--
            &nbsp;&nbsp;<a href="${ctx}/comment?blogId=${blog.id}"><c:if
                test="${blog.commentNum > 0}">${blog.commentNum}条</c:if>评论</a>--%>
        </p>

        <div id="editormd-view-${blog.id}" class="editormd-content" bid="${blog.id}">
            <textarea style="display: none;" id="content-${blog.id}"><c:out value="${blog.content}"
                                                                                  escapeXml="true"/></textarea>
        </div>
            <%--
            <c:if test="${fn:length(blog.content)>200}">${fn:substring(blog.content ,0,200)}</c:if>
            <c:if test="${fn:length(blog.content)<=200}">${blog.content}</c:if>
            --%>
    </div>
    <hr>
</c:forEach>
<%--
<ul class="pager">
    <li <c:if test="${page.prePage==1}"> class="disabled" </c:if>>
        <a href="${ctx}/web/blog?pageNum=${page.prePage}">上一页</a>
    </li>
    <li>
        <a href="${ctx}/web/blog?pageNum=${page.nextPage}">下一页</a>
    </li>
</ul>
--%>

<script type="text/javascript">
    /*$(function(){
     $('.content').each(function(){
     var c = $(this).text();
     var content = markdown.toHTML(c);
     $(this).html(content).show();
     });
     });*/
    $(function () {
        $('.editormd-content').each(function () {
            var divId = $(this).attr('id');
            var bId = $(this).attr('bId');
            var content = $('#content-' + bId).text();
            editormd.markdownToHTML(divId, {
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

    });
</script>
</body>
</html>
