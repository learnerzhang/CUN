<%@page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录-藏语情感系统</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<link rel="stylesheet" type="text/css" href="css/page.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/md5.js"></script>
<script type="text/javascript" src="js/jquery.json-2.4.js"></script>
<script type="text/javascript">
	function reloadVcode() {
		var img = $("#vcode_image");
		var src = img.attr("src");
		var timestamp = (new Date()).valueOf();
		//时间戳   
		//为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳   
		if (src.indexOf("?") != -1) {
			src = src.substring(0, src.indexOf("?timestamp"));
		}
		src = src + "?timestamp=" + timestamp;
		img.attr("src", src);
	}
	$(function(){
		$("#login").click(function(){
			$("#username").css("border-color","");
			$("#password").css("border-color","");
			$("#vcode").css("border-color","");
			
			var flag = true;
			if ($("#username").val()==""||$("#username").val().trim()=="") {
				$("#username").css("border-color","red").focus();
				flag = false;
			}
			if ($("#password").val()==""||$("#password").val().trim()=="") {
				$("#password").css("border-color","red").focus();
				flag = false;
			}
			if ($("#vcode").val()==""||$("#vcode").val().trim()=="") {
				$("#vcode").css("border-color","red").focus();
				flag = false;
			}
			
			if(!flag)
				return;
			
			var md5 = new MD5();
			var paratmeter = {
					"username" : $("#username").val(),
					"password" : md5.MD5($("#password").val()),
					"vcode" : $("#vcode").val()
				};
			
			$.ajax({
				contentType:"application/json;charset=utf-8",
				url : "ValidateServlet",
				type : "post",
				data : JSON.stringify(paratmeter),
				dataType : "json",
				success : function(data) {
					if (data.hasOwnProperty("code")) {
						if (data.code == "0") {
							window.location.href = "<%=request.getContextPath()%>/";//登录成功.跳转首页...
						} else if (data.code == "1") {
							$("#vcode").css("border-color","red");
						} else if (data.code == "2") {
							$("#username").css("border-color","red");
						}else if (data.code == "3") {
							$("#password").css("border-color","red");
						}
					}
				},
				error:function(){
					
                }
			});	
			return false;
		});
	})
</script>
</head>
<body>

	<!-- 登录页面头部 -->
	<div class="logHead">
		<img src="img/logo.png" height="76px"/>
	</div>
	<!-- 登录页面头部结束 -->

	<!-- 登录body -->
	<div class="logDiv">
		<img class="logBanner" src="img/logBanner.png" />
		<div class="logGet">
			<!-- 头部提示信息 -->
			<div class="logD logDtip">
				<p class="p1">登录</p>
				<p class="p2">藏语情感评测</p>
			</div>
			<!-- 输入框 -->
			<div class="lgD">
				<img class="img1" src="img/logName.png" /><input type="text" placeholder="输入用户名" id="username" name="username"/>
			</div>
			<div class="lgD">
				<img class="img1" src="img/logPwd.png" /><input type="password" placeholder="输入用户密码" id="password" name="password"/>
			</div>
			<div class="lgD logD2">
				<input class="getYZM" type="text" id="vcode" name="vcode"/>
				<div class="logYZM">
					<img onclick="reloadVcode()" id="vcode_image" class="yzm" src="CaptchaServlet" />
				</div>
			</div>
			<div class="logC">
				<button id="login">登 录</button>
			</div>
		</div>
	</div>
	<!-- 登录body  end -->

	<!-- 登录页面底部 -->
	<div class="logFoot">
		<p class="p1">Copyright©版权所有: 个人</p>
		<!-- <p class="p2">南京设易网络科技有限公司 登记序号：苏ICP备11003578号-2</p> -->
	</div>
	<!-- 登录页面底部end -->
</body>
</html>