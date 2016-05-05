<%@page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>头部-有点</title>
<link rel="stylesheet" type="text/css" href="css/css.css" />
<link rel="stylesheet" type="text/css" href="css/reset.css" />
<link rel="stylesheet" type="text/css" href="css/pagination.css" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.json-2.4.js"></script>
<script type="text/javascript" src="js/jquery.pagination.js"></script>
<style type="text/css">
.tendency {
	margin: auto;
	font-size: 15px;
	height: 30px;
	width: 70px;
	color: #fff;
	padding-top: 11px;
}
.checkbox {
	width: 120px;
	height: 40px;
	background: #D2C755;
	margin: 0px 0px 0px 40px;
	border-radius: 50px;
	position: relative;
}
.checkbox:before {
	content: '积极';
	position: absolute;
	top: 6px;
	left: 13px;
	height: 2px;
	color: #1971FA;
	font-size: 20px;
}
.checkbox:after {
	content: '消极';
	position: absolute;
	top: 6px;
	left: 72px;
	height: 2px;
	color: rgb(153, 150, 150);
	font-size: 20px;
}
.checkbox label {
	display: block;
	width: 56px;
	height: 30px;
	border-radius: 50px;
	margin-left: 0px;
 
	transition: all .5s ease;
	cursor: pointer;
	position: absolute;
	top: 5px;
	z-index: 1;
	left: 12px;
	background: rgb(153, 150, 150);
}
.checkbox input[type=checkbox]:checked + label {
	left: 60px;
	background: #1971FA;
}
</style>
<script type="text/javascript">
	function PageCallback(index) {
		window.location.href = "MarkDataServlet?type=info&page=" + (index + 1);
	}

	$(document).ready(function() {
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
				url:"MarkDataServlet?type=reset&id="+id,
				dataType: "json",
				success:function(data){
					if (data.hasOwnProperty("code")) {
						if (data.code == "0") {
							window.location.href="<%=request.getContextPath()%>/MarkDataServlet?type=info&page=1";//...
							//location.reload();//MarkDataServlet?type=info&page=1当前页面...
						} else if (data.code == "1") {
							alert("网络异常....");
						} 
					}
				}
			});
		});
		
		$("#add").click(function(){
			var tendency;
			if ($("input[type='checkbox']").is(':checked')==true) {
				tendency = "2";
			}else{
				tendency = "0";
			}
			
			$("#context").css("border-color","");
			if ($("#context").val().trim()=="") {
				$("#context").css("border-color","red").focus();
				return false;
			}
			
			var paratmeter = {
					"username" : "${user.username}",
					"tendency" : tendency,
					"context" : $("#context").val()
				};
			//alert(JSON.stringify(paratmeter));
			$.ajax({
				contentType:"application/json;charset=utf-8",
				type:"post",
				url:"TendencyServlet?type=add",
				data : JSON.stringify(paratmeter),
				dataType: "json",
				success:function(data){
					if (data.hasOwnProperty("code")) {
						if (data.code == "0") {
							window.location.href="<%=request.getContextPath()%>/MarkDataServlet?type=info&page=1";//...
							//location.reload();//MarkDataServlet?type=info&page=1当前页面...
						} else if (data.code == "1") {
							alert("网络异常....");
						} 
					}
				}
			});
			
			return false;
		});
		$("#Pagination").pagination("${page.totalPage }", {
			current_page : "${page.currentPage-1}",
			callback : PageCallback
		});
	});
</script>
</head>
<body>
	<div id="pageAll">
		<div class="pageTop">
			<div class="page">
				<img src="img/coin02.png" /><span><a href="#">首页</a>&nbsp;-&nbsp;<a
					href="#">工作详情</a>&nbsp;-</span>&nbsp;个人数据
			</div>
		</div>
		<div class="page">
			<!-- opinion 页面样式 -->
			<div class="opinion">
			
				<!-- <div class="conform">
					<form>
						<div class="cfD">
							<div style="float: left;"><input class="userinput" style="width: 280px;" id="context" name="context" type="text" placeholder="藏语情感句" /></div>
							<div class="checkbox" style="float: left;">
						  		<input type="checkbox" value="2" id="checkbox" name="tendency" style="visibility: hidden;margin: 3px 3px 3px 4px;"/>
							  	<label for="checkbox"></label>
						  	</div>
							<button class="userbtn" id="add">添加</button>
						</div>
					</form>
				</div> -->
				<!-- opinion 表格 显示 -->
				<div class="opShow">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="66px" class="tdColor tdC">序号</td>
							<td width="440px" class="tdColor">文本</td>
							<td width="260px" class="tdColor">情感倾向</td>
							<td width="260px" class="tdColor">否定副词</td>
							<td width="260px" class="tdColor">程度副词</td>
							<td width="760px" class="tdColor">关键词</td>
							<td width="130px" class="tdColor">修辞类型</td>
							<td width="130px" class="tdColor">操作</td>
						</tr>
						<c:forEach items="${corpus }" var="c" varStatus="status">
							<tr height="40px">
								<td>${status.index+1+page.beginIndex }</td>
								<td><p style="font-size: 16px; font-weight: bold;">${c.context }</p></td>
								<td>${c.tendency }</td>								
								<td>${c.negative }</td>
								<td>${c.degree }</td>
								<td>${c.feature }</td>
								<td>${c.type }</td>
								<td>
									<a href="MarkDataServlet?type=load&page=${page.currentPage}&id=${c.id }">
										<img class="operation" src="img/update.png">
									</a>
									<c:if test="${user.type eq '0' }">
										<img id="${c.id }" class="operation delban" src="img/delete.png">
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
					<div class="pages">
						<div id="Pagination" style="float: right;"></div>
						<%-- <div class="searchPage" style="float: right;">
				        	<span class="page-sum">共<strong class="allPage">${page.totalPage }</strong>页</span>
				          	<span class="page-go">跳转<input type="text">页</span>
				        	<a href="javascript:;" class="page-btn">GO</a>
				        </div> --%>
					</div>
				</div>
				<!-- opinion 表格 显示 end-->
			</div>
			<!-- 页面样式end -->
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