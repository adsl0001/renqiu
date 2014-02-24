<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">
<head>
<META HTTP-EQUIV="pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
<META HTTP-EQUIV="expires" CONTENT="Wed, 26 Feb 1997 08:21:57 GMT">
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
	//屏蔽回车事件
	document.onkeydown = function(event){
		var e = event || window.event || arguments.callee.caller.arguments[0];
         if(e.keyCode==13){ 
        	 queryHistory();
        	 event.returnValue = false;
        }
	}
	//身份证验证js
	function isCard(num){
	    num = num.toUpperCase();
	    var errorvalue;
	    if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(num))) {
	        alert('输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。 ');
	        errorvalue = 1;
	        return errorvalue;
	    }
	    // 校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
	    // 下面分别分析出生日期和校验位
	    var len, re; len = num.length;
	    if (len == 15) {
	        re = new RegExp(/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/);
	        var arrSplit = num.match(re);  // 检查生日日期是否正确
	        var dtmBirth = new Date('19' + arrSplit[2] + '/' + arrSplit[3] + '/' + arrSplit[4]);
	        var bGoodDay; bGoodDay = (dtmBirth.getYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4]));
	        if (!bGoodDay) {
	            alert('输入的身份证号里出生日期不对！');
	            errorvalue = 2;
	            return errorvalue;
	        } else { // 将15位身份证转成18位 //校验位按照ISO 7064:1983.MOD
	     // 11-2的规定生成，X可以认为是数字10。
	            var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
	            var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
	            var nTemp = 0, i;
	            num = num.substr(0, 6) + '19' + num.substr(6, num.length - 6);
	            for (i = 0; i < 17; i++) {
	                nTemp += num.substr(i, 1) * arrInt[i];
	            }
	            num += arrCh[nTemp % 11];
	            errorvalue = 2;
	            return errorvalue;
	        }
	    }
	    if (len == 18) {
	        re = new RegExp(/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/);
	        var arrSplit = num.match(re);  // 检查生日日期是否正确
	        var dtmBirth = new Date(arrSplit[2] + "/" + arrSplit[3] + "/" + arrSplit[4]);
	        var bGoodDay; bGoodDay = (dtmBirth.getFullYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4]));
	        if (!bGoodDay) {
	            alert('输入的身份证号里出生日期不对！');
	            errorvalue = 1;
	            return errorvalue;
	        }
	        else { // 检验18位身份证的校验码是否正确。 //校验位按照ISO 7064:1983.MOD
	    // 11-2的规定生成，X可以认为是数字10。
	            var valnum;
	            var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
	            var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
	            var nTemp = 0, i;
	            for (i = 0; i < 17; i++) {
	                nTemp += num.substr(i, 1) * arrInt[i];
	            }
	            valnum = arrCh[nTemp % 11];
	            if (valnum != num.substr(17, 1)) {
	                alert('18位身份证的校验码不正确！' + valnum);
	                errorvalue = 1;
	                return errorvalue;
	            }
	            return errorvalue;
	        }
	    }
	    return errorvalue;
	}
	function submitForm()
	{
		//判断原法人身份证号与文本框中是否一致，不一致提示
		var temp = $("#frsfzh").val();
		this.disabled=true;
		this.form.submit();
	}
	//查询历史记录
	function queryHistory(){
		var frsfzh = $('#queryfrsfzh').val();
		if (frsfzh==""){
			alert("请输入法人身份证号码");
			return false;
		}
		var errorvalue = isCard(frsfzh);
		if(errorvalue == 1){
			 $('#historyProcess').empty();
			 return ;
		}
		if(errorvalue != 1){
			$.ajax({ url: ctx+"/szyzsq/queryList",
				data:"frsfzh="+frsfzh,
				success: function(data){
					$("#frsfzh").val(frsfzh);
					 if (data.length == 0) {
	                     $('#historyProcess').empty();
	                     $('#historyProcess').html('未查询到<span class="info large">'+frsfzh+'</span>的办理记录，您可以<input type = "button"	onclick="this.disabled=true;this.form.submit()" value="启动新流程"/> 。');
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
	                		contextHtml+='<p>查询到<span class="info large">'+frsfzh+'</span>未办理完成的流程，您可以<input type = "button"	onclick="this.disabled=true;this.form.submit()" value="启动新流程"/> 或继续办理以前没有完成的流程。</p>'
	                	 dblc.html(contextHtml);
	                		// 跟踪
	                	    $('.trace').click(graphTrace);
	                 }
				}
			});
		}
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
    <fieldset>
      <legend> <small>四证申请受理</small> </legend>
      <div>
        法人身份证号：<input id='queryfrsfzh' name='queryfrsfzh' type="text"></input>
        &nbsp;
        <input id="queryHistory" type="button" value="查询" ></input>
       
        <p></p>
        <input type="hidden" id="sqbh" name="sqbh" value=""></input>
      </div>
     
  
  <form:form id="inputForm" action="${ctx}/szyzsq/inputApply"
			method="post" class="form-horizontal" >
  		<input id='frsfzh' name='frsfzh' type="hidden"></input>
  		 <input type="text" style="display:none">
  		  <div id="historyProcess">
        &nbsp;
      </div>
  </form:form>  </fieldset>
</div>
</body>
</html>
