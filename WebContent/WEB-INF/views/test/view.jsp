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
	<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
	<title>测试</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-base-styles.jsp" %>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css" rel="stylesheet" />

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/jui/extends/i18n/jquery-ui-date_time-picker-zh-CN.js" type="text/javascript"></script>
 
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
	<form:form id="inputForm" action="${ctx}/test/complete" method="post" class="form-horizontal">
		<fieldset>
			<legend><small>测试流程</small></legend>
			
			<input type="hidden"  name = "taskId" value ="${task.id}"></input>
		
			<table border="1">
			<tr>
				<td>id</td>
				<td>
				 ${testModel.id}
				<input type="hidden"  name = "id" value ="${testModel.id}"></input>
				</td>
			</tr>
			<tr><td>名称</td>
				<td>
				<input id="name" name="name" value ="${testModel.name}" ></input>
				</td></tr>
			  
			<tr>
			<div id="reasonDiv"><td>审批意见:</td>
				<td><textarea  rows="2" cols="2"  id="reason" name="commentMessage" placeholder="审批意见"></textarea></td>
			</div>
			 </tr>
			 <tr>
			 <td colspan="2">
			 	<div>
			 	<fieldset> <legend><small>办理历史</small></legend>
			 		<div>
			 			<table>
			 			<thead>
			 				<tr>
								<th>节点名称</th>
								<th>办理人</th>
								<th>办理人姓名</th>
								<th>时间</th>
								<th>办理结果</th>
							</tr>
							</thead>
							<tbody>
								<c:forEach items="${commentList }" var="comment1">
									<tr>
										 <td>${comment1.taskName }</td>
										<td>${comment1.userId  }</td>
										<td>${comment1.userName }</td>
										<td>${comment1.time }</td>
										<td>${comment1.fullMessage }</td>
									</tr>
								</c:forEach>
							</tbody>
			 			</table>
			 		</div></fieldset>
			 	</div>
			 	</td>
			 </tr>
			 <tr>
			 <td></td>
			 <td><select id="reasonSelect" style="width: 300px;"  name = "assignee" placeholder="办理人">  
						<option>段松江</option>
						<option>张建波</option>
					</select></td>
			 </tr>
			<tr>
				<td>&nbsp; </td>
				<td>
					<input type = "button"	onclick="this.disabled=true;this.form.submit()" value="提交"/> 
<!-- 					&nbsp; -->
<!-- 					<input type = "button"	onclick="this.disabled=true;goBack();" value="退回上一步"/>  -->
				</td>
			</tr>
		</table>
		</fieldset>
	</form:form>
	</div>
<%-- 	<form:form id="goBackForm" action="${ctx}/szyzsq/rejectTask" method="post" class="form-horizontal"> --%>
<%-- 		<input type="hidden"  name = "taskId" value ="${szyzsq.task.id}"></input> --%>
<!-- 		<input id="backMessage" name="commentMessage" type="hidden" value ="" ></input> -->
<!-- 		<input></input> -->
<%-- 	</form:form> --%>
	<script type="text/javascript">
	function goBack (){
		$("#backMessage").val($("#reason").val());
		$("#goBackForm").submit();
	}
	</script>
</body>
</html>
