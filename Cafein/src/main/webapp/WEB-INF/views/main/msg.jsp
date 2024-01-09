<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<script type="text/javascript">
		alert("사원번호와 비밀번호를 확인해주세요.");
		
		// alert은 작동하나 sweetalert은 작동하지 않음
// 		Swal.fire({
// 	  	  icon: "error",
// 	  	  title: "사원번호, 비밀번호 불일치",
// 	  	  text: "사원번호와 비밀번호를 확인해주세요.",
// 		});
		history.back();
	</script>
</body>
</html>