<%-- 회원가입 아이디 중복체크 기능 구현 --%>

<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String ID = request.getParameter("Id");
	
	MemberDAO memberdao = new MemberDAO();
	
	int resData  = memberdao.idCheck(ID);
	
	if(ID.equals("") || ID == null){ // 아이디가 공백이거나 입력되지 않았을 때
		resData = -1;
		out.print(resData);
		
	}else if(resData == 1){ // 아이디가 중복일 때
		resData = 1;
		out.print(resData);
		
	}else if(resData == 0){ // 아이디를 사용할 수 있을 때
		resData = 0;
		out.print(resData);	
	}
%>