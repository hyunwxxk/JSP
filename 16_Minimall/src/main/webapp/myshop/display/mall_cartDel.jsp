<%@page import="my.shop.ProductDao"%>
<%@page import="my.shop.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_cartList.jsp(pnum) => mall_cartDel.jsp -->

<jsp:useBean id="mallCart" class="my.shop.mall.CartBean" scope="session"></jsp:useBean>

<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));

	mallCart.deleteByPnum(pnum); 
%>

	<script type="text/javascript">
		alert("상품이 삭제되었습니다.");
		location.href="mall_cartList.jsp";
	</script>
