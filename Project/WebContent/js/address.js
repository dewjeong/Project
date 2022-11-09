//---------------------------------------------------------- id중복체크란
$(function(form) {
	// 아래의 아이디 중복체크 버튼을 클릭했을 때...
	$(".idbtn").click(function() {

		// 입력한 아이디 얻기
		var requestId = $("#Id").val();

		$.ajax({
			// 비동기방식으로 요청을 보낼 서버페이지의 URL
			url: 'signupIdCheck.jsp',
			// 전송방식을 get 또는 post로 지정
			type: 'post',
			// 서버페이지로 요청시 전송할 데이터를 지정
			data: { Id: requestId },
			// 서버페이지로부터 응답받을 데이터의 타입을 지정
			dataType: "text",
			// 서버페이지에 비동기방식으로 요청에 성공했을 때, 서버페이지가 응답하는 응답데이터를 받을 콜백함수 function이
			// 자동으로 호출이되어 매개변수로 전달받아 처리하게 된다.
			success: function(resData) {

				if (resData == -1) {
					$("#check").text("아이디는 필수정보입니다.");
					return false;

				} else if (resData == 0) {
					$("#check").text("사용가능한 아이디입니다.");
				
				} else if (resData == 1){
					$("#check").text("이미 사용중인 아이디입니다.");
					return false;
				}

			}
		});

	});

});

//---------------------------------------------------------- id중복체크란