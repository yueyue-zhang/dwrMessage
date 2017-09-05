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
	<style type="text/css">
		.content{
			width: 100%;
			height: 80%;
			background-color: antiquewhite;
		}
		
		.selecttype{
			display: block;
			width: 100%;
			height: 20px;
		}
		
		.selecttype select{
			display: block;
			width: 60%;
			height: 20px;
			margin: 0px auto;
		}
		
		.msgcontent{
			width: 100%;
			display: block;
			margin-top: 10px;
			display: none;
		}
		
		.automsg{
			width: 100%;
			display: block;
			margin-top: 10px;
			display: none;
		}
		
		.msgcontent div{
			width: 90%;
			text-align: center;
		}
		
		.msgcontent div:nth-child(1) input{
			width: 80%;
			margin-bottom: 10px;
		}
		
		.msgcontent div:nth-child(2) textarea{
			width: 90%;
		}
		
		.msgcontent div:nth-child(4) input{
			width: 80%;
			margin-top: 10px;
			text-align: center;
		}
		
		.automsg div:nth-child(2) input{
			width: 80%;
			margin-top: 10px;
			text-align: center;
		}
	</style>
	<script type='text/javascript' src='/dwrPullMsg_pro/dwr/engine.js'></script>
    <script type='text/javascript' src='/dwrPullMsg_pro/dwr/interface/common.js'></script>
    <script type='text/javascript' src='/dwrPullMsg_pro/dwr/util.js'></script>
	<script type="text/javascript">
		window.onload=initPage;
		var selectValue,
			proName,
			folderName,
			fileName,
			splitArray,
			pullStr,
			btnObj;
		function initPage(){
			//获得可以推送的.jsp页面或.html页面
			common.getPage(function(data){
				console.log(data);
				proName=data[0];
				pullStr="<lable>请选择您想推送的页面</lable><br>";
				for(var i=1;i<data.length;i++){
					splitArray=data[i].split("\\");
					folderName=splitArray[splitArray.length-2];
					fileName=splitArray[splitArray.length-1];
					/*  <lable for="">请选择您想推送的页面</lable>
						<br>
						<input type="checkbox">a.jsp
						<input type="checkbox">b.jsp
						<br>
						user包下:<input type="checkbox">c.jsp */
					console.log(folderName+","+proName);//admin,dwrPullMsg_pro ; dwrPullMsg_pro,dwrPullMsg_pro
					if(folderName==proName){
						pullStr+="<span>WebRoot</span>";
					}else{
						pullStr+="<span>"+folderName+"</span>";
					}
					pullStr+="<input type='checkbox' name='checks' value="+fileName+">"+fileName+"<br>";
				}
				$("pullPage").innerHTML=pullStr;
				$("autopullPage").innerHTML=pullStr;
			});
			var selectObj=$("selectId");
			selectObj.onchange=function(){
				selectValue=this.value;
				if(selectValue==1){
					//手动推送
					$("msgcontent").style.display="block";
					$("automsg").style.display="none";
				}else{
					//自动推送
					$("msgcontent").style.display="none";
					$("automsg").style.display="block";
				}
			};
			//推送按钮点击，获取用户勾选
			$("btnObj").onclick=clickBtn;
			$("autoBtn").onclick=autoBtn;
		}
		function $(id){
			return document.getElementById(id);
		}
		
		function autoBtn(){
			param=commonClick();
			common.sendMsg(param);
		}
		
		function commonClick(){
			var checkFile=null,
				previousSibling,
			    k=0,
			    paramlists=null,
			    param=[];
			var checkObj=document.getElementsByName("checks");
			for(var j=0;j<checkObj.length;j++){
				console.log(checkObj[j].checked);
				if(checkObj[j].checked){
					checkFile=checkObj[j].value;
					//获取上一个元素的值
					previousSibling=checkObj[j].previousSibling.innerText;
					if(previousSibling!="WebRoot"){
						paramlists=previousSibling+"/"+checkFile;
					}else{
						paramlists=checkFile;
					}
					param[k++]=paramlists;
				}
			}
			for(var i=0;i<param.length;i++){
				console.log(i+":"+param[i]);
			}
			return param;
		}
		
		function clickBtn(){
			//获取管理员勾选的页面 以及其对应的包
			var msgTitle,
				msgContent,
				msg;
			msgTitle=$("msgTitle").value;
			msgContent=$("msgContent").value;
			msg=msgTitle+"|"+msgContent;
			param=commonClick();
			//common.sendMsg(param);
			common.sendMsg(param,msg);
		}
	</script>
  </head>
  
  <body>
	<h1>管理员推送消息</h1>
	<hr>
	<div class="selecttype">
		<select id="selectId">
			<option value="-1">请选择推送方式</option>
			<option value="1">手动推送</option>
			<option value="2">自动推送</option>
		</select>
	</div>
	
	<!--如果是手动推送方式，则出现这个div-->
	<div class="msgcontent" id="msgcontent">
		<div>
			<input type="text" placeholder="请输入推送消息的标题" id="msgTitle">
		</div>
		<div>
			<textarea name="" cols="55" rows="10" placeholder="请输入您想推送的消息" id="msgContent"></textarea>
		</div>
		<div id="pullPage">
		</div>
		<div>
			<input type="button" value="推送" id="btnObj">
		</div>
	</div>
	
	<div class="automsg" id="automsg">
		<div id="autopullPage">
		</div>
		<div>
			<input type="button" value="自动推送" id="autoBtn">
		</div>
	</div>
</body>
</html>
