<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="UTF-8">

<head>
    <meta charset="utf-8">
    <title>Cafe In</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <!-- Favicon -->
    <link href="../resources/img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="../resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="../resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="../resources/css/style.css?2" rel="stylesheet">
    
    <!-- Favicon -->
    <link href="../resources/img/bean.ico" rel="icon">
</head>

<body>

	<!-- 로그인 시작 -->
	<div class="container-fluid">
		<div class="row h-100 align-items-center justify-content-center"
			style="min-height: 100vh;">
			<div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
				<div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
					<div class="d-flex align-items-center justify-content-between mb-3">
						<h3>Cafe In</h3>
					</div>
					<form action="/main/login" method="post" id="login">
						<div class="form-group m-2">
							<input class="form-control" type="text" name="membercode" id="membercode"
								   placeholder="사원번호" aria-label="default input example">
						</div>
						<div class="form-group m-2">
							<input class="form-control" type="password" name="memberpw" id="memberpw"
								   placeholder="비밀번호" aria-label="default input example">
						</div>
						<div class="d-flex align-items-center justify-content-between m-2">
							<div class="form-check">
								<input type="checkbox" class="form-check-input"	id="idSaveCheck">
								<label class="form-check-label"	for="idSaveCheck">사원번호 기억하기</label>
							</div>
						</div>
						<div class="col-4 mx-auto">
							<button type="submit" class="btn btn-lg btn-dark m-2">로그인</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 로그인 끝 -->

	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script>
	//form 제출 이벤트를 가로채고 빈 값이 있는지 확인
	document.getElementById("login").onsubmit = function(event) {
		
	    // 사원번호 입력 필드의 값을 가져옴
	    var membercode = document.getElementById("membercode").value;
	 	// 비밀번호 입력 필드의 값을 가져옴
	    var memberpw = document.getElementById("memberpw").value;
	    
	    // 사원번호 값이 비어 있는지 확인
	    if (membercode === "") {
	        // 사원번호가 비어 있는 경우 알림 메시지를 띄움
	        Swal.fire({
	        	  icon: "error",
	        	  title: "사원번호 입력 오류",
	        	  text: "사원번호를 입력하세요.",
        	});
	        // 폼 제출 중단
	        event.preventDefault();
	    }
	    
	 	// 비밀번호 값이 비어 있는지 확인
	    if (membercode != "" && memberpw === "") {
	        // 비밀번호가 비어 있는 경우 알림 메시지를 띄움
	        Swal.fire({
	        	  icon: "error",
	        	  title: "비밀번호 입력 오류",
	        	  text: "비밀번호를 입력하세요.",
        	});
	        // 폼 제출 중단
	        event.preventDefault();
	    }
	};
	
	// 사원번호 기억하기
	$(document).ready(function() {
		var key = getCookie("idChk"); //user1
		if (key != "") {
			$("#membercode").val(key);
		}

		if ($("#membercode").val() != "") {
			$("#idSaveCheck").attr("checked", true);
		}

		$("#idSaveCheck").change(function() {
			if ($("#idSaveCheck").is(":checked")) {
				setCookie("idChk", $("#membercode").val(), 7);
			} else {
				deleteCookie("idChk");
			}
		});

		$("#membercode").keyup(function() {
			if ($("#idSaveCheck").is(":checked")) {
				setCookie("idChk", $("#membercode").val(), 7);
			}
		});
	});
	
	function setCookie(cookieName, value, exdays) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value)
				+ ((exdays == null) ? "" : "; expires="
						+ exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}

	function deleteCookie(cookieName) {
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires="
				+ expireDate.toGMTString();
	}

	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if (start != -1) {
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if (end == -1)
				end = cookieData.length;
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="../resources/lib/chart/chart.min.js"></script>
	<script src="../resources/lib/easing/easing.min.js"></script>
	<script src="../resources/lib/waypoints/waypoints.min.js"></script>
	<script src="../resources/lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="../resources/lib/tempusdominus/js/moment.min.js"></script>
	<script src="../resources/lib/tempusdominus/js/moment-timezone.min.js"></script>
	<script
		src="../resources/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

	<!-- Template Javascript -->
	<script src="../resources/js/main.js"></script>
</body>

</html>