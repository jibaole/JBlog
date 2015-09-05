<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<html>
<head>
    <title>JBlog-控制台</title>
</head>

<body>
<div class="container">
    <h3 class="page-header">网站概要</h3>

    <div class="row placeholders">
        <div class="col-xs-6 col-sm-3 placeholder">
            <img data-src="holder.js/80x80?text=${num.blogNum}&theme=sky" class="img-responsive">
            <h5><a href="${ctx}/admin/article/list">文章数</a></h5>
        </div>
        <div class="col-xs-6 col-sm-3 placeholder">
            <img data-src="holder.js/80x80?text=${num.commentNum}&theme=industrial" class="img-responsive">
            <h5><a href="${ctx}/admin/comment/list">评论数</a></h5>
        </div>
        <div class="col-xs-6 col-sm-3 placeholder">
            <img data-src="holder.js/80x80?text=${num.noAuditNum}&theme=lava" class="img-responsive">
            <shiro:hasRole name="admin">
                <h5><a href="${ctx}/admin/article/audits">待审核文章</a></h5>
            </shiro:hasRole>
            <shiro:hasRole name="user">
                <h5><a href="${ctx}/admin/comment/audits">待审核评论</a></h5>
            </shiro:hasRole>
        </div>
        <div class="col-xs-6 col-sm-3 placeholder">
            <img data-src="holder.js/80x80?text=${num.categoryNum}&theme=social" class="img-responsive">
            <h5><a href="${ctx}/admin/category/list">分类数</a></h5>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12 col-sm-6">
            <h4 class="sub-header">【最近发布的文章】</h4>

            <div class="table-responsive">
                <table class="table table-hover">
                    <colgroup>
                        <col width="20%"/>
                        <col width="60%"/>
                        <col width="20%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>时间</th>
                        <th>标题</th>
                        <th>作者</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${blogs}" var="blog" varStatus="v">
                        <tr>
                            <td><fmt:formatDate value="${blog.createdDate}" pattern="yyyy-MM-dd"
                                                dateStyle="default"/></td>
                            <td title="${blog.title}"><a href="${ctx}/admin/article/edit?id=${blog.id}">${blog.title}</a></td>
                            <td title="${blog.user.nickname}"><a href="${ctx}/admin/user/edit?id=${blog.user.id}">${blog.user.nickname}</a></td>
                        </tr>
                    </c:forEach>晚上
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-xs-12 col-sm-6">
            <h4 class="sub-header">【最近得到的回复】</h4>

            <div class="table-responsive">
                <table class="table table-hover">
                    <colgroup>
                        <col width="45%"/>
                        <col width="20%"/>
                        <col width="25%"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>内容</th>
                        <th>作者</th>
                        <th>时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${comments}" var="comment" varStatus="v">
                        <tr>
                            <td>${comment.content}</td>
                            <td>${comment.author}</td>
                            <td><fmt:formatDate value="${comment.createdDate}" pattern="yyyy-MM-dd" dateStyle="default"/></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="${ctx}/static/js/plugin/holder.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/admin/index.js" type="text/javascript"></script>
</body>
</html>
