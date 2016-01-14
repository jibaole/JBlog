<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="闲想录是一个专注于程序开发的IT技术博客，整理分享原创Java、手机开发、Web前端、服务器等技术。源于技术不止于技术，少许技术人文关怀，欢迎大家光临。">
    <meta name="keywords" content="Java技术博客,MDL博客,Caliven,闲想录,闲思录">
    <title><sitemesh:title/></title>
    <sitemesh:head/>
    <script type="text/javascript">var _ctx = '${ctx}';</script>

    <link type="image/x-icon" rel="shortcut icon" href="${qiniu}/statics/images/favicon/favicon.ico"/>
    <link type="text/css" rel="stylesheet" href="${qiniu}/statics/mdl/material.min.css"/>
    <link type="text/css" rel="stylesheet" href="${qiniu}/statics/styles/web/common.css"/>
    <link type="text/css" rel="stylesheet" href="${qiniu}/statics/editor.md/css/editormd.preview.min.css"/>
    <link href="https://fonts.googleapis.com/css?family=Roboto:regular,bold,italic,thin,light,bolditalic,black,medium&amp;lang=en" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script type="text/javascript" src="${qiniu}/statics/js/jquery/jquery.min.js"></script>

    <%--百度统计--%>
    <%--
    <script type="text/javascript">
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?20db30cf8bb316624e79a0e5050bd974";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    --%>
</head>

<body
        <c:if test="${navnum==1}">class="jblog-index"</c:if>
        <c:if test="${navnum!=1}">class="jblog-other"</c:if>>
<div class="docs-layout mdl-layout mdl-js-layout">
    <header class="docs-layout-header mdl-layout__header">
        <div class="mdl-layout__header-row">
            <%--
            <span class="docs-layout-title mdl-layout-title"><a href="${ctx}/">闲想录</a></span>
            --%>
            <%--
            <div class="mdl-layout-spacer"></div>
            <form action="#">
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable">
                    <label class="mdl-button mdl-js-button mdl-button--icon" for="sample6">
                        <i class="material-icons">search</i>
                    </label>

                    <div class="mdl-textfield__expandable-holder">
                        <input class="mdl-textfield__input" type="text" id="sample6">
                        <label class="mdl-textfield__label"></label>
                    </div>
                </div>
            </form>
            --%>
        </div>

        <div class="docs-navigation__container">
            <nav class="docs-navigation mdl-navigation">
                <a href="${ctx}/" class="mdl-navigation__link<c:if test="${navnum==1}"> is-active</c:if>">首页</a>
                <a href="${ctx}/archives"
                   class="mdl-navigation__link<c:if test="${navnum==2}"> is-active</c:if>">归档</a>
                <a href="${ctx}/tags"
                   class="mdl-navigation__link<c:if test="${navnum==3}"> is-active</c:if>">标签</a>
                <a href="${ctx}/category"
                   class="mdl-navigation__link<c:if test="${navnum==4}"> is-active</c:if>">分类</a>
                <a href="${ctx}/msgboard"
                   class="mdl-navigation__link<c:if test="${navnum==5}"> is-active</c:if>">留言板</a>
                <a href="${ctx}/about" class="mdl-navigation__link<c:if test="${navnum==6}"> is-active</c:if>">关于</a>

                <%--<div class="spacer"></div>
                <form action="#">
                    <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label search-div">
                        <input class="mdl-textfield__input" type="text" id="sample3">
                        <label class="mdl-textfield__label" for="sample3">Search...</label>
                    </div>
                </form>--%>
            </nav>
        </div>
        <button id="play-music" title="双击空白区域可停止播放"
                class="mdl-button mdl-js-ripple-effect mdl-js-button mdl-button--fab mdl-color--accent header-button">
            <i class="material-icons mdl-color-text--white" role="presentation">play_arrow</i>
        </button>

        <i class="material-icons scrollindicator scrollindicator--right">&#xE315;</i>
        <i class="material-icons scrollindicator scrollindicator--left">&#xE314;</i>
    </header>
    <main class="docs-layout-content mdl-layout__content mdl-color-text--grey-600">
        <%--<sitemesh:body/>--%>
        <div class="mdl-grid mdl-grid--no-spacing">
            <sitemesh:body/>
        </div>
        <jsp:include page="footer.jsp" flush="true"/>
    </main>
</div>

<%-- 返回顶部 --%>
<%--<button id="back-to-top" style="display: none;"
        class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored back-to-top">
    <i class="material-icons">keyboard_arrow_up</i>
</button>--%>
<audio id="music" preload="auto" src="http://m2.music.126.net/XQo6IAe0In6D5ckPbhpmqA==/2053887720694509.mp3"
       style="display: none;"/>

<script type="text/javascript" src="${qiniu}/statics/mdl/material.min.js"></script>
<script type="text/javascript" src="${qiniu}/statics/js/index/index.js"></script>
</body>
</html>