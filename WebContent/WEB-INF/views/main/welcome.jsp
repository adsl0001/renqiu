<?xml version="1.0" encoding="UTF-8" ?>
<%@page import="com.renqiu.demo.activiti.util.PropertyFileUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	<%@ include file="/common/meta.jsp"%>

	<%@ include file="/common/include-base-styles.jsp" %>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jui/extends/portlet/jquery.portlet.min.css?v=1.1.2" type="text/css" rel="stylesheet" />
    <link href="${ctx }/js/common/plugins/qtip/jquery.qtip.css?v=1.1.2" type="text/css" rel="stylesheet" />
    <%@ include file="/common/include-custom-styles.jsp" %>
    <style type="text/css">
    	.template {display:none;}
    	.version {margin-left: 0.5em; margin-right: 0.5em;}
    	.trace {margin-right: 0.5em;}
        .center {
            width: 1200px;
            margin-left:auto;
            margin-right:auto;
        }
     </style>
 

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/extends/portlet/jquery.portlet.pack.js?v=1.1.2" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/html/jquery.outerhtml.js" type="text/javascript"></script>
	<script src="${ctx }/js/module/activiti/workflow.js" type="text/javascript"></script>
    <script src="${ctx }/js/module/main/welcome-portlet.js" type="text/javascript"></script>
<<<<<<< HEAD
=======
     <script type="text/javascript">
    // function popup(){
    	 //重复执行任务，可设置一段时间后执行检查流程超期情况；
    	 //setInterval("xxxx()",time);
    	 //在查询流程超期方法中调用窗口弹出方法；
    	 
   //  }
    
   
	</script>
>>>>>>> branch 'master' of https://github.com/adsl0001/renqiu
</head>
<body style="margin-top: 1em;">
	<div class="center">
        <div style="text-align: center;">
            <h3>欢迎访问企业注册四证联办监管系统</h3>
        </div>
        <div id='portlet-container'></div>
    </div>
     <div id="welcome" class="template">
         <TABLE>
         <tr><TD>办结量:${bjl }</TD></tr>
         <tr><TD>办结率:${bjlv }%</TD></tr>
         <tr><TD>运行中的流程:${running}</TD></tr>
         <tr><TD>流程总数:${all }</TD></tr>
         </TABLE>
    </div>
<<<<<<< HEAD
=======
     <!-- <button onclick="tips_pop()">测试按钮</button> -->
<!-- 	 <div id="winpop">  -->
<!-- 	 	<div class="title">流程提醒功能<span class="close" onclick="tips_pop()">X</span></div>  -->
<!-- 	   <div class="con">未读信息(1)</div>  -->  
<!-- 	 	<div><FONT size="4">以下流程即将到期请及时处理：</FONT></div>  -->
<!-- 	 </div> -->
>>>>>>> branch 'master' of https://github.com/adsl0001/renqiu
</body>
</html>
