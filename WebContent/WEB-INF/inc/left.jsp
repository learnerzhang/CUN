<%@page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页左侧导航</title>
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
<body id="bg">
	<!-- 左边节点 -->
	<div class="container">

		<div class="leftsidebar_box">
			<a href="main" target="main">
				<div class="line">
					<img src="img/coin01.png" />&nbsp;&nbsp;首页
				</div>
			</a>
			<!-- <dl class="system_log">
			<dt><img class="icon1" src="../img/coin01.png" /><img class="icon2"src="../img/coin02.png" />
				首页<img class="icon3" src="../img/coin19.png" /><img class="icon4" src="../img/coin20.png" /></dt>
		</dl> -->
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin03.png" /><img class="icon2"
						src="img/coin04.png" /> 网站管理<img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a class="cks" href="AdminServlet?type=list&page=1"
						target="main">管理员</a><img class="icon5" src="img/coin21.png" />
				</dd>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a class="cks" href="TeachServlet?type=list&page=1"
						target="main">教师组</a><img class="icon5" src="img/coin21.png" />
				</dd>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a class="cks" href="StuServlet?type=list&page=1"
						target="main">学生组</a><img class="icon5" src="img/coin21.png" />
				</dd>
			</dl>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin05.png" /><img class="icon2"
						src="img/coin06.png" /> 资源管理<img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a class="cks" href="banner"
						target="main">语料管理</a><img class="icon5" src="img/coin21.png" />
				</dd>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a class="cks" href="banner"
						target="main">广告管理</a><img class="icon5" src="img/coin21.png" />
				</dd>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22" src="img/coin222.png" /><a class="cks" href="opinion" target="main">意见管理</a><img class="icon5" src="img/coin21.png" />
				</dd>
			</dl>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin07.png" /><img class="icon2"
						src="img/coin08.png" /> 会员管理<img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
				<dd>
					<img class="coin11" src="img/coin111.png" />
					<img class="coin22" src="img/coin222.png" />
					<a href="vip" target="main" class="cks">会员管理</a>
					<img class="icon5" src="img/coin21.png" />
				</dd>
			</dl>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin10.png" /><img class="icon2"
						src="img/coin09.png" /> 行家管理<img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a href="connoisseur"
						target="main" class="cks">行家管理</a><img class="icon5"
						src="img/coin21.png" />
				</dd>
			</dl>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin11.png" /><img class="icon2"
						src="img/coin12.png" /> 话题管理<img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a href="topic" target="main"
						class="cks">话题管理</a><img class="icon5" src="img/coin21.png" />
				</dd>
			</dl>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin14.png" /><img class="icon2"
						src="img/coin13.png" /> 心愿管理<img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a href="wish" target="main"
						class="cks">心愿管理</a><img class="icon5" src="img/coin21.png" />
				</dd>
			</dl>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin15.png" /><img class="icon2"
						src="img/coin16.png" /> 约见管理<img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a href="appointment"
						target="main" class="cks">约见管理</a><img class="icon5"
						src="img/coin21.png" />
				</dd>
			</dl>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coin17.png" /><img class="icon2"
						src="img/coin18.png" /> 收支管理<img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a href="balance"
						target="main" class="cks">收支管理</a><img class="icon5"
						src="img/coin21.png" />
				</dd>
			</dl>
			<dl class="system_log">
				<dt>
					<img class="icon1" src="img/coinL1.png" /><img class="icon2"
						src="img/coinL2.png" /> 系统管理<img class="icon3"
						src="img/coin19.png" /><img class="icon4"
						src="img/coin20.png" />
				</dt>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a href="changepwd"
						target="main" class="cks">修改密码</a><img class="icon5"
						src="img/coin21.png" />
				</dd>
				<dd>
					<img class="coin11" src="img/coin111.png" /><img class="coin22"
						src="img/coin222.png" /><a class="cks" id="logout">退出</a><img
						class="icon5" src="img/coin21.png" />
				</dd>
			</dl>
		</div>
	</div>
</body>
</html>
