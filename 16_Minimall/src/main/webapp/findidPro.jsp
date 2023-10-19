<%@page import="my.member.MemberDTO"%>
<%@page import="my.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String ssn1 = request.getParameter("ssn1");
	String ssn2 = request.getParameter("ssn2");
	/* 넘어온 3가지 정보를 가지고 select */
	
	MemberDAO mdao = MemberDAO.getInstance();
	MemberDTO mb = mdao.getMemberByNameAndSsn(name,ssn1,ssn2);
	String viewPage ;
	String id ;
	if(mb != null){
		id = mb.getId();
	}else{ // 가입하지 않은 회원
		id = "가입하지 않은 회원입니다.";
	}
		viewPage = request.getContextPath() + "/main.jsp";
%>
<script type="text/javascript">
	alert("<%= id %>"+"입니다.");
	location.href = "<%= viewPage %>";
</script>


