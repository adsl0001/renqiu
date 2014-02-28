<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/common/global.jsp"%>
<meta http-equiv="content-type" content="text/html;charset=utf-8">
 <%@ include file="/common/meta.jsp" %>
<link href="${ctx }/css/bgstretcher.css" type="text/css" rel="stylesheet"/>
   <script src="${ctx }/js/common/jquery-1.8.3.js" type="text/javascript"></script>
   <script src="${ctx }/js/common/jquery-bgstretcher-3.1.2.min.js" type="text/javascript"></script>

<title> </title>

<style type="text/css">
.context{ width:900px; height: 768px; position: absolute;margin-top: -384px; margin-left: -450px; left: 50%; top: 50%; overflow: hidden;}
</style> 
</head>
<body>
  <div id="context1" class="context">
  	<div id="gundong" style="width:900px;height:768px;">
  		<object width="900" height="760" 
		codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,2,0" 
		classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"> 
			<param value="${ctx}/aaa.swf" name="movie"> 
			<param value="high" name="quality"> 
			<param value="transparent" name="wmode"> 
			<param value="exactfit" name="SCALE"> 
			<embed width="900" height="760" wmode="transparent" type="application/x-shockwave-flash" 
			pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" 
			quality="high" src="${ctx}/aaa.swf"> 
		</object> 
  	</div>
  </div>

 <script type="text/javascript">
 
//    $( function(){
// 	   var path = ctx+"/photo/";
// 	   var images=[path+"1.jpg",
// 	               path+"2.jpg",
// 	               path+"3.jpg",
// 	               path+"4.jpg",
// 	               path+"5.jpg" ];
//     $( "#gundong" ).bgStretcher({
//       images: images,
//  				  slideShow: true,
//              transitionEffect: "superSlide",
//              slideDirection: 'NW',
//              nextSlideDelay:5000,
//              slideShowSpeed:'slow',
//              imageWidth: 900,
//              imageHeight: 768
//     }); 

//   });k
   </script>
 
</body>
</html>