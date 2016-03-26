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
		//TendencyServlet?type=list&flag_tendency=0&page=1
		window.location.href="TendencyServlet?type=list&flag_tendency=0&page="+(index+1);
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
				<img src="img/coin02.png" /><span><a href="#">首页</a>&nbsp;-&nbsp;
				<a href="#">资源管理</a>&nbsp;-</span>&nbsp;情感标记
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
							<td width="440px" class="tdColor">文本</td>
							<td width="180px" class="tdColor">附加信息</td>
							<td width="596px" class="tdColor">词性标志</td>
							<td width="90px" class="tdColor">状态</td>
							<td width="80px" class="tdColor">倾向</td>
						</tr>
						<c:forEach items="${corpus }" var="c" varStatus="status">
							<tr height="40px">
							<td>${status.index+1+page.beginIndex }</td>
							<td>${c.context }</td>
							<td>${c.addition }</td>
							<td>
								<table border="1px solid gray">
									<tr><td>${c.tagging }</td></tr>
									<tr><td>${c.label }</td></tr>
								</table>
							</td>
							<td>
								<c:choose>
									<c:when test="${c.flag_tendency==0}">未标注</c:when>
									<c:when test="${c.flag_tendency==1}">已标注</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${empty c.tendency}">待定</c:when>
									<c:when test="${c.tendency==0}">消极</c:when>
									<c:when test="${c.tendency==1}">中性</c:when>
									<c:when test="${c.tendency==2}">积极</c:when>
								</c:choose>
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
</body>
</html>