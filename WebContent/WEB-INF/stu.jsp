<%@page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员管理-有点</title>
<link rel="stylesheet" type="text/css" href="css/css.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/md5.js"></script>
<script type="text/javascript" src="js/jquery.json-2.4.js"></script>
<!-- <script type="text/javascript" src="js/page.js" ></script> -->
<script type="text/javascript">

	function changeStatus(id){
		$.ajax({
			contentType: "application/json;charset=utf-8",
			url : "StuServlet?type=status&id="+id,
			type : "post",
			dataType : "json",
			success : function(data) {
				if (data.hasOwnProperty("code")) {
					if (data.code == "0") {
						if (data.status=="yes") {
							$("#button"+id).val("yes").css("background-color","#C5E211")
						}else{
							$("#button"+id).val("no").css("background-color","rgba(165, 168, 60, 0.74)")
						}
					} else if (data.code == "1") {
						alert("网络异常....");
					} 
				}
			}
		});	
	}
	$(function() {
		var id = 0;
		//广告弹出框
		$(".delban").click(function(){
		  	id = $(this).attr("id");
		 	$(".banDel").show();
		 	return;
		});
		$(".close").click(function(){
		  	$(".banDel").hide();
		});
		$(".no").click(function(){
		  	$(".banDel").hide();
		});
		$(".yes").click(function(){
		  	$(".banDel").hide();
		  	$.ajax({
				type:"post",
				url:"StuServlet?type=del&id="+id,
				dataType: "json",
				success:function(data){
					if (data.hasOwnProperty("code")) {
						if (data.code == "0") {
							location.reload();//当前页面...
						} else if (data.code == "1") {
							alert("网络异常....");
						} 
					}
				}
			});
		});
		// 广告弹出框 end
		$("#add").click(function() {
			$("#username").css("border-color","");
			$("#password").css("border-color","");
			var flag = true;
			if ($("#username").val()==""||$("#username").val().trim()=="") {
				$("#username").css("border-color","red").focus();
				flag = false;
			}
			if ($("#password").val()==""||$("#password").val().trim()=="") {
				$("#password").css("border-color","red").focus();
				flag = false;
			}
			if(!flag)
				return false;
			var md5 = new MD5();
			var paratmeter = {
					"username" : $("#username").val(),
					"password" : md5.MD5($("#password").val())
				};
			$.ajax({
				contentType:"application/json;charset=utf-8",
				type:"post",
				url:"StuServlet?type=add",
				data : JSON.stringify(paratmeter),
				dataType: "json",
				success:function(data){
					if (data.hasOwnProperty("code")) {
						if (data.code== "0") {
							location.reload();
						} else if (data.code == "1") {
							$("#username").css("border-color","red");
						} 
					}
				},
				error:function(){
					alert("网络延迟,稍后再试...");
                }
			});
			return false;
		});
	});
</script>
</head>
<body>
	<div id="pageAll">
		<div class="pageTop">
			<div class="page">
				<img src="img/coin02.png" /><span><a href="#">首页</a>&nbsp;-&nbsp;<a href="#">网站管理</a>&nbsp;-</span>&nbsp;学生组管理
			</div>
		</div>

		<div class="page">
			<!-- user页面样式 -->
			<div class="connoisseur">
				<div class="conform">
					<form>
						<div class="cfD">
							<input class="userinput" id="username" name="username" type="text" placeholder="输入用户名" />&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;
							<input class="userinput vpr" id="password" name="password" type="text" placeholder="输入用户密码" />
							<button class="userbtn" id="add">添加</button>
						</div>
					</form>
				</div>
				<!-- user 表格 显示 -->
				<div class="conShow">
					<table border="1" cellspacing="0" cellpadding="0">
						<tr>
							<td width="66px" class="tdColor tdC">序号</td>
							<td width="400px" class="tdColor">权限级别</td>
							<td width="400px" class="tdColor">用户名</td>
							<td width="630px" class="tdColor">添加时间</td>
							<td width="130px" class="tdColor">状态</td>
							<td width="130px" class="tdColor">操作</td>
						</tr>
						<c:forEach items="${stus }" var="stu" varStatus="status">
							<tr height="40px">
								<td>${status.index+1+page.beginIndex }</td>
								<td>${stu.type }</td>
								<td>${stu.username }</td>
								<td>${fn:split(stu.createtime,".")[0] }</td>
								<td>
									<c:choose>
											<c:when test="${stu.status=='yes' }">
												<input id="button${stu.id }" onclick="changeStatus(${stu.id })" style="background-color:#C5E211;width:80px;color: #fff" type="button" value="${stu.status }"/>
											</c:when>
											<c:otherwise>
												<input id="button${stu.id }" onclick="changeStatus(${stu.id })" style="background-color:rgba(165, 168, 60, 0.74);width:80px;color: #fff" type="button" value="${stu.status }"/>
											</c:otherwise>
										</c:choose>
								</td>
								<td><img id="${stu.id }" class="operation delban" src="img/delete.png"></td>
							</tr>
						</c:forEach>
						
					</table>
					<div class="paging">此处是分页</div>
				</div>
				<!-- user 表格 显示 end-->
			</div>
			<!-- user页面样式end -->
		</div>
	</div>
	<!-- 删除弹出框 -->
	<div class="banDel">
		<div class="delete">
			<div class="close">
				<a><img src="img/shanchu.png" /></a>
			</div>
			<p class="delP1">你确定要删除此条记录吗？</p>
			<p class="delP2">
				<a href="#" class="ok yes">确定</a><a class="ok no">取消</a>
			</p>
		</div>
	</div>
	<!-- 删除弹出框  end-->
</body>
</html>