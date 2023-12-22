<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
	<h1>plist (생산 / 반품 품질 관리)</h1>
	
	<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
			<h6 class="mb-4">Responsive Table</h6>
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
											<c:if test="${clist.produceid == 0 && clist.returnid != 0}"> <!-- 반품ID 존재 -->
												<input type="button" value="반품검수" onclick="location.href='/quality/raudit?returnid=${clist.returnid}';">				
											</c:if>
											<c:if test="${clist.produceid == 0 && clist.returnid == 0 }"> <!-- 생산ID, 반품ID 둘 다 미존재 = 자재 -->
												<input type="button" value="자재검수" onclick="location.href='/quality/iaudit?itemid=${clist.itemid}';">								
											</c:if>
										</c:if>
										<c:if test="${!empty clist.auditstatus && clist.auditstatus.equals('검수완료') && clist.defectquantity == 0 }"> <!-- 불량 X -->
											<c:if test="${!empty clist.process && !clist.process.equals('포장')}"> <!-- 생산 - 포장이 아닌 경우 -->
												<input type="button" value="정상"> <!-- 생산 상태 업데이트 -->
											</c:if>	
											<c:if test="${!empty clist.process && clist.process.equals('포장')}"> <!-- 생산 - 포장인 경우 -->
												<form action="/stock/new" method="POST"> <!-- 재고로 --> <!-- 생산 상태 업데이트 -->
													<input type="hidden" value="${clist.qualityid }" name="qualityid">
													<input type="hidden" value="${clist.itemid }" name="itemid">
													<input type="hidden" value="${clist.productquantity - clist.defectquantity }" name="stockquantity">
													<input type="submit" value="정상">
												</form>
											</c:if>
											<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품')}"> <!-- 반품인 경우 -->
												<input type="button" value="정상"> <!-- 재고로 --> <!-- 생산 상태 업데이트 -->
											</c:if>	
										</c:if>
										<c:if test="${!empty clist.auditstatus && clist.auditstatus.equals('검수완료') && clist.defectquantity != 0 }"> <!-- 불량 O -->
											<c:if test="${clist.normalquantity != 0 }"> <!-- 불량도 있고 정상도 있는 경우 -->
												<c:if test="${!empty clist.process && !clist.process.equals('포장')}"> <!-- 포장이 아닌 경우 -->
													<!-- <input type="button" value="정상"> --> <!-- 생산 상태 업데이트 [포장이 아닌 경우는 불량이 조금이라도 발생 시 전체 불량 처리] -->
													<input type="button" value="불량" class="pdefects" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'"> <!-- 생산 상태 업데이트 -->
												</c:if>	
												<c:if test="${!empty clist.process && clist.process.equals('포장')}"> <!-- 포장인 경우 -->
												<form action="/stock/new" method="POST"> <!-- 재고로 --> <!-- 생산 상태 업데이트 -->
													<input type="hidden" value="${clist.qualityid }" name="qualityid">
													<input type="hidden" value="${clist.itemid }" name="itemid">
													<input type="hidden" value="${clist.productquantity - clist.defectquantity }" name="stockquantity">
													<input type="submit" value="정상">
													<input type="button" value="불량" class="pdefects" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'"> <!-- 생산 상태 업데이트 -->
												</form>
												</c:if>	
												<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품')}"> <!-- 반품인 경우 -->
													<input type="button" value="정상"> <!-- 재고로 -->
													<input type="button" value="불량" class="pdefects" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'">
												</c:if>	
											</c:if>
											<c:if test="${clist.normalquantity == 0 }"> <!-- 불량은 있지만 정상은 없는 경우 -->
												<c:if test="${!empty clist.process && !clist.process.equals('포장')}"> <!-- 포장이 아닌 경우 -->
													<input type="button" value="불량" class="pdefects" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'">
												</c:if>	
												<c:if test="${!empty clist.process && clist.process.equals('포장')}"> <!-- 포장인 경우 -->
													<input type="button" value="불량" class="pdefects" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'">
												</c:if>	
												<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품')}"> <!-- 반품인 경우 -->
													<input type="button" value="불량" class="pdefects" onclick="location.href='/quality/pdefects?qualityid=${clist.qualityid}'">
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
	
<!-- 모달창1 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/stock/updateStockQuantity" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">생산 검수</h1>
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
            	<input type="number" class="form-control" id="number" name="number" value="" required>
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
<!-- 모달창1 -->

<!-- 모달 1 출력 -->
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
        
    });
});
</script>
<!-- 모달 1 출력 -->	
	

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

<%@ include file="../include/footer.jsp" %>