<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>闲想录-增加用户</title>
    <script src="${ctx}/static/js/plugin/holder.min.js" type="text/javascript"></script>
</head>

<body>
<div class="container">
    <h3 class="page-header"><c:if test="${user.id != null}">编辑</c:if><c:if test="${user.id == null}">增加</c:if>用户</h3>

    <div class="row">
        <form id="saveForm" action="${ctx}/admin/user/save" method="post">
            <input type="hidden" name="id" value="${user.id}"/>

            <div class="col-sm-3">
                <div class="form-group">
                    <img data-src="holder.js/200x200" class="img-responsive img-thumbnail" alt="200x200"
                         data-holder-rendered="true" width="200" height="200">
                </div>
                <div class="form-group">
                    <input type="file" name="imgId" value="${user.imgId}"/>

                    <p class="description">支持.jpg .jpeg .gif .png格式.</p>
                </div>
            </div>
            <div class="col-sm-6">
                <c:if test="${error != null}">
                    <div class="alert alert-danger alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <strong>操作失败!</strong> 原因：${error}
                    </div>
                </c:if>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"
                              id="basic-addon1"><strong>用&nbsp;&nbsp;户&nbsp;&nbsp;名</strong></span>
                        <input type="text" class="form-control" name="username" value="${user.username}"
                               placeholder="zhangsan" aria-describedby="basic-addon1"
                                <c:if test="${user.id != null}"> disabled="disabled" </c:if>/>
                    </div>
                    <span class="help-block" id="usernameMessage"/>
                </div>
                <div class="description">此用户名将作为用户登录时所用的名称.<br>请不要与系统中现有的用户名重复.</div>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon2"><strong>昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称</strong></span>
                        <input type="text" class="form-control" name="nickname" value="${user.nickname}"
                               placeholder="张三"
                               aria-describedby="basic-addon2"/>
                    </div>
                    <span class="help-block" id="nicknameMessage"/>
                </div>
                <div class="description">用户昵称可以与用户名不同, 用于前台显示.<br>如果你将此项留空, 将默认使用用户名.</div>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon3"><strong>邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱</strong></span>
                        <input type="email" class="form-control" name="email" value="${user.email}"
                               placeholder="example@example.com"
                               aria-describedby="basic-addon3"/>
                    </div>
                    <span class="help-block" id="emailMessage"/>
                </div>
                <div class="description">电子邮箱地址将作为此用户的主要联系方式.<br>请不要与系统中现有的电子邮箱地址重复.</div>

                <c:if test="${user.id == null}">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon4"><strong>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码</strong></span>
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="password"
                                   aria-describedby="basic-addon4"/>
                        </div>
                        <span class="help-block" id="passwordMessage"/>
                    </div>
                    <div class="description">为此用户分配一个密码.<br>建议使用特殊字符与字母、数字的混编样式,以增加系统安全性.</div>

                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon5"><strong>确认密码</strong></span>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                   placeholder="confirm password"
                                   aria-describedby="basic-addon5"/>
                        </div>
                        <span class="help-block" id="confirmPasswordMessage"/>
                    </div>
                    <div class="description">请确认你的密码, 与上面输入的密码保持一致.</div>
                </c:if>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon6"><strong>个人地址</strong></span>
                        <input type="text" class="form-control" name="url" value="${user.url}"
                               placeholder="http://www.example.com"
                               aria-describedby="basic-addon6"/>
                    </div>
                    <span class="help-block" id="urlMessage"/>
                </div>
                <div class="description">此用户的个人主页地址, 请用 http:// 开头.</div>

                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon7"><strong>用&nbsp;&nbsp;户&nbsp;&nbsp;组</strong></span>
                        <select class="form-control" name="roles" aria-describedby="basic-addon7">
                            <option <c:if test="${user.roles == null}"> selected="selected" </c:if>></option>
                            <option value="1" <c:if test="${user.roles == 1}"> selected="selected" </c:if>>管理员</option>
                            <option value="2" <c:if test="${user.roles == 2}"> selected="selected" </c:if>>贡献者</option>
                            <option value="3" <c:if test="${user.roles == 3}"> selected="selected" </c:if>>编辑</option>
                            <option value="4" <c:if test="${user.roles == 4}"> selected="selected" </c:if>>关注者</option>
                        </select>
                    </div>
                    <span class="help-block" id="rolesMessage"/>
                </div>
                <div class="description">不同的用户组拥有不同的权限.<br>具体的权限分配表请<a href="#">参考这里</a>.</div>

                <c:if test="${user.id != null}">
                    <div class="form-group">
                        <label class="radio-inline">
                            <input type="radio" name="status" value="1" <c:if
                                    test="${user.status==true}"> checked="checked" </c:if>/> 生效用户
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="status" value="0" <c:if
                                    test="${user.status==false}"> checked="checked" </c:if>/> 关闭用户
                        </label>
                    </div>
                    <div class="description">关闭用户后, 用户将无法登陆, 所有博文在网站上将无法查看, 当然管理员可以.</div>
                </c:if>
                <button type="submit" class="btn btn-primary">
                    <c:if test="${user.id != null}">编辑</c:if><c:if test="${user.id == null}">增加</c:if>用户
                </button>
            </div>
        </form>
    </div>
</div>

<script src="${ctx}/static/bootstrap/validator/js/bootstrapValidator.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/admin/user-edit.js" type="text/javascript"></script>
</body>
</html>
