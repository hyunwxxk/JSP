<%@page import="my.shop.ProductBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_cartList(주문하기), 
mall_prodView.jsp(즉시구매하기,pnum과 oqty를 가지고 넘어옴) 
=> mall_order.jsp(결제내역서보기) -->  
<jsp:useBean id="mallCart" class="my.shop.mall.CartBean" scope="session"></jsp:useBean> 
    
 <%
 	/* 장바구니에서 주문하기를 클릭했을 때 오류가 발생하는 이유는 즉시구매하기에서는 pnum과 oqty를 넘겨서
 	2가지를 mall_order에서 받아야 한다. 하지만 mall_cartList에서는 pnum과 oqty를 넘겨주지 않기 때문에
 	mall_cartList에서 pnum과 oqty를 넘겨줘야 한다. 하지만 넘겨줄 때 실제 있는 제품을 넘기지 않고 
 	00을 사용하여 pnum과 oqty를 넘겼을 때 제품과 수량에 영향을 주지 않도록 해야된다. */
 	int pnum = Integer.parseInt(request.getParameter("pnum"));
 	int oqty = Integer.parseInt(request.getParameter("oqty"));
 	int sum = 0;
 	
 	if(pnum!=0 && oqty!=0){
 		mallCart.addProduct(pnum,oqty);// 장바구니에 접근하기 위해서 mallCart사용하여 pnum, oqty 정보를 담음
 	}
 	Vector<ProductBean> clist = mallCart.getAllProducts();
 %>


<%@ include file="mall_top.jsp" %>
<table border="1" width="90%" align="center" class="outline">
	<tr class="m2">
		<th colspan="3" align="center" height="50px;" >
				결제 내역서 보기</th>
	</tr>
	<tr class="m1">
		<th width="40%">상품명</th>
		<th width="20%">수량</th>
		<th width="40%">금액</th>
	</tr>
	
	<%
		for(int i=0; i<clist.size();i++){
			   ProductBean pb = clist.get(i);
			  
	            String pname = pb.getPname();
	            int pqty = pb.getPqty();
	            int price = pb.getPrice();
	            int amount = pqty * price;
	%>
			<tr>
				<th><%= pname %></th>
				<th><%= pqty %></th>
				<th><%= amount %>원</th>
			</tr>
		
			<% 
			  sum += amount;
	
			}//for
	%>
	<tr class=m1>
		<th colspan="3">
			결제 총액 : <font color=red><%=sum%>원</font>
		</th>
	</tr>
</table>
<br>

<input type="button" value="결제하기" onClick="location.href = 'mall_calculate.jsp'">

<%@ include file="mall_bottom.jsp" %>