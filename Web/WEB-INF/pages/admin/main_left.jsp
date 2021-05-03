<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head></head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="<%=basePath%>font-awesome/css/font-awesome.css" />
</head>

<body>
	<!--sidebar-menu-->
	<div id="sidebar">
		<ul>
			<li class="submenu"><a href="#"><i class="icon icon-group"></i>
					<span>User Control</span> </a>
				<ul>
					<li><a href="<%=basePath%>admin/userList?pageNum=1">User List</a></li>
					<%-- <li><a href="<%=basePath%>admin/user/user_add.jsp">添加用户</a></li> --%>
				</ul>
			</li>
			<li class="submenu"><a href="#"><i class="icon icon-signal"></i>
					<span>Goods Control</span> </a>
				<ul>
					<li><a href="<%=basePath%>admin/goodsList?pageNum=1">Goods List</a></li>
					<%-- <li><a href="<c:url value="/back/agent/addForm"/>">添加商品</a></li> --%>
				</ul>
			</li>
			<li class="submenu"><a href="#"><i class="icon icon-fullscreen"></i>
					<span>Settings</span> </a>
				<ul>
					<li><a href="<%=basePath%>admin/info">Personal Info</a></li>
					<li><a href="<%=basePath%>admin/modify">Change Password</a></li>
				</ul>
			</li>
		</ul>
	</div>
</body>
</html>
