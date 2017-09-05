<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type='text/javascript' src='/dwrPullMsg_pro/dwr/engine.js'></script>
    <script type='text/javascript' src='/dwrPullMsg_pro/dwr/interface/common.js'></script>
    <script type='text/javascript' src='/dwrPullMsg_pro/dwr/util.js'></script>
  	<link rel="stylesheet" href="css/common.css">
  	<style type="text/css">
  		.msgContent img{
  			width:190px;
  			margin:0px auto;
  			height:180px;
  		}
  	</style>
  	<script type="text/javascript">
  		window.onload=initPage;
  		function initPage(){
  			dwr.engine.setActiveReverseAjax(true);
  		}
  		
  		function usershow(msg){
			var splitObj=msg.split("|");
			$("banner").style.display="block";
			$("titleMsg").innerHTML=splitObj[0];
			$("imgpath").setAttribute("src",splitObj[1]);
		}
		
		function $(id){
			return document.getElementById(id);
		}
  	</script>
  </head>
  
  <body>
    <div class="banner" id="banner">
		<div class="msgTitle"><span id="titleMsg"></span></div>
		<div class="msgContent"><img id="imgpath"></div>
	</div>
  </body>
</html>
