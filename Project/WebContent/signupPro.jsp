<%-- 회원가입기능을 구현하는 페이지 --%>

<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");

	String ID = request.getParameter("Id");
	String PWD = request.getParameter("Pass");
	String NAME = request.getParameter("Name");
	String ADDRESS = request.getParameter("addr1") + request.getParameter("addr2")+request.getParameter("addr3")+request.getParameter("addr4");
	
	MemberDTO memberdto = new MemberDTO(ID, PWD, NAME, ADDRESS);
	
	MemberDAO memberdao = new MemberDAO();
	int result = memberdao.insertMember(memberdto);
	
	if(result == 1){
%>
	<script>
		alert("회원이 되신걸 환영합니다!")
		location.href="index.jsp"
	</script>

<%
	}else{
%>
		<script>
			alert("필수정보를 모두 입력해주세요!")
			history.back();
		</script>
<%
	}
%>
