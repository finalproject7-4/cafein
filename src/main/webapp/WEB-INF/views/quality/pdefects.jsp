<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<form method="POST">
		<fieldset>
			<legend>불량 현황 등록</legend>
			<input type="hidden" value="qualityid" name="qualityid">
			<label>검수 번호 : <input type="text" value="${vo.auditcode }" readonly></label><br>
			<label>상품 구분 : 
				<c:if test="${!empty vo.itemtype && vo.itemtype.equals('반품') }"> <!-- 반품인 경우 -->
					<input type="text" value="${vo.itemtype }" readonly><br>
				</c:if>
				<c:if test="${!empty vo.itemtype && vo.itemtype.equals('생산') }"> <!-- 생산인 경우 -->
					<input type="text" value="${vo.itemtype }-${vo.process }" readonly><br>
				</c:if>
			</label>
			<label>상품 코드 : <input type="text" value="${vo.itemcode }" readonly></label><br>
			<label>상품명 : <input type="text" value="${vo.itemname }" readonly></label><br>
			<label>불량개수 : <input type="number" value="${vo.defectquantity }" readonly></label><br>
			<label>불량사유 : <br>
			<textarea rows="3" placeholder="불량 사유를 입력하세요" name="defecttype" required></textarea></label><br>
			<label>처리 방식 :
			<select name="processmethod" required>
				<option>폐기</option>
			</select></label><br>
		
		<input type="submit" value="불량 저장">
		</fieldset>
	</form>

<%@ include file="../include/footer.jsp" %>