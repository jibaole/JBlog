<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="p" uri="http://caliven.com/tags/page" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<c:set var="navbar" value="3" scope="request"/>

<html>
<head>
    <title>文章管理</title>
</head>

<body>
<div class="container">
    <h3 class="page-header">博文管理</h3>

    <form id="searchForm" action="${ctx}/admin/article/list" method="post">
        <input type="hidden" id="type" name="type" value="${blog.type}"/>
        <input type="hidden" id="categroyTagId" name="categroyTagId" value="${blog.categroyTagId}"/>

        <div class="row div-operate">
            <div class="col-xs-5 col-sm-7">
                <input type="button" class="btn btn-info" id="addBtn" value="新增"/>
                <input type="button" class="btn btn-warning" id="delBtn" value="删除"/>
            </div>
            <div class="col-xs-7 col-sm-5">
                <div class="input-group">
                    <input type="text" class="form-control" name="title" value="${blog.title}" placeholder="输入关键字..."/>

                    <div class="input-group-btn">
                        <div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                                    aria-haspopup="true" aria-expanded="false">
                                <span id="typeName"></span><span class="caret"></span>
                            </button>
                            <ul id="type-dropdown-menu" class="dropdown-menu">
                                <li <c:if test="${blog.type==1}">class="active"</c:if>>
                                    <a href="#" val="1">文章</a>
                                </li>
                                <li <c:if test="${blog.type==0}">class="active"</c:if>>
                                    <a href="#" val="0">其他类型</a>
                                </li>
                            </ul>
                        </div>

                        <div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                                    aria-haspopup="true" aria-expanded="false">
                                <span id="categroyTagName"></span><span class="caret"></span>
                            </button>
                            <ul id="dropdown-menu" class="dropdown-menu">
                                <li <c:if test="${blog.categroyTagId==null}">class="active"</c:if>>
                                    <a href="#" val="">所有分类</a>
                                </li>
                                <c:forEach items="${treeList}" var="c" varStatus="v">
                                    <c:if test="${c.parentId != 0}">
                                        <li <c:if test="${c.id==blog.categroyTagId}">class="active"</c:if>>
                                            <a href="#" val="${c.id}">
                                                <c:choose>
                                                    <c:when test="${c.level==2}">&nbsp;&nbsp;</c:when>
                                                    <c:when test="${c.level==3}">&nbsp;&nbsp;&nbsp;&nbsp;</c:when>
                                                    <c:when test="${c.level==4}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:when>
                                                    <c:when test="${c.level==5}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:when>
                                                </c:choose>${c.name}
                                            </a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                        <button class="btn btn-info" type="submit">筛选</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="table-responsive">
            <table id="dataTable" class="table table-hover">
                <colgroup>
                    <col width="3%"/>
                    <col width="3%"/>
                    <col width="50%"/>
                    <col width="20%"/>
                    <col width="10%"/>
                    <col width="14%"/>
                </colgroup>
                <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll"/></th>
                    <th></th>
                    <th>标题</th>
                    <th>分类</th>
                    <th>作者</th>
                    <th>发表日期</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${blogs}" var="b" varStatus="v">
                    <tr>
                        <td><input type="checkbox" name="checkId" value="${b.id}"/></td>
                        <td><a href="${ctx}/admin/article/list" class="balloon-button"
                               title="${b.commentNum}评论">${b.commentNum}</a></td>
                        <td>
                            <c:if test="${b.isDraft==true}">
                                <small class="text-muted">[草稿]</small>
                            </c:if>
                            <a href="${ctx}/admin/article/edit?id=${b.id}">${b.title}</a>
                            <a href="${ctx}/article/${b.id}" class="a-exlink" target="_blank" title="浏览文章"></a>
                        </td>
                        <td>
                            <c:if test="${b.type==1}">${b.categoryNames}</c:if>
                            <c:if test="${b.type==2}">独立页面</c:if>
                            <c:if test="${b.type==3}">关于我页面</c:if>
                            <c:if test="${b.type==4}">留言板页面</c:if>
                        </td>
                        <td>${b.user.username}</td>
                        <td title="${b.relativeTime}">
                            <fmt:formatDate value="${b.createdDate}" pattern="yyyy-MM-dd HH:mm"/>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <p:page pn="${page.pn}" ps="${page.ps}" rct="${page.rct}"/>
    </form>
</div>

<script type="text/javascript">
    $(function () {
        $("#selectAll").click(function () {
            $('#dataTable [name="checkId"]:checkbox').each(function () {
                this.checked = !this.checked;
            });
        });
        $("#addBtn").click(function () {
            location.href = _ctx + '/admin/article/edit';
        });

        $("#delBtn").click(function () {
            var ids = new Array;
            $('#dataTable input[name="checkId"]:checked').each(function (i) {
                ids[i] = $(this).val();
            });
            if (ids.length <= 0) {
                return;
            }
            if (confirm('确定这么干？')) {
                var data = {ids: ids.join(',')};
                var url = _ctx + '/admin/article/del';
                $.get(url, data, function (result) {
                    if ("success" == result) {
                        location.href = location.href;
                    } else {
                        alert('哦no,炒蛋的系统,在挂一次我立马走人!');
                    }
                });
            }
        });
        var typeName = $('#type-dropdown-menu li[class="active"] a').text();
        var categroyTagName = $('#dropdown-menu li[class="active"] a').text();
        $('#typeName').text($.trim(typeName));
        $('#categroyTagName').text($.trim(categroyTagName));

        $('#type-dropdown-menu a').click(function () {
            var value = $(this).attr('val');
            var text = $(this).text();
            $('#type').val(value);
            $('#categroyTagId').val('');
            $('#searchForm').submit();
        });

        $('#dropdown-menu a').click(function () {
            var value = $(this).attr('val');
            var text = $(this).text();
            $('#type').val('1');
            $('#categroyTagId').val(value);
            $('#searchForm').submit();
        });
    })
    ;

    function goto(pageNum) {
        $('#pageNum').val(pageNum);
        $('#searchForm').submit();
    }

</script>
</body>
</html>
