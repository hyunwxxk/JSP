<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- logout.jsp -->

<!-- session으로 설정한 모든 것들을 로그아웃을 눌렀을 때 무효화시키도록 설정
id,no,cartBean,OrderDao -->

<%
	session.invalidate(); /* session.invalidate() : 모든 세션을 해제하도록 설정 */
	String viewPage = "main.jsp";
	response.sendRedirect(viewPage);
%>