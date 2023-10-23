<%@page import="my.shop.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_order.jsp(결제하기) => mall_calculate.jsp -->

<jsp:useBean id="mallCart" class="my.shop.mall.CartBean" scope="session"></jsp:useBean>
<jsp:useBean id="odao" class="my.shop.mall.OrderDao" scope="session"></jsp:useBean> 
<!-- session임으로 객체를 한번만 만들어 생성자로 한번만 갈 수 있다. 접속을 끊으면 안됨 -->
<%
	String msg;
	Vector<ProductBean> cv = mallCart.getAllProducts(); /* 장바구니 정보를 cv에 넣음 */
	int memno = (Integer)session.getAttribute("memno");
	int cnt = odao.insertOrder(memno, cv); /* session으로 설정한 회원번호와 장바구니 정보를 넘김 */
	if(cnt != 0){
		msg = "주문 완료했습니다.";
		mallCart.removeAllProducts(); // 주문완료하면 장바구니의 모든 제품을 삭제하는 메서드 호출
%>
		<script type="text/javascript">
			alert("<%= msg %>");
			var resp = confirm("계속하시겠습니까?"); /* confirm : 메세지 박스와 확인과 취소가 나옴 */
			if(resp){
				location.href="<%= request.getContextPath() %>/myshop/display/mall.jsp";
			}else{
				location.href="<%= request.getContextPath() %>/logout.jsp";
			}
		</script>
<%
	}else{
		msg = "주문 실패했습니다.";
%>
		<script type="text/javascript">
			alert("<%= msg %>");
			location.href="<%= request.getContextPath() %>/myshop/display/mall.jsp";
		</script>
<%
	}
	
%>