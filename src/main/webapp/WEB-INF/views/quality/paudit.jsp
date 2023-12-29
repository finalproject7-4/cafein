<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<h1>paudit (생산 검수 입력 폼)</h1>
	<h2>포장 단계가 아닌 생산의 경우 불량이 발생 시 전체 불량 처리</h2>
	
	<form method="POST" onsubmit="return calculate();">
		<fieldset>
			<legend>생산 검수</legend>
			<!-- 검수자는 나중에 세션에 저장되어있는 코드 받아와서 사용 -->
			<input type="hidden" name="qualityid" value="${vo.qualityid }">
			<label>검수코드 : <input type="text" name="auditcode" value="${vo.auditcode }" readonly></label><br>
			<label>생산ID : <input type="text" name="produceid" value="${vo.produceid }" readonly></label><br>
			<label>생산 단계 : <input type="text" name="process" value="${vo.process }" readonly></label><br>
			<label>품목코드 : <input type="text" name="itemcode" value="${vo.itemcode }" readonly></label><br>
			<label>품목명 : <input type="text" name="itemname" value="${vo.itemname}" readonly></label><br>
			<label>검수자 : <input type="text" name="auditbycode" value="${sessionScope.membercode }" readonly></label><br>
			<label>생산량 : <input type="number" name="productquantity" value="${vo.productquantity }" readonly>
			<c:if test="${!empty vo.process && !vo.process.equals('포장')}"> <!-- 포장이 아닐 때 -->
			(g)
			</c:if>
			<c:if test="${!empty vo.process && vo.process.equals('포장')}"> <!-- 포장일 때 -->
			(개)
			</c:if>
			</label><br>
			<label>검수량 입력 : <input type="number" name="auditquantity" value="${vo.auditquantity }" required>
				<c:if test="${!empty vo.process && !vo.process.equals('포장')}"> <!-- 포장이 아닐 때 -->
					(g)
				</c:if>
				<c:if test="${!empty vo.process && vo.process.equals('포장')}"> <!-- 포장일 때 -->
					(개)
				</c:if>
			</label>
			<input type="button" value="검수량 확인" onclick="calculate();">
			<br>
			<label>불량 입력 : 
 				<c:if test="${!empty vo.process && !vo.process.equals('포장')}"> <!-- 포장이 아닐 때 -->
 					<c:if test="${vo.defectquantity == 0 }">
 						<label><input type="radio" name="defectYesOrNo" value="defect" onclick="setDefectQuantityHidden();">불량&nbsp;</label>
        				<label><input type="radio" name="defectYesOrNo" value="normal" onclick="setDefectQuantityHidden();" checked>정상</label><br>
 					</c:if>
 					<c:if test="${vo.defectquantity != 0 }">
 						<label><input type="radio" name="defectYesOrNo" value="defect" onclick="setDefectQuantityHidden();" checked>불량&nbsp;</label>
        				<label><input type="radio" name="defectYesOrNo" value="normal" onclick="setDefectQuantityHidden();">정상</label><br>
 					</c:if> 				
    				<input type="number" name="defectquantity" value="${vo.defectquantity }" required readonly> (g)
    			</c:if>
				<c:if test="${!empty vo.process && vo.process.equals('포장')}"> <!-- 포장일 때 -->
					<input type="number" name="defectquantity" value="${vo.defectquantity }" required> (개)
				</c:if>
			</label>
			<input type="button" value="정상 계산" onclick="calculate();">
			<br>
			<label>정상 : <input type="number" name="normalquantity" value=${vo.normalquantity } readonly> 
				<c:if test="${!empty vo.process && !vo.process.equals('포장')}"> <!-- 포장이 아닐 때 -->
					(g)
				</c:if>
				<c:if test="${!empty vo.process && vo.process.equals('포장')}"> <!-- 포장일 때 -->
					(개)
				</c:if>
			(불량 개수 입력에 따른 자동 계산)</label><br>
			<input type="submit" value="검수 저장"> <input type="button" value="뒤로 가기" onclick="location.href='/quality/plist';">
		</fieldset>
	</form>

<script>
function calculate() {
    // 생산량 가져오기
    var totalProduction = parseInt(document.getElementsByName('productquantity')[0].value);

    // 검수량 가져오기
    var auditQuantityInput = document.getElementsByName('auditquantity')[0];
    var auditQuantity = parseInt(auditQuantityInput.value);

    // 불량 개수 가져오기
    var defectiveCountInput = document.getElementsByName('defectquantity')[0];
    var defectiveCount = parseInt(defectiveCountInput.value);

    // 이미 받아온 값들 가져오기
	var originalAuditQuantity = parseInt("${vo.auditquantity}", 10);
	var originalDefectQuantity = parseInt("${vo.defectquantity}", 10);

    // 검수량과 불량 개수의 유효성 검사
    if (auditQuantity > totalProduction) {
        alert("검수량은 생산량을 넘을 수 없습니다.");
        auditQuantityInput.value = originalAuditQuantity;  // 검수량 초기화
        defectiveCountInput.value = originalDefectQuantity;  // 불량 개수 초기화
        return false;
    }

    if (defectiveCount > auditQuantity) {
        alert("불량 개수는 검수량을 넘을 수 없습니다.");
        defectiveCountInput.value = originalDefectQuantity;  // 불량 개수 초기화
        return false;
    }

    // 검수량이 이미 받아온 값 미만인 경우 경고
    if (auditQuantity < originalAuditQuantity) {
        alert("검수량은 이미 받아온 값 미만으로 입력할 수 없습니다.");
        auditQuantityInput.value = originalAuditQuantity;  // 검수량 초기화
        return false;
    }

    // 불량 개수가 이미 받아온 값 미만인 경우 경고
    if (defectiveCount < originalDefectQuantity) {
        alert("불량 개수는 이미 받아온 값 미만으로 입력할 수 없습니다.");
        defectiveCountInput.value = originalDefectQuantity;  // 불량 개수 초기화
        return false;
    }

    // 정상 개수 계산
    var normalCount = auditQuantity - defectiveCount;

    // 결과 출력
    document.getElementsByName('normalquantity')[0].value = normalCount;
    
    // 함수 재호출
    setDefectQuantityHidden();
    return true;
}
</script>
<script>

	var auditQuantity = "${auditQuantity}";
	
	if(auditQuantity == "zero"){
		alert(" 검수량은 0을 지정할 수 없습니다. ");
	}

</script>
<script>
function setDefectQuantityHidden() {
    var auditQuantityInput = document.getElementsByName('auditquantity')[0];
    var defectQuantityInput = document.getElementsByName('defectquantity')[0];
    var normalQuantityInput = document.getElementsByName('normalquantity')[0];
    
    // 불량 버튼이 선택되었을 때
    if (document.querySelector('input[name="defectYesOrNo"]:checked').value === "defect") {
        defectQuantityInput.value = auditQuantityInput.value;
        normalQuantityInput.value = "0";  // 정상 개수 초기화
    } 
    // 정상 버튼이 선택되었을 때
    else if (document.querySelector('input[name="defectYesOrNo"]:checked').value === "normal") {
        defectQuantityInput.value = "0";  // 0으로 설정
        normalQuantityInput.value = auditQuantityInput.value;
    }
}
</script>

<%@ include file="../include/footer.jsp" %>