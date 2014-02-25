<%@page import="com.renqiu.demo.activiti.util.PropertyFileUtil"%>
<%@page import="org.springframework.beans.factory.config.PropertiesFactoryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
PropertyFileUtil.init();
%>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	<script>
		var notLogon = ${empty user}; 
		if (notLogon) { 
			location.href = '${ctx}/login?timeout=true';
		}
	</script>
	<%@ include file="/common/meta.jsp" %>
    <title>企业注册四证联办监管系统</title>
    <%@ include file="/common/include-base-styles.jsp" %>
	<%@ include file="/common/include-jquery-ui-theme.jsp" %>
	<link rel="shortcut icon" href="${ctx }/images/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="${ctx }/css/menu.css" />
    <%@ include file="/common/include-custom-styles.jsp" %>
	<link href="${ctx }/css/main.css" type="text/css" rel="stylesheet"/>
	<style type="text/css">
	.ui-tabs-panel {height: 100%; width: 100%;}
	.ui-tabs .ui-tabs-nav li a {padding-right: .5em;}
	#tabs li .ui-icon-close { float: left; margin: 0.5em 0.2em 0 0; cursor: pointer; }
	#add_tab { cursor: pointer; }
	</style>

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/extends/themeswitcher/jquery.ui.switcher.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/tools/jquery.cookie.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/jui/extends/layout/jquery.layout.min.js?v=1.3" type="text/javascript"></script>
	<script src='${ctx }/js/common/common.js' type="text/javascript"></script>
	    <script src="${ctx }/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/html/jquery.outerhtml.js" type="text/javascript"></script>
		<script src="${ctx }/js/module/activiti/workflow.js" type="text/javascript"></script>
    <script src='${ctx }/js/module/main/main-frame.js' type="text/javascript"></script>
</head>
<body>
<!-- #TopPane -->
<div id="topPane" class="ui-layout-north ui-widget ui-widget-header ui-widget-content">
	<div style="padding-left:5px; font-size: 16px; margin-top: 1px;">
       	<table id="topTable" style="padding: 0px;margin: 0px;margin-top: -5px" width="100%">
       		<tr>
<!--        			<td width="40px"> -->
<%--        				<img src="${ctx }/images/logo.png" height="48" align="top"  style="margin-top:5px" /> --%>
<!--        			</td> -->
<!--        			<td> -->
<!--        				<span style="font-size: 17px;color:#FFFF33">Activiti<br/>演示系统</span><br/> -->
<!--        			</td> -->
       			<td>
       				<div style="float:right; color: #fff;font-size: 12px;margin-top: 2px">
		        		<div>
		        			<label for="username">欢迎：</label>
		        			<span title="角色：${groupNames }">${user.firstName }${user.lastName }/${user.id }</span>
		        		</div>
		        		<div style="text-align: right;">
 		       				<a href="#" id="loginOut">安全退出</a>
		        		</div>
		        	</div>
       			</td>
       		</tr>
       	</table>
       </div>
</div>

<!-- RightPane -->
<div id="centerPane" class="ui-layout-center ui-helper-reset ui-widget-content">
	<div id="tabs">
		<ul><li><a class="tabs-title" href="#tab-index">首页</a><span class='ui-icon ui-icon-close' title='关闭标签页'></span></li></ul>
		<div id="tab-index">
			<iframe id="mainIframe" name="mainIframe" src="welcome" class="module-iframe" scrolling="auto" frameborder="0" style="width:100%;height:100%;"></iframe>
		</div>
	</div>
</div>
<div id="popPane" > </div>

<!-- #BottomPane -->
<!-- <div id="bottomPane" class="ui-layout-south ui-widget ui-widget-content"> -->
<!-- 	<div class="footer ui-state-default"> -->
<!-- 		<a href="#" target="_blank">任丘</a> -->
<!-- 		<span class="copyright">©2008-2013</span> -->
<%-- 		<span class="version">Version：${prop['system.version']}</span> --%>
<!-- 	</div> -->
<!-- </div> -->
<%@ include file="menu.jsp" %>
<div id="themeswitcherDialog"><div id="themeSwitcher"></div></div>

<script type="text/javascript">
	$(function(){
		var dialog = $("#popPane").dialog({
			title:"以下流程即将超期",
			width:580,
			height:300,
			autoOpen: false,
		      show: {
		        effect: "blind",
		        direction :"down",
		        duration: 400
		      },
		      hide: {
		        effect: "blind",
		        direction :"down",
		        duration: 400
		      },
		      position:{ my: "right bottom", at: "right bottom", of: window }
		});
		setTimeout( popup, 1000 );
	}
	);
  	function initData(p,ps){
		$.ajax({url: ctx+"/query/queryTimeoutTask",
			success: function(data){
				 if (data.length == 0) {
					 
				 }else{
					//有数据
					//组织数据,弹出窗口
					var pop = $('#popPane');
					pop.empty();
					
					var contextHtml = "";
				 	//表头
	               	contextHtml += '<table width="100%" > ';
	               	contextHtml+=' <thead  > <tr>';
// 	               	contextHtml+='<th ><center>任务编号</center></th>';
	               	contextHtml+=' 	<th><center>节点名称</center></th>';
	               	contextHtml+=' <th><center>开始时间</center></th>';
	               	contextHtml+=' 	<th><center>超期时间</center></th>';
	               	contextHtml+='<th><center>操作</center></th>';
	               	contextHtml+='</tr> </thead>';	
	               	contextHtml+='<tbody>';			
	               	$.each(data, function() {
	               		contextHtml+='<tr>';
// 	               		contextHtml+='<td><center>'+this.taskId+'</center></td>';
	               		contextHtml+="<td><center><span class='ui-state-highlight ui-corner-all'>" + this.taskName + "</span></center></td>"
	               		contextHtml+='<td>'+this.createTime+'</td>';
	               		contextHtml+='<td><center>'+this.dueDate+' </center></td>';
	               		contextHtml+='<td><center>'+
	               		"<a class='trace' href='#' pid='" + this.pid + "' title='点击查看流程图'>跟踪</a><span> &nbsp;</span>"
	               		+"<a target='_blank' href='"+ctx+"/szyzsq/handleTask/"+this.taskId+"'>办理</a>"+'</center></td>';
	               							});	
	               	contextHtml+='</tbody>	</table>';			
	               	pop.html(contextHtml); 
	               	$('.trace').click(graphTrace);
	               	$("#popPane").dialog("open");
					//popup();
					//隔20分钟再次检查
					 setTimeout(popup, 1000*60*20 );
	               //	setTimeout(popup, 2000 );
				}
                
			}
		});
	}
  
	function popup (){
		$("#popPane").dialog("close" );
		initData();
	}
	
	
</script>
</body>
</html>
