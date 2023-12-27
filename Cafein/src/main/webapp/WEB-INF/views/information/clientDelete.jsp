<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<h1>/information/clientDelete.jsp</h1>

	<fieldset>
		<legend>거래처 정보 삭제</legend>
		<form method="post">
		<input type="hidden" name="clientid" value="${resultVO.clientid }">
			거래처 코드 : <input type="text" name="clientcode" value="${resultVO.clientcode }"><br>
			거래처명 : <input type="text" name="clientname" value="${resultVO.clientname }"><br>
			거래처 구분 : <input type="text" name="categoryofclient" value="${resultVO.categoryofclient }"><br>
			거래처 업종 : <input type="text" name="typeofclient" value="${resultVO.typeofclient }"><br>
			사업자 번호 : <input type="text" name="businessnumber" value="${resultVO.businessnumber }"><br>
			대표자 : <input type="text" name="representative" value="${resultVO.representative }"><br>
			담당자 : <input type="text" name="manager" value="${resultVO.manager }"><br>
			주소 : <input type="text" name="clientaddress" value="${resultVO.clientaddress }"><br>
			전화번호 : <input type="text" name="clientphone" value="${resultVO.clientphone }"><br>
			팩스번호 : <input type="text" name="clientfax" value="${resultVO.clientfax }"><br>
			E-Mail : <input type="text" name="clientemail" value="${resultVO.clientemail }"><br>
			<button type="submit">거래처 삭제</button>
		</form>
	</fieldset>

<%@ include file="../include/footer.jsp" %>