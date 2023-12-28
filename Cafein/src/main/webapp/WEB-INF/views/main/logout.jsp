<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<h1>logout.jsp</h1>
	
	<form action="/main/logout" method="post">
		<input type="hidden" name="${_csrf.parameterName }" 
							 value="${_csrf.token }">	
		<input type="submit" value="로그아웃">
	</form>

<%@ include file="../include/footer.jsp" %>