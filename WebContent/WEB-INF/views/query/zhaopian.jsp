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
.context{ width:800px; height: 600px; position: absolute;margin-top: -300px; margin-left: -400px; left: 50%; top: 50%; }
</style>
</head>
<body>
  <div id="context" class="context"><div id="gundong" style="width:800px;height:600px;">aaaaaaaaaaaaab</div></div>
 
 <script type="text/javascript">
 
   $( function(){
    $( "#gundong" ).bgStretcher({
      images: [ctx+'/photo/f01.jpg', ctx+'/photo/f02.jpg', ctx+'/photo/f03.jpg', ctx+'/photo/f04.jpg'],
 				// slideShow: true,
                    transitionEffect: "superSlide",
             slideDirection: 'W',
             nextSlideDelay:2000,
             slideShowSpeed:'slow',
             imageWidth: 1600,
             imageHeight: 1200
    }); 

  });
   </script>

</body>
</html>