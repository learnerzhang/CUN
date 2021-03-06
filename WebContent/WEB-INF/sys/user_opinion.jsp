<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/css.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.json-2.4.js"></script>
<script type="text/javascript">
$(function(){
	$(".btn_yes").click(function(){
		
		if ($("#context").val().trim()=="") {
			return;
		}
		var paratmeter = {
			"username" : "${user.username}",
			"context" : $("#context").val()
		};
		$.ajax({
			contentType:"application/json;charset=utf-8",
			url : "OpinionServlet?type=add",
			type : "post",
			dataType : "json",
			data : JSON.stringify(paratmeter),
			success : function(data) {
				if (data.hasOwnProperty("code")) {
					if (data.code == "0") {
						window.parent.location.reload();//登录成功.跳转首页...
					}else {
						alert("网络异常...");
					} 
				}
			},
			error:function(){
				
            }
		});
	});
});
</script>
<title>添加建议</title>
</head>
<body>
	<div id="pageAll">
		<div class="pageTop">
			<div class="page">
				<img src="img/coin02.png" /><span><a href="#">首页</a>&nbsp;-&nbsp;<a
					href="#">工作内容</a>&nbsp;-</span>&nbsp;反馈建议
			</div>
		</div>
		<div class="page">
			<!-- opinion 页面样式 -->
			<div class="opinion">
				<!-- opinion 表格 显示 -->
				<div class="opShow">
					<div class="bbD">
						<div class="btext2" style="margin-left:20px;">
							<textarea class="text2" id="context" name="context"></textarea>
						</div>
					</div>
					<div class="bbD">
						<p class="bbDP">
							<button class="btn_ok btn_yes" href="#">提交</button>
							<a class="btn_ok btn_no" href="MainServlet?username=${user.username }&type=${user.type }">取消</a>
						</p>
					</div>
				</div>
				<!-- opinion 表格 显示 end-->
			</div>
			<!-- 页面样式end -->
		</div>
	</div>
</body>
</html>