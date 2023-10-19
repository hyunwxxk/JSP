<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%=request.getContextPath() %>/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script src="<%=request.getContextPath()%>/script.js"></script> 
findid.jsp<br>

<form method="post" action="findidPro.jsp" onSubmit="return writeSave()">
	<table border="1">
		<tr>
			<td align="center" bgcolor="yellow">이름</td>
			<td>
				<input type="text" name="name">
			</td>
		</tr>
		<tr>
			<td align="center" bgcolor="yellow">주민 등록 번호</td>
			<td>
				<input type="text" name="ssn1" maxlength="6">-<input type="text" name="ssn2" maxlength="7">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center" bgcolor="#ffcc00">
				<input type="submit" value="아이디 찾기">
			</td>
		</tr>
	</table>
</form>