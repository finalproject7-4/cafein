<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<h1>/information/memberJoin.jsp</h1>
	
	<fieldset>
		<legend>직원 정보 등록</legend>
		<form method="post">
			직원 코드 : <input type="text" name="membercode"><br>
			직원명 : <input type="text" name="membername"><br>
			비밀번호 : <input type="password" name="memberpw"><br>
			생년월일 : <input type="date" name="memberbirth"><br>
			입사일 : <input type="date" name="memberhire"><br>
			부서명 : <input type="text" name="departmentname"><br>
			직급 : <input type="text" name="memberposition"><br>
			E-Mail : <input type="email" name="memberemail"><br>
			내선번호 : <input type="text" name="memberdeptphone"><br>
			전화번호 : <input type="text" name="memberphone"><br>
			<button type="submit">직원 등록</button>
		</form>
	</fieldset>
	
<%@ include file="../include/footer.jsp" %>
