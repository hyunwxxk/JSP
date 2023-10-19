<%@page import="my.shop.CategoryBean"%>
<%@page import="my.shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
cate_proc.jsp<br>
<%
   request.setCharacterEncoding("UTF-8");
   String code = request.getParameter("code");
   String cname = request.getParameter("cname");
   
   CategoryDao cdao = CategoryDao.getInstance();
   /* 
   CategoryBean cb = new CategoryBean();
   cb.setCode(code);
   cb.setCname(cname); 
   */
%>
<jsp:useBean id="cdto" class = "my.shop.CategoryBean"/>
<jsp:setProperty property="*" name="cdto"/>
<%    
   String msg, url;
   int cnt = cdao.insertCategory(cdto); 
   
   if(cnt > 0){
      msg = "입력 성공";
      url = "cate_list.jsp";
   } else {
      msg = "입력 실패";
      url = request.getContextPath() + "/myshop/admin/cate_input.jsp";
   }
%>

<script type="text/javascript">
   alert("<%=msg%>");
   location.href="<%=url%>";
</script>
