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
</head>
<body>
	<div id="pageAll">
		<div class="pageTop">
			<div class="page">
				<img src="img/coin02.png" /><span><a href="#">首页</a>&nbsp;-&nbsp;
				<a href="#">资源管理</a>&nbsp;-</span>&nbsp;对比数据
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
							<td width="180px" class="tdColor">用户名</td>
							<!-- <td width="180px" class="tdColor">姓名</td> -->
							<td width="116px" class="tdColor">情感句子</td>
							<td width="116px" class="tdColor">中性句子</td>
							<td width="116px" class="tdColor">标记总数</td>
						</tr>
						<c:forEach items="${datas }" var="info" varStatus="status">
							<tr height="40px">
								<td>${status.index+1 }</td>
								<td>${info.username }</td>
								<%-- <td>${info.name }</td> --%>
								<td>${info.sentiNum }</td>
								<td>${info.neuNum }</td>
								<td>${info.totalNum }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<!-- opinion 表格 显示 end-->
			</div>
			<!-- 页面样式end -->
		</div>
	</div>
</body>
</html>