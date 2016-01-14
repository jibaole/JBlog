<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="p" uri="http://caliven.com/tags/page" %>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<c:set var="navbar" value="7" scope="request"/>

<html>
<head>
    <title>文件管理</title>
</head>

<body>
<div class="container">
    <h3 class="page-header">文件管理</h3>

    <form id="searchForm" action="${ctx}/admin/file/list" method="post">
        <div class="row div-operate">
            <div class="col-xs-5 col-sm-6">
                <c:if test="${file.isDeleted==false}">
                    <input type="button" class="btn btn-warning" id="deleteBtn" value="删除"/>
                </c:if>
                <c:if test="${file.isDeleted==true}">
                    <input type="button" class="btn btn-warning" id="recoveryBtn" value="恢复"/>
                </c:if>
            </div>
            <div class="col-xs-2 col-sm-2">
                <div class="input-group">
                    <input type="text" class="form-control" name="entityId" value="${file.entityId}"
                           placeholder="输入文章ID..."/>
                </div>
            </div>
            <div class="col-xs-5 col-sm-4">
                <div class="input-group">

                    <input type="hidden" id="isDeleted" name="isDeleted" value="${file.isDeleted}"/>
                    <input type="text" class="form-control" name="fileName" value="${file.fileName}"
                           placeholder="输入关键字..."/>

                    <div class="input-group-btn">
                        <div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                                    aria-haspopup="true" aria-expanded="false">
                            <span id="deleteName"><c:if test="${file.isDeleted==false}">未</c:if><c:if
                                    test="${file.isDeleted==true}">已</c:if>删除</span>
                                <span class="caret"></span>
                            </button>
                            <ul id="dropdown-menu" class="dropdown-menu">
                                <li <c:if test="${file.isDeleted==false}">class="active"</c:if>>
                                    <a href="#" val="false">未删除</a>
                                </li>
                                <li <c:if test="${file.isDeleted==true}">class="active"</c:if>>
                                    <a href="#" val="true">已删除</a>
                                </li>
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
                    <col width="15%"/>
                    <col width="6%"/>
                    <col width="40%"/>
                    <col width="6%"/>
                    <col width="8%"/>
                    <col width="15%"/>
                    <col width="7%"/>
                </colgroup>
                <thead>
                <tr>
                    <th><input type="checkbox" id="selectAll"/></th>
                    <th>真实名</th>
                    <th>文章</th>
                    <th>路径</th>
                    <th>大小</th>
                    <th>类型</th>
                    <th>上传日期</th>
                    <th>操作</th>
                </tr>
                <tbody>
                <c:forEach items="${files}" var="f" varStatus="v">
                    <tr>
                        <td><input type="checkbox" name="checkId" value="${f.id}"/></td>
                        <td>${f.fileRealName}</td>
                        <td>
                            <a target="_blank" href="${ctx}/admin/article/edit?id=${f.entityId}"
                               title="编辑文章">${f.entityId}</a>
                            <a href="${ctx}/article/${f.entityId}" class="a-exlink" target="_blank" title="浏览文章"></a>
                        </td>
                        <td><a target="_blank" href="${f.filePath}">${f.filePath}</a></td>
                        <td>${f.fileSize}</td>
                        <td>${f.fileType}</td>
                        <td><fmt:formatDate value="${f.createdDate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
                        <td>
                            <c:if test="${!f.isDeleted}">
                                <a href="javascript:;" onclick="deleteFile(${f.id});">删除</a>
                            </c:if>
                            <c:if test="${f.isDeleted}">
                                <a href="javascript:;" onclick="recoveryFile(${f.id});">恢复</a>
                            </c:if>
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
        $("#deleteBtn,#recoveryBtn").click(function () {
            var ids = new Array;
            $('#dataTable input[name="checkId"]:checked').each(function (i) {
                ids[i] = $(this).val();
            });
            if (ids.length <= 0) {
                return;
            }
            var id = $(this).attr('id');
            if ('deleteBtn' == id) {
                deleteFile(ids.join(','));
            } else if ('recoveryBtn' == id) {
                recoveryFile(ids.join(','));
            }
        });

        $('#dropdown-menu a').click(function () {
            var value = $(this).attr('val');
            var text = $(this).text();
            $('#deleteName').text(text);
            $('#isDeleted').val(value);
            $('#searchForm').submit();
        });
    });

    /**
     * 删除文件
     */
    function deleteFile(id) {
        if (confirm('删除文件会删除七牛云服务器上的文件，删除的文件会备份在名为“caliven-bak”的bucket中，确定删除？')) {
            var data = {ids: id};
            var url = _ctx + '/admin/file/delete';
            $.get(url, data, function (result) {
                if ("success" == result) {
                    location.href = _ctx + '/admin/file/list?isDeleted=false';
                } else {
                    alert('哦no,炒蛋的系统,在挂一次我立马走人!');
                }
            });
        }
    }

    /**
     * 恢复文件
     * @param id
     */
    function recoveryFile(id) {
        if (confirm('恢复文件会将备份在名为“caliven-bak”的bucket中的文件恢复到名为“caliven”的bucket中，确定恢复？')) {
            var data = {ids: id};
            var url = _ctx + '/admin/file/recovery';
            $.get(url, data, function (result) {
                if ("success" == result) {
                    location.href = _ctx + '/admin/file/list?isDeleted=true';
                } else {
                    alert('哦no,炒蛋的系统,在挂一次我立马走人!');
                }
            });
        }
    }
</script>
</body>
</html>