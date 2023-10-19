<%@page import="my.member.MemberDTO"%>
<%@page import="my.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String ssn1 = request.getParameter("ssn1");
	String ssn2 = request.getParameter("ssn2");
	
	MemberDAO mdao = MemberDAO.getInstance();
	MemberDTO mb = mdao.getMemberByIdAndNameAndSsn(id,name,ssn1,ssn2);
	String viewPage ;
	String password ;
	if(mb != null){
		password = mb.getPassword();
	}else{
		password = "가입하지 않은 회원입니다.";
	}
		viewPage = request.getContextPath() + "/main.jsp";
%>

<script type="text/javascript">
	alert("<%= password %>"+"입니다.");
	location.href = "<%= viewPage %>";
</script>