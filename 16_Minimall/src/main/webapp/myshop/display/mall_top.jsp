<%@page import="my.shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
myshop\display\mall_top.jsp<br>
<link rel="stylesheet" href="<%=request.getContextPath()%>/style.css" type="text/css">
<style>
	.right{
		float:right;
	} 
</style>
<%
	String cPath = request.getContextPath();
	String id = request.getParameter("id");
	System.out.println("mall_top.jsp id:" + id);
	
	String memid = (String)session.getAttribute("memid");
	System.out.println("mall_top.jsp memid:" + memid);
%>
<table border="1" align="center" width="800">
	<tr height="50">
		<td colspan="2" align="center">
			<a href="<%=cPath %>/main.jsp">HOME</a>|
			<%
				if(memid.equals("admin")){
					
			%>
				<a href="<%=cPath %>/myshop/admin/main.jsp">관리자홈</a>|
			<%
				}
			%>
			<a href="<%=cPath %>/myshop/display/mall.jsp">쇼핑몰홈</a>|
			<a href="<%=cPath %>/myshop/display/mall_cartList.jsp">장바구니</a>|
			<a href="<%=cPath %>/myshop/board/list.jsp">게시판</a>|
			<a href="<%=cPath %>/myshop/display/company.jsp">회사소개</a>
			
			<a href="<%=cPath %>/logout.jsp" class="right">
				<img src="<%=cPath%>/img/logout3.jpg" width="50" height="20">
			</a>
			<span class="right"><%=memid %>님</span>
		</td>
	</tr>
	<tr height="400">
		<td valign="top" width="150" align="center">
			<table border="1">
				<caption><b>카테고리</b></caption>
				<%
				CategoryDao cdao = CategoryDao.getInstance();
				ArrayList<CategoryBean> lists = cdao.getAllCategory();
				
				if(lists.size() == 0){
				%>
					<tr>
						<td>
							카테고리가 없습니다.
						</td>
					</tr>
				<%	
			}else{
				for(CategoryBean cb: lists){
			%>
					<tr>
						<td>
							<a href="mall_cgList.jsp?code=<%=cb.getCode() %>&cgname=<%=cb.getCname() %>"><%=cb.getCname() %>[<%=cb.getCode() %>]</a>
						</td>
					</tr>
			<%
				}//for
			}//else
			%>
			</table>
		</td>
		<td align="center" valign="top">     
		
		
	