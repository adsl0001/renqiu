<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>出错了</title>
</head>

<body>
<div><h1>系统运行错误.</h1></div>
<div>${errorInfo }</div>
<div><a href="<c:url value="/"/>" target="_parent">返回首页</a></div>
</body>
</html>
