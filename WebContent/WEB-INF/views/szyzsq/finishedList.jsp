<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	<script>
		var notLogon = ${empty user};
		if (notLogon) {
			location.href = '${ctx}/login?timeout=true';
		}
	</script>
	<title>已办结流程</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-base-styles.jsp" %>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css" rel="stylesheet" />
    <link href="${ctx }/js/common/plugins/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" />
    <%@ include file="/common/include-custom-styles.jsp" %>

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/jui/extends/i18n/jquery-ui-date_time-picker-zh-CN.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/html/jquery.outerhtml.js" type="text/javascript"></script>
	<script src="${ctx }/js/module/activiti/workflow.js" type="text/javascript"></script>
 
</head>

<body>
	<table width="100%" class="need-border">
		<thead>
			<tr>
				<th>申请编号</th>
				<th>法人身份证</th>
				<th>法人姓名</th>
				<th>联系方式</th>
				<th>企业名称</th>
				<th>受理人</th>
				 <th>流程启动时间</th>
				<th>流程结束时间</th>
				<th>流程结束原因</th>
				<th>流程版本</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.result }" var="szyzsq">
				<c:set var="hpi" value="${szyzsq.historicProcessInstance }" />
				<tr >
				 <td>${szyzsq.sqbh }</td>
					<td>${szyzsq.frsfzh }</td>
					<td>${szyzsq.frxm }</td>
					<td>${szyzsq.lxfs }</td>
					<td>${szyzsq.qymc }</td>
					<td>${szyzsq.slrxm } </td>
					<td><fmt:formatDate value="${hpi.startTime }" pattern="yyyy-MM-dd hh:mm:ss" /></td>
					<td><fmt:formatDate value="${hpi.endTime }" pattern="yyyy-MM-dd hh:mm:ss" /></td>
					<td>${hpi.deleteReason }</td>
					<td><b title='流程版本号'>V: ${szyzsq.processDefinition.version }</b></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<tags:pagination page="${page}" paginationSize="${page.pageSize}"/>
</body>
</html>
