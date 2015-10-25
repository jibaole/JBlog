<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>闲想录-增加用户</title>
    <link href="${ctx}/static/bootstrap/select/css/bootstrap-select.css" type="text/css" rel="stylesheet"/>
</head>

<body>
<div class="container">
    <%--
    <h3 class="page-header">
        <ul class="nav nav-pills">
            <li role="presentation">
                <a href="javasrcipt:void(0);" onclick="javascript:history.go(-1);" title="返回列表">
                    <span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span><c:if test="${category.id != null}">编辑</c:if><c:if test="${category.id == null}">增加</c:if>分类
                </a>
            </li>
        </ul>
    </h3>
    --%>
    <h3 class="page-header">
        <a href="javasrcipt:void(0);" onclick="javascript:history.go(-1);" title="返回">
            <%--<span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>--%>
            《&nbsp;<c:if test="${category.id != null}">编辑</c:if><c:if test="${category.id == null}">增加</c:if>分类
        </a>
    </h3>

    <div class="row">
        <div class="col-sm-6 col-sm-offset-3">
            <form id="saveForm" action="${ctx}/admin/category/save" method="post">
                <input type="hidden" id="cateId" name="id" value="${category.id}"/>
                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <strong>操作失败!</strong> 原因：${error}
                    </div>
                </c:if>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1"><strong>分类名称</strong></span>
                        <input type="text" class="form-control" name="name" value="${category.name}"
                               placeholder="如：默认分类" aria-describedby="basic-addon1"/>
                    </div>
                    <span class="help-block" id="nameMessage"/>
                </div>
                <div class="description">分类名称必须唯一, 建议使用文字描述.</div>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"
                              id="basic-addon2"><strong>缩&nbsp;&nbsp;略&nbsp;&nbsp;名</strong></span>
                        <input type="text" class="form-control" name="slug" value="${category.slug}"
                               placeholder="如：default" aria-describedby="basic-addon2"/>
                    </div>
                    <span class="help-block" id="slugMessage"/>
                </div>
                <div class="description">分类缩略名用于创建友好的链接形式, 建议使用字母, 数字, 下划线和横杠.</div>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><strong>父级分类</strong></span>
                        <select name="parentId" class="form-control selectpicker" data-live-search="true"
                                title="请选择父级分类...">
                            <c:forEach items="${treeList}" var="c" varStatus="v">
                                <option value="${c.id}"
                                        <c:if test="${parentId == c.id || category.parentId == c.id}">selected</c:if>>
                                    <c:choose>
                                        <c:when test="${c.level==2}">&nbsp;&nbsp;</c:when>
                                        <c:when test="${c.level==3}">&nbsp;&nbsp;&nbsp;&nbsp;</c:when>
                                        <c:when test="${c.level==4}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:when>
                                        <c:when test="${c.level==5}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</c:when>
                                    </c:choose>
                                        ${c.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <span class="help-block" id="parentIdMessage"/>
                </div>
                <div class="description">此分类将归档在您选择的父级分类下.</div>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon4"><strong>分类描述</strong></span>
                        <textarea class="form-control" name="description" rows="3"
                                  aria-describedby="basic-addon4">${category.description}</textarea>
                    </div>
                    <span class="help-block" id="descriptionMessage"/>
                </div>
                <div class="description">此文字用于描述分类, 在有的主题中它会被显示.</div>

                <button type="submit" class="btn btn-primary">
                    <c:if test="${category.id != null}">编辑</c:if><c:if test="${category.id == null}">增加</c:if>分类
                </button>
            </form>
        </div>
    </div>
</div>

<script src="${ctx}/static/bootstrap/select/js/bootstrap-select.min.js" type="text/javascript"></script>
<script src="${ctx}/static/bootstrap/select/js/i18n/defaults-zh_CN.min.js" type="text/javascript"></script>
<script src="${ctx}/static/bootstrap/validator/js/bootstrapValidator.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        $('#saveForm').bootstrapValidator({
            message: '值无效',
            //container: 'tooltip',
            //container: '#errors',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                name: {
                    container: '#nameMessage',
                    validators: {
                        notEmpty: {
                            message: '分类名称不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 10,
                            message: '分类名称长度为1-10位'
                        },
                        remote: {
                            type: 'GET',
                            url: _ctx + '/admin/category/check_name?id=' + $('#cateId').val(),
                            message: '分类名称已被使用',
                            delay: 1000
                        }
                    }
                },
                slug: {
                    container: '#slugMessage',
                    validators: {
                        notEmpty: {
                            message: '缩略名不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 10,
                            message: '缩略名长度为1-10位'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '缩略名只能由字母、数字、下划线组成'
                        },
                        remote: {
                            type: 'GET',
                            url: _ctx + '/admin/category/check_slug?id=' + $('#cateId').val(),
                            message: '缩略名已被使用',
                            delay: 1000
                        }
                    }
                },
                parentId: {
                    container: '#parentIdMessage',
                    validators: {
                        notEmpty: {
                            message: '父级分类不能为空'
                        }
                    }
                },
                description: {
                    container: '#descriptionMessage',
                    validators: {
                        stringLength: {
                            min: 0,
                            max: 200,
                            message: '分类描述最长不能超过200字符'
                        }
                    }
                }
            }
        });
    });
</script>
</body>
</html>