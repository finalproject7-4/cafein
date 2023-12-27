<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<h1>/information/memberDelete.jsp</h1>
	
	<fieldset>
		<legend>직원 정보 삭제</legend>
			<form method="post">
			<input type="hidden" name="memberid" value="${resultVO.memberid }">
				직원명 : <input type="text" name="membername" value="${resultVO.membername }"><br>
				비밀번호 : <input type="password" name="memberpw" value="${resultVO.memberpw }"><br>
				생년월일 : <input type="date" name="memberbirth" value="${resultVO.memberbirth }"><br>
				입사일 : <input type="date" name="memberhire" value="${resultVO.memberhire }"><br>
				부서명 : <input type="text" name="departmentname" value="${resultVO.departmentname }"><br>
				직급 : <input type="text" name="memberposition" value="${resultVO.memberposition }"><br>
				E-Mail : <input type="email" name="memberemail" value="${resultVO.memberemail }"><br>
				내선번호 : <input type="text" name="memberdeptphone" value="${resultVO.memberdeptphone }"><br>
				전화번호 : <input type="text" name="memberphone" value="${resultVO.memberphone }"><br>
			<button type="submit">직원 삭제</button>
		</form>
	</fieldset>
	
<%@ include file="../include/footer.jsp" %>

