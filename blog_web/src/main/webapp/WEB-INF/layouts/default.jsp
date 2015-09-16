<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="A front-end template that helps you build fast, modern mobile web apps.">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="images/touch/chrome-touch-icon-192x192.png">
    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Material Design Lite">
    <link rel="apple-touch-icon-precomposed" href="apple-touch-icon-precomposed.png">
    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="images/touch/ms-touch-icon-144x144-precomposed.png">
    <meta name="msapplication-TileColor" content="#3372DF">

    <meta name="keywords" content="Java技术博客,个人博客,技术博客,Caliven,闲想录">
    <meta name="description" content="技术人文-闲想录，分享技术，亦可探讨生活。">
    <title><sitemesh:title/></title>
    <sitemesh:head/>

    <!-- SEO: If your mobile URL is different from the desktop URL, add a canonical link to the desktop page https://developers.google.com/webmasters/smartphone-sites/feature-phones -->
    <!--
    <link rel="canonical" href="http://www.example.com/">
    -->
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css?family=Roboto:regular,bold,italic,thin,light,bolditalic,black,medium&amp;lang=en">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.4/material.grey-orange.min.css">
    <%--
    <link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.4/material.cyan-light_blue.min.css"/>
    <link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.4/material.pink-deep_purple.min.css" />
    <link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.4/material.cyan-teal.min.css" />

    --%>
    <link rel="shortcut icon" href="${ctx}/static/images/favicon/favicon.ico">
    <%--
        <link rel="stylesheet" href="${ctx}/static/mdl/fonsts/fonts1.css">
        <link rel="stylesheet" href="${ctx}/static/mdl/fonsts/fonts2.css">
        &lt;%&ndash;
            <link rel="stylesheet" href="${ctx}/static/mdl/material.grey-orange.min.css">&ndash;%&gt;

        <link rel="stylesheet" href="${ctx}/static/mdl/material.min.css">
    --%>
    <link rel="stylesheet" href="${ctx}/static/mdl/styles.css">
    <%--
    <link rel="stylesheet" href="${ctx}/static/editor.md/css/editormd.preview.css">
    --%>

    <script language="javascript">
        var _ctx = '${ctx}';
    </script>
</head>

<body>

<div class="demo-blog mdl-layout mdl-js-layout has-drawer is-upgraded">
    <main class="mdl-layout__content">
        <sitemesh:body/>
        <jsp:include page="footer.jsp" flush="true"/>
    </main>
    <div class="mdl-layout__obfuscator"></div>
</div>
<%--
<button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab back-to-top" id="back-to-top">
    <i class="material-icons">keyboard_arrow_up</i>
</button>
--%>
<button class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored back-to-top" id="back-to-top">
    <%-- <i class="material-icons">flight</i> --%>
    <i class="material-icons">keyboard_arrow_up</i>
</button>
<script src="${ctx}/static/js/jquery/jquery.min.js"></script>
<script src="${ctx}/static/mdl/material.min.js"></script>

<%--
<script src="${ctx}/static/editor.md/lib/marked.min.js"></script>
<script src="${ctx}/static/editor.md/lib/prettify.min.js"></script>
<script src="${ctx}/static/editor.md/lib/raphael.min.js"></script>
<script src="${ctx}/static/editor.md/lib/underscore.min.js"></script>
<script src="${ctx}/static/editor.md/lib/sequence-diagram.min.js"></script>
<script src="${ctx}/static/editor.md/lib/flowchart.min.js"></script>
<script src="${ctx}/static/editor.md/lib/jquery.flowchart.min.js"></script>
<script src="${ctx}/static/editor.md/editormd.js"></script>
--%>
</body>

<script type="text/javascript">
    $(window).scroll(function () {
        var scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
        if (scrollTop <= 200) {
            $('#back-to-top').animate({
                opacity: "hide"
            }, "slow");
        } else {
            $('#back-to-top').animate({
                opacity: "show"
            }, "slow");
        }
    });

    $(function () {
        $('#back-to-top').click(function () {
            $('html, body').animate({
                scrollTop: 0
            }, 500);
        });
        //$.getScript('${ctx}/static/editor.md/lib/marked.min.js');
        //$.getScript('${ctx}/static/editor.md/lib/prettify.min.js');
        //$.getScript('${ctx}/static/editor.md/lib/raphael.min.js');
        //$.getScript('${ctx}/static/editor.md/lib/underscore.min.js');
        //$.getScript('${ctx}/static/editor.md/lib/sequence-diagram.min.js');
        //$.getScript('${ctx}/static/editor.md/lib/flowchart.min.js');
        //$.getScript('${ctx}/static/editor.md/lib/jquery.flowchart.min.js');
        //$.getScript('${ctx}/static/editor.md/editormd.js');
        /*
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
         markdownSourceCode: false, // 是否保留 Markdown 源码，即是否删除保存源码的 Textarea 标签
         emoji: true,
         taskList: true,
         tex: true,  // 默认不解析
         flowChart: true,  // 默认不解析
         sequenceDiagram: true  // 默认不解析
         });
         });*/
    });
</script>
</html>