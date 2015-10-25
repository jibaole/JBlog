<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <title>登陆到闲想录</title>
    <script language="javascript">
        var _ctx = '${ctx}';
    </script>

    <link href="${ctx}/static/images/favicon/favicon.ico" rel="shortcut icon" />
    <link href="${ctx}/static/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/styles/account/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/styles/account/css/form-elements.css" type="text/css" rel="stylesheet"/>
    <link href="${ctx}/static/styles/account/css/style.css" type="text/css" rel="stylesheet"/>

    <!--[if lt IE 9]>
    <script src="${ctx}/static/js/plugin/html5shiv.min.js" type="text/javascript"></script>
    <script src="${ctx}/static/js/plugin/respond.min.js" type="text/javascript"></script>
    <![endif]-->
</head>

<body>
<div class="top-content">
    <div class="inner-bg">
        <div class="container">
            <%--
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text">
                    <h1><strong>Bootstrap</strong> Login Form</h1>

                    <div class="description">
                        <p>
                            This is a free responsive login form made with Bootstrap.
                            Download it on <a href="http://azmind.com"><strong>AZMIND</strong></a>, customize and use it
                            as you like!
                        </p>
                    </div>
                </div>
            </div>
            --%>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top">
                        <div class="form-top-left">
                            <h3>【闲想录】</h3>
                            <p class="alert alert-error">${error}</p>
                        </div>
                        <%--
                        <div class="form-top-right">
                            <i class="fa fa-lock"></i>
                        </div>
                        --%>
                    </div>
                    <div class="form-bottom">
                        <form id="login-form" action="${ctx}/login" method="post" class="login-form">
                            <div class="form-group">
                                <input type="text" name="username" placeholder="邮箱/用户名"
                                       class="form-username form-control" id="form-username"
                                       data-toggle="popover" data-placement="top" data-content="似乎忘了点什么?"/>
                            </div>
                            <div class="form-group">
                                <input type="password" name="password" placeholder="密码"
                                       class="form-password form-control" id="form-password"
                                       data-toggle="popover" data-placement="top" data-content="似乎忘了点什么?"/>
                            </div>
                            <div class="form-group">
                                <label><input type="checkbox" name="rememberMe"/> 记住我</label>
                            </div>
                            <button type="submit" class="btn">登录</button>
                        </form>
                    </div>
                </div>
            </div>
            <%--
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 social-login">
                    <h4>或</h4>

                    <div class="social-login-buttons">
                        <a class="btn btn-link-2" href="#">
                            <i class="fa fa-facebook"></i> 微信
                        </a>
                        <a class="btn btn-link-2" href="#">
                            <i class="fa fa-twitter"></i> QQ
                        </a>
                        <a class="btn btn-link-2" href="#">
                            <i class="fa fa-google-plus"></i> 微博
                        </a>
                    </div>
                </div>
            </div>
            --%>
        </div>
    </div>
</div>

<script src="${ctx}/static/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="${ctx}/static/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/jquery/jquery.backstretch.min.js" type="text/javascript"></script>
<script src="${ctx}/static/js/account/login.js" type="text/javascript"></script>
<!--[if lt IE 10]>
<script src="${ctx}/static/js/account/placeholder.js" type="text/javascript"></script>
<![endif]-->
</body>
</html>
