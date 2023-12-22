<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<br>
		<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
			<h2>plist (생산 / 반품 품질 관리)</h2>
			<div class="form-check form-check-inline">
  				<input class="form-check-input" type="radio" name="stocktype" id="inlineRadio1" value="생산" checked onclick="navigatePage('생산')">
  				<label class="form-check-label" for="inlineRadio1">생산</label>
			</div>
			<div class="form-check form-check-inline">
  				<input class="form-check-input" type="radio" name="stocktype" id="inlineRadio2" value="자재" onclick="navigatePage('자재')">
  				<label class="form-check-label" for="inlineRadio2">자재</label>
			</div>
			<form action="/stock/slist" method="POST">
				<input type="text" name="search" placeholder="검색어를 입력하세요">
				<input type="submit" value="검색">
			</form>
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">품질관리번호</th>
								<th scope="col">검수번호</th>
								<th scope="col">상품구분</th>
								<th scope="col">생산/반품ID</th>
								<th scope="col">품목코드</th>
								<th scope="col">제품명</th>
								<th scope="col">검수자</th>
								<th scope="col">생산량</th>
								<th scope="col">검수량</th>
								<th scope="col">정상</th>
								<th scope="col">불량</th>
								<th scope="col">검수상태</th>
								<th scope="col">등록일</th>
								<th scope="col">검수완료일자</th>
								<th scope="col">확인</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="clist" items="${list }" varStatus="loop">
								<tr>
									<th>${clist.qualityid }</th>
									<td>${clist.auditcode }</td>
									<c:if test="${empty clist.process }">
										<td>${clist.itemtype }</td>
									</c:if>
									<c:if test="${!empty clist.process }">
										<td>${clist.itemtype }-${clist.process }</td>
									</c:if>			
									<td>
									<c:if test="${clist.returnid == 0}">
										${clist.produceid }
									</c:if>
									<c:if test="${clist.produceid == 0}">
										${clist.returnid }
									</c:if>
									</td>
									<td>${clist.itemcode }</td>
									<td>${clist.itemname }</td>
									<td>${clist.auditbycode }</td>
									<td>
										<c:if test="${(!empty clist.itemtype && clist.itemtype == '반품') || (!empty clist.process && clist.process == '포장')}">${clist.productquantity }(개)</c:if>
										<c:if test="${!empty clist.process && !clist.process.equals('포장') }">${clist.productquantity }(g)</c:if>
									</td>
									<td>
										<c:if test="${(!empty clist.itemtype && clist.itemtype == '반품') || (!empty clist.process && clist.process == '포장')}">${clist.auditquantity }(개)</c:if>
										<c:if test="${!empty clist.process && !clist.process.equals('포장') }">${clist.auditquantity }(g)</c:if>
									</td>
									<td>
										<c:if test="${(!empty clist.itemtype && clist.itemtype == '반품') || (!empty clist.process && clist.process == '포장')}">${clist.auditquantity - clist.defectquantity }(개)</c:if>
										<c:if test="${!empty clist.process && !clist.process.equals('포장') }">${clist.auditquantity - clist.defectquantity }(g)</c:if>
									</td>
									<td>
									<c:if test="${clist.defectquantity == 0}">
										<c:if test="${(!empty clist.itemtype && clist.itemtype == '반품') || (!empty clist.process && clist.process == '포장')}">${clist.defectquantity }(개)</c:if>
										<c:if test="${!empty clist.process && !clist.process.equals('포장') }">${clist.defectquantity }(g)</c:if>
									</c:if>
									<c:if test="${clist.defectquantity != 0}">
										<c:if test="${(!empty clist.itemtype && clist.itemtype == '반품') || (!empty clist.process && clist.process == '포장')}"><b style="color: red;">${clist.defectquantity }</b>(개)</c:if>
										<c:if test="${!empty clist.process && !clist.process.equals('포장') }"><b style="color: red;">${clist.defectquantity }</b>(g)</c:if>
									</c:if>
									</td>
									<td>
									<c:if test="${!empty clist.auditstatus && clist.auditstatus.equals('검수완료') && clist.defectquantity == 0}">
										<b style="color: brown;">${clist.auditstatus }</b>
									</c:if>
									<c:if test="${!empty clist.auditstatus && clist.auditstatus.equals('검수완료') && clist.defectquantity != 0}">
										<b style="color: red;">${clist.auditstatus }</b>
									</c:if>									
									<c:if test="${!empty clist.auditstatus && clist.auditstatus.equals('검수중')}">
										<b style="color: black;">${clist.auditstatus }</b>
									</c:if>
									<c:if test="${!empty clist.auditstatus && clist.auditstatus.equals('대기')}">
										${clist.auditstatus }
									</c:if>									
									</td>
									<td>${clist.registerationdate }</td>
									<td>${clist.completedate }</td>
									<td>
										<c:if test="${clist.auditstatus.equals('대기') || clist.auditstatus.equals('검수중') }">
											<c:if test="${clist.produceid != 0 && clist.returnid == 0 }"> <!-- 생산ID 존재 -->
												<c:if test="${!empty clist.process && clist.process.equals('포장')}">
<%-- 											<input type="button" value="생산검수" onclick="location.href='/quality/paudit?produceid=${clist.produceid}';"> --%>
												<button type="button" class="btn btn-primary btn-sm" 
												data-bs-toggle="modal" data-bs-target="#exampleModal"
												data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
												data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
												data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
												data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
												data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
												data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 												생산검수
												</button>
												</c:if>
												<c:if test="${!empty clist.process && !clist.process.equals('포장') }">
												<button type="button" class="btn btn-primary btn-sm" 
												data-bs-toggle="modal" data-bs-target="#produceAuditModal2"
												data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
												data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
												data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
												data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
												data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
												data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 												생산검수
												</button>
												</c:if>
											</c:if>
											<c:if test="${clist.produceid == 0 && clist.returnid != 0}"> <!-- 반품ID 존재 -->
<%-- 											<input type="button" value="반품검수" onclick="location.href='/quality/raudit?returnid=${clist.returnid}';">				 --%>
												<button type="button" class="btn btn-primary btn-sm" 
												data-bs-toggle="modal" data-bs-target="#returnAuditModal"
												data-returnid="${clist.returnid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
												data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
												data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
												data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
												data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
												data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 												반품검수
												</button>
											</c:if>
											<c:if test="${clist.produceid == 0 && clist.returnid == 0 }"> <!-- 생산ID, 반품ID 둘 다 미존재 = 자재 -->
												<input type="button" value="자재검수" onclick="location.href='/quality/iaudit?itemid=${clist.itemid}';">								
											</c:if>
										</c:if>
										<c:if test="${!empty clist.auditstatus && clist.auditstatus.equals('검수완료') && clist.defectquantity == 0 }"> <!-- 불량 X -->
											<c:if test="${!empty clist.process && !clist.process.equals('포장')}"> <!-- 생산 - 포장이 아닌 경우 -->
												<input type="button" class="btn btn-success btn-sm" value="정상"> <!-- 생산 상태 업데이트 -->
											</c:if>	
											<c:if test="${!empty clist.process && clist.process.equals('포장')}"> <!-- 생산 - 포장인 경우 -->
												<form action="/stock/new" method="POST"> <!-- 재고로 --> <!-- 생산 상태 업데이트 -->
													<input type="hidden" value="${clist.qualityid }" name="qualityid">
													<input type="hidden" value="${clist.itemid }" name="itemid">
													<input type="hidden" value="${clist.productquantity - clist.defectquantity }" name="stockquantity">
													<input type="submit" class="btn btn-success btn-sm" value="정상">
												</form>
											</c:if>
											<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품')}"> <!-- 반품인 경우 -->
												<input type="button" class="btn btn-success btn-sm" value="정상"> <!-- 재고로 --> <!-- 생산 상태 업데이트 -->
											</c:if>	
										</c:if>
										<c:if test="${!empty clist.auditstatus && clist.auditstatus.equals('검수완료') && clist.defectquantity != 0 }"> <!-- 불량 O -->
											<c:if test="${clist.normalquantity != 0 }"> <!-- 불량도 있고 정상도 있는 경우 -->
												<c:if test="${!empty clist.process && !clist.process.equals('포장')}"> <!-- 포장이 아닌 경우 -->
													<!-- <input type="button" value="정상"> --> <!-- 생산 상태 업데이트 [포장이 아닌 경우는 불량이 조금이라도 발생 시 전체 불량 처리] -->
<%-- 												<input type="button" value="불량" class="pdefects btn btn-danger btn-sm" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'"> <!-- 생산 상태 업데이트 --> --%>
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newPDefect"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
													data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 													불량
													</button>
												</c:if>	
												<c:if test="${!empty clist.process && clist.process.equals('포장')}"> <!-- 포장인 경우 -->
												<form action="/stock/new" method="POST"> <!-- 재고로 --> <!-- 생산 상태 업데이트 -->
													<input type="hidden" value="${clist.qualityid }" name="qualityid">
													<input type="hidden" value="${clist.itemid }" name="itemid">
													<input type="hidden" value="${clist.productquantity - clist.defectquantity }" name="stockquantity">
													<input type="submit" value="정상" class="btn btn-success btn-sm" >
<%-- 													<input type="button" value="불량" class="pdefects btn btn-danger btn-sm" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'"> <!-- 생산 상태 업데이트 --> --%>
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newPDefect"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
													data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 													불량
													</button>
												</form>
												</c:if>	
												<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품')}"> <!-- 반품인 경우 -->
													<input type="button" class="btn btn-success btn-sm" value="정상"> <!-- 재고로 -->
<%-- 												<input type="button" value="불량" class="pdefects btn btn-danger btn-sm" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'"> --%>
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newRDefect"
													data-returnid="${clist.returnid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
													data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 													불량
													</button>
												</c:if>	
											</c:if>
											<c:if test="${clist.normalquantity == 0 }"> <!-- 불량은 있지만 정상은 없는 경우 -->
												<c:if test="${!empty clist.process && !clist.process.equals('포장')}"> <!-- 포장이 아닌 경우 -->
<%-- 												<input type="button" value="불량" class="pdefects btn btn-danger btn-sm" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'"> --%>
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newPDefect"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
													data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 													불량
													</button>												
												</c:if>	
												<c:if test="${!empty clist.process && clist.process.equals('포장')}"> <!-- 포장인 경우 -->
<%-- 												<input type="button" value="불량" class="pdefects btn btn-danger btn-sm" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'"> --%>
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newPDefect"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
													data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 													불량
													</button>													
												</c:if>	
												<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품')}"> <!-- 반품인 경우 -->
<%-- 													<input type="button" value="불량" class="pdefects btn btn-danger btn-sm" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'"> --%>
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newRDefect"
													data-returnid="${clist.returnid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
													data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 													불량
													</button>												
												</c:if>	
											</c:if>
										</c:if>
									</td>
								</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
<!-- 경고 메세지 출력 -->	
<script>
 var result = "${result}";
 
 if(result == "duplicate"){
	 alert("이미 불량 정보가 등록된 검수 내역입니다.");
 }else if(result == "duplicateStock"){
	 alert("이미 재고 정보가 등록된 검수 내역입니다."); 
 }
 
 var stockInfo = $('#stockInfo');

 $('.stockNormal').click(function(){
	stockInfo.attr("action", "/stock/new");
	stockInfo.submit();
 });
</script>
<!-- 경고 메세지 출력 -->	
	
<!-- 생산 검수 모달창 (포장) -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/quality/paudit" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">생산 검수 (포장)</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      	<div class="row">
 			<div class="col">
           		<label for="qualityid" class="col-form-label">품질관리ID:</label>
            	<input type="text" class="form-control" id="qualityid" name="qualityid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="produceid" class="col-form-label">생산ID:</label>
            	<input type="text" class="form-control" id="produceid" name="produceid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="auditcode" class="col-form-label">검수번호:</label>
            	<input type="text" class="form-control" id="auditcode" name="auditcode" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="process" class="col-form-label">생산단계:</label>
            	<input type="text" class="form-control" id="process" name="process" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="productquantity" class="col-form-label">생산량:</label>
            	<input type="number" class="form-control" id="productquantity" name="productquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="auditquantity" class="col-form-label">검수량:</label>
            	<input type="number" class="form-control" id="auditquantity" name="auditquantity" value="" required>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="normalquantity" class="col-form-label">정상 (자동 계산):</label>
            	<input type="number" class="form-control" id="normalquantity" name="normalquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="defectquantity" class="col-form-label">불량 입력:</label>
            	<input type="number" class="form-control" id="defectquantity" name="defectquantity" value="" required>
  			</div>
		</div>
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">검수 저장</button>
      </div>
    </div>
   </form>
  </div>
</div>
<!-- 생산 검수 모달창 (포장) -->

<!-- 생산 검수 모달창 데이터 (포장) -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    let myModal = document.getElementById('exampleModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let qualityid = button.getAttribute('data-qualityid'); // qualityid
        let produceid = button.getAttribute('data-produceid'); // produceid
        let auditcode = button.getAttribute('data-auditcode'); // auditcode
        let itemtype = button.getAttribute('data-itemtype'); // itemtype
        let process = button.getAttribute('data-process'); // process
        let productquantity = button.getAttribute('data-productquantity'); // productquantity
        let auditquantity = button.getAttribute('data-auditquantity'); // auditquantity
        let defectquantity = button.getAttribute('data-defectquantity'); // defectquantity
        let normalquantity = button.getAttribute('data-normalquantity'); // normalquantity
        
        // 모달 내부의 입력 필드에 값을 설정
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityid;
        
        let pinputField = myModal.querySelector('input[name="produceid"]');
        pinputField.value = produceid;
        
        let ainputField = myModal.querySelector('input[name="auditcode"]');
        ainputField.value = auditcode;
        
        let proinputField = myModal.querySelector('input[name="process"]');
        proinputField.value = itemtype + " - " + process;
        
        let pqinputField = myModal.querySelector('input[name="productquantity"]');
        pqinputField.value = productquantity;
        
        let aqinputField = myModal.querySelector('input[name="auditquantity"]');
        aqinputField.value = auditquantity;
        
        let nqinputField = myModal.querySelector('input[name="normalquantity"]');
        nqinputField.value = normalquantity;
        
        let dqinputField = myModal.querySelector('input[name="defectquantity"]');
        dqinputField.value = defectquantity;
        
    	const productQuantityInput = document.getElementById("productquantity");
    	const auditQuantityInput = document.getElementById("auditquantity");
    	const defectiveQuantityInput = document.getElementById("defectquantity");
            
    	// 검수량 입력 필드의 blur 이벤트 리스너 추가
    	auditQuantityInput.addEventListener("blur", function() {
    		const productQuantity = parseInt(productQuantityInput.value, 10); // 생산량
    		const auditQuantity = parseInt(auditQuantityInput.value, 10);     // 검수량
    		const defectiveQuantity = parseInt(defectiveQuantityInput.value, 10);          // 불량 개수
    		
        	// 검수량이 생산량보다 큰 경우
        	if (auditQuantity > productquantity) {
        		alert("검수량은 생산량보다 많을 수 없습니다!");
        		auditQuantityInput.value = auditquantity; // 검수량 입력 필드 초기화
        		auditQuantityInput.focus();    // 검수량 입력 필드에 포커스
        		return;
        	}else if(auditQuantity < auditquantity){
        		alert("검수량은 기존 검수량보다 적을 수 없습니다!");
        		auditQuantityInput.value = auditquantity; // 검수량 입력 필드 초기화
        		auditQuantityInput.focus();    // 검수량 입력 필드에 포커스 
        		return;
    		}
				const normalQuantity = auditQuantity - defectiveQuantity;
 				document.getElementById("normalquantity").value = normalQuantity;
    	});

    	// 불량 개수 입력 필드의 blur 이벤트 리스너 추가
    	defectiveQuantityInput.addEventListener("blur", function() {
    		const auditQuantity = parseInt(auditQuantityInput.value, 10);                  // 검수량
    		const defectiveQuantity = parseInt(defectiveQuantityInput.value, 10);          // 불량 개수

    		// 불량 개수가 검수량을 초과하는 경우
    		if (defectiveQuantity > auditQuantity) {
    			alert("불량 개수는 검수량을 초과할 수 없습니다!");
    			defectiveQuantityInput.value = defectquantity; // 불량 개수 입력 필드 초기화
    			defectiveQuantityInput.focus();    // 불량 개수 입력 필드에 포커스
    			return;
    		}else if(defectiveQuantity < defectquantity){
    			alert("불량 개수는 기존 불량 개수보다 적을 수 없습니다!");
    			defectiveQuantityInput.value = defectquantity; // 불량 개수 입력 필드 초기화
    			defectiveQuantityInput.focus();    // 불량 개수 입력 필드에 포커스
    			return;
    		}
    			const normalQuantity = auditQuantity - defectiveQuantity;
     			document.getElementById("normalquantity").value = normalQuantity;
    		
    	});
    });
});
</script>
<!-- 생산 검수 모달창 데이터 (포장) -->

<!-- 생산 검수 모달창 (포장 X) -->
<div class="modal fade" id="produceAuditModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/quality/paudit" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">생산 검수 (블렌딩 / 냉각)</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      	<div class="row">
 			<div class="col">
           		<label for="qualityid" class="col-form-label">품질관리ID:</label>
            	<input type="text" class="form-control" id="qualityid" name="qualityid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="produceid" class="col-form-label">생산ID:</label>
            	<input type="text" class="form-control" id="produceid" name="produceid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="auditcode" class="col-form-label">검수번호:</label>
            	<input type="text" class="form-control" id="auditcode" name="auditcode" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="process" class="col-form-label">생산단계:</label>
            	<input type="text" class="form-control" id="process" name="process" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="productquantity" class="col-form-label">생산량:</label>
            	<input type="number" class="form-control" id="productquantity" name="productquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="auditquantity" class="col-form-label">검수량:</label>
            	<input type="number" class="form-control" id="auditquantity" name="auditquantity" value="" required>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="normalquantity" class="col-form-label">정상 (자동 계산):</label>
            	<input type="number" class="form-control" id="normalquantity" name="normalquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="defectquantity" class="col-form-label">불량 입력:</label>
            	<input type="number" class="form-control" id="defectquantity" name="defectquantity" value="" required>
  			</div>
		</div>
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">검수 저장</button>
      </div>
    </div>
   </form>
  </div>
</div>
<!-- 생산 검수 모달창 (포장 X) -->

<!-- 생산 검수 모달창 데이터 (포장 X) -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    let myModal = document.getElementById('produceAuditModal2');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let qualityid = button.getAttribute('data-qualityid'); // qualityid
        let produceid = button.getAttribute('data-produceid'); // produceid
        let auditcode = button.getAttribute('data-auditcode'); // auditcode
        let itemtype = button.getAttribute('data-itemtype'); // itemtype
        let process = button.getAttribute('data-process'); // process
        let productquantity = button.getAttribute('data-productquantity'); // productquantity
        let auditquantity = button.getAttribute('data-auditquantity'); // auditquantity
        let defectquantity = button.getAttribute('data-defectquantity'); // defectquantity
        let normalquantity = button.getAttribute('data-normalquantity'); // normalquantity
        
        // 모달 내부의 입력 필드에 값을 설정
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityid;
        
        let pinputField = myModal.querySelector('input[name="produceid"]');
        pinputField.value = produceid;
        
        let ainputField = myModal.querySelector('input[name="auditcode"]');
        ainputField.value = auditcode;
        
        let proinputField = myModal.querySelector('input[name="process"]');
        proinputField.value = itemtype + " - " + process;
        
        let pqinputField = myModal.querySelector('input[name="productquantity"]');
        pqinputField.value = productquantity;
        
        let aqinputField = myModal.querySelector('input[name="auditquantity"]');
        aqinputField.value = auditquantity;
        
        let nqinputField = myModal.querySelector('input[name="normalquantity"]');
        nqinputField.value = normalquantity;
        
        let dqinputField = myModal.querySelector('input[name="defectquantity"]');
        dqinputField.value = defectquantity;
        
    	const productQuantityInput = document.getElementById("productquantity");
    	const auditQuantityInput = document.getElementById("auditquantity");
    	const defectiveQuantityInput = document.getElementById("defectquantity");
            
    	// 검수량 입력 필드의 blur 이벤트 리스너 추가
    	auditQuantityInput.addEventListener("blur", function() {
    		const productQuantity = parseInt(productQuantityInput.value, 10); // 생산량
    		const auditQuantity = parseInt(auditQuantityInput.value, 10);     // 검수량
    		const defectiveQuantity = parseInt(defectiveQuantityInput.value, 10);          // 불량 개수
    		
        	// 검수량이 생산량보다 큰 경우
        	if (auditQuantity > productquantity) {
        		alert("검수량은 생산량보다 많을 수 없습니다!");
        		auditQuantityInput.value = auditquantity; // 검수량 입력 필드 초기화
        		auditQuantityInput.focus();    // 검수량 입력 필드에 포커스
        		return;
        	}else if(auditQuantity < auditquantity){
        		alert("검수량은 기존 검수량보다 적을 수 없습니다!");
        		auditQuantityInput.value = auditquantity; // 검수량 입력 필드 초기화
        		auditQuantityInput.focus();    // 검수량 입력 필드에 포커스 
        		return;
    		}
				const normalQuantity = auditQuantity - defectiveQuantity;
 				document.getElementById("normalquantity").value = normalQuantity;
    	});

    	// 불량 개수 입력 필드의 blur 이벤트 리스너 추가
    	defectiveQuantityInput.addEventListener("blur", function() {
    		const auditQuantity = parseInt(auditQuantityInput.value, 10);                  // 검수량
    		const defectiveQuantity = parseInt(defectiveQuantityInput.value, 10);          // 불량 개수

    		// 불량 개수가 검수량을 초과하는 경우
    		if (defectiveQuantity > auditQuantity) {
    			alert("불량 개수는 검수량을 초과할 수 없습니다!");
    			defectiveQuantityInput.value = defectquantity; // 불량 개수 입력 필드 초기화
    			defectiveQuantityInput.focus();    // 불량 개수 입력 필드에 포커스
    			return;
    		}else if(defectiveQuantity < defectquantity){
    			alert("불량 개수는 기존 불량 개수보다 적을 수 없습니다!");
    			defectiveQuantityInput.value = defectquantity; // 불량 개수 입력 필드 초기화
    			defectiveQuantityInput.focus();    // 불량 개수 입력 필드에 포커스
    			return;
    		}
    			const normalQuantity = auditQuantity - defectiveQuantity;
     			document.getElementById("normalquantity").value = normalQuantity;
    		
    	});
    });
});
</script>
<!-- 생산 검수 모달창 데이터 (포장 X) -->		

<!-- 반품 검수 모달창 -->
<div class="modal fade" id="returnAuditModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/quality/raudit" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel2">반품 검수</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      	<div class="row">
 			<div class="col">
           		<label for="qualityid2" class="col-form-label">품질관리ID:</label>
            	<input type="text" class="form-control" id="qualityid2" name="qualityid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="returnid2" class="col-form-label">반품ID:</label>
            	<input type="text" class="form-control" id="returnid2" name="returnid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="auditcode2" class="col-form-label">검수번호:</label>
            	<input type="text" class="form-control" id="auditcode2" name="auditcode" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="process2" class="col-form-label">상품구분:</label>
            	<input type="text" class="form-control" id="process2" name="process" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="productquantity2" class="col-form-label">반품량:</label>
            	<input type="number" class="form-control" id="productquantity2" name="productquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="auditquantity2" class="col-form-label">검수량:</label>
            	<input type="number" class="form-control" id="auditquantity2" name="auditquantity" value="" required>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="normalquantity2" class="col-form-label">정상 (자동 계산):</label>
            	<input type="number" class="form-control" id="normalquantity2" name="normalquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="defectquantity2" class="col-form-label">불량 입력:</label>
            	<input type="number" class="form-control" id="defectquantity2" name="defectquantity" value="" required>
  			</div>
		</div>
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">검수 저장</button>
      </div>
    </div>
   </form>
  </div>
</div>
<!-- 반품 검수 모달창 -->

<!-- 반품 검수 모달창 데이터 -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    let myModal = document.getElementById('returnAuditModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let qualityid = button.getAttribute('data-qualityid'); // qualityid
        let returnid = button.getAttribute('data-returnid'); // returnid
        let auditcode = button.getAttribute('data-auditcode'); // auditcode
        let itemtype = button.getAttribute('data-itemtype'); // itemtype
        let process = button.getAttribute('data-process'); // process
        let productquantity = button.getAttribute('data-productquantity'); // productquantity
        let auditquantity = button.getAttribute('data-auditquantity'); // auditquantity
        let defectquantity = button.getAttribute('data-defectquantity'); // defectquantity
        let normalquantity = button.getAttribute('data-normalquantity'); // normalquantity
        
        // 모달 내부의 입력 필드에 값을 설정
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityid;
        
        let rinputField = myModal.querySelector('input[name="returnid"]');
        rinputField.value = returnid;
        
        let ainputField = myModal.querySelector('input[name="auditcode"]');
        ainputField.value = auditcode;
        
        let proinputField = myModal.querySelector('input[name="process"]');
        proinputField.value = itemtype;
        
        let pqinputField = myModal.querySelector('input[name="productquantity"]');
        pqinputField.value = productquantity;
        
        let aqinputField = myModal.querySelector('input[name="auditquantity"]');
        aqinputField.value = auditquantity;
        
        let nqinputField = myModal.querySelector('input[name="normalquantity"]');
        nqinputField.value = normalquantity;
        
        let dqinputField = myModal.querySelector('input[name="defectquantity"]');
        dqinputField.value = defectquantity;
        
    	const productQuantityInput = document.getElementById("productquantity2");
    	const auditQuantityInput = document.getElementById("auditquantity2");
    	const defectiveQuantityInput = document.getElementById("defectquantity2");
        
    	// 검수량 입력 필드의 blur 이벤트 리스너 추가
    	auditQuantityInput.addEventListener("blur", function() {
    		const productQuantity = parseInt(productQuantityInput.value, 10); // 생산량
    		const auditQuantity = parseInt(auditQuantityInput.value, 10);     // 검수량
    		const defectiveQuantity = parseInt(defectiveQuantityInput.value, 10);          // 불량 개수
    		
        	// 검수량이 생산량보다 큰 경우
        	if (auditQuantity > productquantity) {
        		alert("검수량은 반품량보다 많을 수 없습니다!");
        		auditQuantityInput.value = auditquantity; // 검수량 입력 필드 초기화
        		auditQuantityInput.focus();    // 검수량 입력 필드에 포커스
        		return;
        	}else if(auditQuantity < auditquantity){
        		alert("검수량은 기존 검수량보다 적을 수 없습니다!");
        		auditQuantityInput.value = auditquantity; // 검수량 입력 필드 초기화
        		auditQuantityInput.focus();    // 검수량 입력 필드에 포커스 
        		return;
    		}
				const normalQuantity = auditQuantity - defectiveQuantity;
 				document.getElementById("normalquantity2").value = normalQuantity;
    	});

    	// 불량 개수 입력 필드의 blur 이벤트 리스너 추가
    	defectiveQuantityInput.addEventListener("blur", function() {
    		const auditQuantity = parseInt(auditQuantityInput.value, 10);                  // 검수량
    		const defectiveQuantity = parseInt(defectiveQuantityInput.value, 10);          // 불량 개수

    		// 불량 개수가 검수량을 초과하는 경우
    		if (defectiveQuantity > auditQuantity) {
    			alert("불량 개수는 검수량을 초과할 수 없습니다!");
    			defectiveQuantityInput.value = defectquantity; // 불량 개수 입력 필드 초기화
    			defectiveQuantityInput.focus();    // 불량 개수 입력 필드에 포커스
    			return;
    		}else if(defectiveQuantity < defectquantity){
    			alert("불량 개수는 기존 불량 개수보다 적을 수 없습니다!");
    			defectiveQuantityInput.value = defectquantity; // 불량 개수 입력 필드 초기화
    			defectiveQuantityInput.focus();    // 불량 개수 입력 필드에 포커스
    			return;
    		}
    			const normalQuantity = auditQuantity - defectiveQuantity;
     			document.getElementById("normalquantity2").value = normalQuantity;
    		
    	});
            
    });
});
</script>
<!-- 반품 검수 모달창 데이터 -->

<!-- 라디오 버튼 이동 -->
<script>
    function navigatePage(type) {
        if (type === '생산') {
            window.location.href = '/quality/plist';
        } else if (type === '자재') {
            window.location.href = '/quality/pmlist';
        }
    }
</script>
<!-- 라디오 버튼 이동 -->

<%@ include file="../include/footer.jsp" %>