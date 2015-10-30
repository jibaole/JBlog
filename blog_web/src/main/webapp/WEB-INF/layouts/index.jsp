<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description"
          content="闲想录是一个专注于程序开发的IT技术博客，整理分享原创Java、手机开发、Web前端、服务器等技术。源于技术不止于技术，同时也有一丝丝技术人文关怀，欢迎大家光临。">
    <meta name="keywords" content="Java技术博客,个人博客,技术博客,Android开发,IOS开发,Caliven,闲想录,闲思录">
    <%--百度统计--%>
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?20db30cf8bb316624e79a0e5050bd974";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <%--CNZZ统计--%>
    <script type="text/javascript">
        var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
        document.write(unescape("%3Cspan id='cnzz_stat_icon_1256666242'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s11.cnzz.com/z_stat.php%3Fid%3D1256666242' type='text/javascript'%3E%3C/script%3E"));
    </script>
    <%--
    &lt;%&ndash; Add to homescreen for Chrome on Android &ndash;%&gt;
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="images/touch/chrome-touch-icon-192x192.png">
    &lt;%&ndash; Add to homescreen for Safari on iOS &ndash;%&gt;
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Java技术博客,个人博客,技术博客,Caliven,闲想录,闲思录">
    <link rel="apple-touch-icon-precomposed" href="apple-touch-icon-precomposed.png">
    &lt;%&ndash; Tile icon for Win8 (144x144 + tile color) &ndash;%&gt;
    <meta name="msapplication-TileImage" content="images/touch/ms-touch-icon-144x144-precomposed.png">
    <meta name="msapplication-TileColor" content="#3372DF">
    --%>
    <title><sitemesh:title/></title>
    <sitemesh:head/>
    <script type="text/javascript">var _ctx = '${ctx}';</script>

    <link type="image/x-icon" rel="shortcut icon" href="${ctx}/static/images/favicon/favicon.ico"/>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Roboto:regular,bold,italic,thin,light,bolditalic,black,medium&amp;lang=en"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/static/mdl/material.css"/>
    <%--
    <link type="text/css" rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.5/material.grey-orange.min.css">
    --%>
    <link type="text/css" rel="stylesheet" href="${ctx}/static/mdl/styles.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/static/editor.md/css/editormd.preview.css"/>
</head>

<body>
<div class="demo-blog mdl-layout mdl-js-layout has-drawer is-upgraded">
    <main class="mdl-layout__content">
        <sitemesh:body/>
        <jsp:include page="footer.jsp" flush="true"/>
    </main>
    <audio id="music" preload="auto" src="http://m2.music.126.net/kdmVoHkL1G-RbeXnsr1rnw==/6624557558012901.mp3"
           style="display: none;"/>
</div>
<%-- 返回顶部 --%>
<button id="back-to-top" style="display: none;"
        class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored back-to-top">
    <i class="material-icons">keyboard_arrow_up</i>
</button>

<%--
<script type="text/javascript" src="https://storage.googleapis.com/code.getmdl.io/1.0.5/material.min.js"></script>
--%>
<script type="text/javascript" src="${ctx}/static/mdl/material.min.js"></script>
<%-- editormd编辑器解析 markdown 文档依赖 js --%>
<script type="text/javascript" src="${ctx}/static/js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/editor.md/lib/marked.min.js"></script>
<script type="text/javascript" src="${ctx}/static/editor.md/lib/prettify.min.js"></script>
<script type="text/javascript" src="${ctx}/static/editor.md/lib/raphael.min.js"></script>
<script type="text/javascript" src="${ctx}/static/editor.md/lib/underscore.min.js"></script>
<script type="text/javascript" src="${ctx}/static/editor.md/lib/sequence-diagram.min.js"></script>
<script type="text/javascript" src="${ctx}/static/editor.md/lib/flowchart.min.js"></script>
<script type="text/javascript" src="${ctx}/static/editor.md/lib/jquery.flowchart.min.js"></script>
<script type="text/javascript" src="${ctx}/static/editor.md/editormd.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/index/index.js"></script>

</body>
</html>