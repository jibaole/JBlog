<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>

<html>
<head>
    <title>留言板 | 想录</title>
    <link type="text/css" rel="stylesheet" href="${qiniu}/statics/styles/web/about.css"/>
</head>

<body>
<div class="msg-board-ribbon"></div>
<main class="about-main">
    <div class="about-container mdl-grid">
        <div class="mdl-cell mdl-cell--2-col mdl-cell--hide-tablet mdl-cell--hide-phone"></div>
        <div class="about-div mdl-color--white mdl-shadow--2dp content mdl-color-text--grey-800 mdl-cell mdl-cell--12-col">
            <div class="blog-content">
                <div id="editormd-view-${blog.id}" class="editormd-content">
                    <textarea style="display: none;"><c:out value="${blog.content}" escapeXml="true"/></textarea>
                </div>
            </div>
            <jsp:include page="../common/comment.jsp" flush="true"/>
        </div>
    </div>
</main>
<%@include file="/WEB-INF/views/common/markdown.jsp" %>
</body>
</body>
</html>