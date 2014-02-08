<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
<%@ include file="/common/global.jsp"%>
<script>
		var notLogon = ${empty user};
		if (notLogon) {
			location.href = '${ctx}/login?error=nologon';
		}
	</script>
<title>四证联办受理</title>
<%@ include file="/common/meta.jsp"%>
<%@ include file="/common/include-base-styles.jsp"%>
<%@ include file="/common/include-jquery-ui-theme.jsp"%>
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
	//查询历史记录
	function queryHistory(event){
		var frsfzh = $('#frsfzh').val();
		if (frsfzh==""){
			alert("请输入法人身份证号码");
			return;
		}
		$.ajax({ url: ctx+"/szyzsq/queryList",
			data:"frsfzh="+frsfzh,
			success: function(data){
				 if (data.length == 0) {
                     $('#historyProcess').empty();
                     $('#historyProcess').html('未查询到办理记录，您可以<button type="submmit">启动新流程</button>。');
                 }else{
                	 var dblc = $('#historyProcess');
                	 dblc.empty();
                	 var contextHtml= '';
                	//表头
                	  contextHtml += '<table width="100%" class="need-border"> ';
                	contextHtml+=' <thead> <tr>';
                	contextHtml+='<th>申请编号</th>';
                	contextHtml+=' 	<th>法人身份证</th>';
                	contextHtml+=' <th>法人姓名</th>';
                	contextHtml+=' 	<th>联系方式</th>';
                	contextHtml+='<th>当前节点</th>';
                	contextHtml+='<th>任务创建时间</th>';
                	contextHtml+='	<th>流程状态</th>';
                	contextHtml+='	<th>流程版本</th>';
                	contextHtml+='	<th>操作</th>';
                	contextHtml+='</tr> </thead>';	
                	contextHtml+='<tbody>';			
                	$.each(data, function() {
                		contextHtml+='<tr>';
                		contextHtml+='<td>'+this.sqbh+'</td>';
                		contextHtml+='<td>'+this.frsfzh+'</td>';
                		contextHtml+='<td>'+this.frxm+'</td>';
                		contextHtml+='<td>'+this.lxfs+'</td>';
                		contextHtml+='<td>'+'<a class="trace" href="#" pid="'+this.pi_id+'" title="点击查看流程图">'+this.task_name+'</a></td>';
                		contextHtml+='<td>'+this.task_createTime+'</td>';
                		contextHtml+='<td> </td>';
                		contextHtml+='<td>V'+this.processDefinition_version+'</td>';
                		contextHtml+='<td><a href="'+ctx+'/szyzsq/handleTask/'+this.task_id+'">继续办理</a></td>';
						 
					});	
                	contextHtml+='</tbody>	</table>';			
                	contextHtml+='<p>查询到未办理完成的流程，您可以<button type="submmit">启动新的受理流程</button>或继续办理以前没有完成的流程。</p>'
                	 dblc.html(contextHtml);
                 
                		// 跟踪
                	    $('.trace').click(graphTrace);
                	 
                 }
			}
		});
	}
	$(function() {
	 $('#queryHistory').bind('click',queryHistory);
	});
</script>
</head>

<body>
<div class="container showgrid">
  <c:if test="${not empty message}">
    <div id="message" class="alert alert-success">
      ${message}
    </div>
    <!-- 自动隐藏提示信息 --> 
    <script type="text/javascript">
				setTimeout(function() {
					$('#message').hide('slow');
				}, 5000);
 </script> 
  </c:if>
  <c:if test="${not empty error}">
    <div id="error" class="alert alert-error">
      ${error}
    </div>
    <!-- 自动隐藏提示信息 --> 
    <script type="text/javascript">
				setTimeout(function() {
					$('#error').hide('slow');
				}, 5000);
			</script> 
  </c:if>
  <form:form id="inputForm" action="${ctx}/szyzsq/inputApply"
			method="post" class="form-horizontal">
    <fieldset>
      <legend> <small>四证申请受理</small> </legend>
      <div>
        法人身份证号：<input id='frsfzh' name='frsfzh' type="text"></input>
        &nbsp;
        <input id="queryHistory" type="button" value="查询" ></input>
        <p></p>
        <input type="hidden" id="sqbh" name="sqbh" value=""></input>
      </div>
      <div id="historyProcess">
        &nbsp;
      </div>
    </fieldset>
  </form:form>
</div>
</body>
</html>
