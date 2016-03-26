<%@page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>头部-有点</title>
<link rel="stylesheet" type="text/css" href="css/public.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<script type="text/javascript">
	$(function(){
		$("#logout").click(function(){
			$.ajax({
				contentType:"application/json;charset=utf-8",
				url : "LogoutServlet",
				type : "get",
				dataType : "json",
				success : function(data) {
					if (data.hasOwnProperty("code")) {
						if (data.code == "0") {
							window.parent.location.reload();//登录成功.跳转首页...
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
	<!-- 头部 -->
	<div class="head">
		<div class="headL">
			<img style="padding-top:0px" class="headLogo" src="img/head.png" />
		</div>
		<div class="headR">
			<p class="p1">
				欢迎, ${user.username }
			</p>
			<p class="p2">
				<a href="changepwd" class="resetPWD"  target="main">重置密码</a>&nbsp;&nbsp;
				<a id="logout" class="goOut">退出</a>
			</p>
		</div>
		<!-- onclick="{if(confirm(&quot;确定退出吗&quot;)){return true;}return false;}" -->
	</div>

	<div class="closeOut">
		<div class="coDiv">
			<p class="p1">
				<span>X</span>
			</p>
			<p class="p2">确定退出当前用户？</p>
			<P class="p3">
				<a class="ok yes" href="#">确定</a><a class="ok no" href="#">取消</a>
			</p>
		</div>
	</div>
</body>
</html>