<%-- 로그인 기능이 구현된 페이지 --%>


<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("Id");
	String pass = request.getParameter("Pass");
	
	int check = new MemberDAO().userCheck(id, pass);
	
	if(check == 1){
		session.setAttribute("userID", id);
		session.setAttribute("userPW", pass);
		response.sendRedirect("cousor-single.jsp");
		

	}else if(check == 0){
%>
	<script type="text/javascript">
		alert("패스워드를 잘못 입력했습니다.")
		history.back();
	</script>

<%	
	}else{
%>
	<script type="text/javascript">
		alert("입력하신 정보가 존재하지 않습니다.");
		history.back();
	</script>


<%
	}
%>