<%@page import="my.shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
prod_list.jsp => prod_update.jsp<br>
<%
	int pnum =Integer.parseInt(request.getParameter("pnum"));
	System.out.println("pnum:"+pnum);
	ProductDao pdao = ProductDao.getInstance();
	ProductBean pb = pdao.selectProdNum(pnum);
	System.out.println(pb.getPcategory_fk());
%>
<%@include file="top.jsp" %>
	<td colspan="6" align="center">
		<form method="post" action="prod_updateProc.jsp" name="f" enctype="multipart/form-data">
		<table border="1" align="center" width="800" class=outline >
				<caption><b>상품 수정</b></caption>
			<tr>
				<th class="m2">카테고리</th>
				<td align=left>
					<input type="text" name="pcategory_fk" value="<%=pb.getPcategory_fk()%>" disabled>
				</td>
			</tr>
			<tr>
				<th class="m2">상품번호</th>
				<td align=left> 
					<%=pb.getPnum() %>
					<input type="hidden" name="pnum" value="<%=pb.getPnum()%>">  
				</td>
			</tr>
			<tr>
			<th class="m2">상품명</th>
				<td align=left> <input type="text" name="pname" value="<%=pb.getPname()%>"> </td>
			</tr>
			
			<tr>
				<th class="m2">제조회사</th>
				<td align=left> <input type="text" name="pcompany" value="<%=pb.getPcompany()%>"> </td>
			</tr>
			<tr>
				<th class="m2">상품이미지</th>
				<td align=left>
					<img  src="<%=request.getContextPath() %>/myshop/images/<%=pb.getPimage()%>" width="100"> 
					<input type="file" name="pimage"> <br>
					<input type="text"  name="pimage2" value="<%=pb.getPimage()%>">
				</td>
			</tr>
			<tr>
				<th class="m2">상품수량</th>
				<td align=left> <input type="text" name="pqty" maxlength="8" value="<%=pb.getPqty()%>"> </td>
			</tr>
			<tr>
				<th class="m2">상품가격</th>
				<td align=left> <input type="text" name="price" maxlength="8" value="<%=pb.getPrice()%>"> </td>
			</tr>
<tr>
				<th class="m2">상품스펙</th>
				<td align=left>
				<select name="pspec">
					<%-- <option value="NORMAL" <%if(pb.getPspec().equals("NORMAL")) {%> selected<%} %> >::NORMAL::</option>
					<option value="HIT"  <%if(pb.getPspec().equals("HIT")) {%> selected<%} %>>Hit</option>
					<option value="NEW"  <%if(pb.getPspec().equals("NEW")) {%> selected<%} %>>NFW</option>
					<option value="BEST"  <%if(pb.getPspec().equals("BEST")) {%> selected<%} %>>Best</option> --%>
					<%
						String[] pspecs = {"NORMAL", "HIT", "NEW", "BEST"};
					
						for(String pspec:pspecs){
					%>	
							<option value="<%=pspec%>" <%if(pb.getPspec().equals(pspec)){%>selected<%}%>>
								<%if(pspec==pspecs[0]){%>::<%=pspec%>::<%} 
								else{%><%=pspec%><%}%>
							</option>
					<%	
						}
					%>
				</select>
				</td>
			</tr>
			<tr>
				<th class="m2">상품소개</th>
				<td align=left>
					<textarea rows="10" cols="30" name="pcontents" style="resize:none;"><%=pb.getPcontents()%></textarea>
				</td>
			</tr>
				<tr>
				<th class="m2">상품포인트</th>
				<td align=left> <input type="text" name="point"  value="<%=pb.getPoint()%>"> </td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="m1">
					<input type="submit" value="상품 수정" >
					<input type="reset" value="취소" >
				</td>
			</tr>
	</table>
</form>
	</td>
<%@include file="bottom.jsp" %>
