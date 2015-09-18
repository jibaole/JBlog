<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="p" uri="http://caliven.com/tags/page" %>

<html>
<head>
    <title>JBlog-分类管理</title>
</head>

<body>
<div class="container">
    <h3 class="page-header">
        <c:if test="${parentCategroy!=null}">
            <a href="${ctx}/admin/category/list?parentId=${parentCategroy.parentId}" title="返回">
                《&nbsp;管理&nbsp;${parentCategroy.name}&nbsp;的子分类
            </a>
        </c:if>
        <c:if test="${parentCategroy==null}">分类管理</c:if>
        <input type="hidden" id="parentId" value="${parentCategroy.id}"/>
    </h3>

    <form id="searchForm" action="${ctx}/admin/category/list" method="get">
        <div class="row div-operate">
            <div class="col-xs-5 col-sm-8 text-left">
                <input type="button" class="btn btn-info" id="addBtn" value="新增"/>
                <input type="button" class="btn btn-warning" id="delBtn" value="删除"/>
            </div>
            <div class="col-xs-7 col-sm-4 text-right">
                <div class="input-group">
                    <input type="text" class="form-control" name="name" value="${categroy.name}"
                           onkeyup="search(event)" placeholder="输入关键字..."/>
                    <span class="input-group-btn">
                        <button class="btn btn-info" type="submit">筛选</button>
                    </span>
                </div>
            </div>
        </div>
    </form>

    <div class="table-responsive">
        <table id="dataTable" class="table table-hover">
            <thead>
            <tr>
                <th><input type="checkbox" id="selectAll"/></th>
                <th>名称</th>
                <th>缩略名</th>
                <th>子分类</th>
                <th></th>
                <th>文章数</th>
                <shiro:hasRole name="admin">
                    <th>所属用户</th>
                </shiro:hasRole>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${categroys}" var="cate" varStatus="v">
                <tr>
                    <td><input type="checkbox" name="checkId" value="${cate.id}"/></td>
                    <td>
                        <a href="${ctx}/admin/category/edit?id=${cate.id}">${cate.name}</a>
                        <a href="" class="a-exlink" title="浏览${cate.name}"></a>
                    </td>
                    <td>${cate.slug}</td>
                    <td>
                        <c:if test="${cate.childrenNum==null || cate.childrenNum==0}">
                            <a href="${ctx}/admin/category/edit?parentId=${cate.id}">新增</a>
                        </c:if>
                        <c:if test="${cate.childrenNum > 0}">
                            <a href="${ctx}/admin/category/list?parentId=${cate.id}">${cate.childrenNum}个子分类</a>
                        </c:if>
                    </td>
                    <td><a href="${ctx}/admin/category/list?parentId=${cate.id}">默认</a></td>
                    <td>
                        <a href="${ctx}/admin/blog/list?categroyId=${cate.id}" class="balloon-button"
                           title="${cate.blogNum}篇文章">${cate.blogNum}</a>
                    </td>
                    <shiro:hasRole name="admin">
                        <td>${cate.username}</td>
                    </shiro:hasRole>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <p:page pn="${page.pn}" ps="${page.ps}" rct="${page.rct}"/>
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
    </nav>--%>
</div>

<script type="text/javascript">
    $(function () {
        $("#selectAll").click(function () {
            $('#cateTable [name="checkId"]:checkbox').each(function () {
                this.checked = !this.checked;
            });
        });
        $("#addBtn").click(function () {
            var url = _ctx + '/admin/category/edit';
            var parentId = $('#parentId').val();
            if (undefined != parentId && '' != parentId) {
                url += '?parentId=' + parentId;
            }
            location.href = url;
        });

        $("#delBtn").click(function () {
            if (confirm("此分类下所有子分类将被删除，博文关联分类将被取消，确认删除这些分类？")) {
                var ids = new Array;
                $('#dataTable input[name="checkId"]:checked').each(function (i) {
                    ids[i] = $(this).val();
                });
                var data = {ids: ids.join(',')};
                var url = _ctx + '/admin/category/del';
                $.get(url, data, function (result) {
                    if ("success" == result) {
                        location.href = location.href;
                    } else {
                        alert('看来程序猿又加班写了些烂代码!');
                    }
                });
            }
        });
    });

    function search() {
        if (event.keyCode == 13) {
            $('#pageNum').val(1);
            $('#searchForm').submit();
        }
    }

    function goto(pageNum) {
        $('#pageNum').val(pageNum);
        $('#searchForm').submit();
    }
</script>
</body>
</html>
