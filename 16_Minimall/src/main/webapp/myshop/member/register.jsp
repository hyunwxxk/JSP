<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <link rel="stylesheet" href="../../style.css" type="text/css"> -->  
<link rel="stylesheet" href="<%=request.getContextPath() %>/style.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script src="<%=request.getContextPath()%>/script.js"></script> 
 
myshop\member\register.jsp<br>

<form action="registerPro.jsp" method="post" onSubmit="return writeSave()">
<table border="1" align="center" width="700">
	<tr>
		<th colspan="2" bgcolor="#ffcc00">
			<font size="3" color="#5d1900">◈기본 정보◈</font>
		</th>
	</tr>
	<tr>
		<th bgcolor="yellow">* 회원아이디</th>
		<td>
			<input type="text" name="id">
			<input type="button" value="중복체크" onClick="return duplicate()">
			<span id="idmessage"></span>
		</td>
	</tr>
	<tr>
		<th bgcolor="yellow">* 비밀 번호</th>
		<td><input type="password" name="password" onBlur="return pwcheck()"> 영문 소문자/숫자 조합 3~8</td>
	</tr>
	<tr>
		<th bgcolor="yellow">* 비밀 번호 확인</th>
		<td>
			<input type="password" name="repassword" onKeyUp="return repassword_keyup()">
			<span id="pwmessage"></span>
		</td>
	</tr>
	<tr>
		<th bgcolor="yellow">E-Mail
		<td><input type="text" name="email">
	</tr>
	<tr>
		<th colspan="2" bgcolor="#ffcc00">
			<font size="3" color="#5d1900">◈개인 신상 정보◈</font>
		</th>
	</tr>
	<tr>
		<th bgcolor="yellow">한글 이름</th>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<th bgcolor="yellow">주민 등록 번호</th>
		<td><input type="text" name="ssn1" maxlength="6">-<input type="text" name="ssn2" maxlength="7"></td>
	</tr>
	<tr>
		<th bgcolor="yellow">휴대 전화 번호</th>
		<td>
		<select name="hp1">
			<option value="010">010
			<option value="011">011
			<option value="012">012
			<option value="013">013
		</select> -
		<input type="text" name="hp2" size="5"> - <input type="text" name="hp3" size="5">
		</td>
	</tr>
	<tr>
		<th bgcolor="yellow">가입 일자</th>
		<td><input type="text" name="joindate" size="13"></td>
	</tr>
	<tr  bgcolor="#FFCC00">
		<th colspan="2">
			<input type="submit" value="가입 하기">
			<input type="button" value="취소">
		</th>
	</tr>
</table>
</form>