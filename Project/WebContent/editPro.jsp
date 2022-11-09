<%-- 글수정 기능을 구현하는 페이지 --%>

<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	
	String num = request.getParameter("Num");
	String id = request.getParameter("Id");
	String pass = request.getParameter("Pass");
	String title = request.getParameter("Title");
	String content = request.getParameter("Content");
	String filename = request.getParameter("File");
	String filerealname = request.getParameter("File");

	BoardDTO dto = new BoardDTO();
	dto.setNum(num);
	dto.setName(id);
	dto.setPass(pass);
	dto.setTitle(title);
	dto.setContent(content);
	dto.setFilename(filename);
	dto.setFilerealname(filerealname);
	
	int check = new BoardDAO().updateBoard(dto);

	if(check == 1){
%>
	<script>
		alert("글이 수정되었습니다.");
		location.href="cousor-single.jsp";
	</script>
	
<% 		
	}else{
%>
	<script>
		alert("패스워드가 일치하지 않습니다.");
		history.back();
	</script>
<% 
	}
%>

</body>
</html>