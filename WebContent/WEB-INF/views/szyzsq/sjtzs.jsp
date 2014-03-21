<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	<script>
		var notLogon = ${empty user};
		if (notLogon) {
			location.href = '${ctx}/login?timeout=true';
		}
	</script>
	<%@ include file="/common/meta.jsp" %>
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
	<script>
		var notLogon = ${empty user};
		if (notLogon) {
			location.href = '${ctx}/login?timeout=true';
		}
	</script>
<title>"四证"联办卡打印页面</title>
<style media=print type="text/css">
.noprint {
	visibility: hidden
}
</style>
<script type="text/javascript">
	$(function() {
		$('#planTime').datepicker({
	// 		 showButtonPanel: true 
	    });
	});
</script>

<style type="text/css">
body {
	font-size: 15pt;
}
</style>
<style id="四证联办日常所需表格_12143_Styles">
<!--
table {
	mso-displayed-decimal-separator: "\.";
	mso-displayed-thousand-separator: "\,";
}

.font512143 {
	color: windowtext;
	font-size: 9.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
}

.font612143 {
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
}

.font712143 {
	color: windowtext;
	font-size: 18.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
}

.font812143 {
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
}

.font912143 {
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
}

.xl6312143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: bottom;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl6412143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl6512143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl6612143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 11.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: normal;
}

.xl6712143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: normal;
}

.xl6812143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl6912143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl7012143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl7112143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: middle;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl7212143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl7312143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl7412143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl7512143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl7612143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: normal;
}

.xl7712143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl7812143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl7912143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl8012143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: none;
	border-bottom: none;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl8112143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl8212143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: none;
	border-bottom: none;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl8312143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl8412143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 18.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl8512143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: left;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: none;
	border-bottom: none;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: normal;
}

.xl8612143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: bottom;
	border-top: .5pt solid windowtext;
	border-right: none;
	border-bottom: none;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl8712143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: bottom;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl8812143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: bottom;
	border-top: none;
	border-right: none;
	border-bottom: none;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl8912143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: bottom;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl9012143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: bottom;
	border-top: none;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl9112143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: bottom;
	border-top: none;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl9212143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: bottom;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl9312143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
	layout-flow: vertical-ideographic;
}

.xl9412143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
	layout-flow: vertical-ideographic;
}

.xl9512143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
	layout-flow: vertical-ideographic;
}

.xl9612143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: normal;
}

.xl9712143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: left;
	vertical-align: bottom;
	border-top: .5pt solid windowtext;
	border-right: none;
	border-bottom: none;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl9812143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 18.0pt;
	font-weight: 700;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt dotted windowtext;
	border-right: none;
	border-bottom: none;
	border-left: none;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl9912143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 12.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

.xl10012143 {
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: windowtext;
	font-size: 14.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: center;
	vertical-align: middle;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: .5pt solid windowtext;
	mso-background-source: auto;
	mso-pattern: auto;
	white-space: nowrap;
}

ruby {
	ruby-align: left;
}

rt {
	color: windowtext;
	font-size: 9.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-char-type: none;
}
-->
</style>
</head>

<body">
	<!--[if !excel]>　　<![endif]-->
	<!--下列信息由 Microsoft Excel 的发布为网页向导生成。-->
	<!--如果同一条目从 Excel 中重新发布，则所有位于 DIV 标记之间的信息均将被替换。-->
	<!----------------------------->
	<!--“从 EXCEL 发布网页”向导开始-->
	<!----------------------------->

	<div id="四证联办日常所需表格_12143" align=center x:publishsource="Excel">

		<table border=0 cellpadding=0 cellspacing=0 width=580 class=xl6312143
			style='border-collapse: collapse; table-layout: fixed; width: 437pt'>
			<col class=xl6312143 width=38
				style='mso-width-source: userset; mso-width-alt: 1216; width: 29pt'>
			<col class=xl6312143 width=66
				style='mso-width-source: userset; mso-width-alt: 2112; width: 50pt'>
			<col class=xl6312143 width=52
				style='mso-width-source: userset; mso-width-alt: 1664; width: 39pt'>
			<col class=xl6312143 width=101
				style='mso-width-source: userset; mso-width-alt: 3232; width: 76pt'>
			<col class=xl6312143 width=45
				style='mso-width-source: userset; mso-width-alt: 1440; width: 34pt'>
			<col class=xl6312143 width=109
				style='mso-width-source: userset; mso-width-alt: 3488; width: 82pt'>
			<col class=xl6312143 width=77
				style='mso-width-source: userset; mso-width-alt: 2464; width: 58pt'>
			<col class=xl6312143 width=92
				style='mso-width-source: userset; mso-width-alt: 2944; width: 69pt'>
			<tr height=72 style='mso-height-source: userset; height: 54.0pt'>
				<td colspan=8 height=72 class=xl8412143 width=580
					style='height: 54.0pt; width: 437pt'>任丘市“四证联办”收件通知书(存根）</td>
				<td>
					<p class="noprint">
						<input type='button' onclick="window.print()" value='打印'></input>
					</p>
				</td>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
				<td colspan=8 height=40 class=xl7712143 style='height: 30.0pt'><span
					style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</span>编号：${szyzsq.sqbh}</td>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
				<td colspan=2 height=40 class=xl7612143 style='height: 30.0pt'>企业名称</td>
				<td colspan=6 class=xl7512143>${szyzsq.qymc}</td>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
				<td colspan=2 rowspan=5 height=284 class=xl8212143
					style='border-right: .5pt solid black; border-bottom: .5pt solid black; height: 213.0pt'>材料目录</td>
				<td colspan=6 rowspan=5 class=xl8512143 width=476
					style='border-right: .5pt solid black; border-bottom: .5pt solid black; width: 358pt'><br>
					<font class="font912143">质</font><font class="font912143"><span
						style='mso-spacerun: yes'>&nbsp; </span></font><font class="font912143">监：</font><font
					class="font812143"><input name="Fruit" type="checkbox"
						value="" /></font><font class="font812143">组织机构基本信息登记表</font></br> <font
					class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font812143"><input name="Fruit" type="checkbox"
						value="" /></font><font class="font812143">法定代表人身份证件原件、复印件（正反面）</br> <font
						class="font912143"><span style='mso-spacerun: yes'>&nbsp;
						</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
						</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
						</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
						</span></font>、预收费单
				</font><font class="font812143"><br> </font><font class="font912143">国地税：</font><font
					class="font812143"><input name="Fruit" type="checkbox"
						value="" /></font><font class="font812143">税务登记表</font></br> <font
					class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font812143"><input name="Fruit" type="checkbox"
						value="" /></font><font class="font812143">财务人员身份证（正反面）</font><font
					class="font812143">2</font><font class="font812143">份</font></br> <font
					class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font812143"><input name="Fruit" type="checkbox"
						value="" /></font><font class="font812143">财务人员会计从业资格证书原件、复印件</font><font
					class="font812143">2</font><font class="font812143">份</font></br> <font
					class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font812143"><input name="Fruit" type="checkbox"
						value="" /></font><font class="font812143">公司章程</font><font
					class="font812143">2</font><font class="font812143">份</font></br> <font
					class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font812143"><input name="Fruit" type="checkbox"
						value="" /></font><font class="font812143">房产证明、租赁协议</font><font
					class="font812143">2</font><font class="font812143">份</font></br> <font
					class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font912143"><span style='mso-spacerun: yes'>&nbsp;
					</span></font><font class="font812143"><input name="Fruit" type="checkbox"
						value="" /></font><font class="font812143">验资报告原件</font><font
					class="font812143">2</font><font class="font812143">份</font></br> 
					<font class="font912143">公</font><font
					class="font912143"> </font><font class="font912143">章：</font>&nbsp;<input
					name="Fruit" type="checkbox" value="" /><font class="font812143">预收费单</font></td>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
			</tr>
			<tr height=124 style='mso-height-source: userset; height: 93.0pt'>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
				<td colspan=3 height=40 class=xl10012143 style='height: 30.0pt'>法人代表或代理人</td>
				<td class=xl6512143 style='border-top: none; border-left: none'>${szyzsq.frxm}
				</td>
				<td  class=xl6612143 width=45
					style='border-top: none; border-left: none; width: 34pt'>交接日期</td>
				<td colspan=3 class=xl6512143 style='border-top: none; border-left: none;' >
					${myDate }
				</td>
				
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
				<td colspan=3 height=40 class=xl7612143 style='height: 30.0pt'>联系电话</td>
				<td colspan=3 class=xl7612143 style='border-left: none'>${szyzsq.lxfs}</td>
				<td class=xl7612143 style='border-left: none; width: 58pt;font-size: 12.0pt;'>综合窗口接收人</td>
				<td class=xl7612143>
					${assignee }
				</td>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
				<td height=40 class=xl6812143 style='height: 30.0pt'></td>
				<td class=xl6812143></td>
				<td class=xl6812143></td>
				<td class=xl6812143></td>
				<td class=xl6812143></td>
				<td class=xl6812143></td>
				<td class=xl6812143></td>
				<td class=xl6812143></td>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
				<td colspan=8 height=40 class=xl9812143 style='height: 30.0pt'>任丘市<font
					class="font712143">“</font><font class="font712143">四证联办</font><font
					class="font712143">”</font><font class="font712143">收件通知书</font></td>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
				<td colspan=8 height=40 class=xl6812143 style='height: 30.0pt'><span
					style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</span>编号：${szyzsq.sqbh}<span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
				<td colspan=2 height=40 class=xl7612143 style='height: 30.0pt'>企业名称</td>
				<td colspan=6 class=xl7612143 style='border-left: none'>${szyzsq.qymc}</td>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
				<td height=40 class=xl6912143 colspan=3 style='height: 30.0pt'>法人代表或代理人</span></td>
				<td colspan=6 class=xl9912143>${szyzsq.frxm}</td>
			</tr>
			<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
				<td colspan=3 height=40 class=xl7212143
					style='border-right: .5pt solid black; height: 30.0pt'>证件计划领取时间</td>
				<td colspan=2 class=xl7212143
					style='border-right: .5pt solid black; border-left: none'>
					<input id="planTime" name="planTime" type="text"   style="width: 120px" value="${planTime }"/></td>
				<td class=xl6412143 style='border-top: none; border-left: none'>咨询电话</td>
				<td colspan=2 class=xl7212143
					style='border-right: .5pt solid black; border-left: none'>0317-0000000</td>
			</tr>
			<tr height=119 style='mso-height-source: userset; height: 89.25pt'>
				<td colspan=2 height=119 class=xl9312143
					style='border-right: .5pt solid black; height: 89.25pt'>收件情况</td>
					
				<td colspan=6 class=xl9612143 width=424
					style='border-right: .5pt solid black; border-left: none; width: 319pt'>盖章:<font
					class="font612143"><br> </font><font class="font612143">时间:</font></td>
			</tr>
			<tr height=32 style='mso-height-source: userset; height: 24.0pt'>
				<td colspan=8 height=32 class=xl9712143 style='height: 24.0pt'>注：凭此收件通知书，领取相关证照</td>
			</tr>
			<![if supportMisalignedColumns]>
			<tr height=0 style='display: none'>
				<td width=38 style='width: 29pt'></td>
				<td width=66 style='width: 50pt'></td>
				<td width=52 style='width: 39pt'></td>
				<td width=101 style='width: 76pt'></td>
				<td width=45 style='width: 34pt'></td>
				<td width=109 style='width: 82pt'></td>
				<td width=77 style='width: 58pt'></td>
				<td width=92 style='width: 69pt'></td>
			</tr>
			<![endif]>
		</table>
	</div>
</body>
</html>