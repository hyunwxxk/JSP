<%@page import="my.shop.mall.CartBean"%>
<%@page import="java.util.Vector"%>
<%@page import="my.shop.ProductBean"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- clist가 관리하는 것이 장바구니에 담은 것 -->

<jsp:useBean id="mallCart" class="my.shop.mall.CartBean" scope="session"></jsp:useBean> 
<!-- CartBean 객체를 생성해줘야 메서드 호출이 가능 -->
<%
	System.out.println("mall_cartList.jsp mallCart:"+mallCart); /* mallCart주소를 출력해봄 */
	/* mall_cardAdd와 mall_cartList의 ProductBean의 상품 하나를 추가할 때마다 장바구니의 공간을 새로 만들기 때문에 scope="session"을 통해 같은 객체를 사용하게 해야된다. */
%>
<%@ include file="mall_top.jsp" %>
<%
	Vector<ProductBean> clist = mallCart.getAllProducts(); /* 이 메서드를 호출하면 장바구니를 보내줌 */
%>
<table border="1" width="90%" align="center">
	<tr>
		<td colspan="6" align="center">
			<h4>장바구니 보기</h4>
		</td>
	</tr>
	<tr class="m1">
		<th width="10%">번호</th>
		<th width="20%">상품명</th>
		<th width="20%">수량</th>
		<th width="20%">단가</th>
		<th width="20%">금액</th>
		<th width="10%">삭제</th>
	</tr>
	<%
		if(clist.size() == 0){ /* clist.size() == 0 : 장바구니에 담은 것이 하나도 없다 */
	%>
		<tr>
		<td colspan="6" align="center">
			선택한 상품이 없습니다.
		</td>
		</tr>
		</table>
	<%
		}else{
			int sumPrice = 0;
			int sumPoint = 0;
			for(int i=0;i<clist.size();i++){
				ProductBean pb = clist.get(i);
				sumPrice += pb.getPrice()*pb.getPqty();
				sumPoint += pb.getPoint()*pb.getPqty();
	%>
		<tr align="center">
			<td>
				<%= pb.getPnum() %>
			</td>
			<td>
				<img src="<%= request.getContextPath() + "/myshop/images/"+pb.getPimage() %>" width="50" height="50">
				<br>
				<%= pb.getPname() %>
				</td>
				<td>
					<form name="f" method="post" action="mall_cartEdit.jsp">
								<input type="hidden" name="pnum" value="<%= pb.getPnum() %>">
								<input type="text" name="oqty" size="1" value="<%=pb.getPqty()%>">개
							<input type="submit" value="수정">
						</form>
					</td>
					<td>
						[<%=pb.getPrice() %>]원<br>
						[<%=pb.getPoint() %>]point
					</td>
					<td>
						[<%=pb.getPrice()*pb.getPqty() %>]원<br>
						[<%=pb.getPoint()*pb.getPqty() %>]point
					</td>
					<td>
						<a href="mall_cartDel.jsp?pnum=<%= pb.getPnum() %>">삭제</a>
					</td>
				</tr>
			<% 
			}//for
		%>
		<tr>
			<td colspan="4">
				장바구니 총액 : <%=sumPrice %>원
				총 적립 포인트 : [<%=sumPoint %>] point  
			</td>
			<td align="left" colspan="2">
				<a href="mall_order.jsp?pnum=00&oqty=00">[주문하기]</a>
				<!-- mall_order에서 mall_prodView에서 즉시구매를 통해 넘기는 pnum과 oqty를 받아야 하지만
				mall_cartList에 주문하기를 하는 경우도 mall_order로 넘어간다. mall_cartList에서는 넘기는 
				값이 없기 때문에 에러가 발생한다. 그러므로 pnum과 oqty에 다른 제품, 수량에 영향을 받지 않는 00값을 담아 넘긴다.  -->
				<a href="javascript:history.go(-2)">[계속 쇼핑]</a>
			</td>
		</tr>
	</table>		
<%
	} // else
%>
<%@ include file="mall_bottom.jsp" %>