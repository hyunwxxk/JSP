<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="mdao" class="myPkg.MovieDao"/>
<%
	String userid = request.getParameter("userid");

	boolean isCheck = mdao.searchId(userid);
	String str = "";
	if(isCheck){
		str = "NO";
		out.print(str);
		/* out은 원래 웹 브라우저에 출력하는 기능이 있지만 여기서는 응답의 형태로 요청한 쪽으로 보내는 역할을 한다 */
	}else{
		str = "YES";
		out.print(str);
	}
%>