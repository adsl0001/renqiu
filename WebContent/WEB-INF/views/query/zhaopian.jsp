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
.context{ width:700px; height: 600px; position: absolute;margin-top: -300px; margin-left: -350px; left: 50%; top: 50%; }
</style>
</head>
<body>
  <div id="context1" class="context"><div id="gundong" style="width:700px;height:600px;"></div></div>
 
 <script type="text/javascript">
 
   $( function(){
	   var path = ctx+"/photo/";
	   var images=[path+"1.jpg",
	               path+"2.jpg",
	               path+"3.jpg",
	               path+"4.jpg",
	               path+"5.jpg",
	               path+"6.jpg"];
    $( "#gundong" ).bgStretcher({
      images: images,
 				  slideShow: true,
             transitionEffect: "superSlide",
             slideDirection: 'NW',
             nextSlideDelay:5000,
             slideShowSpeed:'SLOW',
             imageWidth: 700,
             imageHeight: 600
    }); 

  });
   </script>

</body>
</html>