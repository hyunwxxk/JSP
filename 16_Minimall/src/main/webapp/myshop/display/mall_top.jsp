<%@page import="my.shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/style.css" type="text/css">
<style>
	.right{
		float:right;
	}
</style>
myshop\display\mall_top.jsp<br>

<%
	String cPath = request.getContextPath();
%>

<body align="center">
<table border="1" align="center" width="800">
	<tr height="50">
		<td colspan="2" align="center">
			<a href="<%= cPath %>/main.jsp">HOME</a>|
			<a href="<%= cPath %>/myshop/admin/main.jsp">관리자홈</a>|
			<a href="<%= cPath %>/myshop/display/mall.jsp">쇼핑몰홈</a>|
			<a href="<%= cPath %>/myshop/display/mall_cartList.jsp">장바구니</a>|
			<a href="<%= cPath %>/myshop/board/list.jsp">게시판</a>|
			<a href="<%= cPath %>/myshop/display/company.jsp">회사소개</a>
			
			<a href="<%= cPath %>/logout.jsp" class="right">
				<img src="<%= cPath %>/img/logout.jpg" width="50" height="30">
			</a>
			<span class="right">admin님</span>
		</td>
	</tr>
	<tr  height="400">
		<td valign="top" width="150" align="center">
			<table border="1">
			<caption><b>카테고리</b></caption>
				<%
				CategoryDao cdao = CategoryDao.getInstance();
				ArrayList<CategoryBean> lists = cdao.getAllCategory();
				
					if(lists.size() == 0){
				%>
					<tr>
						<td>카테고리가 없습니다.</td>
					</tr>
				<%
					}else{
						for(CategoryBean cb : lists){
				%>
					<tr>
						<td>
							<a href=""><%= cb.getCname() %>[<%= cb.getCode() %>]</a>
						</td>
					</tr>
				<%
						}
					}
				%>
			</table>
		</td>
		<td>