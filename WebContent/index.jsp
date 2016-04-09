<%@page import="com.cun.model.User"%>
<%@page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>藏语情感处理及分析系统</title>
<%
	User user = (User)session.getAttribute("user");
	if(user==null){
		request.getRequestDispatcher("WEB-INF/sys/login.jsp").forward(request, response);
	}
%>
</head>
	<frameset rows="100,*" cols="*" scrolling="No" framespacing="0" frameborder="no" border="0">
	<!-- 引用头部 -->
		<frame src="head" name="headmenu" id="mainFrame" title="mainFrame"></frame>
	<!-- 引用左边和主体部分 --> 
		<frameset rows="100*" cols="220,*" scrolling="No" framespacing="0" frameborder="no" border="0">
			<frame src="left" name="leftmenu" id="mainFrame" title="mainFrame"></frame>
			<frame src="MainServlet?username=${user.username }&type=${user.type }" name="main" scrolling="yes" noresize="noresize" id="rightFrame" title="rightFrame"></frame>
		</frameset>
	</frameset>
</html>