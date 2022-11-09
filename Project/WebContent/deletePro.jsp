<%-- 글삭제 기능 구현하는 페이지 --%>

<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");

	String num = request.getParameter("num");

	BoardDAO dao = new BoardDAO();
	
	int check = dao.deletePost(num);
	
	if(check == 1){
%>
	
	<script>
		alert("글이 삭제되었습니다.")
		location.href="cousor-single.jsp";
	</script>

<% 
	}else{
%>	
	<script>
		alert("글삭제를 실패하였습니다.")
		history.back();
	</script>
	
<%	
	}
%>