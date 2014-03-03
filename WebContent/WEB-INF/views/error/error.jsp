<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%response.setStatus(200);%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>出错了</title>
</head>

<body>
<% Exception ex = (Exception)request.getAttribute("Exception"); %> 
<H2>系统运行期错误:<br> <%= ex.getMessage()%></H2> 
<P/> 
<% 
	//记录日志
	Logger logger = LoggerFactory.getLogger("error.jsp");
	logger.error(ex.getMessage(), ex);
	%> 

<div><a href="<c:url value="/"/>" target="_parent">返回首页</a></div>
</body>
</html>
