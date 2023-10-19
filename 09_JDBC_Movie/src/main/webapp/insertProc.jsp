<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="mb" class="myPkg.MovieBean"/> <!-- mb로 한묶음으로 묶음 -->
<jsp:setProperty property="*" name="mb"/>
<jsp:useBean id="mdao" class="myPkg.MovieDao"/>

<%
	String[] genres = request.getParameterValues("genre");
	String genre = "";
	if(genres == null){
		genre = "선택항목 없습니다.";
	}else{
		for(int i=0;i<genres.length;i++){
			if(i != genres.length-1){
				genre += genres[i] + ",";
			}else{
				genre += genres[i];
			}
		}
	}
	
	mb.setGenre(genre);
	
	int cnt = mdao.insertData(mb);
	if(cnt != -1){
		response.sendRedirect("list.jsp");
	}else{
		response.sendRedirect("insertForm.jsp");
	}
	
%>