<%-- 글수정 기능을 구현하는 페이지 --%>

<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

   request.setCharacterEncoding("utf-8");
  
	String directory = application.getRealPath("/upload/");
	// C:\02Workspace\Project\WebContent\ upload
	
	int maxSize = 1024 * 1024 * 1024;
	
	MultipartRequest multipartRequest; // 변수 저장
	multipartRequest = new MultipartRequest(request,
											directory,
											maxSize,
											"UTF-8",
											new DefaultFileRenamePolicy()
											);

	String id = multipartRequest.getParameter("Id");
	String pass = multipartRequest.getParameter("Pass");
	String title = multipartRequest.getParameter("Title");
	String content = multipartRequest.getParameter("Content");
	String fileName = multipartRequest.getOriginalFileName("File");
	String fileRealName = multipartRequest.getFilesystemName("File");
	
   BoardDTO dto = new BoardDTO();
   dto.setId(id);
   dto.setPass(pass);
   dto.setTitle(title);
   dto.setContent(content);
   dto.setFilerealname(fileRealName);
   dto.setFilename(fileName);
   
   new BoardDAO().insertBoard(dto);
   
%>

	<script>
		if(confirm("글을 작성하시겠습니까?") == true ){
		
			location.href="cousor-single.jsp";
				
		}else{

	   		history.back();
		
		}
	 </script>

	 