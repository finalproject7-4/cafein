<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<br>
		<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
			<h2>자재 품질 관리</h2>
			<div class="form-check form-check-inline">
  				<input class="form-check-input" type="radio" name="type" id="productRadio" value="생산">
  				<label class="form-check-label" for="product">생산</label>
			</div>
			<div class="form-check form-check-inline">
  				<input class="form-check-input" type="radio" name="type" id="materialRadio" value="자재" checked>
  				<label class="form-check-label" for="material">자재</label>
			</div><br>
			<input type="button" class="btn btn-sm btn-primary" value="원자재" id="rawmaterial">
			<input type="button" class="btn btn-sm btn-danger" value="부자재" id="submaterial">
			<input type="button" class="btn btn-sm btn-success" value="전체" id="allmaterial">
			
			<form action="/quality/productQualityList" method="GET">
				<c:if test="${!empty param.searchBtn }">
				<input type="hidden" name="searchBtn" value="${param.searchBtn}">
				</c:if>
				<input type="date" name="startDate" required> ~
				<input type="date" name="endDate" required>
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
									<td>
									<c:if test="${!empty clist.process && clist.process.equals('포장') }">
									${clist.itemname } (${clist.weight }g)
									</c:if>
									<c:if test="${!empty clist.process && !clist.process.equals('포장') }">
									${clist.itemname }
									</c:if>
									<c:if test="${!empty clist.itemtype && clist.itemtype == '반품' }">
									${clist.itemname }
									</c:if>
									</td>
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
										<c:if test="${(!empty clist.itemtype && clist.itemtype == '반품') || (!empty clist.process && clist.process == '포장')}">${clist.normalquantity }(개)</c:if>
										<c:if test="${!empty clist.process && !clist.process.equals('포장') }">${clist.normalquantity }(g)</c:if>
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
												<c:if test="${!empty clist.process && clist.process.equals('포장')}"> <!-- 포장 O -->
<%-- 											<input type="button" value="생산검수" onclick="location.href='/quality/productAudit?produceid=${clist.produceid}';"> --%>
												<button type="button" class="btn btn-primary btn-sm" 
												data-bs-toggle="modal" data-bs-target="#exampleModal"
												data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
												data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
												data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
												data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" data-weight="${clist.weight }" 
												data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
												data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 												생산검수
												</button>
												</c:if>
												<c:if test="${!empty clist.process && !clist.process.equals('포장') }"> <!-- 포장 X -->
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
<%-- 											<input type="button" value="반품검수" onclick="location.href='/quality/returnAudit?returnid=${clist.returnid}';">				 --%>
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
											<c:if test="${!empty clist.process && !clist.process.equals('포장') && !empty clist.registerstock && clist.registerstock.equals('N')}"> <!-- 생산 - 포장이 아닌 경우 -->
												<input type="button" class="btn btn-success btn-sm" value="정상"> <!-- 생산 상태 업데이트 -->
											</c:if>	
											<c:if test="${!empty clist.process && clist.process.equals('포장') && !empty clist.registerstock && clist.registerstock.equals('N')}"> <!-- 생산 - 포장인 경우 -->
												<form action="/stock/newStock" method="POST"> <!-- 재고로 --> <!-- 생산 상태 업데이트 -->
													<input type="hidden" value="${clist.qualityid }" name="qualityid">
													<input type="hidden" value="${clist.itemid }" name="itemid">
													<input type="hidden" value="${clist.produceid }" name="produceid">
													<input type="hidden" value="${clist.normalquantity }" name="stockquantity">
													<input type="submit" class="btn btn-success btn-sm" value="정상">
												</form>
											</c:if>
											<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품') && !empty clist.registerstock && clist.registerstock.equals('N')}"> <!-- 반품인 경우 -->
												<input type="button" class="btn btn-success btn-sm" value="정상"> <!-- 재고로 --> <!-- 생산 상태 업데이트 -->
											</c:if>	
										</c:if>
										<c:if test="${!empty clist.auditstatus && clist.auditstatus.equals('검수완료') && clist.defectquantity != 0 }"> <!-- 불량 O -->
											<c:if test="${clist.normalquantity != 0 }"> <!-- 불량도 있고 정상도 있는 경우 (포장이 아닌 경우라면 전체 불량 처리) -->
												<c:if test="${!empty clist.process && !clist.process.equals('포장') && !empty clist.registerdefect && clist.registerdefect.equals('N')}"> <!-- 포장이 아닌 경우 -->
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newProductDefectModal"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-defectquantity="${clist.defectquantity }">
 													불량
													</button>
												</c:if>	
												<c:if test="${!empty clist.process && clist.process.equals('포장')}"> <!-- 포장인 경우 -->
												<form action="/stock/newStock" method="POST"> <!-- 재고로 --> <!-- 생산 상태 업데이트 -->
													<input type="hidden" value="${clist.qualityid }" name="qualityid">
													<input type="hidden" value="${clist.itemid }" name="itemid">
													<input type="hidden" value="${clist.produceid }" name="produceid">
													<input type="hidden" value="${clist.normalquantity }" name="stockquantity">
													<c:if test="${!empty clist.registerstock && clist.registerstock.equals('N') }">
													<input type="submit" value="정상" class="btn btn-success btn-sm" >
													</c:if>
													<c:if test="${!empty clist.registerdefect && clist.registerdefect.equals('N') }">
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newProductDefectModal"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-defectquantity="${clist.defectquantity }">
 													불량
													</button>
													</c:if>
												</form>
												</c:if>	
												<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품')}"> <!-- 반품인 경우 -->
													<c:if test="${!empty clist.registerstock && clist.registerstock.equals('N') }">
													<input type="button" class="btn btn-success btn-sm" value="정상"> <!-- 재고로 -->
													</c:if>
													<c:if test="${!empty clist.registerdefect && clist.registerdefect.equals('N') }">
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newReturnDefectModal"
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
											<c:if test="${clist.normalquantity == 0 }"> <!-- 불량은 있지만 정상은 없는 경우 -->
												<c:if test="${!empty clist.process && !clist.process.equals('포장') && !empty clist.registerdefect && clist.registerdefect.equals('N')}"> <!-- 포장이 아닌 경우 -->
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newProductDefectModal"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-defectquantity="${clist.defectquantity }">
 													불량
													</button>												
												</c:if>	
												<c:if test="${!empty clist.process && clist.process.equals('포장') && !empty clist.registerdefect && clist.registerdefect.equals('N')}"> <!-- 포장인 경우 -->
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newProductDefectModal"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-process="${clist.process }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-defectquantity="${clist.defectquantity }">
 													불량
													</button>													
												</c:if>	
												<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품') && !empty clist.registerdefect && clist.registerdefect.equals('N')}"> <!-- 반품인 경우 -->
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newReturnDefectModal"
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
       								url: "/quality/productQualityList",
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
       								url: "/quality/productQualityList",
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
       								url: "/quality/productQualityList",
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
	
<!-- 생산 검수 모달창 (포장) -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/quality/productAudit" method="POST">
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
           		<label for="productquantity" class="col-form-label">생산량 (개):</label>
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
<!-- 생산 검수 모달창 (포장) -->

<!-- 생산 검수 모달창 데이터 (포장) -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('exampleModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let qualityid = button.getAttribute('data-qualityid'); // qualityid
        let produceid = button.getAttribute('data-produceid'); // produceid
        let auditcode = button.getAttribute('data-auditcode'); // auditcode
        let itemtype = button.getAttribute('data-itemtype'); // itemtype
        let process = button.getAttribute('data-process'); // process
        let itemcode = button.getAttribute('data-itemcode'); // itemcode
        let itemname = button.getAttribute('data-itemname'); // itemname
        let weight = button.getAttribute('data-weight'); // weight
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
        
        let icinputField = myModal.querySelector('input[name="itemcode"]');
        icinputField.value = itemcode;
        
        let ininputField = myModal.querySelector('input[name="itemname"]');
        ininputField.value = itemname + " (" + weight + "g)";
        
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

<!-- 불량 입력 모달창 (생산) -->
<div class="modal fade" id="newProductDefectModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/quality//productReturnNewDefect" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel2">불량 등록 (생산)</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<input type="hidden" name="qualityid" value="" readonly>
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
  					<option value="폐기" selected>폐기</option>
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
<!-- 불량 입력 모달창 (생산) -->

<!-- 불량 입력 모달창 데이터 (생산) -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('newProductDefectModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let qualityid = button.getAttribute('data-qualityid'); // qualityid
        let produceid = button.getAttribute('data-produceid'); // produceid
        let auditcode = button.getAttribute('data-auditcode'); // auditcode
        let itemtype = button.getAttribute('data-itemtype'); // itemtype
        let process = button.getAttribute('data-process'); // process
        let itemcode = button.getAttribute('data-itemcode'); // itemcode
        let itemname = button.getAttribute('data-itemname'); // itemname
        let defectquantity = button.getAttribute('data-defectquantity'); // defectquantity
        
        // 모달 내부의 입력 필드에 값을 설정
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityid;
        
        let ainputField = myModal.querySelector('input[name="auditcode"]');
        ainputField.value = auditcode;
        
        let iinputField = myModal.querySelector('input[name="itemtype"]');
        iinputField.value = itemtype + " - " + process;
        
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
<!-- 불량 입력 모달창 데이터 -->

<!-- 라디오 버튼 이동 -->
<script>
$(document).ready(function(){
    $('#materialRadio').click(function(){ // 자재를 눌렀을 때
        console.log("Material radio clicked!");
        $.ajax({
            url: "/quality/materialQualityList",
            type: "GET",
            success: function(data) {
                $("#qualityListContainer").html(data);
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        }); 
    });
    
    $('#productRadio').click(function(){ // 생산을 눌렀을 때
        console.log("Product radio clicked!");
        $.ajax({
            url: "/quality/productQualityList", // 윗 목록 전환
            type: "GET",
            success: function(data) {
                $("#qualityListContainer").html(data);
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
        
        $.ajax({
            url: "/quality/productDefectList",
            type: "GET",
            success: function(data) { // 아랫 목록 전환
                $("#defectListContainer").html(data);
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
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
    $("#all").click(function() {
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
    $("form[action='/quality/productQualityList']").submit(function(event) {
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
            url: "/quality/productQualityList",
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
