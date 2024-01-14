<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<!-- SweetAlert 추가 -->
<script src="
https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js
"></script>
<!-- SweetAlert 추가 -->

		<div class="col-12">
		<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
			<h2>자재 품질 관리</h2>
			<div class="form-check form-check-inline">
  				<input class="form-check-input" type="radio" name="type" id="productRadio" value="생산">
  				<label class="form-check-label" for="product">생산</label>
			</div>
			<div class="form-check form-check-inline">
  				<input class="form-check-input" type="radio" name="type" id="materialRadio" value="자재" checked>
  				<label class="form-check-label" for="material">자재</label>
			</div><br>
			
			<div class="buttonarea1" style="margin-bottom: 10px;">
				<input type="button" class="btn btn-sm btn-primary" value="원자재" id="rawmaterial">
				<input type="button" class="btn btn-sm btn-danger" value="부자재" id="submaterial">
				<input type="button" class="btn btn-sm btn-success" value="전체" id="allmaterial">
			</div>
			
			<div class="buttonarea3" style="margin-bottom: 10px;">
			<form action="/quality/materialQualityList" method="GET" style="margin-bottom: 10px;">
				<c:if test="${!empty param.searchBtn }">
				<input type="hidden" name="searchBtn" value="${param.searchBtn}">
				</c:if>
				<input type="date" id="startDate" name="startDate" required> ~
				<input type="date" id="endDate" name="endDate" required>
				<input type="submit" value="조회">
			</form>	
			</div>
				<form action="/materialQualityPrint" method="GET">
					<c:if test="${!empty param.searchBtn }">
						<input type="hidden" name="searchBtn" value="${param.searchBtn}">
					</c:if>
					<c:if test="${!empty param.startDate }">
						<input type="hidden" value="${param.startDate }" name="startDate">
					</c:if>
					<c:if test="${!empty param.endDate }">
						<input type="hidden" value="${param.endDate }" name="endDate">
					</c:if>
					<input type="submit" value="엑셀 파일 다운로드" class="btn btn-sm btn-success">
				</form>
			<br>		
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">검수번호</th>
								<th scope="col">상품구분</th>
								<th scope="col">입고번호</th>
								<th scope="col">품목코드</th>
								<th scope="col">제품명</th>
								<th scope="col">검수자</th>
								<th scope="col">입고량</th>
								<th scope="col">검수량</th>
								<th scope="col">정상수량</th>
								<th scope="col">불량수량</th>
								<th scope="col">검수상태</th>
								<th scope="col">등록일</th>
								<th scope="col">검수완료일자</th>
								<th scope="col">확인</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="mlist" items="${list }" varStatus="loop">
								<tr>
									<th>${mlist.qualityid }</th>
									<td>${mlist.auditcode }</td>
									<td>${mlist.itemtype }</td>	
									<td>${mlist.receiveid }</td>
									<td>${mlist.itemcode }</td>
									<td>${mlist.itemname }</td>
									<c:if test="${mlist.auditbycode != 0 }">
									<td>${mlist.auditbycode }</td>
									</c:if>
									<c:if test="${mlist.auditbycode == 0 }">
									<td></td>
									</c:if>
									<td>${mlist.productquantity }(개)</td>
									<td>${mlist.auditquantity }(개)</td>
									<td>${mlist.normalquantity }(개)</td>
									<td>
									<c:if test="${mlist.defectquantity == 0}">
										${mlist.defectquantity }(개)
									</c:if>
									<c:if test="${mlist.defectquantity != 0}">
										<b style="color: red;">${mlist.defectquantity }</b>(개)
									</c:if>
									</td>
									<td>
									<c:if test="${!empty mlist.auditstatus && mlist.auditstatus.equals('검수완료') && mlist.defectquantity == 0}">
										<b style="color: brown;">${mlist.auditstatus }</b>
									</c:if>
									<c:if test="${!empty mlist.auditstatus && mlist.auditstatus.equals('검수완료') && mlist.defectquantity != 0}">
										<b style="color: red;">${mlist.auditstatus }</b>
									</c:if>									
									<c:if test="${!empty mlist.auditstatus && mlist.auditstatus.equals('검수중')}">
										<b style="color: black;">${mlist.auditstatus }</b>
									</c:if>
									<c:if test="${!empty mlist.auditstatus && mlist.auditstatus.equals('대기')}">
										${mlist.auditstatus }
									</c:if>									
									</td>
									<td>${mlist.registerationdate }</td>
									<td>${mlist.completedate }</td>
									<td>
									<c:if test="${(sessionScope.departmentname == '품질' && sessionScope.memberposition == '팀장') || sessionScope.membername.equals('admin') }">
										<c:if test="${mlist.auditstatus.equals('대기') || mlist.auditstatus.equals('검수중') }">
											<button type="button" class="btn btn-primary btn-sm" 
												data-bs-toggle="modal" data-bs-target="#materialAuditModal"
												data-receiveid="${mlist.receiveid }" data-qualityid="${mlist.qualityid}" data-itemtype="${mlist.itemtype }" 
												data-auditcode="${mlist.auditcode }" 
												data-itemid="${mlist.itemid }" data-itemcode="${mlist.itemcode }" 
												data-itemname="${mlist.itemname }" data-auditbycode="${mlist.auditbycode }" 
												data-productquantity="${mlist.productquantity }" data-auditquantity="${mlist.auditquantity }" 
												data-normalquantity="${mlist.normalquantity }" data-defectquantity="${mlist.defectquantity }" 
												data-page="${param.page }">
 												자재검수
											</button>
										</c:if>
										<c:if test="${!empty mlist.auditstatus && mlist.auditstatus.equals('검수완료') && mlist.defectquantity == 0 && !empty mlist.registerstock && mlist.registerstock.equals('N') }"> <!-- 불량 X -->
											<form action="/material/newMaterialStock" method="POST"> <!-- 재고로 (자재) -->
												<input type="hidden" value="${mlist.qualityid }" name="qualityid">
												<input type="hidden" value="${mlist.itemid }" name="itemid">
												<input type="hidden" value="${mlist.receiveid }" name="receiveid">
												<input type="hidden" value="${mlist.storageid }" name="storageid">
												<input type="hidden" value="${mlist.normalquantity }" name="stockquantity">
												<input type="submit" class="btn btn-success btn-sm" value="정상">
											</form>
										</c:if>
										<c:if test="${!empty mlist.auditstatus && mlist.auditstatus.equals('검수완료') && mlist.defectquantity != 0 }"> <!-- 불량 O -->
											<c:if test="${mlist.normalquantity != 0 }"> <!-- 불량도 있고 정상도 있는 경우 -->
												<form action="/material/newMaterialStock" method="POST"> <!-- 재고로 (자재) -->
													<input type="hidden" value="${mlist.qualityid }" name="qualityid">
													<input type="hidden" value="${mlist.itemid }" name="itemid">
													<input type="hidden" value="${mlist.receiveid }" name="receiveid">
													<input type="hidden" value="${mlist.storageid }" name="storageid">
													<input type="hidden" value="${mlist.normalquantity }" name="stockquantity">
													<c:if test="${!empty mlist.registerstock && mlist.registerstock.equals('N') }">
													<input type="submit" value="정상" class="btn btn-success btn-sm" >
													</c:if>
													<c:if test="${!empty mlist.registerdefect && mlist.registerdefect.equals('N') }">
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newMaterialDefectModal"
													data-receiveid="${mlist.receiveid }" data-qualityid="${mlist.qualityid}" data-itemtype="${mlist.itemtype }" 
													data-auditcode="${mlist.auditcode }" 
													data-itemid="${mlist.itemid }" data-itemcode="${mlist.itemcode }" 
													data-itemname="${mlist.itemname }" data-auditbycode="${mlist.auditbycode }" 
													data-defectquantity="${mlist.defectquantity }">
 													불량
													</button>
													</c:if>
												</form>
											</c:if>
											<c:if test="${mlist.normalquantity == 0 }"> <!-- 불량은 있지만 정상은 없는 경우 -->
												<c:if test="${!empty clist.registerdefect && mlist.registerdefect.equals('N')}"> <!-- 포장이 아닌 경우 -->
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newMaterialDefectModal"
													data-receiveid="${mlist.receiveid }" data-qualityid="${mlist.qualityid}" data-itemtype="${mlist.itemtype }" 
													data-auditcode="${mlist.auditcode }"
													data-itemid="${mlist.itemid }" data-itemcode="${mlist.itemcode }" 
													data-itemname="${mlist.itemname }" data-auditbycode="${mlist.auditbycode }" 
													data-defectquantity="${mlist.defectquantity }">
 													불량
													</button>												
												</c:if>		
											</c:if>
										</c:if>
										</c:if>
									</td>
								</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<!-- 페이지 블럭 생성 -->
			<nav aria-label="Page navigation example">
  				<ul class="pagination justify-content-center">
    				<li class="page-item">
    					<c:if test="${pageVO.prev }">
      					<a class="page-link pageBlockPrev" href="" aria-label="Previous" data-page="${pageVO.startPage - 1}">
        					<span aria-hidden="true">&laquo;</span>
      					</a>
        					
        				<!-- 페이지 블럭 Ajax 동적 이동 - prev (1) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockPrev').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거
   						            var prevPage = $(this).data('page');
   									
   									var searchBtn = "${param.searchBtn}";
   									var startDate = "${param.startDate}";
   									var endDate = "${param.endDate}";

   									var dataObject = {
   										"page" : prevPage	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (startDate) {
   									    dataObject.startDate = startDate;
   									}
   									if (endDate) {
   									    dataObject.endDate = endDate;
   									}
   									
   									console.log("Page Block clicked!", prevPage);
   									
        						$.ajax({
       								url: "/quality/materialQualityList",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#qualityListContainer").html(data);
            						},
           						 	error: function(error) {
                						console.error("Error fetching data:", error);
            						}
        							});
    							});
							});
						</script>
						<!-- 페이지 블럭 Ajax 동적 이동 - prev (1) -->
    					</c:if>
    				</li>
					<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1" var="i">
    				<li class="page-item ${pageVO.cri.page == i? 'active' : ''}"><a class="page-link pageBlockNum" href="" data-page="${i}">${i }</a></li>
    					
    					<!-- 페이지 블럭 Ajax 동적 이동 - num (2) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockNum').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거

   						            var pageNum = $(this).data('page');
   									
   									var searchBtn = "${param.searchBtn}";
   									var startDate = "${param.startDate}";
   									var endDate = "${param.endDate}";

   									var dataObject = {
   										"page" : pageNum	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (startDate) {
   									    dataObject.startDate = startDate;
   									}
   									if (endDate) {
   									    dataObject.endDate = endDate;
   									}
   									
   									console.log("Page Block clicked!");
   									
        						$.ajax({
       								url: "/quality/materialQualityList",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#qualityListContainer").html(data);
            						},
           						 	error: function(error) {
                						console.error("Error fetching data:", error);
            						}
        							});
    							});
							});
						</script>
						<!-- 페이지 블럭 Ajax 동적 이동 - num (2) -->

					</c:forEach>
    				<li class="page-item">
    					<c:if test="${pageVO.next }">
      					<a class="page-link pageBlockNext" href="" aria-label="Next" data-page="${pageVO.endPage + 1}">
        				<span aria-hidden="true">&raquo;</span>
      					</a>
      					
    					<!-- 페이지 블럭 Ajax 동적 이동 - next (3) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockNext').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거
   						            var nextPage = $(this).data('page');
   									
   									var searchBtn = "${param.searchBtn}";
   									var startDate = "${param.startDate}";
   									var endDate = "${param.endDate}";

   									var dataObject = {
   										"page" : nextPage	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (startDate) {
   									    dataObject.startDate = startDate;
   									}
   									if (endDate) {
   									    dataObject.endDate = endDate;
   									}
   									
   									console.log("Page Block clicked!", nextPage);
   									
        						$.ajax({
       								url: "/quality/materialQualityList",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#qualityListContainer").html(data);
            						},
           						 	error: function(error) {
                						console.error("Error fetching data:", error);
            						}
        							});
    							});
							});
						</script>
						<!-- 페이지 블럭 Ajax 동적 이동 - next (3) -->      					
    					</c:if>
    				</li>
  				</ul>
			</nav>
			<!-- 페이지 블럭 생성 -->
			
		</div>
	</div>	
	
<!-- 자재 검수 모달창 -->
<div class="modal fade" id="materialAuditModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/quality/materialAudit" method="POST">
  
      <c:if test="${empty param.page }">
      	<input type="hidden" name="page" value="1">
      </c:if>
      <c:if test="${!empty param.page }">
      	<input type="hidden" name="page" value="${param.page }">
      </c:if>
      <c:if test="${!empty param.searchBtn }">
      	<input type="hidden" name="searchBtn" value="${param.searchBtn }">
      </c:if>
	  <c:if test="${!empty param.startDate }">
		<input type="hidden" value="${param.startDate }" name="startDate">
	  </c:if>
	  <c:if test="${!empty param.endDate }">
	  	<input type="hidden" value="${param.endDate }" name="endDate">
	  </c:if>

    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">자재 검수</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div class="row">
 			<div class="col">
           		<label for="qualityid" class="col-form-label">품질관리번호:</label>
            	<input type="text" class="form-control" id="qualityid" name="qualityid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="receiveid" class="col-form-label">입고번호:</label>
            	<input type="text" class="form-control" id="receiveid" name="receiveid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="auditcode" class="col-form-label">검수번호:</label>
            	<input type="text" class="form-control" id="auditcode" name="auditcode" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="itemtype" class="col-form-label">상품구분:</label>
            	<input type="text" class="form-control" id="itemtype" name="itemtype" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="itemcode" class="col-form-label">품목코드:</label>
            	<input type="text" class="form-control" id="itemcode" name="itemcode" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="itemname" class="col-form-label">제품명:</label>
            	<input type="text" class="form-control" id="itemname" name="itemname" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="productquantity" class="col-form-label">입고량 (개):</label>
            	<input type="number" class="form-control" id="productquantity" name="productquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="auditquantity" class="col-form-label">검수량 (개):</label>
            	<input type="number" class="form-control" id="auditquantity" name="auditquantity" value="" required>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="normalquantity" class="col-form-label">정상 (개 / 자동 계산):</label>
            	<input type="number" class="form-control" id="normalquantity" name="normalquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="defectquantity" class="col-form-label">불량 입력 (개):</label>
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
<!-- 자재 검수 모달창 -->

<!-- 자재 검수 모달창 데이터 -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('materialAuditModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let qualityid = button.getAttribute('data-qualityid'); // qualityid
        let receiveid = button.getAttribute('data-receiveid'); // receiveid
        let auditcode = button.getAttribute('data-auditcode'); // auditcode
        let itemtype = button.getAttribute('data-itemtype'); // itemtype
        let itemcode = button.getAttribute('data-itemcode'); // itemcode
        let itemname = button.getAttribute('data-itemname'); // itemname
        let productquantity = button.getAttribute('data-productquantity'); // productquantity
        let auditquantity = button.getAttribute('data-auditquantity'); // auditquantity
        let defectquantity = button.getAttribute('data-defectquantity'); // defectquantity
        let normalquantity = button.getAttribute('data-normalquantity'); // normalquantity
        
        // 모달 내부의 입력 필드에 값을 설정
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityid;
        
        let riinputField = myModal.querySelector('input[name="receiveid"]');
        riinputField.value = receiveid;
        
        let ainputField = myModal.querySelector('input[name="auditcode"]');
        ainputField.value = auditcode;
        
        let icinputField = myModal.querySelector('input[name="itemcode"]');
        icinputField.value = itemcode;
        
        let ininputField = myModal.querySelector('input[name="itemname"]');
        ininputField.value = itemname;
        
        let itinputField = myModal.querySelector('input[name="itemtype"]');
        itinputField.value = itemtype;
        
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
        		Swal.fire("검수량은 입고량보다 많을 수 없습니다!");
        		auditQuantityInput.value = auditquantity; // 검수량 입력 필드 초기화
        		auditQuantityInput.focus();    // 검수량 입력 필드에 포커스
        		return;
        	}else if(auditQuantity < auditquantity){
        		Swal.fire("검수량은 기존 검수량보다 적을 수 없습니다!");
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
    			Swal.fire("불량 개수는 검수량을 초과할 수 없습니다!");
    			defectiveQuantityInput.value = defectquantity; // 불량 개수 입력 필드 초기화
    			defectiveQuantityInput.focus();    // 불량 개수 입력 필드에 포커스
    			return;
    		}else if(defectiveQuantity < defectquantity){
    			Swal.fire("불량 개수는 기존 불량 개수보다 적을 수 없습니다!");
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
<!-- 자재 검수 모달창 데이터 -->

<!-- 불량 입력 모달창 (자재) -->
<div class="modal fade" id="newMaterialDefectModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/quality/materialNewDefect" method="POST">
  
      <c:if test="${empty param.page }">
      	<input type="hidden" name="page" value="1">
      </c:if>
      <c:if test="${!empty param.page }">
      	<input type="hidden" name="page" value="${param.page }">
      </c:if>
      <c:if test="${!empty param.searchBtn }">
      	<input type="hidden" name="searchBtn" value="${param.searchBtn }">
      </c:if>
	  <c:if test="${!empty param.startDate }">
		<input type="hidden" value="${param.startDate }" name="startDate">
	  </c:if>
	  <c:if test="${!empty param.endDate }">
	  	<input type="hidden" value="${param.endDate }" name="endDate">
	  </c:if>
  
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel2">불량 등록 (생산)</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<input type="hidden" name="qualityid" value="" readonly>
      	<input type="hidden" name="itemid" value="" readonly>
      	<div class="row">
 			<div class="col">
           		<label for="auditcode" class="col-form-label">검수번호:</label>
            	<input type="text" class="form-control" id="auditcode" name="auditcode" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="defectitemtype" class="col-form-label">상품구분:</label>
            	<input type="text" class="form-control" id="defectitemtype" name="itemtype" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="defectitemcode" class="col-form-label">상품코드:</label>
            	<input type="text" class="form-control" id="defectitemcode" name="itemcode" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="defectitemname" class="col-form-label">상품명:</label>
            	<input type="text" class="form-control" id="defectitemname" name="itemname" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="productdefectquantity" class="col-form-label">불량:</label>
            	<input type="number" class="form-control" id="productdefectquantity" name="defectquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="productprocessmethod" class="col-form-label">처리방식:</label>
				<select class="form-select" aria-label="Small select example" id="productprocessmethod" name="processmethod">
  					<option value="반품" selected>반품</option>
				</select>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="productdefecttype" class="col-form-label">불량사유:</label>
            	<input type="text" class="form-control" id="productdefecttype" name="defecttype" value="" required>
  			</div>
  		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">불량 저장</button>
      </div>
    </div>
   </form>
  </div>
</div>
<!-- 불량 입력 모달창 (자재) -->

<!-- 불량 입력 모달창 데이터 (자재) -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('newMaterialDefectModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let qualityid = button.getAttribute('data-qualityid'); // qualityid
        let receiveid = button.getAttribute('data-receiveid'); // receiveid
        let auditcode = button.getAttribute('data-auditcode'); // auditcode
        let itemid = button.getAttribute('data-itemid'); // itemid
        let itemtype = button.getAttribute('data-itemtype'); // itemtype
        let itemcode = button.getAttribute('data-itemcode'); // itemcode
        let itemname = button.getAttribute('data-itemname'); // itemname
        let defectquantity = button.getAttribute('data-defectquantity'); // defectquantity
        
        // 모달 내부의 입력 필드에 값을 설정
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityid;
        
        let ainputField = myModal.querySelector('input[name="auditcode"]');
        ainputField.value = auditcode;
        
        let idinputField = myModal.querySelector('input[name="itemid"]');
        idinputField.value = itemid;
        
        let iinputField = myModal.querySelector('input[name="itemtype"]');
        iinputField.value = itemtype;
        
        let icinputField = myModal.querySelector('input[name="itemcode"]');
        icinputField.value = itemcode;
        
        let ininputField = myModal.querySelector('input[name="itemname"]');
        ininputField.value = itemname;

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
        		Swal.fire("검수량은 반품량보다 많을 수 없습니다!");
        		auditQuantityInput.value = auditquantity; // 검수량 입력 필드 초기화
        		auditQuantityInput.focus();    // 검수량 입력 필드에 포커스
        		return;
        	}else if(auditQuantity < auditquantity){
        		Swal.fire("검수량은 기존 검수량보다 적을 수 없습니다!");
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
    			Swal.fire("불량 개수는 검수량을 초과할 수 없습니다!");
    			defectiveQuantityInput.value = defectquantity; // 불량 개수 입력 필드 초기화
    			defectiveQuantityInput.focus();    // 불량 개수 입력 필드에 포커스
    			return;
    		}else if(defectiveQuantity < defectquantity){
    			Swal.fire("불량 개수는 기존 불량 개수보다 적을 수 없습니다!");
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
<!-- 불량 입력 모달창 데이터 (자재) -->

<!-- 라디오 버튼 이동 -->
<script>
$(document).ready(function(){
    $('#materialRadio').click(function(){ // 자재를 눌렀을 때
        console.log("Material radio clicked!");
		location.href="/quality/qualitiesMaterial";
    });
    
    $('#productRadio').click(function(){ // 생산을 눌렀을 때
        console.log("Product radio clicked!");
		location.href="/quality/qualities";
    });
});
</script>
<!-- 라디오 버튼 이동 -->

<!-- 페이지 Ajax 동적 이동 (1) -->
<script>
$(document).ready(function() {
    // 원자재 버튼 클릭
    $("#rawmaterial").click(function() {
        fetchData("원자재");
    });

    // 부자재 버튼 클릭
    $("#submaterial").click(function() {
        fetchData("부자재");
    });

    // 전체 버튼 클릭
    $("#allmaterial").click(function() {
        $.ajax({
            url: "/quality/materialQualityList",
            type: "GET",
            success: function(data) {
                // 성공적으로 데이터를 받아왔을 때 처리할 코드
                $("#qualityListContainer").html(data);
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
});

function fetchData(searchBtnValue) {
    $.ajax({
        url: "/quality/materialQualityList",
        type: "GET",
        data: {
        	searchBtn: searchBtnValue
        },
        success: function(data) {
            // 성공적으로 데이터를 받아왔을 때 처리할 코드
            $("#qualityListContainer").html(data);
        },
        error: function(error) {
            console.error("Error fetching data:", error);
        }
    });
}
</script>
<!-- 페이지 Ajax 동적 이동 (1) -->

<!-- 페이지 Ajax 동적 이동 (2) -->
<script>
$(document).ready(function() {
    // 폼의 submit 이벤트 감지
    $("form[action='/quality/materialQualityList']").submit(function(event) {
        event.preventDefault(); // 기본 폼 제출 동작 방지

        // 폼 데이터 수집
        let formData = {
            startDate: $("input[name='startDate']").val(),
            endDate: $("input[name='endDate']").val()
        };

        // 선택된 검색 버튼 값이 있으면 추가
        if ($("input[name='searchBtn']").length > 0) {
            formData.searchBtn = $("input[name='searchBtn']").val();
        }

        // AJAX 요청 수행
        $.ajax({
            url: "/quality/materialQualityList",
            type: "GET",
            data: formData,
            success: function(data) {
                // 성공적으로 데이터를 받아왔을 때 처리할 코드
                $("#qualityListContainer").html(data); // 결과를 화면에 표시
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
});
</script>
<!-- 페이지 Ajax 동적 이동 (2) -->

<!-- 날짜 비교 -->
<script>
$(document).ready(function(){
    const checkDates = function() {
        const startDateStr = document.getElementById("startDate").value;
        const endDateStr = document.getElementById("endDate").value;

        // 둘 다 유효한 날짜 문자열인지 확인
        if (startDateStr && endDateStr) {
            const startDate = new Date(startDateStr);
            const endDate = new Date(endDateStr);

            if (startDate > endDate) {
                Swal.fire("종료일은 시작일과 같거나 이후여야 합니다.");
                document.getElementById("endDate").value = "";
            }   
        }
    };

    // 페이지 로드 시 한 번 실행
    checkDates();

    // 날짜 입력 값에서 포커스가 빠져나갈 때 실행
    $("#startDate, #endDate").on("blur", checkDates);
});
</script>
<!-- 날짜 비교 -->