<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="p" uri="http://caliven.com/tags/page" %>

<html>
<head>
    <title>JBlog-博文管理</title>
</head>

<body>
<div class="container">
    <h3 class="page-header">博文管理</h3>

    <form id="searchForm" action="${ctx}/admin/article/list" method="post">
        <div class="row div-operate">
            <div class="col-xs-5 col-sm-8 text-left">
                <input type="button" class="btn btn-info" id="addBtn" value="新增"/>
                <input type="button" class="btn btn-warning" id="delBtn" value="删除"/>
            </div>
            <div class="col-xs-7 col-sm-4 text-right">
                <div class="input-group">
                    <input type="hidden" id="categroyId" name="categroyId" value="${blog.categroyId}"/>

                    <input type="text" class="form-control" name="title" value="${blog.title}" placeholder="输入关键字..."/>

                    <div class="input-group-btn">
                        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false"><span id="categroyName">分类</span> <span
                                class="caret"></span>
                        </button>
                        <ul id="dropdown-menu" class="dropdown-menu">
                            <li <c:if test="${blog.categroyId==null}">class="active"</c:if>><a href="#" val="">所有分类</a>
                            </li>
                            <c:forEach items="${treeList}" var="c" varStatus="v">
                                <c:if test="${c.parentId != 0}">
                                    <li <c:if test="${c.id==blog.categroyId}">class="active"</c:if>>
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
                        <button class="btn btn-info" type="submit">筛选</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <div class="table-responsive">
        <table id="dataTable" class="table table-hover">
            <colgroup>
                <col width="3%"/>
                <col width="3%"/>
                <col width="47%"/>
                <col width="20%"/>
                <col width="15%"/>
                <col width="12%"/>
            </colgroup>
            <thead>
            <tr>
                <th><input type="checkbox" id="selectAll"/></th>
                <th></th>
                <th>标题</th>
                <th>分类</th>
                <th>作者</th>
                <th>日期</th>
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
                    <td>${b.categoryNames}</td>
                    <td>${b.user.username} / ${b.user.nickname}</td>
                    <td>${b.relativeTime}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <p:page pn="${page.pn}" ps="${page.ps}" rct="${page.rct}"/>
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
            if(ids.length <= 0){
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

        $('#dropdown-menu a').click(function () {
            var value = $(this).attr('val');
            var text = $(this).text();
            $('#categroyName').text(text);
            $('#categroyId').val(value);
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
