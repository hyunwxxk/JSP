<%@page import="my.shop.ProductBean"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_cartList.jsp(pnum, oqty) => mall_cartEdit.jsp -->
<!-- 장바구니 목록보기에서 수량을 수정 -->
<jsp:useBean id="mallCart" class="my.shop.mall.CartBean" scope="session"></jsp:useBean>

<%
	String pnum = request.getParameter("pnum");
	String oqty = request.getParameter("oqty");
	
	ProductDao pdao = ProductDao.getInstance();
	ProductBean pb = pdao.getSelectByPnum(Integer.parseInt(pnum)); // pnum에 해당하는 레코드 하나 가져옴
	if(pb.getPqty() < Integer.parseInt(oqty)){
%>
		<script type="text/javascript">
		alert("수량초과");
		location.href="mall.jsp";
		</script>
<%
	return; // 주문수량이 초과하면 주문화면으로 넘어가지 못하도록 return사용
	}
	
	mallCart.setEdit(pnum,oqty); /* mallCart로 관리하는 주문 수량 수정하는 setEdit에 장바구니에 담긴 상품의 수량을 수정 */
	
%>

	<script type="text/javascript">
		alert("주문 수량 수정되었습니다.");
		location.href="mall_cartList.jsp";
	</script>

