<%-- 로그인 요청이 구현된 메인페이지 --%>

<%@page import="board.BoardPage"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	BoardDAO dao = new BoardDAO();
	
	Map<String, Object> param = new HashMap<String, Object>();
	
	request.setCharacterEncoding("utf-8");
	
	String searchField = request.getParameter("searchField"); 
	String searchWord = request.getParameter("searchWord");
	
	System.out.println(searchField);
	System.out.println(searchWord);
	
	if (searchWord != null) { 
	
		param.put("searchField", searchField); 
		param.put("searchWord", searchWord); 
	
	}
	
	int totalCount = dao.selectCount(param);
	
	/*--------------------- 페이징 --------------------*/

	// 한 페이지에 출력할 게시물의 개수 10
	int pageSize = Integer.parseInt(application.getInitParameter("POST_PER_PAGE"));
	
	// 한 블럭에 출력할 페이지 번호 개수 5
	int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
	
	int totalPage = (int) Math.ceil((double) totalCount / pageSize); 
																						
	System.out.println(totalPage);	
	
	int pageNum = 1;
	String pageTemp = request.getParameter("pageNum");
	
	if (pageTemp != null && !pageTemp.equals("")) { 
	
		pageNum = Integer.parseInt(pageTemp); 
	}
	
	int start = (pageNum - 1) * pageSize + 1; // 첫게시물 번호
	int end = (pageNum * pageSize); // 마지막게시물 번호
	
	param.put("start", start);
	param.put("end", end);

	/*--------------------- 페이징 --------------------*/

	List<BoardDTO> boardLists = dao.selectList(param); 
%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>OneSchool 메인화면</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Muli:300,400,700,900" rel="stylesheet">
    <link rel="stylesheet" href="fonts/icomoon/style.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/jquery-ui.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/jquery.fancybox.min.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">
    <link rel="stylesheet" href="css/aos.css">
    <link rel="stylesheet" href="css/style.css">
    
 <script type="text/javascript">
	
 	function validateForm(form) {
		
		if(form.Id.value == ""){
			alert("로그인 후 이용해주세요.");
			return false;
		}
		
		if(form.Pass.value == ""){
			alert("패스워드를 입력하세요.")
			return false;
		
		}else{
			
		}
		
	}

</script> 
</head>

 <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">
  
  <div class="site-wrap">
    <div class="site-mobile-menu site-navbar-target">
      <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close mt-3">
          <span class="icon-close2 js-menu-toggle"></span>
        </div>
      </div>
      <div class="site-mobile-menu-body"></div>
    </div>

    <!--------------------- header --------------------->
	<jsp:include page="header.jsp"/>
	<!--------------------- header --------------------->
	
    <div class="intro-section" id="home-section">
      <div class="slide-1" style="background-image: url('images/hero_1.jpg');" data-stellar-background-ratio="0.5">
        <div class="container">
          <div class="row align-items-center">
            <div class="col-12">
              <div class="row align-items-center">
                <div class="col-lg-6 mb-4">
                  <h1  data-aos="fade-up" data-aos-delay="100">Learn From The Expert</h1>
                  <p class="mb-4"  data-aos="fade-up" data-aos-delay="200">Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime ipsa nulla sed quis rerum amet natus quas necessitatibus.</p>
                  <p data-aos="fade-up" data-aos-delay="300"><a href="#" class="btn btn-primary py-3 px-5 btn-pill">Admission Now</a></p>
                </div>

                <div class="col-lg-5 ml-auto" data-aos="fade-up" data-aos-delay="500">
                  <form action="loginPro.jsp" 
                  		method="post" 
                  		id="form"
                  		class="form-box"
                  		onsubmit="return validateForm(this);">
                    <h3 class="h4 text-black mb-4">Login</h3>
                    
                    <div class="form-group">
                      <input type="text" class="form-control" placeholder="Id" name="Id">
                    </div>
                    
                    <div class="form-group">
                      <input type="password" class="form-control" placeholder="Password" name="Pass">
                    </div>
                    
                    <div class="form-group" align="center">
                      <input type="submit" class="btn btn-primary btn-pill" value="Login">
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="site-section courses-title" id="courses-section">
      <div class="container">
        <div class="row mb-5 justify-content-center">
          <div class="col-lg-7 text-center" data-aos="fade-up" data-aos-delay="">
            <h2 class="section-title">Gallery</h2>
          </div>
        </div>
      </div>
    </div>
    
    <div class="site-section courses-entry-wrap"  data-aos="fade-up" data-aos-delay="100">
      <div class="container">
        <div class="row">
          <div class="owl-carousel col-12 nonloop-block-14">
            <div class="course bg-white h-100 align-self-stretch">
              <figure class="m-0">
                <a href="course-single.jsp"><img src="images/img_1.jpg" alt="Image" class="img-fluid"></a>
              </figure>
              
              <div class="course-inner-text py-4 px-4">
                <span class="course-price">$20</span>
                <div class="meta"><span class="icon-clock-o"></span>4 Lessons / 12 week</div>
                <h3><a href="#">Study Law of Physics</a></h3>
                <p>Lorem ipsum dolor sit amet ipsa nulla adipisicing elit. </p>
              </div>
              
              <div class="d-flex border-top stats">
                <div class="py-3 px-4"><span class="icon-users"></span> 2,193 students</div>
                <div class="py-3 px-4 w-25 ml-auto border-left"><span class="icon-chat"></span> 2</div>
              </div>
            </div>

            <div class="course bg-white h-100 align-self-stretch">
              <figure class="m-0">
                <a href="course-single.jsp"><img src="images/img_2.jpg" alt="Image" class="img-fluid"></a>
              </figure>
              <div class="course-inner-text py-4 px-4">
                <span class="course-price">$99</span>
                
                <div class="meta"><span class="icon-clock-o"></span>4 Lessons / 12 week</div>
                <h3><a href="#">Logo Design Course</a></h3>
                <p>Lorem ipsum dolor sit amet ipsa nulla adipisicing elit. </p>
              </div>
              
              <div class="d-flex border-top stats">
                <div class="py-3 px-4"><span class="icon-users"></span> 2,193 students</div>
                <div class="py-3 px-4 w-25 ml-auto border-left"><span class="icon-chat"></span> 2</div>
              </div>
            </div>

            <div class="course bg-white h-100 align-self-stretch">
              <figure class="m-0">
                <a href="course-single.jsp"><img src="images/img_3.jpg" alt="Image" class="img-fluid"></a>
              </figure>
              
              <div class="course-inner-text py-4 px-4">
                <span class="course-price">$99</span>
                <div class="meta"><span class="icon-clock-o"></span>4 Lessons / 12 week</div>
                <h3><a href="#">JS Programming Language</a></h3>
                <p>Lorem ipsum dolor sit amet ipsa nulla adipisicing elit. </p>
              </div>
              
              <div class="d-flex border-top stats">
                <div class="py-3 px-4"><span class="icon-users"></span> 2,193 students</div>
                <div class="py-3 px-4 w-25 ml-auto border-left"><span class="icon-chat"></span> 2</div>
              </div>
            </div>

            <div class="course bg-white h-100 align-self-stretch">
              <figure class="m-0">
                <a href="course-single.jsp"><img src="images/img_4.jpg" alt="Image" class="img-fluid"></a>
              </figure>
              
              <div class="course-inner-text py-4 px-4">
                <span class="course-price">$20</span>
                <div class="meta"><span class="icon-clock-o"></span>4 Lessons / 12 week</div>
                <h3><a href="#">Study Law of Physics</a></h3>
                <p>Lorem ipsum dolor sit amet ipsa nulla adipisicing elit. </p>
              </div>
              
              <div class="d-flex border-top stats">
                <div class="py-3 px-4"><span class="icon-users"></span> 2,193 students</div>
                <div class="py-3 px-4 w-25 ml-auto border-left"><span class="icon-chat"></span> 2</div>
              </div>
            </div>

            <div class="course bg-white h-100 align-self-stretch">
              <figure class="m-0">
                <a href="course-single.jsp"><img src="images/img_5.jpg" alt="Image" class="img-fluid"></a>
              </figure>
              
              <div class="course-inner-text py-4 px-4">
                <span class="course-price">$99</span>
                <div class="meta"><span class="icon-clock-o"></span>4 Lessons / 12 week</div>
                <h3><a href="#">Logo Design Course</a></h3>
                <p>Lorem ipsum dolor sit amet ipsa nulla adipisicing elit. </p>
              </div>
              
              <div class="d-flex border-top stats">
                <div class="py-3 px-4"><span class="icon-users"></span> 2,193 students</div>
                <div class="py-3 px-4 w-25 ml-auto border-left"><span class="icon-chat"></span> 2</div>
              </div>
            </div>

            <div class="course bg-white h-100 align-self-stretch">
              <figure class="m-0">
                <a href="course-single.jsp"><img src="images/img_6.jpg" alt="Image" class="img-fluid"></a>
              </figure>
              
              <div class="course-inner-text py-4 px-4">
                <span class="course-price">$99</span>
                <div class="meta"><span class="icon-clock-o"></span>4 Lessons / 12 week</div>
                <h3><a href="#">JS Programming Language</a></h3>
                <p>Lorem ipsum dolor sit amet ipsa nulla adipisicing elit. </p>
              </div>
              
              <div class="d-flex border-top stats">
                <div class="py-3 px-4"><span class="icon-users"></span> 2,193 students</div>
                <div class="py-3 px-4 w-25 ml-auto border-left"><span class="icon-chat"></span> 2</div>
              </div>
            </div>
          </div>
        </div>
        
        <div class="row justify-content-center">
          <div class="col-7 text-center">
            <button class="customPrevBtn btn btn-primary m-1">Prev</button>
            <button class="customNextBtn btn btn-primary m-1">Next</button>
          </div>
        </div>
      </div>
    </div>

	<!------------------- 게시판 --------------------->
	<div class="site-section" id="programs-section">
		<div class="container">
			<div class="row mb-5 justify-content-center">
				<div class="col-lg-7 text-center" data-aos="fade-up"
					data-aos-delay="">
					<h2 class="section-title">Our Board</h2>
					<div id="table_search" align="right">
						<form action="cousor-single.jsp" method="post">
							<select name="searchField" style="width: 100px; height: 40px;">
								<option value="title" class="btn" name="Title">제목</option>
								<option value="content" class="btn" name="Con">내용</option>
							</select> 
								<input type="text" name="searchWord"> 
								<input type="submit" value="검색">
						</form>
					</div>
					
					<div align="left">
					<p>
						▶ 현재페이지: <%=pageNum%> (전체:<%=totalPage%>) ◀
					</p>
					</div>
					<table class="table table-striped">
						<tr align="center">
							<th style="background-color: #eeeeee; text-align: center;">글번호</th>
							<th style="background-color: #eeeeee; text-align: center;">제목</th>
							<th style="background-color: #eeeeee; text-align: center;">작성자</th>
							<th style="background-color: #eeeeee; text-align: center;">작성일</th>
							<th style="background-color: #eeeeee; text-align: center;">조회수</th>
						</tr>
						<%
						if (boardLists.isEmpty()) {
						%>
						
						<tr align="center">
							<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
						</tr>
						
						<%
						} else { 

						int virtualNum = 0; // 화면상에서의 게시물 번호

						int countNum = 0;

							for (BoardDTO dto : boardLists) {
	
								virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);		
						%>
						
							<tr align="center">
								<td><%=virtualNum%></td>
								<td><a href="view.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle()%></a></td>
								<td><%=dto.getId()%></td>
								<td><%=dto.getPostdate()%></td>
								<td><%=dto.getVisitcount()%></td>
							</tr>
							
						<%
							}
						}
						%>
						
					</table>
					<div id="table_search" align="right">

						<%
							String userID = (String) session.getAttribute("userID"); // 다운캐스팅

						if (userID != null) { // 로그인 했다면 글쓰기 버튼 활성화 !!!!!!!!!
						%>
						
						<input type="button" value="글쓰기"  class="btn btn-primary pull-right"
								onclick="location.href='write.jsp'">

						<%
							}
						%>
					</div>
				</div>
			</div>
				<div id="page_control" align="center">
				
					<!-- 					  조회한글수	화면에보여지는   하나의블럭에묶이는   현재보여지는   요청할주소  -->
					<!-- 									글수		 페이지번호개수	     페이지번호   				 -->
					<%
						out.println(BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()));
					%>
				</div>				
		</div>
	</div>
	<div class="clear"></div>
	<!------------------- 게시판 --------------------->

    <div class="site-section" id="teachers-section">
      <div class="container">

        <div class="row mb-5 justify-content-center">
          <div class="col-lg-7 mb-5 text-center"  data-aos="fade-up" data-aos-delay="">
            <h2 class="section-title">Our Teachers</h2>
            <p class="mb-5">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magnam repellat aut neque! Doloribus sunt non aut reiciendis, vel recusandae obcaecati hic dicta repudiandae in quas quibusdam ullam, illum sed veniam!</p>
          </div>
        </div>

        <div class="row">
          <div class="col-md-6 col-lg-4 mb-4" data-aos="fade-up" data-aos-delay="100">
            <div class="teacher text-center">
              <img src="images/person_1.jpg" alt="Image" class="img-fluid w-50 rounded-circle mx-auto mb-4">
              <div class="py-2">
                <h3 class="text-black">Benjamin Stone</h3>
                <p class="position">Physics Teacher</p>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Porro eius suscipit delectus enim iusto tempora, adipisci at provident.</p>
              </div>
            </div>
          </div>

          <div class="col-md-6 col-lg-4 mb-4" data-aos="fade-up" data-aos-delay="200">
            <div class="teacher text-center">
              <img src="images/person_2.jpg" alt="Image" class="img-fluid w-50 rounded-circle mx-auto mb-4">
              <div class="py-2">
                <h3 class="text-black">Katleen Stone</h3>
                <p class="position">Physics Teacher</p>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Porro eius suscipit delectus enim iusto tempora, adipisci at provident.</p>
              </div>
            </div>
          </div>

          <div class="col-md-6 col-lg-4 mb-4" data-aos="fade-up" data-aos-delay="300">
            <div class="teacher text-center">
              <img src="images/person_3.jpg" alt="Image" class="img-fluid w-50 rounded-circle mx-auto mb-4">
              <div class="py-2">
                <h3 class="text-black">Sadie White</h3>
                <p class="position">Physics Teacher</p>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Porro eius suscipit delectus enim iusto tempora, adipisci at provident.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="site-section bg-image overlay" style="background-image: url('images/hero_1.jpg');">
      <div class="container">
        <div class="row justify-content-center align-items-center">
          <div class="col-md-8 text-center testimony">
            <img src="images/person_4.jpg" alt="Image" class="img-fluid w-25 mb-4 rounded-circle">
            <h3 class="mb-4">Jerome Jensen</h3>
            <blockquote>
              <p>&ldquo; Lorem ipsum dolor sit amet consectetur adipisicing elit. Rerum rem soluta sit eius necessitatibus voluptate excepturi beatae ad eveniet sapiente impedit quae modi quo provident odit molestias! Rem reprehenderit assumenda &rdquo;</p>
            </blockquote>
          </div>
        </div>
      </div>
    </div>

    <div class="site-section pb-0">
      <div class="future-blobs">
        <div class="blob_2">
          <img src="images/blob_2.svg" alt="Image">
        </div>
        <div class="blob_1">
          <img src="images/blob_1.svg" alt="Image">
        </div>
      </div>
      <div class="container">
        <div class="row mb-5 justify-content-center" data-aos="fade-up" data-aos-delay="">
          <div class="col-lg-7 text-center">
            <h2 class="section-title">Why Choose Us</h2>
          </div>
        </div>
        
        <div class="row">
          <div class="col-lg-4 ml-auto align-self-start"  data-aos="fade-up" data-aos-delay="100">
            <div class="p-4 rounded bg-white why-choose-us-box">
              <div class="d-flex align-items-center custom-icon-wrap custom-icon-light mb-3">
                <div class="mr-3"><span class="custom-icon-inner"><span class="icon icon-graduation-cap"></span></span></div>
                <div><h3 class="m-0">22,931 Yearly Graduates</h3></div>
              </div>

              <div class="d-flex align-items-center custom-icon-wrap custom-icon-light mb-3">
                <div class="mr-3"><span class="custom-icon-inner"><span class="icon icon-university"></span></span></div>
                <div><h3 class="m-0">150 Universities Worldwide</h3></div>
              </div>

              <div class="d-flex align-items-center custom-icon-wrap custom-icon-light mb-3">
                <div class="mr-3"><span class="custom-icon-inner"><span class="icon icon-graduation-cap"></span></span></div>
                <div><h3 class="m-0">Top Professionals in The World</h3></div>
              </div>

              <div class="d-flex align-items-center custom-icon-wrap custom-icon-light mb-3">
                <div class="mr-3"><span class="custom-icon-inner"><span class="icon icon-university"></span></span></div>
                <div><h3 class="m-0">Expand Your Knowledge</h3></div>
              </div>

              <div class="d-flex align-items-center custom-icon-wrap custom-icon-light mb-3">
                <div class="mr-3"><span class="custom-icon-inner"><span class="icon icon-graduation-cap"></span></span></div>
                <div><h3 class="m-0">Best Online Teaching Assistant Courses</h3></div>
              </div>

              <div class="d-flex align-items-center custom-icon-wrap custom-icon-light">
                <div class="mr-3"><span class="custom-icon-inner"><span class="icon icon-university"></span></span></div>
                <div><h3 class="m-0">Best Teachers</h3></div>
              </div>
            </div>
          </div>
          
          <div class="col-lg-7 align-self-end"  data-aos="fade-left" data-aos-delay="200">
            <img src="images/person_transparent.png" alt="Image" class="img-fluid">
          </div>
        </div>
      </div>
    </div>

    <div class="site-section bg-light" id="contact-section">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-md-7">
            <h2 class="section-title mb-3">Message Us</h2>
            <p class="mb-5">Natus totam voluptatibus animi aspernatur ducimus quas obcaecati mollitia quibusdam temporibus culpa dolore molestias blanditiis consequuntur sunt nisi.</p>
      
            <form method="post" data-aos="fade">
              <div class="form-group row">
                <div class="col-md-6 mb-3 mb-lg-0">
                  <input type="text" class="form-control" placeholder="First name">
                </div>
                
                <div class="col-md-6">
                  <input type="text" class="form-control" placeholder="Last name">
                </div>
              </div>

              <div class="form-group row">
                <div class="col-md-12">
                  <input type="text" class="form-control" placeholder="Subject">
                </div>
              </div>

              <div class="form-group row">
                <div class="col-md-12">
                  <input type="email" class="form-control" placeholder="Email">
                </div>
              </div>
              
              <div class="form-group row">
                <div class="col-md-12">
                  <textarea class="form-control" id="" cols="30" rows="10" placeholder="Write your message here."></textarea>
                </div>
              </div>

              <div class="form-group row">
                <div class="col-md-6">               
                  <input type="submit" class="btn btn-primary py-3 px-5 btn-block btn-pill" value="Send Message">
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    
    <!------------------- footer ------------------->
 	<jsp:include page="footer.jsp"/>
	<!------------------- footer ------------------->
  
  </div> <!-- .site-wrap -->

  <script src="js/jquery-3.3.1.min.js"></script>
  <script src="js/jquery-migrate-3.0.1.min.js"></script>
  <script src="js/jquery-ui.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.stellar.min.js"></script>
  <script src="js/jquery.countdown.min.js"></script>
  <script src="js/bootstrap-datepicker.min.js"></script>
  <script src="js/jquery.easing.1.3.js"></script>
  <script src="js/aos.js"></script>
  <script src="js/jquery.fancybox.min.js"></script>
  <script src="js/jquery.sticky.js"></script>
  <script src="js/main.js"></script>
    
  </body>
</html>