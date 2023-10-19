<%@page import="java.io.File"%>
<%@page import="my.shop.ProductDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
prod_update.jsp => prod_updateProc.jsp<br>

<% 
	request.setCharacterEncoding("UTF-8"); 
	String configFolder = config.getServletContext().getRealPath("/myshop/images"); // 웹서버 폴더의 위치
	int maxSize = 1024*1024*10; // 파일의 최대 크기. 가로*세로*파일크기(mb)
	String encoding = "UTF-8"; // 위에서 이미 한글처리해줘서 꼭 쓰진 않아도 됨
	String saveFolder = "img";
	MultipartRequest mr = new MultipartRequest(request, 
							configFolder, 
							maxSize, 
							encoding, 
							new DefaultFileRenamePolicy()); 
	System.out.println("configFolder:"+configFolder);
	
	
	String oldimg = mr.getParameter("pimage2"); // 기존이미지
	String pimage = mr.getFilesystemName("pimage"); // 새이미지
	
	String img = null;
	
	if(oldimg == null){ // 기존이미지가 없을 때
		if(pimage != null){ // 새이미지가 있을 때
			img = pimage; // img에 새이미지를 넣는다.
		} 
	}else if(oldimg != null){ // 기존이미지가 있을 때
		if(pimage == null){ // 새이미지가 없을 때
			img = oldimg; // img에 기존이미지를 넣는다
		}else if(pimage != null){ // 새이미지가 있을 때
			img = pimage; // img에 새이미지를 넣는다
		
			File delFile = new File(configFolder,oldimg); 
			delFile.delete();
		}
	}
	
	ProductDao pdao = ProductDao.getInstance();
	int cnt = pdao.updateProduct(mr,img);
	String msg, url;
	
	
	if(cnt > 0){
		%>
		<script type="text/javascript">
			alert("수정 성공");
			location.href="prod_list.jsp";
		</script>
		<%
	} else {
		%>
		<script type="text/javascript">
			alert("수정 실패");
			history.go(-1); 
		</script>
		<%
	}
%>
