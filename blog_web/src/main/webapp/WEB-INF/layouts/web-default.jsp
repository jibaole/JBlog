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
    <meta name="renderer" content="webkit">
    <title><sitemesh:title/></title>
    <meta name="keywords" content="Java技术博客,个人博客,技术博客,Caliven,闲想录">
    <meta name="description" content="技术人文-闲想录，分享技术，亦可探讨生活。">

    <link href="${ctx}/static/images/favicon/favicon.ico" type="image/x-icon" rel="shortcut icon"/>
    <link href="${ctx}/static/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>

    <link href="${ctx}/static/editor.md/css/editormd.preview.css" type="text/css" rel="stylesheet" />

    <link href="${ctx}/static/styles/web/common.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/styles/web/index.css" type="text/css" rel="stylesheet"/>

    <script src="${ctx}/static/js/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/jquery/jquery.backstretch.min.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
    <script src="${ctx}/static/js/plugin/ie8-responsive-file-warning.js"></script>
    <![endif]-->
    <script src="${ctx}/static/js/plugin/ie-emulation-modes-warning.js"></script>
    <!--[if lt IE 9]>
    <script src="${ctx}/static/js/plugin/html5shiv.min.js"></script>
    <script src="${ctx}/static/js/plugin/respond.min.js"></script>
    <![endif]-->


    <script src="${ctx}/static/editor.md/lib/marked.min.js"></script>
    <script src="${ctx}/static/editor.md/lib/prettify.min.js"></script>

    <script src="${ctx}/static/editor.md/lib/raphael.min.js"></script>
    <script src="${ctx}/static/editor.md/lib/underscore.min.js"></script>
    <script src="${ctx}/static/editor.md/lib/sequence-diagram.min.js"></script>
    <script src="${ctx}/static/editor.md/lib/flowchart.min.js"></script>
    <script src="${ctx}/static/editor.md/lib/jquery.flowchart.min.js"></script>

    <script src="${ctx}/static/editor.md/editormd.js"></script>

    <script language="javascript">
        var _ctx = '${ctx}';
    </script>
    <sitemesh:head/>
</head>

<body>
<%--<jsp:include page="web-top.jsp" flush="true"/>--%>

<div class="container">
    <div class="blog-header">
        <h2 class="blog-title"><a href="${ctx}">闲想录</a></h2>

        <p class="lead blog-description">源于技术不止于技术.</p>
    </div>
    <div class="row">
        <div class="col-sm-8 blog-main">
            <sitemesh:body/>
        </div>
        <div class="col-sm-3 col-sm-offset-1 blog-sidebar">
            <jsp:include page="web-right.jsp" flush="true"/>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/layouts/web-footer.jsp" %>


<script src="${ctx}/static/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<%--
    <script type="text/javascript" src="${ctx}/static/bootstrap/markdown/js/markdown.js"></script>
    <script type="text/javascript" src="${ctx}/static/bootstrap/markdown/js/to-markdown.js"></script>
--%>
<!--[if lt IE 10]>
<script type="text/javascript" src="${ctx}/static/js/plugin/ie10-viewport-bug-workaround.js"></script>
<![endif]-->
<script type="text/javascript">
    //$.backstretch(_ctx + "/static/images/bg.jpg");
</script>
</body>
</html>