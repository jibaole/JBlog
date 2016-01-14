<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>

<html>
<head>
    <title>文章归档 | 闲想录</title>
    <link type="text/css" rel="stylesheet" href="${qiniu}/statics/styles/web/archives.css"/>
</head>

<body>
<div class="mdl-archives">
    <div class="mdl-layout__tab-panel is-active">
        <section class="section--center mdl-grid mdl-grid--no-spacing mdl-shadow--2dp">
            <div class="mdl-card mdl-cell mdl-cell--12-col">
                <div class="mdl-card__supporting-text mdl-grid mdl-grid--no-spacing">
                    <h4 class="mdl-cell mdl-cell--12-col">归档</h4>
                    <c:forEach items="${archivesMap}" var="m">
                        <div class="section__circle-container mdl-cell mdl-cell--2-col mdl-cell--1-col-phone">
                            <div class="section__circle-container__circle mdl-color--primary">
                                <div>${m.key}</div>
                            </div>
                        </div>
                        <div class="section__text mdl-cell mdl-cell--10-col-desktop mdl-cell--6-col-tablet mdl-cell--3-col-phone">
                            <c:forEach items="${m.value}" var="b">
                                <div class="item-div">
                                    <fmt:formatDate value="${b.createdDate}" pattern="MM月dd日："/>
                                    <a href="${ctx}/article/${b.id}" target="_blank">${b.title}</a>
                                </div>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </div>
</div>
</body>
</html>