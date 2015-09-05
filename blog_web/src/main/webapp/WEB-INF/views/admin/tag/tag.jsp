<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>JBlog-标签管理</title>
    <link href="${ctx}/static/styles/admin/tag.css" type="text/css" rel="stylesheet"/>
</head>

<body>
<div class="container">
    <h3 class="page-header">标签管理</h3>

    <div class="row">
        <div class="col-sm-7 tag-main">
            <ul class="tag-list">
                <c:forEach items="${tags}" var="t">
                    <li class="size" id="${t.id}">
                        <input type="checkbox" value="${t.id}" name="tagId"/>
                        <span>${t.name}</span>
                        <a href="javascript:void(0);" class="tag-edit-link"
                           onclick="getTagInfo('${t.id}', '${t.name}', '${t.slug}');"
                           title="编辑">
                            <i class="i-edit"></i>
                        </a>
                        <a href="javascript:void(0);" class="tag-edit-link"
                           onclick="del('${t.id}',this);" title="删除">
                            <i class="i-del"></i>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="col-sm-5">
            <form id="saveForm" action="${ctx}/admin/tag/save" method="post">
                <input type="hidden" id="tagId" name="id"/>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1"><strong>标签名称</strong></span>
                        <input type="text" class="form-control" id="name" name="name" placeholder="如：Java"
                               aria-describedby="basic-addon1"/>
                    </div>
                    <span class="help-block" id="nameMessage"/>
                </div>
                <div class="description">标签名称必须唯一, 建议使用文字描述.</div>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"
                              id="basic-addon2"><strong>缩&nbsp;&nbsp;略&nbsp;&nbsp;名</strong></span>
                        <input type="text" class="form-control" id="slug" name="slug" placeholder="如：java"
                               aria-describedby="basic-addon2"/>
                    </div>
                    <span class="help-block" id="slugMessage"/>
                </div>
                <div class="description">标签缩略名用于创建友好的链接形式, 建议使用字母, 数字, 下划线和横杠, 如果留空则默认使用标签名称.</div>

                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <strong>操作失败!</strong> 原因：${error}
                    </div>
                </c:if>

                <button type="submit" class="btn btn-primary">
                    <span id="btnSpan">增加</span>分类
                </button>
            </form>
        </div>
    </div>
</div>

<script src="${ctx}/static/bootstrap/validator/js/bootstrapValidator.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        // 便签点击效果
        $('.tag-list .size').click(function () {
            $('.size').removeClass('checked');
            $(this).addClass('checked');
        });

        $('#saveForm').bootstrapValidator({
            message: '值无效',
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
                            message: '标签名称不能为空'
                        },
                        stringLength: {
                            min: 1,
                            max: 10,
                            message: '分类名称长度为1-10位'
                        },
                        remote: {
                            type: 'GET',
                            url: _ctx + '/admin/tag/check_name?id=' + $('#tagId').val(),
                            message: '标签名称已被使用',
                            delay: 1000
                        }
                    }
                },
                slug: {
                    container: '#slugMessage',
                    validators: {
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
                            url: _ctx + '/admin/tag/check_slug?id=' + $('#tagId').val(),
                            message: '缩略名已被使用',
                            delay: 1000
                        }
                    }
                }
            }
        });
    });
    function getTagInfo(id, name, slug) {
        $('#tagId').val(id);
        $('#name').val(name);
        $('#slug').val(slug);
        $('#btnSpan').text('编辑');
    }

    function del(id, dom) {
        if (confirm("此标签与博文的关联将被取消，确认删除标签？")) {
            var url = _ctx + '/admin/tag/del';
            var data = {id: id};
            $.post(url, data, function (result) {
                if ("success" == result) {
                    $(dom).parent().remove();
                } else {
                    alert('我了个擦，又出错，我去!');
                }
            });
        }
    }
</script>
</body>
</html>
