<%@page import="my.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
myshop\member\registerPro.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mb" class="my.member.MemberDTO"/>
<jsp:setProperty property="*" name="mb"/>
    
<%
   
	MemberDAO mdao =  MemberDAO.getInstance();
    int cnt = mdao.insertMember(mb);  
    String msg,url;
    if(cnt > 0){
    	msg = "성공";
    	url = request.getContextPath()+"/main.jsp";
        
     } else {
    	 msg = "실패";
    	 url = request.getContextPath()+"/myshop/member/register.jsp";
        
     }
%>

 <script type="text/javascript">
    alert("<%=msg%>"+"했습니다.");
    location.href="<%=url%>";
 </script>
 
 
 
 