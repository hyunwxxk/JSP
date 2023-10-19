<%@page import="myPkg.MovieBean"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
table {
	margin: auto;
	width: 90%;
	text-align: center;
}

th {
	background: yellow;
}
</style>
<script type="text/javascript">
	function insert(){
		location.href = "insertForm.jsp";
	}
	
	function allCheck(obj){
		var chkobj = document.getElementsByName("rowcheck");
		var check = obj.checked;
		
		if(check){
			for(var i=0;i<chkobj.length;i++){
				chkobj[i].checked = true;
			}
		}else{
			for(var i=0;i<chkobj.length;i++){
				chkobj[i].checked = false;
			}
		}
	}
	
	function selectDelete(){
		var flag = false;
		var chkobj = document.getElementsByName("rowcheck");
		for(i=0;i<chkobj.length;i++){
			if(chkobj[i].checked){
				flag = true;
			}
		}
		if(!flag){
			alert('삭제할 체크박스 하나라도 선택하세요');
			return;
		}
		
		document.myform.submit();
		
	}//selectDelete
</script>
<jsp:useBean id="mdao" class="myPkg.MovieDao" />

<%
ArrayList<MovieBean> lists = mdao.getAllMovies();
%>

<form name="myform" action="deleteAll.jsp">
	<input type="reset" value="삭제" onClick="selectDelete()">
	<input type="button" value="추가" onClick="insert()">
	<br>
	<table border="1">
		<tr>
			<th><input type="checkbox" name="allcheck" onClick="allCheck(this)"></th>
			<th>번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>나이</th>
			<th>좋아하는 장르</th>
			<th>즐겨보는 시간대</th>
			<th>동반관객수</th>
			<th>개선사항</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<tr>
			<%
				for(int i=0;i<lists.size();i++){
					MovieBean mb = lists.get(i);
			%>
			<td>
			<input type="checkbox" name="rowcheck" value="<%= mb.getNum() %>">
			</td>
			<td><%= mb.getNum() %></td>
			<td><%= mb.getId() %></td>
			<td><%= mb.getName() %></td>
			<td><%= mb.getAge() %></td>
			<td><%= mb.getGenre() %></td>
			<td><%= mb.getTime() %></td>
			<td><%= mb.getPartner() %></td>
			<td><%= mb.getMemo()%></td>
			<td><a href="updateForm.jsp?num=<%= mb.getNum() %>">수정</a></td>
			<td><a href="deleteProc.jsp?num=<%= mb.getNum() %>">삭제</a></td>
		</tr>
		<%} %>
	</table>
</form>