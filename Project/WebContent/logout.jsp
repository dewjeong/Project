<%-- 로그아웃 요청이 구현된 페이지 --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	request.setCharacterEncoding("utf-8");

	session.invalidate();
	
	response.sendRedirect("index.jsp");

%>