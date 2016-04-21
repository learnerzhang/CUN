<%@page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>行家编辑-有点</title>
<link rel="stylesheet" type="text/css" href="css/css.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".btn_yes").click(function(){
			
			$("#name").css("border-color","");
			$("#phone").css("border-color","");
			$("#email").css("border-color","");
			
			var flag = true;
			
			if($("#name").val().trim()==""){
				$("#name").css("border-color","red");
				flag = false;
			}
			
			if (! /^1[0-9]{10}/.test($("#phone").val())) {
				$("#phone").css("border-color","red");
				flag = false;
			}
			if (! /[a-zA-Z0-9]{1,10}@[a-zA-Z0-9]{1,5}\.[a-zA-Z0-9]{1,5}/.test($("#email").val())) {
				$("#email").css("border-color","red");
				flag = false;
			}
			
			if (!flag) {
				return;
			}
			var paratmeter;
			if ("${user.type}"=='2') {//学生
				
				var card = $("#bcid").val().trim();
				var uid = $("#uid").val().trim();
				if(card.length!=19 && isNaN(card)){
					$("#bcid").css("border-color","red");
					return;
				}
				if(uid.length!=18){
					$("#uid").css("border-color","red");
					return;
				}
				paratmeter = {
						"id" : "${user.id}",
						"name" : $("#name").val(),
						"uid" : $("#uid").val(),
						"bcid" : $("#bcid").val(),
						"phone" : $("#phone").val(),
						"email" : $("#email").val(),
						"sex" : $("#sex").val()
				};
				
			}else{
				paratmeter = {
						"id" : "${user.id}",
						"name":$("#name").val(),
						"phone" : $("#phone").val(),
						"email" : $("#email").val(),
						"sex" : $("#sex").val()
				};
				
			}
			//alert(JSON.stringify(paratmeter))
			$.ajax({
				contentType:"application/json;charset=utf-8",
				url : "UserServlet?type=update_info",
				type : "post",
				data : JSON.stringify(paratmeter),
				dataType : "json",
				success : function(data) {
					if (data.hasOwnProperty("code")) {
						if (data.code == "0") {
							window.parent.location.reload();//登录成功.跳转首页...
						} else if (data.code == "1") {//原密码错误
							alert("网络异常,请稍后再试...");
						} 
					}
				},
				error:function(){
					
                }
			});	
		});
	});
</script>
</head>
<body>
	<div id="pageAll">
		<div class="pageTop">
			<div class="page">
				<img src="img/coin02.png" /><span><a href="#">首页</a>&nbsp;-&nbsp;<a
					href="#">系统管理</a>&nbsp;-</span>&nbsp;个人信息
			</div>
		</div>
		<div class="page ">
			<!-- 上传广告页面样式 -->
			<div class="banneradd bor">
				<div class="baTopNo">
					<span>信息编辑</span>
				</div>
				<div class="baBody">
					<div class="bbD">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户名称：<input disabled="disabled" type="text" class="input3" id="username" value="${user.username }"/>
					</div>
					<div class="bbD">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：<input type="text" class="input3" id="name" value="${user.name }"/>
					</div>
					<c:if test="${user.type eq '2' }">
						<div class="bbD"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;身份证号：<input type="text" class="input3" id="uid" value="${user.uid }"/>
						</div>
						<div class="bbD"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;银行卡号：<input type="text" class="input3" id="bcid" value="${user.bcid }"/>
						</div>
					</c:if>
					<div class="bbD"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;手机号码：<input type="text" class="input3" id="phone" value="${user.phone }"/>
					</div>
					<div class="bbD">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：<input type="text" class="input3" id="email" value="${user.email }"/>
					</div>
					<div class="bbD"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：
					<select class="input3" id="sex">
						<c:choose>
							<c:when test="${empty user.sex}"><option value="m">男</option><option value="f">女</option></c:when>
							<c:when test="${user.sex eq 'm'}"><option value="m" selected="selected">男</option><option value="f">女</option></c:when>
							<c:when test="${user.sex eq 'f'}"><option value="f" selected="selected">女</option><option value="m">男</option></c:when>
						</c:choose>
					</select>
					</div>
					<div class="bbD">
						<p class="bbDP">
							<button class="btn_ok btn_yes">提交</button>
							<a class="btn_ok btn_no" href="main" target="main">取消</a>
						</p>
					</div>
				</div>
			</div>
			<!-- 上传广告页面样式end -->
		</div>
	</div>
</body>
</html>