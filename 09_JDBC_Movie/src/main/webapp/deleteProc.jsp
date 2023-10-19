<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mdao" class="myPkg.MovieDao"/>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	int cnt = mdao.deleteData(num);
	String msg;
	
	if(cnt != -1){
		msg = "삭제 성공";
	}else{
		msg = "삭제 실패";
	}
%>
<script type="text/javascript">
	alert("<%= msg %>");
	location.href="list.jsp";
</script>