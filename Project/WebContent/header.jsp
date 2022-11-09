<%-- 페이지의 헤더 영역 --%>

<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <header class="site-navbar py-4 js-sticky-header site-navbar-target" role="banner">
            <%
            	MemberDAO dao = new MemberDAO();
				String userID = (String)session.getAttribute("userID"); 
				
				if(userID == null){

			%>	
				<div id="login">
					<div style="margin-left: 120px;">
						<a href="index.jsp">login</a> | <a href="signup.jsp">signup</a>
				</div>					
			<% 		
				}else{
			%>	
				<div id="login" style="margin-left: 100px;">
					<div>
						<%=dao.getName(userID)%> 회원님, 반갑습니다. 
						&nbsp;<a href="logout.jsp">logout</a> | <a href="update.jsp">MyInfo</a>
					</div>
				</div>					
			<%		
				}
			%>
      		
      		
      <div class="container-fluid">
        <div class="d-flex align-items-center">
          <div class="site-logo mr-auto w-25"><a href="index.jsp">OneSchool</a></div>

          <div class="mx-auto text-center">
            <nav class="site-navigation position-relative text-right" role="navigation">
              <ul class="site-menu main-menu js-clone-nav mx-auto d-none d-lg-block  m-0 p-0">
                <li><a href="#home-section" class="nav-link">Home</a></li>
                <li><a href="#courses-section" class="nav-link">Gallery</a></li>
                <li><a href="#programs-section" class="nav-link">Our Board</a></li>
                <li><a href="#teachers-section" class="nav-link">Teachers</a></li>
              </ul>
            </nav>
          </div>

          <div class="ml-auto w-25">
            <nav class="site-navigation position-relative text-right" role="navigation">
              <ul class="site-menu main-menu site-menu-dark js-clone-nav mr-auto d-none d-lg-block m-0 p-0">
                <li class="cta"><a href="#contact-section" class="nav-link"><span>Contact Us</span></a></li>
              </ul>
            </nav>
            <a href="#" class="d-inline-block d-lg-none site-menu-toggle js-menu-toggle text-black float-right"><span class="icon-menu h3"></span></a>
          </div>
        </div>
      </div>
      
    </header>