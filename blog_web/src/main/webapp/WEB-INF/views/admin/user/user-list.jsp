<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="p" uri="http://caliven.com/tags/page" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<c:set var="navbar" value="6" scope="request"/>

<html>
<head>
    <title>用户管理</title>
</head>

<body>
<div class="container">
    <h3 class="page-header">用户管理</h3>

    <form id="searchForm" action="${ctx}/admin/user/list" method="post">
        <div class="row div-operate">
            <div class="col-xs-5 col-sm-8 text-left">
                <input type="button" class="btn btn-info" id="addBtn" value="新增"/>
                <input type="button" class="btn btn-success" id="activeBtn" value="激活"/>
                <input type="button" class="btn btn-warning" id="closeBtn" value="关闭"
                       title="关闭用户后, 用户将无法登陆, 所有博文在网站上将无法查看, 当然管理员可以."/>
            </div>
            <div class="col-xs-7 col-sm-4 text-right">
                <div class="input-group">
                    <input type="text" class="form-control" name="search" value="${search.search}"
                           onkeyup="searchUser(event)" placeholder="输入关键字..."/>
                    <input type="hidden" id="roles" name="roles" value="${search.roles}"/>

                    <div class="input-group-btn">
                        <div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                                    aria-haspopup="true" aria-expanded="false"><span
                                    id="roleName">${roleName}</span> <span
                                    class="caret"></span>
                            </button>
                            <ul id="dropdown-menu" class="dropdown-menu">
                                <li <c:if test="${search.roles==1}">class="active"</c:if>><a href="#" val="1">管理员</a>
                                </li>
                                <li <c:if test="${search.roles==2}">class="active"</c:if>><a href="#" val="2">贡献者</a>
                                </li>
                                <li <c:if test="${search.roles==3}">class="active"</c:if>><a href="#" val="3">编辑</a>
                                </li>
                                <li <c:if test="${search.roles==4}">class="active"</c:if>><a href="#" val="4">关注者</a>
                                </li>
                                <li <c:if test="${search.roles==null}">class="active"</c:if>><a href="#" val="">所有角色</a>
                                </li>
                            </ul>
                        </div>
                        <button class="btn btn-info" type="submit">筛选</button>
                    </div>
                </div>
            </div>
        </div>

        <div id="table-responsive" class="table-responsive">
            <table id="dataTable" class="table table-hover">
                <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll"/></th>
                    <th></th>
                    <th>用户名</th>
                    <th>昵称</th>
                    <th>邮箱</th>
                    <th>主页</th>
                    <th>角色</th>
                    <th>注册时间</th>
                    <th>最后登录时间</th>
                    <th>状态</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user" varStatus="v">
                    <tr>
                        <td><input type="checkbox" name="checkId" value="${user.id}"/></td>
                        <td><a href="${ctx}/admin/blog/list" class="balloon-button"
                               title="${user.blogNum}篇文章">${user.blogNum}</a></td>
                        <td>
                            <a href="${ctx}/admin/user/edit?id=${user.id}">${user.username}</a>
                            <a href="" class="a-exlink" title="浏览${user.username}"></a>
                        </td>
                        <td>${user.nickname}</td>
                        <td><a href="mailto:${user.email}" target="_blank">${user.email}</a></td>
                        <td><a href="${user.url}" target="_blank">${user.url}</a></td>
                        <td>
                            <c:choose>
                                <c:when test="${user.roles==1}">管理员</c:when>
                                <c:when test="${user.roles==2}">贡献者</c:when>
                                <c:when test="${user.roles==3}">编辑</c:when>
                                <c:when test="${user.roles==4}">关注着</c:when>
                            </c:choose>
                        </td>
                        <td><fmt:formatDate value="${user.createdDate}" pattern="yyyy-MM-dd"/></td>
                        <td><fmt:formatDate value="${user.lastLoginDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td><c:if test="${user.status==true}">有效</c:if><c:if test="${user.status==false}">关闭</c:if></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <p:page pn="${page.pn}" ps="${page.ps}" rct="${page.rct}"/>
    </form>
    <%--
    <nav class="text-center">
        <ul class="pagination">
            <c:if test="${page.pageNum > 1}">
                <li>
                    <a href="javascript:void(0)" onclick="goto(${page.pageNum-1})" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
            </c:if>
            <c:forEach items="${page.navigatepageNums}" varStatus="v">
                <li <c:if test="${page.pageNum == v.index+1}">class="active"</c:if>>
                    <a href="javascript:void(0)" onclick="goto(${v.index+1})">${v.index+1}</a>
                </li>
            </c:forEach>
            <c:if test="${page.pageNum < page.pages}">
                <li>
                    <a href="javascript:void(0)" onclick="goto(${page.pageNum+1})" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
    --%>
</div>

<script type="text/javascript">
    $(function () {
        $("#selectAll").click(function () {
            $('#dataTable [name="checkId"]:checkbox').each(function () {
                this.checked = !this.checked;
            });
        });
        $("#addBtn").click(function () {
            location.href = _ctx + '/admin/user/edit';
        });

        $("#activeBtn").click(function () {
            operaterUser(1);
        });
        $("#closeBtn").click(function () {
            operaterUser(0);
        });

        $('#dropdown-menu a').click(function () {
            var value = $(this).attr('val');
            var text = $(this).text();
            $('#roleName').text(text);
            $('#roles').val(value);
            $('#searchForm').submit();
        });
    });

    function searchUser() {
        if (event.keyCode == 13) {
            $('#pageNum').val(1);
            $('#searchForm').submit();
        }
    }

    function operaterUser(status) {
        var ids = new Array;
        $('#dataTable input[name="checkId"]:checked').each(function (i) {
            ids[i] = $(this).val();
        });
        var data = {ids: ids.join(','), status: status};
        var url = _ctx + '/admin/user/del';
        $.post(url, data, function (result) {
            if ("success" == result) {
                window.location.href = location.href;
            } else {
                var tips = status == 1 ? "激活" : "失效";
                alert(tips + '失败，原因我也不知，可能加班加傻了!');
            }
        });
    }

    function goto(pageNum) {
        $('#pageNum').val(pageNum);
        $('#searchForm').submit();
    }
</script>
</body>
</html>
