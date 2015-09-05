<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html>
<head>
<title>注册页</title>
<link href="${ctx}/static/styles/account/login.css" type="text/css" rel="stylesheet" />

<script type="text/javascript">
function checkExistEmail(){
	alert(1);
	var email = $("#userEmail").val();
	var url = "${ctx}/account2/checkExistEmails";
	$.get(url, {userEmail: email}, function(result){
		if("true"==result){
			alert("Email已存在");
			$("#userEmail").focus();
		}else{
			$("#loginForm").submit();
		}
	});
}
</script>
</head>

<body>
	<div class="container">
		<%-- <div class="col-md-6">
			<form id="basicForm" action="" class="form-horizontal"
				novalidate="novalidate">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">请注册账号</h4>
					</div>
					<div class="panel-body">
						<div class="form-group has-error">
							<label class="col-sm-3 control-label">邮箱 <span
								class="asterisk">*</span></label>
							<div class="col-sm-9">
								<input type="text" name="name" class="form-control"
									placeholder="Type your name..." required=""><label
									for="name" class="error">This field is required.</label>
							</div>
						</div>

						<div class="form-group has-error">
							<label class="col-sm-3 control-label">姓名 <span
								class="asterisk">*</span></label>
							<div class="col-sm-9">
								<input type="email" name="email" class="form-control"
									placeholder="Type your email..." required=""><label
									for="email" class="error">This field is required.</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-3 control-label">密码</label>
							<div class="col-sm-9">
								<input type="url" name="url" class="form-control valid">
							</div>
						</div>

						<div class="form-group has-error">
							<label class="col-sm-3 control-label">Comment <span
								class="asterisk">*</span></label>
							<div class="col-sm-9">
								<textarea rows="5" class="form-control"
									placeholder="Type your comment..." required=""></textarea>
								<label for="" class="error">This field is required.</label>
							</div>
						</div>
					</div>
					<!-- panel-body -->
					<div class="panel-footer">
						<div class="row">
							<div class="col-sm-9 col-sm-offset-3">
								<button class="btn btn-primary">Submit</button>
								<button type="reset" class="btn btn-default">Reset</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
 		--%>
		
		<form id="loginForm" action="${ctx}/account" method="post" class="form-signin" role="form">
			<h2 class="form-signin-heading">请注册账号</h2>
			<input type="email" id="userEmail" name="userEmail" class="form-control" placeholder="邮箱" required autofocus>
			<input type="text" name="userName" class="form-control" placeholder="姓名" required>
			<input type="password" name="userPwd" class="form-control" placeholder="密码" required>
			<input type="password" name="confirmUserPwd" class="form-control" placeholder="确认密码" required>
			
			<button class="btn btn-lg btn-success" type="submit">创建账户</button>
			<a href="${ctx}/login" class="btn btn-sm btn-link">已有账号登陆</a>
		</form>
	</div>
</body>
</html>
