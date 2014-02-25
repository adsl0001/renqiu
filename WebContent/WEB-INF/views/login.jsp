<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="height:100%;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@ include file="/common/global.jsp"%>
	<title>企业注册四证联办监管系统登录</title>
	<script>
		var logon = ${not empty user};
		if (logon) {
			location.href = '${ctx}/main/index';
		}
	</script>
	<%@ include file="/common/meta.jsp" %>
	<%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <%@ include file="/common/include-base-styles.jsp" %>
    <link rel="stylesheet" href="${ctx }/css/login.css" type="text/css"  > 
    <link rel="shortcut icon" href="${ctx }/images/favicon.ico" />
</head>

<body class="tbody">
	<div class="wrap">
 	
 		<div class="login-top">
 			<div class="alertMessage">  <c:if test="${not empty param.error}">
            <h2 id="error" class="alert alert-error">用户名或密码错误！！！</h2>
        </c:if>
        <c:if test="${not empty param.timeout}">
            <h2 id="error" class="alert alert-error">未登录或超时！！！</h2>
        </c:if></div>
		</div>
		<div class="login">
			<div class="logo">
				<img src="${ctx }/images/word.png" />
			</div>
			<form action="${ctx }/user/logon" method="get">
			<div class="content">
				<div class="c-left">
					<div class="text-div">
						<label class="usernameLabel"></label>
						<span><input id="username" name="username" class="login-input" placeholder="用户名" /></span>
					</div>
					<div class="text-div">
						<label class="passwordLabel"></label>
						<span><input id="password" name="password" type="password" class="login-input" placeholder="密码" /></span>
					</div>
				</div>
				
					<div class="c-right">
						<button class="login-button">登录</button>
						<a href="${ctx }/query/public/30" target="blank">查看公示信息</a>
					</div>
			</div>
			</form>
		</div>
	</div>
</body>
</html>
