<%@page import="my.shop.ProductDao"%>
<%@page import="my.shop.ProductBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- myshop/display/mall.jsp <br> -->

<%@ include file="mall_top.jsp" %>

<%
	ProductDao pdao = ProductDao.getInstance(); 
		String[] spec = {"HIT","NEW","BEST","NORMAL"};
		for(int i=0;i<spec.length;i++){
			ArrayList<ProductBean> plists = pdao.getSelectByPspec(spec[i]);
		%>
		<hr color = green width="80%">
		<font color=red size=3><strong><%= spec[i] %></strong></font>
		<hr color = green width="80%">
		
		<%if(plists.size()==0){%>
				<b><%=spec[i] %>상품 없습니다</b><br><br><br>
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
							<img  src="<%=imgPath%>" width="80" height="60"><br>
						</a>
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
		} // for
		%>
<%@ include file="mall_bottom.jsp" %>
