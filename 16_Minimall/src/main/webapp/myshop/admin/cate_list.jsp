<%@page import="my.shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
cate_input.jsp => cate_proc.jsp => cate_list.jsp<br>
<%
	CategoryDao cdao = CategoryDao.getInstance();
	ArrayList<CategoryBean> list = cdao.getAllCategory(); 
%>    
<%@ include file="top.jsp" %>
	<td colspan="6" align="center" valign="top">
		<table border=1 width="500" >
			<caption><b>카테고리 목록</b></caption> 
			<tr bgcolor="yellow" >			
				<th width="10%">번호</th>
				<th width="30%">카테고리 코드</th>
				<th width="50%">카테고리 이름</th>
				<th width="10%">삭제</th>
			</tr>
			<%
				if(list.size() == 0){
				%>
					<tr>
						<td colspan="6" align="center">등록된 카테고리가 없습니다.</td>
					</tr>
				<%
				}else{
					for(int i=0; i<list.size(); i++){
					CategoryBean cdto = list.get(i);
				%>			
				<tr class="m3">
					<td><%= cdto.getCnum() %></td>
					<td><%= cdto.getCode() %></td>
					<td><%= cdto.getCname() %></td>
					<td><a href="cate_delete.jsp?cnum=<%= cdto.getCnum() %>">삭제</a></td>
					<!-- cate_delete.jsp에 cnum값을 가지고 넘어간다 -->
				</tr>
			<% 		}
				}
			%>
			
		</table>
		
	</td>
<%@ include file="bottom.jsp" %> 
