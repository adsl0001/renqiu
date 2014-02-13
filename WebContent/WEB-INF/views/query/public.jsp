<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	 
	<title>四证联办信息公示</title>
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
 <style>
  .toggler { width: 500px; height: 200px; }
  #button { padding: .5em 1em; text-decoration: none; }
  #effect { width: 790px; height: 390px; padding: 0.4em; position: relative; }
  #effect h3 { margin: 0; padding: 0.4em; text-align: center; }
  #caption  { width: 800px; height: 400px; padding: 0.4em; position: relative; }
  #caption h3 { margin: 0; padding: 0.4em; text-align: center; }
  </style>
  <script>
  $(function() {
	 //初始化数据
	var currentPage = 0;
    var pageSize = 20;
   	function initData(p,ps){
		$.ajax({url: ctx+"/query/queryPublic",
			data:"p="+p+"&ps="+ps,
			success: function(data){
				var page = data.page;
				currentPage = page.hasNext?++currentPage:0;
			
               	 var dblc = $('#effect');
               	 dblc.empty();
               	 var contextHtml= '';
               	//表头
               	contextHtml += '<table width="100%" class="need-border"> ';
               	contextHtml+=' <thead  > <tr>';
               	contextHtml+='<th ><center>申报时间</center></th>';
               	contextHtml+=' 	<th><center>流水号</center></th>';
               	contextHtml+=' <th><center>办理事项</center></th>';
               	contextHtml+=' 	<th><center>流程状态</center></th>';
               	contextHtml+='<th><center>当前环节</center></th>';
               	contextHtml+='<th><center>是否超期</center></th>';
               	contextHtml+='</tr> </thead>';	
               	contextHtml+='<tbody>';			
               	$.each(page.result, function() {
               		contextHtml+='<tr>';
               		contextHtml+='<td><center>'+this.sbsj+'</center></td>';
               		contextHtml+='<td><center>'+this.lsh+'</center></td>';
               		contextHtml+='<td><center>'+'四证联办流程'+'</center></td>';
               		contextHtml+='<td><center>'+this.lczt+' </center></td>';
               		contextHtml+='<td><center>'+this.dqhj+'</center></td>';
               		contextHtml+='<td><center>'+this.sfcq+'</center></td>';
				});	
               	contextHtml+='</tbody>	</table>';			
               	 dblc.html(contextHtml);
			}
		});
	}
    
    function runEffect() {
 	  var selectedEffect = 'blind';
      var options = {};
      $( "#effect" ).show( selectedEffect, options, 500, callback );
    };
    //callback function to bring a hidden box back
    function callback() {
      setTimeout( reOpen, 5000 );
    };

 	function reOpen(){
 		$( "#effect:visible" ).removeAttr( "style" ).fadeOut();
 	    //重新打开页面
 	    if(currentPage==0){initData(++currentPage,pageSize);};
 	    runEffect();
 	};
 	initData(++currentPage,pageSize);
    $( "#effect" ).hide();
    runEffect();
  });
  </script>
</head>
<body>
 
<div class="toggler">
  <div id ="caption" class="ui-widget-content ui-corner-all">
    <h3 class="ui-widget-header ui-corner-all">企业注册四证联办监管系统数据公示</h3>

     <div id="effect" >
    	<table width="100%" class="need-border">
		<thead>
			<tr>
				<th>申报时间</th>
				<th>流水号</th>
				<th>办理事项</th>
				<th>流程状态</th>
				<th>环节</th>
				<th>是否超期</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.result }" var="szyzsq">
				<c:set var="hpi" value="${szyzsq.historicProcessInstance }" />
				<tr >
				 <td>${szyzsq.sqbh }</td>
					<td>${szyzsq.frxm }</td>
					<td><fmt:formatDate value="${hpi.startTime }" pattern="yyyy-MM-dd hh:mm:ss" /></td>
					<td><fmt:formatDate value="${hpi.endTime }" pattern="yyyy-MM-dd hh:mm:ss" /></td>
					<td>${hpi.deleteReason }</td>
					<td><b title='流程版本号'>V: ${szyzsq.processDefinition.version }</b></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
  </div>
</div>
 
<!-- <select name="effects" id="effectTypes"> -->
<!--   <option value="blind">Blind</option> -->
<!--   <option value="bounce">Bounce</option> -->
<!--   <option value="clip">Clip</option> -->
<!--   <option value="drop">Drop</option> -->
<!--   <option value="explode">Explode</option> -->
<!--   <option value="fold">Fold</option> -->
<!--   <option value="highlight">Highlight</option> -->
<!--   <option value="puff">Puff</option> -->
<!--   <option value="pulsate">Pulsate</option> -->
<!--   <option value="scale">Scale</option> -->
<!--   <option value="shake">Shake</option> -->
<!--   <option value="size">Size</option> -->
<!--   <option value="slide">Slide</option> -->
<!-- </select> -->
 
<!-- <a href="#" id="button" class="ui-state-default ui-corner-all">Run Effect</a> -->
 
 
</body>
</html>
