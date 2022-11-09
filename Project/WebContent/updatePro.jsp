<%-- 회원정보수정 기능을 구현하는 페이지 --%>

<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("Id");
	String pass = request.getParameter("Pass");
	String name = request.getParameter("Name");
	String address = request.getParameter("addr2");
	
	MemberDTO dto = new MemberDTO();
	dto.setId(id);
	dto.setPass(pass);
	dto.setName(name);
	dto.setAddress(address);
	
	int check = new MemberDAO().updateMember(dto);
	
	if(check == 1){
%>	
		<script>
			alert("회원정보가 수정되었습니다.");
			location.href="cousor-single.jsp";
		</script>
		
<%
	}else{
%>

<script>		
		alert("필수정보를 모두 입력해주세요!");
		history.back();
</script>	

<%
	}
%>	

