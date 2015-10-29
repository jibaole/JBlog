<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>评论管理</title>
    <link href="${ctx}/static/styles/admin/comment.css" type="text/css" rel="stylesheet"/>
</head>

<body>
<div class="container">
    <h3 class="page-header">评论管理</h3>

    <form id="searchForm" action="${ctx}/admin/comment/list" method="post">
        <input type="hidden" id="status" name="status" value="${comment.status}"/>
        <input type="hidden" id="pageNum" name="pageNum" value="${page.pageNum}"/>
        <input type="hidden" id="pageSize" name="pageSize" value="${page.pageSize}"/>

        <div class="row div-operate">
            <div class="col-xs-1 col-sm-1 text-left">
                <input type="button" class="btn btn-warning" id="delBtn" value="删除"/>
            </div>
            <div class="col-xs-4 col-sm-7">
                <ul class="nav nav-pills">
                    <li <c:if test="${comment.status==1}">class="active"</c:if>>
                        <a href="javascript:void(0);"
                           onclick="javascript:$('#status').val(1);$('#searchForm').submit();">已通过</a>
                    </li>
                    <li <c:if test="${comment.status==0}">class="active"</c:if>>
                        <a href="javascript:void(0);"
                           onclick="javascript:$('#status').val(0);$('#searchForm').submit();">待审核
                            <c:if test="${waitAuditCount > 0}"><span class="badge">${waitAuditCount}</span></c:if>
                        </a>
                    </li>
                    <li <c:if test="${comment.status==2}">class="active"</c:if>>
                        <a href="javascript:void(0);"
                           onclick="javascript:$('#status').val(2);$('#searchForm').submit();">垃圾</a>
                    </li>
                </ul>
            </div>
            <div class="col-xs-7 col-sm-4 text-right">

                <div class="input-group">
                    <input type="text" class="form-control" name="title" value="${blog.title}" placeholder="输入关键字..."/>
                    <span class="input-group-btn">
                        <button class="btn btn-info" type="submit">筛选</button>
                    </span>
                </div>
            </div>
        </div>
    </form>

    <div class="table-responsive">
        <table id="dataTable" class="table table-hover">
            <colgroup>
                <col width="3%"/>
                <col width="25%"/>
                <col/>
            </colgroup>
            <thead>
            <tr>
                <th><input type="checkbox" id="selectAll"/></th>
                <th>作者</th>
                <th>内容</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${comments}" var="c" varStatus="v">
                <tr id="detailTr_${v.index}">
                    <td><input type="checkbox" name="checkId" value="${c.id}"/></td>
                    <td>
                        <div class="row">
                            <div class="col-xs-4 col-sm-4 comment-gap-3">
                                <a href="#" class="thumbnail">
                                    <img data-src="holder.js/100%x180" alt="100%x180"
                                         src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMTcxIiBoZWlnaHQ9IjE4MCIgdmlld0JveD0iMCAwIDE3MSAxODAiIHByZXNlcnZlQXNwZWN0UmF0aW89Im5vbmUiPjwhLS0KU291cmNlIFVSTDogaG9sZGVyLmpzLzEwMCV4MTgwCkNyZWF0ZWQgd2l0aCBIb2xkZXIuanMgMi42LjAuCkxlYXJuIG1vcmUgYXQgaHR0cDovL2hvbGRlcmpzLmNvbQooYykgMjAxMi0yMDE1IEl2YW4gTWFsb3BpbnNreSAtIGh0dHA6Ly9pbXNreS5jbwotLT48ZGVmcz48c3R5bGUgdHlwZT0idGV4dC9jc3MiPjwhW0NEQVRBWyNob2xkZXJfMTRlYWMxMWFjYjMgdGV4dCB7IGZpbGw6I0FBQUFBQTtmb250LXdlaWdodDpib2xkO2ZvbnQtZmFtaWx5OkFyaWFsLCBIZWx2ZXRpY2EsIE9wZW4gU2Fucywgc2Fucy1zZXJpZiwgbW9ub3NwYWNlO2ZvbnQtc2l6ZToxMHB0IH0gXV0+PC9zdHlsZT48L2RlZnM+PGcgaWQ9ImhvbGRlcl8xNGVhYzExYWNiMyI+PHJlY3Qgd2lkdGg9IjE3MSIgaGVpZ2h0PSIxODAiIGZpbGw9IiNFRUVFRUUiLz48Zz48dGV4dCB4PSI2MSIgeT0iOTQuNSI+MTcxeDE4MDwvdGV4dD48L2c+PC9nPjwvc3ZnPg=="
                                         data-holder-rendered="true">
                                </a>
                            </div>
                            <div class="col-xs-8 col-sm-8 comment-gap-3">
                                <div>
                                    <strong>
                                        <c:if test="${c.userId != null}">
                                            <a href="${ctx}/${c.userId}" target="_blank">${c.author}</a>
                                        </c:if>
                                        <c:if test="${c.userId == null}">${c.author}</c:if>
                                    </strong>
                                </div>
                                <div><a href="mailto:${c.email}" target="_blank">${c.email}</a></div>
                                <div>${c.ip}</div>
                            </div>
                        </div>
                    </td>
                    <td class="comment-gap-6">
                        <div class="comment-article">
                            <fmt:formatDate value="${c.createdDate}" pattern="M月dd日 HH:mm"/> 于
                            <a href="http://localhost/index.php/archives/1/#comment-17" target="_blank">
                                欢迎使用 Typecho</a>
                        </div>
                        <div>${c.content}</div>
                        <div id="replyDiv_${v.index}" style="display: none;">
                            <form id="saveForm_${v.index}" action="${ctx}/admin/comment/reply" method="post">
                                <input type="hidden" name="parentId" value="${c.id}"/>

                                <div class="form-group">
                                    <textarea class="form-control" name="content" rows="3"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">提交</button>
                                <button type="button" class="btn btn-default"
                                        onclick="javascript:$('#replyDiv_'+${v.index}).hide();">取消
                                </button>
                            </form>
                        </div>
                        <div class="hidden-by-mouse">
                            <c:choose>
                                <c:when test="${c.status==1}">
                                    <span>通过</span>
                                    <a href="javascript:void(0);" onclick="audit(${c.id}, 0)">待审核</a>
                                    <a href="javascript:void(0);" onclick="audit(${c.id}, 2)">垃圾</a>
                                </c:when>
                                <c:when test="${c.status==0}">
                                    <a href="javascript:void(0);" onclick="audit(${c.id}, 1)">通过</a>
                                    <span>待审核</span>
                                    <a href="javascript:void(0);" onclick="audit(${c.id}, 2)">垃圾</a>
                                </c:when>
                                <c:when test="${c.status==2}">
                                    <a href="javascript:void(0);" onclick="audit(${c.id}, 1)">通过</a>
                                    <a href="javascript:void(0);" onclick="audit(${c.id}, 0)">待审核</a>
                                    <span>垃圾</span>
                                </c:when>
                            </c:choose>
                            <a href="javascript:void(0);" id="${c.id}" index="${v.index}" class="operate-edit">编辑</a>
                            <a href="javascript:void(0);" id="${c.id}" index="${v.index}" class="operate-reply">回复</a>
                            <a href="javascript:void(0);" id="${c.id}" class="operate-delete">删除</a>
                        </div>
                    </td>
                </tr>

                <tr id="editTr_${v.index}" style="display: none;">
                    <td colspan="3">
                        <form id="editForm_${v.index}" action="${ctx}/admin/comment/edit" method="post">
                            <input type="hidden" name="id" value="${c.id}"/>

                            <div class="row edit-div">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label>用户名</label>
                                        <input type="text" class="form-control" name="author" value="${c.author}"/>
                                    </div>
                                    <div class="form-group">
                                        <label>邮箱</label>
                                        <input type="email" class="form-control" name="email" value="${c.email}"/>
                                    </div>
                                    <div class="form-group">
                                        <label>个人主页</label>
                                        <input type="text" class="form-control" name="url" value="${c.url}"/>
                                    </div>
                                </div>
                                <div class="col-sm-8">
                                    <div class="form-group">
                                        <label>内容</label>
                                        <textarea class="form-control" name="content" rows="6">${c.content}</textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">提交</button>
                                    <button type="button" class="btn btn-default btn-cancel" index="${v.index}">取消
                                    </button>
                                </div>
                            </div>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

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
</div>

<script type="text/javascript">
    $(function () {
        $("#selectAll").click(function () {
            $('#dataTable [name="checkId"]:checkbox').each(function () {
                this.checked = !this.checked;
            });
        });

        $("#delBtn").click(function () {
            var ids = new Array;
            $('#dataTable input[name="checkId"]:checked').each(function (i) {
                ids[i] = $(this).val();
            });
            delComment(ids.join(','));
        });

        $(".operate-edit").click(function () {
            var index = $(this).attr('index');
            $('#detailTr_' + index).hide();
            $('#editTr_' + index).show();
        });

        $('.btn-cancel').click(function () {
            var index = $(this).attr('index');
            $('#editTr_' + index).hide();
            $('#detailTr_' + index).show();
        });

        $(".operate-reply").click(function () {
            var index = $(this).attr('index');
            if ('none' == $('#replyDiv_' + index).css('display')) {
                $('#replyDiv_' + index).show();
            } else {
                $('#replyDiv_' + index).hide();
            }
        });

        $(".operate-delete").click(function () {
            var ids = $(this).attr('id');
            delComment(ids);
        });
    });

    function audit(id, status) {
        var data = {id: id, status: status};
        var url = _ctx + '/admin/comment/audit';
        $.get(url, data, function (result) {
            if ("success" == result) {
                $('#searchForm').submit();
            } else {
                alert('哦no,炒蛋的系统,在挂一次我真的立马走人!');
            }
        });
    }

    function delComment(ids) {
        if (confirm('确认要删除评论?')) {
            var data = {ids: ids};
            var url = _ctx + '/admin/comment/del';
            $.get(url, data, function (result) {
                if ("success" == result) {
                    $('#searchForm').submit();
                } else {
                    alert('哦,操蛋的系统,搞评论又挂了,走了走了,不玩了!');
                }
            });
        }
    }

    function goto(pageNum) {
        $('#pageNum').val(pageNum);
        $('#searchForm').submit();
    }

</script>
</body>
</html>
