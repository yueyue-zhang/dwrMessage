<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'bidding.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
		div{
			margin-top: 10px;
			text-align: center;
		}
	</style>
	  <script type='text/javascript' src='/dwrPullMsg_pro/dwr/engine.js'></script>
  	  <script type='text/javascript' src='/dwrPullMsg_pro/dwr/interface/bidding.js'></script>
	  <script type='text/javascript' src='/dwrPullMsg_pro/dwr/util.js'></script>
	  
  </head>
  
  <body>
    <h1>公司竞价</h1>
	<hr>
	<div><input type="text" placeholder="请输入公司名字" id="biddingCompany"></div>
	<!--以后可以扩展为上传图片-->
	<div><input type="text" placeholder="请输入图片路径" id="biddingImgpath"></div>
	<div><input type="text" placeholder="请输入竞价价格" id="biddingPrice"></div>
	<div><input type="button" value="提交" id="biddingSubmit"></div>
	
	<script type="text/javascript">
		$("biddingSubmit").onclick=btnClick;
		function btnClick(){
			var biddingCompany,
				biddingImgpath,
				biddingPrice;
			biddingCompany=$("biddingCompany").value;
			biddingImgpath=$("biddingImgpath").value;
			biddingPrice=$("biddingPrice").value;
			bidding.insertBidding(biddingCompany,biddingImgpath,biddingPrice);
		}
		
		function $(id){
			return document.getElementById(id);
		}
	  </script>
  </body>
</html>
