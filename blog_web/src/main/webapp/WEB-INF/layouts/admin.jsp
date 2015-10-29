<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <%-- 针对老版本IE渲染 --%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <%-- 针对手机浏览器适配 --%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%-- 部分国产浏览器默认采用高速模式渲染页面 --%>
    <meta name="renderer" content="webkit">

    <title><sitemesh:title/> | 闲想录</title>
    <script type="text/javascript">var _ctx = '${ctx}';</script>

    <link type="image/x-icon" rel="shortcut icon" href="${ctx}/static/images/favicon/favicon.ico"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/static/bootstrap/css/bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/static/styles/admin/common.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/static/styles/admin/index.css"/>

    <script type="text/javascript" src="${ctx}/static/js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/bootstrap/js/bootstrap.min.js"></script>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="${ctx}/static/js/plugin/ie8-responsive-file-warning.js"></script>
    <![endif]-->
    <script src="${ctx}/static/js/plugin/ie-emulation-modes-warning.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="${ctx}/static/js/plugin/html5shiv.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/plugin/respond.min.js"></script>
    <![endif]-->
    <sitemesh:head/>
</head>

<body>

<jsp:include page="/WEB-INF/layouts/header.jsp" flush="true"/>
<sitemesh:body/>

<!--[if lt IE 10]>
<script type="text/javascript" src="${ctx}/static/js/plugin/ie10-viewport-bug-workaround.js"></script>
<![endif]-->
</body>
</html>