<%@page import="my.shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	function checkDel(pnum, pimage){
		var answer = window.confirm("정말 삭제하시겠습니까?"); // 확인, 취소
		//alert(answer);
		
		if(answer){ // 확인
			location.href="prod_deletePro.jsp?pnum="+pnum+"&pimage=" + pimage;
		}
	}
</script>
<%@ include file="top.jsp" %>
	<td colspan="6" align="center" valign="top">
<%
    ProductDao pdao = ProductDao.getInstance();
    ArrayList<ProductBean> lists = pdao.getAllProducts(); 
%>
		<table class = "outline" width="95%">
		<caption><b>상품목록</b></caption>
			<tr class = "m2">
				<th>번호</th>
				<th>상품코드</th>
				<th>상품명</th>
				<th>이미지</th>
				<th>가격</th>
				<th>제조사</th>
				<th>수량</th>
				<th>수정|삭제</th>
			</tr>	
			<%
			if(lists.size() == 0){
			%>
				<tr><td colspan = "8">등록된 상품이 없습니다.</td></tr>
			<%	
			}	else{
					for(ProductBean pdto : lists){
						String imgPath = request.getContextPath()+"/myshop/images/"+pdto.getPimage();
						System.out.println("imgPath:" + imgPath);
				%>
					<tr>
						<td><%= pdto.getPnum() %></td>
						<td><%= pdto.getPcategory_fk() %></td>
						<td><%= pdto.getPname() %></td>
						<td><img src = "<%=imgPath %>" width="30" height="30"></td>
						<td><%= pdto.getPrice() %></td>
						<td><%= pdto.getPcompany() %></td>
						<td><%= pdto.getPqty() %></td>
						<td>
							<a href = "prod_update.jsp?pnum=<%= pdto.getPnum() %>">수정</a>|
							<a href = "javascript:checkDel('<%= pdto.getPnum() %>','<%=pdto.getPimage()%>')">삭제</a></td>
					</tr>
				<%
					}//for
				}//else
			%>
		</table>
		
	</td>  
<%@ include file="bottom.jsp" %>   





