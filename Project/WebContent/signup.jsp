<%-- 회원가입을 요청하는 페이지 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>회원가입</title>
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
    
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" 
		style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                var addr = ''; 
                var extraAddr = ''; 

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else { 
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                  
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                  
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                   
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }

                    document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }


                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                document.getElementById("sample2_detailAddress").focus();

                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        element_layer.style.display = 'block';

        initLayerPosition();
    }


    function initLayerPosition(){
        var width = 300; 
        var height = 400; 
        var borderWidth = 5; 

        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
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
                
                  <form action="signupPro.jsp" 
                  		method="post" 
                  		id="form"
                  		class="form-box"
                  		onsubmit="return validateForm(this);">
                  		
                    <h3 class="h4 text-black mb-4">Sign up</h3>
                    <div class="form-group">
                      <input type="text" class="form-control" placeholder="Id" name="Id" id="Id">
                      <input type="button" value="아이디중복확인" class="idbtn" name="addcheck" >
                      <div id="check" style="color:red;">아이디 중복확인을 해주세요</div>
                    </div>
                    <div class="form-group">
                      <input type="password" class="form-control" placeholder="Password" name="Pass">
                    </div>
                    <div class="form-group">
                      <input type="text" class="form-control" placeholder="Name" name="Name">
                    </div>
                     <div class="form-group">
                      <input type="text" class="form-control" id="sample2_postcode" placeholder="우편번호" name="addr1">
                      <input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기">
                    </div> 
                     <div class="form-group">
                      <input type="text" class="form-control" id="sample2_address" placeholder="주소" name="addr2">
                    </div>
                    <div class="form-group">
                    	<input type="text"class="form-control" id="sample2_detailAddress" placeholder="상세주소" name="addr3">
                    </div>
                    <div class="form-group">
                    	<input type="text" class="form-control" id="sample2_extraAddress" placeholder="참고항목" name="addr4">
                    </div>             
                    <div class="form-group" align="center">
                      <input type="submit" class="btn btn-primary btn-pill" value="Sign up">
                    </div>
                  </form>

                </div>
              </div>
            </div>
            
          </div>
        </div>
      </div>
    </div>

    <!--------------------- footer --------------------->
 	<jsp:include page="footer.jsp"/>
	<!--------------------- footer --------------------->
 
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
 
<%--------------------- 아이디 중복체크 버튼 클릭했을 때 ! ---------------------%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/address.js"></script>
  
</body>
</html>