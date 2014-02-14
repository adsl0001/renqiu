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
	<title>流程信息统计</title>
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
	    	$('#startTime,#endTime').datepicker({
// 	    		 showButtonPanel: true 
	        });
	    });
	</script>
</head>

<body>
<!--  <div class="container showgrid"></div>  -->

	<div>
        <div class="  ">
			<a href="javascript:;" onfocus="this.blur();"></a>
			 <h5></h5>流程信息统计 
			<a id="displayHidden" class="right" onclick="this.blur();" href= "javascript:;">隐藏查询条件</a>
		</div>
	
	<hr class="barTitleHr"></hr>

	<div id="conditions" class=""  style="display:block">
	 	<fieldset>
		<legend></legend>
			<form id="queryConditions"  action="${ctx}/query/queryProcessInfo" class="form-horizontal" >
				<div  > 
					<div  > 
						<div>时间范围：
						<input id="startTime" name="startTime" type="text"   style="width: 160px" value="${startTime }"/>至
						<input id="endTime" name="endTime" type="text" style="width: 160px" class="Wdate" value="${endTime }"/>
						<button id="query_button" type="submit"  >查询</button>
						</div>
					</div>
				</div>
			</form>
		</fieldset>
	</div>
<div id="welcome"  class=" ">
          <font color="red">运行中的流程:${running }</font>
          <table border="1" style="align:center">
          <thead>	<tr>
          		<th>工商窗口</th>
          		<th>质监窗口</th>
          		<th>国税窗口</th>
          		<th>地税窗口</th>
          	</tr></thead>
          	<tr>
          		<td>0</td>
          		<td>0</td>
          		<td>0</td>
          		<td>0</td>
          	</tr>
          </table>
          <font color="red">流程总数:${all }</font>
          <table border="1" style="align:center">
           <thead>	<tr>
          		<th>工商窗口</th>
          		<th>质监窗口</th>
          		<th>国税窗口</th>
          		<th>地税窗口</th>
          	</tr></thead>
          	<tr>
          		<td>${all.gongshang }</td>
          		<td>${all.zhijian }</td>
          		<td>${all.guoshui }</td>
          		<td>${all.dishui }</td>
          	</tr>
          </table>
          <font color="red">办结量:${bjl }</font>
          <table border="1">
           <thead>	<tr>
          		<th>工商窗口</th>
          		<th>质监窗口</th>
          		<th>国税窗口</th>
          		<th>地税窗口</th>
          	</tr></thead>
          	<tr>
          		<td>${bjl.gongshang }</td>
          		<td>${bjl.zhijian }</td>
          		<td>${bjl.guoshui }</td>
          		<td>${bjl.dishui }</td>
          	</tr>
          </table>
          <font color="red">办结率:${bjlv }%</font>
          <table border="1">
           <thead>	<tr>
          		<th>工商窗口</th>
          		<th>质监窗口</th>
          		<th>国税窗口</th>
          		<th>地税窗口</th>
          	</tr></thead>
          	<tr>
          			<td>${bjlv.gongshang }</td>
          		<td>${bjlv.zhijian }</td>
          		<td>${bjlv.guoshui }</td>
          		<td>${bjlv.dishui }</td>
          	</tr>
          </table>

<!--          <TABLE> -->
<%--          <tr><TD>办结量:${bjl }</TD></tr> --%>
<%--          <tr><TD>办结率:${bjlv }%</TD></tr> --%>
<%--          <tr><TD>运行中的流程:${running }</TD></tr> --%>
<%--          <tr><TD>流程总数:${all }</TD></tr> --%>
<!--          </TABLE> -->
    </div>
<script type="text/javascript">
	//显示或隐藏查询条件
	$(document).ready(function(){
		$("#displayHidden").click(function(){
	       var conditionsDiv = document.getElementById("conditions");
	       var displayHidden = document.getElementById("displayHidden");
	       if(conditionsDiv.style["display"]=="block"){
	          conditionsDiv.style["display"]="none";
	          displayHidden.innerHTML="显示查询条件";
	       }else if(conditionsDiv.style["display"]=="none"){
	          conditionsDiv.style["display"]="block";
	          displayHidden.innerHTML="隐藏查询条件";
	       }
		});
	});
</script>
</body>
</html>
