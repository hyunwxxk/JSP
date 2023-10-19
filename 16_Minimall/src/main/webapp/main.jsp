<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="style.css" type="text/css">    
main.jsp <br>
[로그인 화면] <br><br>
<form method="post" action="loginPro.jsp">
	<table border="1" height="120">
		<tr>
			<th bgcolor="yellow">아이디</th>
			<td>
				<input type="text" name = "id" value = "admin">
			</td>
		</tr>
		<tr>
			<th bgcolor="yellow">비번</th>
			<td>
				<input type="password" name = "password" value = "1234">
			</td>
		</tr>
		<tr>
			<th colspan="2" bgcolor="#ffcc00">
				<input type="submit" value="로그인">
				<input type="button" value="회원가입"  onclick="location.href='myshop/member/register.jsp'">
				<input type="button" value="아이디 찾기"  onclick="location.href='findid.jsp'">
				<input type="button" value="비번 찾기"  onclick="location.href='findpassword.jsp'">
			</th>
		</tr>
	</table>
</form>