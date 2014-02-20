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
	<title>收集材料及代收费</title>
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
	<form:form id="inputForm" action="${ctx}/szyzsq/completeTask" method="post" class="form-horizontal">
		<fieldset>
			<legend><small>${szyzsq.task.name }</small></legend>
				<input type="hidden"  name = "sqbh" value ="${szyzsq.sqbh}"></input>
				<input type="hidden"  name = "taskId" value ="${szyzsq.task.id}"></input>
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
			<tr><td>法人姓名：</td>
				<td>
				${szyzsq.frxm}
				<input id="frxm" name="frxm" type="hidden" value ="${szyzsq.frxm}" ></input>
				</td></tr>
			<tr>
				<td>联系方式：</td>
				<td>
				${szyzsq.lxfs}
				<input id="lxfs" name="lxfs" type="hidden" value ="${szyzsq.lxfs}" ></input>
				</td>
			</tr>
					<tr>
				<td>公司核准名称：</td>
				<td>
				${szyzsq.qymc}
				<input id="qymc" name="qymc" type="hidden" value ="${szyzsq.qymc}" ></input>
				</td>
			</tr>
			<tr>	
			<td>是否刻章：</td> 
				<td>
					<input type="radio" name="sfkz" value="1" checked >是&nbsp;
					<input type="radio" name="sfkz" value="0" >否
				</td>
			</tr>
			<tr>	
			<td>是否办理国税：</td> 
				<td>
					<input type="radio" name="sfblgs" value="1" checked >是&nbsp;
					<input type="radio" name="sfblgs" value="0" >否
				</td>
			</tr>
				<div id="reasonDiv" hidden="true">
			<tr>
				<td>办理结果:</td>
				<td><textarea  rows="2" cols="2"  id="reason" name="commentMessage" placeholder="例如：材料填写不完整（标明具体项）"></textarea></td>
		
			 </tr>	</div>
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
								<th>办理意见</th>
							</tr>
							</thead>
							<tbody>
								<c:forEach items="${szyzsq.commentList }" var="comment1">
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
				<td>&nbsp;</td>
				<td>
					<button type="submmit">提交</button>
				</td>
			</tr>
		</table>
		</fieldset>
	</form:form>
	</div>
</body>
</html>
