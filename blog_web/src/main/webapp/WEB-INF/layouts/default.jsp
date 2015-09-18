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
          content="闲想录是一个专注于程序开发的IT博客，整理分享和原创Java、Web前端、服务器等技术。源于技术不止于技术，同时也有一丝丝技术人文关怀，欢迎大家光临。">
    <meta name="keywords" content="Java技术博客,个人博客,技术博客,Caliven,闲想录,闲思录">
    <%-- Add to homescreen for Chrome on Android --%>
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="images/touch/chrome-touch-icon-192x192.png">
    <%-- Add to homescreen for Safari on iOS --%>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Java技术博客,个人博客,技术博客,Caliven,闲想录,闲思录">
    <link rel="apple-touch-icon-precomposed" href="apple-touch-icon-precomposed.png">
    <%-- Tile icon for Win8 (144x144 + tile color) --%>
    <meta name="msapplication-TileImage" content="images/touch/ms-touch-icon-144x144-precomposed.png">
    <meta name="msapplication-TileColor" content="#3372DF">

    <title><sitemesh:title/></title>
    <sitemesh:head/>

    <%--
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:regular,bold,italic,thin,light,bolditalic,black,medium&amp;lang=en">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.4/material.grey-orange.min.css">
    <link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.4/material.cyan-light_blue.min.css"/>
    <link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.4/material.pink-deep_purple.min.css" />
    <link rel="stylesheet" href="https://storage.googleapis.com/code.getmdl.io/1.0.4/material.cyan-teal.min.css" />
    --%>
    <link rel="shortcut icon" href="${ctx}/static/images/favicon/favicon.ico">
    <link rel="stylesheet" href="${ctx}/static/mdl/fonsts/fonts1.css">
    <link rel="stylesheet" href="${ctx}/static/mdl/fonsts/fonts2.css">
    <link rel="stylesheet" href="${ctx}/static/mdl/material.grey-orange.min.css">

    <link rel="stylesheet" href="${ctx}/static/mdl/styles.css">
    <link rel="stylesheet" href="${ctx}/static/editor.md/css/editormd.preview.css">

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
</div>

<%-- 返回顶部 --%>
<button id="back-to-top"
        class="mdl-button mdl-js-button mdl-button--fab mdl-button--mini-fab mdl-button--colored back-to-top">
    <i class="material-icons">keyboard_arrow_up</i>
</button>

<script src="${ctx}/static/mdl/material.min.js"></script>

<%-- editormd编辑器解析 markdown 文档依赖 js --%>
<script src="${ctx}/static/js/jquery/jquery.min.js"></script>
<script src="${ctx}/static/editor.md/lib/marked.min.js"></script>
<script src="${ctx}/static/editor.md/lib/prettify.min.js"></script>
<script src="${ctx}/static/editor.md/lib/raphael.min.js"></script>
<script src="${ctx}/static/editor.md/lib/underscore.min.js"></script>
<script src="${ctx}/static/editor.md/lib/sequence-diagram.min.js"></script>
<script src="${ctx}/static/editor.md/lib/flowchart.min.js"></script>
<script src="${ctx}/static/editor.md/lib/jquery.flowchart.min.js"></script>
<script src="${ctx}/static/editor.md/editormd.js"></script>
</body>

<script type="text/javascript">

    /*$(window).scroll(function () {
     var isHidden = $('#back-to-top').is(':hidden');
     var height = document.body.offsetHeight;
     var scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
     console.log(scrollTop + '==' + (height - 200));
     if (scrollTop <= 200) {
     $('#back-to-top').animate({
     opacity: "hide"
     }, "slow");
     } else if (scrollTop >= (height - 1000)) {
     if (isHidden == true) {
     $('#back-to-top').animate({
     opacity: "show"
     }, "slow");
     }
     } else {
     scroll(function (direction) {
     if ('down' == direction) {
     if (isHidden == false) {
     $('#back-to-top').animate({
     opacity: "hide"
     }, "slow");
     }
     } else {
     if (isHidden == true) {
     $('#back-to-top').animate({
     opacity: "show"
     }, "slow");
     }
     }
     });
     }
     });*/
    scroll(function (direction) {
        var isHidden = $('#back-to-top').is(':hidden');
        var height = document.body.offsetHeight;
        var scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
        console.log(scrollTop + '==' + (height - 200));
        if (scrollTop <= 200) {
            $('#back-to-top').animate({
                opacity: "hide"
            }, "slow");
        } else if (scrollTop >= (height - 1000)) {
            if (isHidden == true) {
                $('#back-to-top').animate({
                    opacity: "show"
                }, "slow");
            }
        } else {
            if ('down' == direction) {
                if (isHidden == false) {
                    $('#back-to-top').animate({
                        opacity: "hide"
                    }, "slow");
                }
            } else {
                if (isHidden == true) {
                    $('#back-to-top').animate({
                        opacity: "show"
                    }, "slow");
                }
            }
        }
    });
    function scroll(fn) {
        var beforeScrollTop = document.body.scrollTop, fn = fn || function () {
                };
        window.addEventListener("scroll", function () {
            var afterScrollTop = document.body.scrollTop,
                    delta = afterScrollTop - beforeScrollTop;
            if (delta === 0) return false;
            fn(delta > 0 ? "down" : "up");
            beforeScrollTop = afterScrollTop;
        }, false);
    }

    $(function () {
        $('#back-to-top').click(function () {
            $('html, body').animate({
                scrollTop: 0
            }, 500);
        });
        $('.editormd-content').each(function () {
            var divId = $(this).attr('id');
            //var bId = $(this).attr('bId');
            //var content = $('#content-' + bId).text();
            var editormdContent = editormd.markdownToHTML(divId, {
                htmlDecode: "style,script,iframe",
                tocm: true,  // Using [TOCM]
                emoji: true,
                taskList: true,
                tex: true,  // 默认不解析
                flowChart: true,  // 默认不解析
                sequenceDiagram: true   // 默认不解析
            });

            //console.log(editormdContent.getHTML());
            /*editormd.markdownToHTML(divId, {
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
             });*/
        });
    });
</script>
</html>