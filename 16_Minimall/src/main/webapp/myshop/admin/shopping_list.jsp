<%@page import="my.shop.mall.OrderDao"%>
<%@page import="javax.swing.event.ListSelectionEvent"%>
<%@page import="my.shop.mall.OrderBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp" %>
<jsp:useBean id="odao" class="my.shop.mall.OrderDao" scope="session"></jsp:useBean> 
<%
	String id = request.getParameter("id");
	/* 조회할 회원 아이디를 입력 후 다시 shopping_list로 올 때는 id의 값을 가져오기 때문에 받아줘야 한다. */
		Vector<OrderBean> lists = null;
		int total = 0;
	if(id != null){ /* shopping_list에서 shopping_list로 오면 입력한 조회할 아이디가 있다는 뜻 */
		lists = odao.getOrderList(id);
	}
%>
	<td colspan="6" align="center" valign="top">
			<table border="1" width="100%">
				<tr align="center">
					<td colspan="5">
						<form action="shopping_list.jsp" method="post">
							조회할 회원 아이디 입력 : <input type="text" name="id">
							<input type="submit" value="내역 조회">
						</form>
					</td>
				</tr>
				<tr align="center" class="m1">
					<td>고객명</td>
					<td>아이디</td>
					<td>상품명</td>
					<td>수량</td>
					<td>금액</td>
				</tr>
					<tr>
						<td colspan="5" align="center">
							조회한 회원의 쇼핑 내역이 없습니다.
						</td>
					</tr>
				<%
						if(lists != null){ /* lists가 null이 아닐 때 lists에서 가져와야 한다. */
							for(OrderBean odto : lists){
								String mname = odto.getMname();
								String mid = odto.getMid();
								String pname = odto.getPname();
								int qty = odto.getQty(); 
								int amount = odto.getAmount();
								total += amount;
					
					%>
							<tr>
								<td align="center"><%=mname%></td>
								<td align="center"><%=mid%></td>
								<td align="center"><%=pname%></td>
								<td align="center"><%=qty%></td>
								<td align="center"><%=amount%></td>
							</tr>
				<%
					
						}//for
					}// if
				%>
					<tr>
						<td colspan="4">
							총합
						</td>
						<td>
							<%=total %>
						</td>
					</tr>
				</table>
			</td>
		<%@ include file="bottom.jsp" %> 
