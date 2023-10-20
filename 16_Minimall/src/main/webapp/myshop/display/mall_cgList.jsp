<%@page import="my.shop.ProductBean"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mall_top.jsp(2)=>mall_cgList.jsp<br> -->

<%@ include file="mall_top.jsp" %>
<h3>Welcom to My Mall</h3>
	<%
	String cname = request.getParameter("cgname");
	String code = request.getParameter("code");
	
	ProductDao pdao = ProductDao.getInstance();  
	ArrayList<ProductBean> plists = pdao.getSelectByCategory(code);  
	%> 
		<hr color = green width="80%">
		<font color=red size=3><strong><%= cname %></strong></font>
		<hr color = green width="80%">
		
		<%if(plists.size()==0){%>
			<b><%=cname %>상품 없습니다</b><br><br><br>
		<%
		}else{
		%>
		
		<table width="600" align="center" border="0">
				<tr>
		<%	
			int count = 0;
			for(int j =0 ; j<plists.size(); j++){ // 4
				count++;
				ProductBean pb = plists.get(j);
				String pimage = pb.getPimage();
				String pname = pb.getPname();
				int price = pb.getPrice();
				int point = pb.getPoint(); 
				String imgPath = request.getContextPath()+"/myshop/images/"+pimage;
			%>
					<td align="center">
						<a href="mall_prodView.jsp?pnum=<%=pb.getPnum()%>">
							<img  src="<%=imgPath%>" width="150" height="150">
						</a>
						<br>
						<%=pb.getPname() %><br>
						<font color=red><%=pb.getPrice() %></font>원<br>
						<font color=blue>[<%=pb.getPoint() %>]</font>points
					</td>
					<%
						if(count % 3 == 0){
							out.println("</tr><tr>");
						}
					} // for
					%>
				</tr>
				</table>
		<% } // else 
		%>
<%@ include file="mall_bottom.jsp" %>


