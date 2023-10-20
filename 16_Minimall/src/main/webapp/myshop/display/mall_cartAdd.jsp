<%@page import="my.shop.ProductBean"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_prodView.jsp(장바구니 클릭 -> 상품번호, 주문수량) => mall_cartAdd.jsp -->

<jsp:useBean id="mallCart" class="my.shop.mall.CartBean" scope="session"></jsp:useBean> 
<!-- useBean 액션 태그는 객체를 생성 -->
<!-- 
page : 현재 페이지에서만 객체 사용가능
request : 다음 요청 까지만 객체 사용가능
session : 하나의 브라우저 안에서 객체 사용가능
aplication 하나의 프로젝트 안에서는 객체 사용가능 
-->

<%
	System.out.println("mallCart : "+mallCart); // CartBean을 mallCart라는 이름으로 관리
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	int ovalue = Integer.parseInt(request.getParameter("ovalue"));
	System.out.println("상품번호 : " + pnum);
	System.out.println("주문수량 : " + ovalue);
	
	ProductDao pdao = ProductDao.getInstance();
	ProductBean pb = pdao.getSelectByPnum(pnum); // pnum에 해당하는 레코드 하나 가져옴
	if(pb.getPqty() < ovalue){ /* 보유수량보다 주문수량이 더 많으면 */
%>
		<script type="text/javascript">
		alert("수량초과");
		location.href="mall.jsp";
		</script>
<%
	}
	
		mallCart.addProduct(pnum,ovalue); // 장바구니에 추가하는 메서드를 호출 (pnum상품 ovalue개 주문)
		response.sendRedirect("mall_cartList.jsp");
		
%>