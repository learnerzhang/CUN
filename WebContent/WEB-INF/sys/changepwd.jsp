<%@page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改密码-藏语情感资源</title>
<link rel="stylesheet" type="text/css" href="css/css.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/md5.js"></script>
<script type="text/javascript" src="js/jquery.json-2.4.js"></script>
<script type="text/javascript">
	function checkpwd1() {
		var pwd1 = document.getElementById('pwd1').value.trim();
		var md5 = new MD5();
		if (md5.MD5(pwd1) == "${user.password}") {
			$("#pwd1").parent().find(".imga").show();
			$("#pwd1").parent().find(".imgb").hide();
			return true;
		} else{
			$("#pwd1").parent().find(".imgb").show();
			$("#pwd1").parent().find(".imga").hide();
			return false;
		}
	}
	function checkpwd2() {
		var user = document.getElementById('pwd2').value.trim();
		
		if (user.length >0 && user.length <=20) {
			$("#pwd2").parent().find(".imga").show();
			$("#pwd2").parent().find(".imgb").hide();
			return true;
		} else {
			$("#pwd2").parent().find(".imgb").show();
			$("#pwd2").parent().find(".imga").hide();
			return false;
		}
	}
	function checkpwd3() {
		var user = document.getElementById('pwd3').value.trim();
		var pwd = document.getElementById('pwd2').value.trim();
		
		if (user.length >0 && user.length <=20 && user == pwd) {
			$("#pwd3").parent().find(".imga").show();
			$("#pwd3").parent().find(".imgb").hide();
			return true;
		} else {
			$("#pwd3").parent().find(".imgb").show();
			$("#pwd3").parent().find(".imga").hide();
			return false;
		}
	}
	$(document).ready(function() {
		$(".btn_yes").click(function(){
			
			var flag = true;
			if (checkpwd1()&&checkpwd2()&&checkpwd3()) {
				flag = true;
			}else{
				flag = false;
			}
			if (!flag) {
				return;
			}
			var md5 = new MD5();
			var paratmeter = {
					"id" : "${user.id}",
					"pwd1" : md5.MD5($("#pwd1").val()),
					"pwd2" : md5.MD5($("#pwd2").val()),
					"pwd3" : md5.MD5($("#pwd3").val())
			};
			$.ajax({
				contentType:"application/json;charset=utf-8",
				url : "UserServlet?type=update_pwd",
				type : "post",
				data : JSON.stringify(paratmeter),
				dataType : "json",
				success : function(data) {
					if (data.hasOwnProperty("code")) {
						if (data.code == "0") {
							window.parent.location.reload();//登录成功.跳转首页...
						} else if (data.code == "1") {//原密码错误
							$("#pwd1").parent().find(".imgb").show();
							$("#pwd1").parent().find(".imga").hide();
						} else if (data.code == "2") {//两个密码不一致
							$("#pwd3").parent().find(".imgb").show();
							$("#pwd3").parent().find(".imga").hide();
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
					href="#">系统管理</a>&nbsp;-</span>&nbsp;修改密码
			</div>
		</div>
		<div class="page ">
			<!-- 修改密码页面样式 -->
			<div class="bacen">
				<div class="bbD">
					&nbsp;&nbsp;&nbsp;&nbsp;管理员UID：&nbsp;&nbsp;&nbsp;&nbsp;${user.id }</div>
				<div class="bbD">管理员用户名：&nbsp;&nbsp;&nbsp;&nbsp;${user.username }</div>
				<div class="bbD">
					&nbsp;&nbsp;&nbsp;&nbsp;输入旧密码：<input type="password" class="input3"
						onblur="checkpwd1()" id="pwd1" /> <img class="imga"
						src="img/ok.png" /><img class="imgb" src="img/no.png" />
				</div>
				<div class="bbD">
					&nbsp;&nbsp;&nbsp;&nbsp;输入新密码：<input type="password" class="input3"
						onblur="checkpwd2()" id="pwd2" /> <img class="imga"
						src="img/ok.png" /><img class="imgb" src="img/no.png" />
				</div>
				<div class="bbD">
					再次确认密码：<input type="password" class="input3" onblur="checkpwd3()"
						id="pwd3" /> <img class="imga" src="img/ok.png" /><img
						class="imgb" src="img/no.png" />
				</div>
				<div class="bbD">
					<p class="bbDP">
						<button class="btn_ok btn_yes" href="#">提交</button>
						<a class="btn_ok btn_no" href="main" target="main">取消</a>
					</p>
				</div>
			</div>

			<!-- 修改密码页面样式end -->
		</div>
	</div>
</body>
</html>