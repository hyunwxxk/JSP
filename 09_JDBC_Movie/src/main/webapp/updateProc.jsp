<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mb" class="myPkg.MovieBean"/>
<jsp:setProperty property="*" name="mb"/>
<jsp:useBean id="mdao" class="myPkg.MovieDao"/>
<%
	String[] genre = request.getParameterValues("genre");
	String genres = "";
	
	if(genre == null){
		genres = "좋아하는 장르 없음";
	}else{
	for(int i=0;i<genre.length;i++){
		if(i != genre.length-1){
			genres += genre[i] + ",";
		}else{
			genres += genre[i];
		}
		}
	}
	
	
	mb.setGenre(genres);
	
	int cnt = mdao.updateData(mb);
	
	if(cnt != -1){
		response.sendRedirect("list.jsp");
	}else{
		response.sendRedirect("updateForm.jsp?num="+mb.getNum());
		/* 수정을 실패하고 updateForm으로 다시 갈 때 숫자를 넘겨야 한다. */
	}
	
%>
