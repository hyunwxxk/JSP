<%@page import="my.shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.CategoryDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="top.jsp" %>


	<td colspan="6" align="center">
		<form name="f" action="prod_proc.jsp" method="post" enctype="multipart/form-data">
			<table class=outline border=0 width="600">
				<tr>
					<th class="m2">카테고리</th>
					<td>
						<select	name="pcategory_fk">
							<%
								CategoryDao cdao = CategoryDao.getInstance();
								ArrayList<CategoryBean> list = cdao.getAllCategory();
								if(list.size()==0){
							%>
									<option value="">카테고리 없음</option>
							<%
								}else{
									for(CategoryBean cb : list){
									String cname = cb.getCname();
									String code = cb.getCode();
							%>
						<option value="<%= code %>"> <%= cname %> [<%= code %>]
									
							<%
									}
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th class="m2">상품명</th>
					<td>
						<input type="text" name="pname">
					</td>
				</tr>
				<tr>
					<th class="m2">상품코드</th>
					<td>
						<input type="text" name="pcode">
					</td>
				</tr>
				<tr>
					<th class="m2">제조회사</th>
					<td>
						<input type="text" name="pcompany">
					</td>
				</tr>
				<tr>
					<th class="m2">상품이미지</th>
					<td>
						<input type="file" name="pimage">
					</td>
				</tr>
				<tr>
					<th class="m2">상품 수량</th>
					<td>
						<input type="text" name="pqty">
					</td>
				</tr>
				<tr>
					<th class="m2">상품 가격</th>
					<td>
						<input type="text" name="price">
					</td>
				</tr>
				<tr>
					<th class="m2">상품 스펙</th>
					<td>
						<select name="pspec">
							<option value="::NORMAL::">::NORMAL::
							<option value="HIT">HIT
							<option value="NEW">NEW
							<option value="BEST">BEST
						</select>
					</td>
				</tr>
				<tr>
					<th class="m2">상품 소개</th>
					<td>
						<textarea rows="5" cols="50" name="pcontents" style="resize : none;"></textarea>
					</td>
				</tr>
				<tr>
					<th class="m2">상품 포인트</th>
					<td>
						<input type="text" name="point">
					</td>
				</tr>
				<tr>
					<td colspan="2" class="m1" align="center">
						<input type="submit" value="상품 등록">
						<input type="reset" value="취소">
					</td>
				</tr>
			</table>
		</form>
	</td>
<%@ include file="bottom.jsp" %>