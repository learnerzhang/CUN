<%@page contentType="text/html;charset=utf-8" %>
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
<script type="text/javascript" src="js/jquery.pagination.js"></script>
<script type="text/javascript">
	function PageCallback(index) { 
		window.location.href="OpinionServlet?type=list&page="+(index+1);
	}
	
	$(document).ready(function() {
		$("#Pagination").pagination("${page.totalPage }",{
			current_page:"${page.currentPage-1}",
			callback: PageCallback
		});
	});
</script>
</head>
<body>
	<div id="pageAll">
		<div class="pageTop">
			<div class="page">
				<img src="img/coin02.png" /><span><a href="#">首页</a>&nbsp;-&nbsp;<a
					href="#">网站管理</a>&nbsp;-</span>&nbsp;意见管理
			</div>
		</div>
		<div class="page">
			<!-- opinion 页面样式 -->
			<div class="opinion">
				<!-- opinion 表格 显示 -->
				<div class="opShow">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="66px" class="tdColor tdC">序号</td>
							<td width="440px" class="tdColor">反馈时间</td>
							<td width="396px" class="tdColor">用户名</td>
							<td width="760px" class="tdColor">内容</td>
						</tr>
						<c:forEach items="${opinions }" var="opinion" varStatus="status">
							<tr height="40px">
								<td>${status.index+1+page.beginIndex }</td>
								<td>${fn:split(opinion.timestamp,' ')[0] }</td>
								<td>${opinion.username }</td>
								<td>${opinion.context }</td>
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
</body>
</html>