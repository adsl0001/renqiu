<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
		<script>
		var notLogon = ${empty user};
		if (notLogon) {
			location.href = '${ctx}/login?timeout=true';
		}
	</script>
	<title>四证联办受理</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-base-styles.jsp" %>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css" rel="stylesheet" />

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/jui/extends/i18n/jquery-ui-date_time-picker-zh-CN.js" type="text/javascript"></script>
    <script type="text/javascript">
    $(function() {
    	$('#startTime,#endTime').datetimepicker({
            stepMinute: 5
        });
    });
    </script>
</head>

<body>
	<div class="container showgrid">
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success">${message}</div>
		<!-- 自动隐藏提示信息 -->
		<script type="text/javascript">
		setTimeout(function() {
			$('#message').hide('slow');
		}, 5000);
		</script>
	</c:if>
	<c:if test="${not empty error}">
		<div id="error" class="alert alert-error">${error}</div>
		<!-- 自动隐藏提示信息 -->
		<script type="text/javascript">
		setTimeout(function() {
			$('#error').hide('slow');
		}, 5000);
		</script>
	</c:if>
	<form:form id="inputForm" action="${ctx}/szyzsq/completeTask" method="post" class="form-horizontal">
		<fieldset>
			<legend><small>四证联办申请受理</small></legend>
			<input type="hidden"  name = "sqbh" value ="${szyzsq.sqbh}"></input>
				<input type="hidden"  name = "taskId" value ="${szyzsq.task.id}"></input>
				<input type="hidden"  name = "sfkz" value ="${szyzsq.sfkz}"></input>
				<input type="hidden"  name = "sfblgs" value ="${szyzsq.sfblgs}"></input>
		<input type="hidden"  name = "slr" value ="${szyzsq.slr}"></input>
		<input type="hidden"  name = "slrxm" value ="${szyzsq.slrxm}"></input>
		
			<table border="1">
			<tr>
				<td>法人身份证号：</td>
				<td>
				 ${szyzsq.frsfzh}
				 <input name="frsfzh" type="hidden" value ="${szyzsq.frsfzh}">
				</td>
			</tr>
		 	<tr>
				<td>法人姓名：</td>
				<td>
				<input id="frxm" name="frxm" type="text" value ="${szyzsq.frxm}" ></input>
				</td>
			</tr>
			<tr>
				<td>联系方式：</td>
				<td>
				<input id="lxfs" name="lxfs" type="text" value ="${szyzsq.lxfs}" ></input>
				</td>
			</tr>
			<tr>
				<td>企业名称：</td>
				<td>
				<input id="qymc" name="qymc" type="text" value ="${szyzsq.qymc}" ></input>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<button type="submit">提交</button>
				</td>
			</tr>
		</table>
		</fieldset>
	</form:form>
	</div>
</body>
</html>
