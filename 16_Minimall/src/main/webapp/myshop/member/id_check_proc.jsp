<%@page import="my.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = request.getParameter("userid"); 
	
	MemberDAO mdao = MemberDAO.getInstance();
	boolean isCheck = mdao.searchId(userid); 
	String str = "";
	if(isCheck){ // true=이미
		str = "NO";
		out.print(str);
	}else{
		str = "YES";
		out.print(str);
	}
%>
