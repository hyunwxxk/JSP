<%@page import="my.shop.ProductBean"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall.jsp, mall_cgList.jsp => mall_prodView.jsp -->
<%@ include file="mall_top.jsp" %>
<script type="text/javascript"> 
	function goCart(pnum){
		/* alert("pnum : " + pnum); */
		 ovalue = document.f.oqty.value;
		if(ovalue < 1 || ovalue == ""){
			alert("주문수량 누락 또는 상품갯루를 1개 이상 입력하세요.");
			return;
		}
		location.href="mall_cartAdd.jsp?pnum="+pnum+"&ovalue="+ovalue; // 상품번호, 주문수량을 넘김
	} // goCart
	
	function goOrder(pnum){ /* 넘긴 번호를 받음 goOrder함수로 form의 액션을 설정가능 */
		
		document.f.action = "<%= request.getContextPath() %>/myshop/display/mall_order.jsp?pnum="+pnum;
		document.f.submit(); // type이 submit인것처럼 동작 상품번호, 주문수량을 넘김
		
	} // goOrder
	
</script>
<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	ProductDao pdao = ProductDao.getInstance();
	ProductBean pb = pdao.getSelectByPnum(pnum);
%>
<table border="1" class="outline" width="100%">
	<tr class="m1">
		<td colspan="2" aling="center">
			<font color=green size=3>
				<b>[<%=pb.getPname() %>] 상품정보</b>
			</font>
		</td>
	</tr>
	<tr>
		<td align="center" class="m3">
			<%
				String pimage = pb.getPimage();
				String imgPath = request.getContextPath()+"/myshop/images/"+pimage;
			%>
			<img src="<%=imgPath%>" width="200" height="200"><br>
		</td>
		<td class="m3">
			<form name="f" method="post">
				상품번호 : <%=pb.getPnum() %><br>
				상품이름 : <%=pb.getPname() %><br>
				상품가격 : <font color=red><%=pb.getPrice() %></font><br>
				상품포인트 : <font color=red><%=pb.getPoint() %></font><br>
				상품갯수 : <input type="text" name="oqty" value="1" size="2">개<br><br>
				<table border="1" align="center">
					<tr>
						<td>
							<a href="javascript:goCart('<%= pb.getPnum() %>')">
							<img src="<%=request.getContextPath() %>/img/cartbtn.gif" width="100" height="40">
							</a>
						</td>
						<td>
							<a href="javascript:goOrder('<%= pb.getPnum() %>')"> <!-- 함수로 번호를 하나 넘김 -->
							<img src="../../img/orderbtn.gif" width="100" height="40">
							</a>
						</td>
					</tr>
				</table>
			</form>
		</td>
	</tr>
	<tr>
		<td colspan = "2" height="200" align="top">
			<br><b>상품 상세 설명</b><br>
			<%= pb.getPcontents() %>
		</td>
	</tr>
</table>
<%@ include file="mall_bottom.jsp" %>




