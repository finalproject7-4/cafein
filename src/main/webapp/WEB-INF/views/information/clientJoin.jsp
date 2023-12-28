<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<h1>/information/clientJoin.jsp</h1>
	
	<fieldset>
		<legend>거래처 정보 등록</legend>
		<form method="post">
			거래처 코드 : <input type="text" name="clientcode"><br>
			거래처명 : <input type="text" name="clientname"><br>
			거래처 구분 : <input type="text" name="categoryofclient"><br>
			거래처 업종 : <input type="text" name="typeofclient"><br>
			사업자 번호 : <input type="text" name="businessnumber"><br>
			대표자 : <input type="text" name="representative"><br>
			담당자 : <input type="text" name="manager"><br>
			주소 : <input type="text" name="clientaddress"><br>
			전화번호 : <input type="text" name="clientphone"><br>
			팩스번호 : <input type="text" name="clientfax"><br>
			E-Mail : <input type="text" name="clientemail"><br>
			<button type="submit">거래처 등록</button>
		</form>
	</fieldset>
	
<%@ include file="../include/footer.jsp" %>
