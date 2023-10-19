<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="mdao" class="myPkg.MovieDao"/>
<%
	String[] rowcheck = request.getParameterValues("rowcheck");
	for(int i=0; i<rowcheck.length; i++){
		System.out.print(rowcheck[i]+" ");
	} 
	
	int cnt = mdao.deleteCheckData(rowcheck);
	String msg;
	
	if(cnt != -1){
	    	msg="부분삭제 성공";
	    } else{
	    	msg="부분삭제 실패";
	    }
%>
<script type="text/javascript">
	alert("<%= msg %>");
	location.href="list.jsp";
</script>