<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	 
	<title>公示</title>
	<%@ include file="/common/meta.jsp" %>
    <%@ include file="/common/include-base-styles.jsp" %>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css" rel="stylesheet" />
    <link href="${ctx }/js/common/plugins/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" />
    <%@ include file="/common/include-custom-styles.jsp" %>
	<link rel="shortcut icon" href="${ctx }/images/favicon.ico" />
    <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jui/extends/timepicker/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/jui/extends/i18n/jquery-ui-date_time-picker-zh-CN.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/html/jquery.outerhtml.js" type="text/javascript"></script>
	<script src="${ctx }/js/module/activiti/workflow.js" type="text/javascript"></script>
	 
</head>

<body>
  
</head>
<body>
 <script type="text/javascript">
 var timeout = ${timeout};
 
 function changePage(url)
 {
	 $.ajax({
		 url:getNextUrl(),
		 success: function(data){
			 $("#ccccxxxx").html(data); 
			 setTimeout( changePage, timeout );
			/*  $( "#ccccxxxx:visible" ).removeAttr( "style" ).fadeOut(
					 function(){
						 $("#ccccxxxx").html(data); 
						 //$("#container").css("opacity","1"); 
						  var selectedEffect = 'blind';
					      var options = {};
					      $( "#ccccxxxx" ).show( selectedEffect, options, 500,  function(){
					    	  setTimeout( changePage, timeout );
					      } );
					 }
			  ); */
		    
		 }
	 });
 
 }

 var allUrl =[ctx+"/query/public/10",
              ctx+"/query/showPhoto/30"];
 var currentIndex=0;
 function getNextUrl(){
	 if(currentIndex==allUrl.length)
		 {
		 	currentIndex=0;
		 }
	 return allUrl[currentIndex++];
 }
 	$(function(){
 		changePage();
 	});
 </script>
<div id="containera" class="" style="opacity:1;">
  <div id="ccccxxxx"></div>
</div>
  
 
</body>
</html>
