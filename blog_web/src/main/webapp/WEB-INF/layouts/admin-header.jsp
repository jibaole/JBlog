<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<nav id="top-nav" class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${ctx}/admin/index">闲想录</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="dropdown <c:if test="${navbar == 1}">dropdown-select</c:if>">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true" aria-expanded="true">
                        控制台 <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${ctx}/admin/index">概要</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="#">个人设置</a></li>
                    </ul>
                </li>
                <li class="dropdown <c:if test="${navbar == 2}">dropdown-select</c:if>">
                    <a href="${ctx}/admin/article/edit">撰写文章</a>
                    <%--
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true" aria-expanded="false">
                        撰写 <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${ctx}/admin/article/edit">撰写文章</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${ctx}/admin/index">创建页面</a></li>
                    </ul>--%>
                </li>
                <li class="dropdown <c:if test="${navbar == 3}">dropdown-select</c:if>">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true" aria-expanded="false">
                        管理 <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${ctx}/admin/article/list">文章</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${ctx}/admin/index">独立页面</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${ctx}/admin/category/list">分类</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${ctx}/admin/tag/list">标签</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${ctx}/admin/file/list">文件</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${ctx}/admin/user/list">用户</a></li>
                    </ul>
                </li>
                <li class="dropdown <c:if test="${navbar == 4}">dropdown-select</c:if>">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true" aria-expanded="false">
                        设置 <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${ctx}/admin/setting/list">基本</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${ctx}/admin/indie/list">评论</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${ctx}/admin/comment/list">阅读</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a href="${ctx}/admin/category/clist">永久衔接</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="${ctx}/admin/setting"><shiro:principal property="nickname"/></a></li>
                <li><a href="${ctx}/logout">登出</a></li>
                <li><a href="${ctx}/" target="_blank">网站</a></li>
            </ul>
            <%--<form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>--%>
        </div>
    </div>
</nav>