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
	<title>我的待办列表</title>
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
	<script type="text/javascript">
	$(function() {
		// 跟踪
	    $('.trace').click(graphTrace);
	});
	</script>
</head>

<body>
	<table width="100%" class="need-border">
		<thead>
			<tr>
				<th>申请编号</th>
				<th>法人身份证</th>
				<th>法人姓名</th>
				<th>联系方式</th>
				<th>当前节点</th>
				<th>任务创建时间</th>
				<th>任务到期时间</th>
				<th>流程状态</th>
				<th>当前处理人</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.result }" var="szyzsq">
				<c:set var="task" value="${szyzsq.task }" />
				<c:set var="pi" value="${szyzsq.processInstance }" />
				<tr id="${szyzsq.sqbh }" tid="${task.id }">
				 <td>${szyzsq.sqbh }</td>
					<td>${szyzsq.frsfzh }</td>
					<td>${szyzsq.frxm }</td>
					<td>${szyzsq.lxfs }</td>
					<td>
						<a class="trace" href='#' pid="${pi.id }" title="点击查看流程图">${task.name }</a>
					</td>
					<td><fmt:formatDate value="${task.createTime }" pattern="yyyy-MM-dd hh:mm:ss" /></td>
					<td><fmt:formatDate value="${task.dueDate}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
					<td>${pi.suspended ? "已挂起" : "正常" }；<b title='流程版本号'>V: ${szyzsq.processDefinition.version }</b></td>
					<td>${task.assignee }<a href="${ctx}/szyzsq/handleTask/${task.id }">办理</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<tags:pagination page="${page}" paginationSize="${page.pageSize}"/>
</body>
</html>
