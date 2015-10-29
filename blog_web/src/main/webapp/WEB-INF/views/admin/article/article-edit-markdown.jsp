<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>撰写文章</title>
    <link href="${ctx}/static/bootstrap/markdown/css/bootstrap-markdown.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/bootstrap/datetimepicker/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/bootstrap/select/css/bootstrap-select.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/styles/admin/common.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/styles/admin/article.css" type="text/css" rel="stylesheet"/>
</head>

<body>
<div class="container">
    <h3 class="page-header"><c:if test="${blog.id != null}">编辑</c:if><c:if test="${blog.id == null}">撰写新</c:if>文章</h3>

    <form id="saveForm" action="${ctx}/admin/article/save" method="post"><!-- enctype="multipart/form-data" -->

        <input type="hidden" id="blogId" name="id" value="${blog.id}"/>
        <input type="hidden" id="isDraft" name="isDraft" value="${blog.isDraft}"/>
        <input type="hidden" id="tmpBlogId" name="tmpBlogId" value="${tmpBlogId}"/>
        <c:set var="tBlogId">
            <c:if test="${tmpBlogId==null || tmpBlogId==''}">${blog.id}</c:if>
            <c:if test="${tmpBlogId!=null && tmpBlogId!=''}">${tmpBlogId}</c:if>
        </c:set>

        <div class="row">
            <div class="col-sm-9 markdown-div">
                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <strong>操作失败!</strong> 原因：${error}
                    </div>
                </c:if>

                <div class="form-group">
                    <input type="text" id="title" name="title" value="${blog.title}" class="form-control"
                           placeholder="标题"
                           autocomplete="off" style="font-weight: bold;"/>
                </div>
                <div class="form-group">
                    <textarea id="content" name="content" class="md-editor markdown-text"
                              data-provide="markdown">${blog.content}</textarea>
                </div>
                <div class="text-right">
                    <button type="button" class="btn" onclick="setDraft(true);">保存草稿</button>
                    <button type="submit" class="btn btn-primary" onclick="beforeSave(false);">发表文章</button>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <div class="btn-group btn-group-justified" role="group">
                        <div class="btn-group btn-group-sm" role="group">
                            <button type="button" class="btn btn-default select-btn" onclick="switchDiv(this, 1)">选项
                            </button>
                        </div>
                        <div class="btn-group btn-group-sm" role="group">
                            <button type="button" class="btn btn-default" onclick="switchDiv(this, 2)">
                                附件 <c:if test="${not empty files}"><span class="badge">${files.size()}</span></c:if>
                            </button>
                        </div>
                    </div>
                </div>

                <div id="leftDiv" class="switch-div">
                    <div class="form-group">
                        <label>发布时间</label>
                        <input type="text" id="publishTime" name="publishTime" class="form-control" placeholder="定时发布时间"
                               value="<fmt:formatDate value="${blog.createdDate}" pattern="yyyy-MM-dd HH:mm" />"/>
                    </div>
                    <div class="form-group">
                        <label>分类</label>

                        <div class="cate-div">
                            <c:forEach items="${cateList}" var="c">
                                <c:if test="${c.parentId != 0}">
                                    <div class="checkbox">
                                        <label  <c:choose>
                                            <c:when test="${c.level==2}">style="margin-left: 15px;"</c:when>
                                            <c:when test="${c.level==3}">style="margin-left: 25px;"</c:when>
                                            <c:when test="${c.level==4}">style="margin-left: 25px;"</c:when>
                                            <c:when test="${c.level==5}">style="margin-left: 45px;"</c:when>
                                        </c:choose>>
                                            <input type="checkbox" value="${c.id}" onchange="setCateIds()"
                                                   <c:if test="${fn:contains(cateIds, c.id)}">checked</c:if>/>${c.name}
                                        </label>
                                    </div>
                                </c:if>
                            </c:forEach>
                            <input type="hidden" id="cateIds" name="cateIds" value="${cateIds}"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>标签</label>
                        <select id="tagIds" name="tagIds" class="form-control selectpicker" title="${tagNames}"
                                multiple data-live-search="true" data-max-options="5">
                            <c:forEach items="${tagList}" var="t">
                                <option value="${t.id}"
                                        data-content="<span class='label label-info'>${t.name}</span>">${t.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>公开度</label>
                        <select id="status" name="status" class="form-control" onchange="switchStatus(this)">
                            <option value="1" <c:if test="${blog.status==1}">selected</c:if>>公开</option>
                            <option value="2" <c:if test="${blog.status==2}">selected</c:if>>影藏</option>
                            <option value="3" <c:if test="${blog.status==3}">selected</c:if>>密码保护</option>
                            <option value="4" <c:if test="${blog.status==4}">selected</c:if>>私密</option>
                            <option value="0" <c:if test="${blog.status==0}">selected</c:if>>待审核</option>
                        </select>
                    </div>
                    <div class="form-group" id="pwdDiv" <c:if test="${blog.status!=3}">style="display: none;"</c:if>>
                        <input type="text" id="password" name="password" value="${blog.password}" class="form-control"
                               placeholder="文章密码"/>
                    </div>
                    <div class="form-group">
                        <label>权限控制</label>

                        <div class="checkbox">
                            <label><input type="checkbox" name="allowComment"
                                          <c:if test="${blog.allowComment==true}">checked</c:if>>允许评论&nbsp;&nbsp;
                            </label>
                            <label><input type="checkbox" name="allowQuote"
                                          <c:if test="${blog.allowQuote==true}">checked</c:if>>允许被引用</label>
                        </div>
                    </div>
                    <c:if test="${blog.id != null}">
                        <div class="form-group">
                            <footer>
                                <small>—</small>
                                <br>
                                <small>本文由 <a href="${ctx}/admin/user/edit?id=${user.id}">${user.username}</a> 撰写
                                </small>
                                <br>
                                <small>最后更新于 ${relativeTime}</small>
                            </footer>
                        </div>
                    </c:if>
                </div>

                <div id="rightDiv" class="switch-div" style="display: none;">
                    <div id="upload-panel" class="p">
                        <div id="upload-area" class="upload-area" draggable="true" style="position: relative;">
                            拖放文件到这里<br>或者
                            <a href="javascript:void(0);" onclick="fileupload.click();" class="upload-file"
                               style="position: relative; z-index: 1;">选择文件上传</a>

                            <div style="position: absolute; top: 36px; left: 110px; width: 78px; height: 15px; overflow: hidden; z-index: 0;">
                                <input id="fileupload" type="file"
                                       style="font-size: 999px; opacity: 0; position: absolute; top: 0px; left: 0px; width: 100%; height: 100%;"
                                       name="files[]" data-url="${ctx}/admin/file/upload?blogId=${tBlogId}" multiple
                                       accept="image/gif,image/jpeg,image/png,image/tiff,image/bmp">
                            </div>
                        </div>
                        <ul id="uploaded-files">
                            <c:forEach items="${files}" var="f">
                                <li id="file_${f.id}">
                                    <a class="insert" target="_blank" href="###" title="点击插入文件">${f.fileRealName}</a>

                                    <div class="info">
                                            ${f.fileSize} Kb&nbsp;&nbsp;
                                        <a class="file" target="_blank" href="${ctx}/admin/file/edit/${f.id}"
                                           title="编辑">
                                            <i class="i-edit"></i>
                                        </a>
                                        <a class="delete" href="javascript:voif(0);"
                                           onclick="delFile(${f.id},'${f.fileRealName}')" title="删除">
                                            <i class="i-del"></i>
                                        </a>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>

                    </div>
                </div>

            </div>
        </div>
    </form>
</div>

<script src="${ctx}/static/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="${ctx}/static/js/jquery/jquery.hotkeys.js" type="text/javascript"></script>
<script src="${ctx}/static/bootstrap/validator/js/bootstrapValidator.min.js" type="text/javascript"></script>
<script src="${ctx}/static/bootstrap/select/js/bootstrap-select.min.js" type="text/javascript"></script>
<script src="${ctx}/static/bootstrap/select/js/i18n/defaults-zh_CN.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/jquery/upload/vendor/jquery.ui.widget.js" type="text/javascript"></script>
<script src="${ctx}/static/js/jquery/upload/jquery.iframe-transport.js" type="text/javascript"></script>
<script src="${ctx}/static/js/jquery/upload/jquery.fileupload.js" type="text/javascript"></script>
<script src="${ctx}/static/js/admin/article-edit.js" type="text/javascript"></script>

</body>
</html>
