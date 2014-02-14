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
        body{}
		 #winpop { width:350px; height:0px; position:absolute; right:0; bottom:0; border:1px solid #999999; margin:0; padding:1px; overflow:hidden; display:none; background:#FFFFFF} 
		 #winpop .title { width:100%; height:20px; line-height:20px; background:#FFCC00; font-weight:bold; text-align:center; font-size:15px;} 
		 #winpop .con { width:100%; height:80px; line-height:80px; font-weight:bold; font-size:12px; color:#FF0000; text-decoration:underline; text-align:center} 
		 #silu { font-size:13px; color:#999999; position:absolute; right:0; text-align:right; text-decoration:underline; line-height:22px;} 
		  .close { position:absolute; right:4px; top:-1px; color:#FFFFFF; cursor:pointer}
    </style>

    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/extends/portlet/jquery.portlet.pack.js?v=1.1.2" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/html/jquery.outerhtml.js" type="text/javascript"></script>
	<script src="${ctx }/js/module/activiti/workflow.js" type="text/javascript"></script>
    <script src="${ctx }/js/module/main/welcome-portlet.js" type="text/javascript"></script>
     <script type="text/javascript">
    // function popup(){
    	 //重复执行任务，可设置一段时间后执行检查流程超期情况；
    	 //setInterval("xxxx()",time);
    	 //在查询流程超期方法中调用窗口弹出方法；
    	 
   //  }
    
    function tips_pop(){ 
    	 var MsgPop=document.getElementById("winpop");//获取窗口这个对象,即 ID 为 winpop 的对象 
    	 var popH=parseInt(MsgPop.style.height);
    	 //用 parseInt 将对象的高度转化为数字,以方便下面比 较 
    	 if (popH==0){
	    	 //如果窗口的高度是 0 
	    	 MsgPop.style.display="block";
	    	 //那么将隐藏的窗口显示出来 
	    	 show=setInterval("changeH('up')",2);
	    	 //开始以每 0.002 秒调用函数 changeH("up"),即每 0.002 秒 向上移动一次 
    	 } else { 
    	 //否则 
    	 hide=setInterval("changeH('down')",2);
    	 //开始以每 0.002 秒调用函数 changeH("down"),即每 0.002 秒向下移动一次 
    	 } 
    } 
    function changeH(str) { 
    	 var MsgPop=document.getElementById("winpop"); 
    	 var popH=parseInt(MsgPop.style.height); 
    	 if(str=="up"){ 
	    	 //如果这个参数是 UP 
	    	 if (popH<=200){ 
		    	 //如果转化为数值的高度小于等于 100 
		    	 MsgPop.style.height=(popH+4).toString()+"px";
		    	 //高度增加 4 个象素 
	    	 } else{
		    	 clearInterval(show);
		    	 //否则就取消这个函数调用,意思就是如果高度超过 100 象度了,就不再增 长了
	    	 } 
    	 } 
    	 if(str=="down"){ if (popH>=4){ 
	    	 //如果这个参数是 down 
	    	 MsgPop.style.height=(popH-4).toString()+"px";
	    	 //那么窗口的高度减少 4 个象素 
    	 } else{ 
	    	 //否则 
	    	 clearInterval(hide); 
	    	 //否则就取消这个函数调用,意思就是如果高度小于 4 个象度的时候, 就不再减了 
	    	 MsgPop.style.display="none"; 
	    	 //因为窗口有边框,所以还是可以看见 1~2 象素没缩进去,这时 候就把 DIV 隐藏掉
    	 } 
    	 } 
    	 } 
    	window.onload=function(){ 
	    	 //加载 
	    	 document.getElementById('winpop').style.height='0px';
	    	 setTimeout("tips_pop()",800); 
	    	 //3 秒后调用 tips_pop()这个函数 
    	 } 
	</script>
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
     <!-- <button onclick="tips_pop()">测试按钮</button> -->
	 <div id="winpop"> 
	 	<div class="title">流程提醒功能<span class="close" onclick="tips_pop()">X</span></div> 
	 	<!-- <div class="con">未读信息(1)</div>  -->
	 	<div><FONT size="4">以下流程即将到期请及时处理：</FONT></div> 
	 </div>
</body>
</html>
