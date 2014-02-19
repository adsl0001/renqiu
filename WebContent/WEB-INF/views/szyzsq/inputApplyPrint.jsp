<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<title>"四证"联办卡打印页面</title>
    <style media=print type="text/css">   
		.noprint{visibility:hidden}   
	</style>  
	<style type="text/css">   
	 	body{font-size: 12pt;} .h2{font-size: 15pt;}
	</style> 
</head>
<body>
	<table>
		<tr>
			<td class="h2" align="left">申请编号：</td>
			<td>
			 ${szyzsq.sqbh}
			 <input name="frsfzh" type="hidden" value ="${szyzsq.frsfzh}">
			</td>
		</tr>
		<tr>
			<td class="h2" align="left">法人身份证号：</td>
			<td>
			 ${szyzsq.frsfzh}
			 <input name="frsfzh" type="hidden" value ="${szyzsq.frsfzh}">
			</td>
		</tr>
	 	<tr>
			<td class="h2" align="left">法人姓名：</td>
			<td>
			${szyzsq.frxm}
			<input id="frxm" name="frxm" type="hidden" value ="${szyzsq.frxm}" ></input>
			</td>
		</tr>
		<tr>
			<td class="h2" align="left">联系方式：</td>
			<td>
			${szyzsq.lxfs}
			<input id="lxfs" name="lxfs" type="hidden" value ="${szyzsq.lxfs}" ></input>
			</td>
		</tr>
		<tr>
			<td class="h2" align="left">公司核准名称：</td>
			<td>
			${szyzsq.qymc}
			<input id="qymc" name="qymc" type="hidden" value ="${szyzsq.qymc}" ></input>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<p class="noprint"><input type = 'button'	onclick="window.print()" value='打印'></input></p>
			</td>
		</tr>
	</table>
</body>
</html>