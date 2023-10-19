<%@page import="java.io.File"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String pimage = request.getParameter("pimage");
	System.out.println("pnum : " + pnum );
	System.out.println("pimage : " + pimage );
	ProductDao pdao = ProductDao.getInstance();
	int cnt = pdao.deleteProduct(pnum); // DB  레코드 삭제
	String delPath = config.getServletContext().getRealPath("myshop/images");
	/* 올리거나 삭제할 때 config 사용 */
	File dir = new File(delPath); /* delPath에 있는 글자를 폴더의 역할을 할 수 있게 만들어주는 기능 = File */
	
	File delFile = new File(dir,pimage);
	/* File에 경로와 파일명을 적으면 해당 경로 밑에 파일명을 delFile로 관리 더이상 글자가 아니고 실제 존재하는 파일 */
	if(delFile.exists()){ /* delFile이 존재하는지 존재하면 true */
		if(delFile.delete()){ /* delFile을 지워라 지우는데 성공하면 true */
	%>
		<script type="text/javascript">
			alert("이미지파일 삭제 성공");
		</script>
	<%		
		} // if(delFile.delete())
	} // if(delFile.exists())
	
	String msg,url;

	if(cnt > 0){
		msg = "삭제 성공";
		url = "prod_list.jsp";
	}else{
		msg = "삭제 실패";
		url = "prod_list.jsp";
	}
%>

<script type="text/javascript">
	alert("<%= msg %>");
	location.href="<%= url %>";
</script>