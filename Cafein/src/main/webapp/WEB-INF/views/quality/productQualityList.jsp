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
			<h2>생산 / 반품 품질 관리</h2>
			<div class="form-check form-check-inline">
  				<input class="form-check-input" type="radio" name="type" id="productRadio" value="생산" checked>
  				<label class="form-check-label" for="product">생산</label>
			</div>
			<div class="form-check form-check-inline">
  				<input class="form-check-input" type="radio" name="type" id="materialRadio" value="자재">
  				<label class="form-check-label" for="material">자재</label>
			</div><br>
			
			<div class="buttonarea1" style="margin-bottom: 10px;">
				<input type="button" class="btn btn-sm btn-primary" value="블렌딩" id="blending">
				<input type="button" class="btn btn-sm btn-danger" value="로스팅" id="cooling">
				<input type="button" class="btn btn-sm btn-warning" value="포장" id="packaging">
				<input type="button" class="btn btn-sm btn-secondary" value="반품" id="return">
				<input type="button" class="btn btn-sm btn-success" value="전체" id="all">
			</div>
			
			<div class="buttonarea3" style="margin-bottom: 10px;">
			<form action="/quality/productQualityList" method="GET">
				<c:if test="${!empty param.searchBtn }">
				<input type="hidden" name="searchBtn" value="${param.searchBtn}">
				</c:if>
				<input type="date" id="startDate" name="startDate" required> ~
				<input type="date" id="endDate" name="endDate" required>
				<input type="submit" value="조회">
			</form>
			</div>
				<form action="/productQualityPrint" method="GET">
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
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">검수번호</th>
								<th scope="col">상품구분</th>
								<th scope="col">생산/반품번호</th>						
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
									<c:if test="${empty clist.produceprocess }">
										<td>${clist.itemtype }</td>
									</c:if>
									<c:if test="${!empty clist.produceprocess }">
										<td>${clist.itemtype } - ${clist.produceprocess }</td>
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
									<c:if test="${!empty clist.produceprocess && clist.produceprocess.equals('포장') }">
										<c:if test="${clist.weight != 0 }">
											${clist.itemname } (${clist.weight }g)
										</c:if>
										<c:if test="${clist.weight == 0 }">
											${clist.itemname } (미포장)
										</c:if>
									</c:if>
									<c:if test="${!empty clist.produceprocess && !clist.produceprocess.equals('포장') }">
									${clist.itemname }
									</c:if>
									<c:if test="${!empty clist.itemtype && clist.itemtype == '반품' }">
									${clist.itemname }
									</c:if>
									</td>
									<c:if test="${clist.auditbycode != 0 }">
									<td>${clist.auditbycode }</td>
									</c:if>
									<c:if test="${clist.auditbycode == 0 }">
									<td></td>
									</c:if>
									<td>
										<c:if test="${!empty clist.itemtype && clist.itemtype == '반품' }">${clist.productquantity }(개)</c:if>
										<c:if test="${!empty clist.itemtype && clist.itemtype != '반품' }">${clist.productquantity }(g)</c:if>
									</td>
									<td>
										<c:if test="${!empty clist.itemtype && clist.itemtype == '반품' }">${clist.auditquantity }(개)</c:if>
										<c:if test="${!empty clist.itemtype && clist.itemtype != '반품' }">${clist.auditquantity }(g)</c:if>
									</td>
									<td>
										<c:if test="${!empty clist.itemtype && clist.itemtype == '반품' }">${clist.normalquantity }(개)</c:if>
										<c:if test="${!empty clist.itemtype && clist.itemtype != '반품' }">${clist.normalquantity }(g)</c:if>
									</td>
									<td>
									<c:if test="${clist.defectquantity == 0}">
										<c:if test="${!empty clist.itemtype && clist.itemtype == '반품' }">${clist.defectquantity }(개)</c:if>
										<c:if test="${!empty clist.itemtype && clist.itemtype != '반품' }">${clist.defectquantity }(g)</c:if>
									</c:if>
									<c:if test="${clist.defectquantity != 0}">
										<c:if test="${!empty clist.itemtype && clist.itemtype == '반품' }"><b style="color: red;">${clist.defectquantity }</b>(개)</c:if>
										<c:if test="${!empty clist.itemtype && clist.itemtype != '반품' }"><b style="color: red;">${clist.defectquantity }</b>(g)</c:if>
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
									<c:if test="${(sessionScope.departmentname == '품질' && sessionScope.memberposition == '팀장') || sessionScope.membername.equals('admin') }">
										<c:if test="${clist.auditstatus.equals('대기') || clist.auditstatus.equals('검수중') }">
											<c:if test="${clist.produceid != 0 && clist.returnid == 0 }"> <!-- 생산ID 존재 -->
												<c:if test="${!empty clist.produceprocess && clist.produceprocess.equals('포장')}"> <!-- 포장 O -->
<%-- 											<input type="button" value="생산검수" onclick="location.href='/quality/productAudit?produceid=${clist.produceid}';"> --%>
												<button type="button" class="btn btn-primary btn-sm" 
												data-bs-toggle="modal" data-bs-target="#exampleModal"
												data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
												data-auditcode="${clist.auditcode }" data-produceprocess="${clist.produceprocess }" 
												data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
												data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" data-weight="${clist.weight }" 
												data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
												data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 												생산검수
												</button>
												</c:if>
												<c:if test="${!empty clist.produceprocess && !clist.produceprocess.equals('포장') }"> <!-- 포장 X -->
												<button type="button" class="btn btn-primary btn-sm" 
												data-bs-toggle="modal" data-bs-target="#produceAuditModal2"
												data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
												data-auditcode="${clist.auditcode }" data-produceprocess="${clist.produceprocess }" 
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
												data-auditcode="${clist.auditcode }" 
												data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
												data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
												data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
												data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 												반품검수
												</button>
											</c:if>
										</c:if>
										<c:if test="${!empty clist.auditstatus && clist.auditstatus.equals('검수완료') && clist.defectquantity == 0 }"> <!-- 불량 X -->
											<c:if test="${!empty clist.produceprocess && !clist.produceprocess.equals('포장') && !empty clist.registerstock && clist.registerstock.equals('N')}"> <!-- 생산 - 포장이 아닌 경우 -->
												<form action="/quality/updateQualityCheck" method="POST" > <!-- 재고로 가진 않지만 재고 등록 여부 업데이트 (검수 완료 시 자동 업데이트 [생산 - 포장이 아닐 때]) --> <!-- 생산 상태 업데이트 -->
													<input type="hidden" value="${clist.qualityid }" name="qualityid">
													<input type="hidden" value="${clist.produceid }" name="produceid">													
													<input type="submit" class="btn btn-success btn-sm" value="정상">
												</form>
											</c:if>	
											<c:if test="${!empty clist.produceprocess && clist.produceprocess.equals('포장') && !empty clist.registerstock && clist.registerstock.equals('N')}"> <!-- 생산 - 포장인 경우 -->
												<form action="/material/newStock" method="POST" > <!-- 재고로 --> <!-- 버튼 눌러서 재고 등록 여부 업데이트 -->
													<input type="hidden" value="${clist.qualityid }" name="qualityid">
													<input type="hidden" value="${clist.itemtype }" name="itemtype">
													<input type="hidden" value="${clist.itemid }" name="itemid">
													<input type="hidden" value="${clist.produceid }" name="produceid">
													<input type="hidden" value="${clist.weight }" name="weight">
													<input type="hidden" value="${clist.normalquantity }" name="stockquantity">
													<input type="submit" class="btn btn-success btn-sm" value="정상">
												</form>
											</c:if>
											<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품') && !empty clist.registerstock && clist.registerstock.equals('N')}"> <!-- 반품인 경우 -->
												<form action="/material/newStock" method="POST" > <!-- 재고로 --> <!-- 버튼 눌러서 재고 등록 여부 업데이트 -->
													<input type="hidden" value="${clist.qualityid }" name="qualityid">
													<input type="hidden" value="${clist.itemid }" name="itemid">
													<input type="hidden" value="${clist.normalquantity }" name="stockquantity">
													<input type="submit" class="btn btn-success btn-sm" value="정상">
												</form>
											</c:if>	
										</c:if>
										<c:if test="${!empty clist.auditstatus && clist.auditstatus.equals('검수완료') && clist.defectquantity != 0 }"> <!-- 불량 O -->
											<c:if test="${clist.normalquantity != 0 }"> <!-- 불량도 있고 정상도 있는 경우 (포장이 아닌 경우라면 전체 불량 처리) -->
												<c:if test="${!empty clist.produceprocess && !clist.produceprocess.equals('포장') && !empty clist.registerdefect && clist.registerdefect.equals('N')}"> <!-- 포장이 아닌 경우 -->
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newProductDefectModal"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-produceprocess="${clist.produceprocess }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-defectquantity="${clist.defectquantity }">
 													불량
													</button>
												</c:if>	
												<c:if test="${!empty clist.produceprocess && clist.produceprocess.equals('포장')}"> <!-- 포장인 경우 -->
												<form action="/material/newStock" method="POST" > <!-- 재고로 --> <!-- 생산 상태 업데이트 -->
													<input type="hidden" value="${clist.qualityid }" name="qualityid">
													<input type="hidden" value="${clist.itemtype }" name="itemtype">
													<input type="hidden" value="${clist.itemid }" name="itemid">
													<input type="hidden" value="${clist.produceid }" name="produceid">
													<input type="hidden" value="${clist.weight }" name="weight">
													<input type="hidden" value="${clist.normalquantity }" name="stockquantity">
													<c:if test="${!empty clist.registerstock && clist.registerstock.equals('N') }">
													<input type="submit" value="정상" class="btn btn-success btn-sm" >
													</c:if>
													<c:if test="${!empty clist.registerdefect && clist.registerdefect.equals('N') }">
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newProductDefectModal"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-produceprocess="${clist.produceprocess }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-weight="${clist.weight }"
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-defectquantity="${clist.defectquantity }">
 													불량
													</button>
													</c:if>
												</form>
												</c:if>	
												<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품')}"> <!-- 반품인 경우 -->
													<form action="/material/newStock" method="POST" > <!-- 재고로 -->
													<c:if test="${!empty clist.registerstock && clist.registerstock.equals('N') }">
														<input type="hidden" value="${clist.qualityid }" name="qualityid">
														<input type="hidden" value="${clist.itemid }" name="itemid">
														<input type="hidden" value="${clist.normalquantity }" name="stockquantity">
														<input type="submit" class="btn btn-success btn-sm" value="정상">
													</c:if>
													<c:if test="${!empty clist.registerdefect && clist.registerdefect.equals('N') }">
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newReturnDefectModal"
													data-returnid="${clist.returnid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-produceprocess="${clist.produceprocess }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
													data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
 													불량
													</button>
													</c:if>
													</form>
												</c:if>	
											</c:if>
											<c:if test="${clist.normalquantity == 0 }"> <!-- 불량은 있지만 정상은 없는 경우 -->
												<c:if test="${!empty clist.produceprocess && !clist.produceprocess.equals('포장') && !empty clist.registerdefect && clist.registerdefect.equals('N')}"> <!-- 포장이 아닌 경우 -->
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newProductDefectModal"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-produceprocess="${clist.produceprocess }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-defectquantity="${clist.defectquantity }">
 													불량
													</button>												
												</c:if>	
												<c:if test="${!empty clist.produceprocess && clist.produceprocess.equals('포장') && !empty clist.registerdefect && clist.registerdefect.equals('N')}"> <!-- 포장인 경우 -->
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newProductDefectModal"
													data-produceid="${clist.produceid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }" data-produceprocess="${clist.produceprocess }" 
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-weight="${clist.weight }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-defectquantity="${clist.defectquantity }">
 													불량
													</button>													
												</c:if>	
												<c:if test="${!empty clist.itemtype && clist.itemtype.equals('반품') && !empty clist.registerdefect && clist.registerdefect.equals('N')}"> <!-- 반품인 경우 -->
													<button type="button" class="btn btn-danger btn-sm" 
													data-bs-toggle="modal" data-bs-target="#newReturnDefectModal"
													data-returnid="${clist.returnid }" data-qualityid="${clist.qualityid}" data-itemtype="${clist.itemtype }" 
													data-auditcode="${clist.auditcode }"
													data-itemid="${clist.itemid }" data-itemcode="${clist.itemcode }" 
													data-itemname="${clist.itemname }" data-auditbycode="${clist.auditbycode }" 
													data-productquantity="${clist.productquantity }" data-auditquantity="${clist.auditquantity }" 
													data-normalquantity="${clist.normalquantity }" data-defectquantity="${clist.defectquantity }">
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
	
<!-- 생산 검수 모달창 - LOT 선택 (포장) -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-keyboard="false" data-bs-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">생산 검수 (포장)</h1>
        <button type="button" class="closebtn btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <form action="/quality/autoAudit" method="POST">

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

      	<div class="row">
      		<div class="col">
           		<label for="qualityid" class="col-form-label">품질관리번호:</label>
            	<input type="text" class="form-control" id="qualityid" name="qualityid" value="" readonly>
        	</div>
        	<div class="col">
            	<label for="produceid" class="col-form-label">생산번호:</label>
            	<input type="text" class="form-control" id="produceid" name="produceid" value="" readonly>
			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="auditcode" class="col-form-label">검수번호:</label>
            	<input type="text" class="form-control" id="auditcode" name="auditcode" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="produceprocess" class="col-form-label">생산단계:</label>
            	<input type="text" class="form-control" id="produceprocess" name="produceprocess" value="" readonly>
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
           		<label for="productquantity" class="col-form-label">생산량:</label>
            	<input type="text" class="form-control" id="productquantity" name="productquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="weight" class="col-form-label">개별 중량:</label>
            	<input type="text" class="form-control" id="weight" name="weight" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="auditquantity" class="col-form-label">검수량:</label>
            	<input type="text" class="form-control" id="auditquantity" name="auditquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="defectquantity" class="col-form-label">불량:</label>
            	<input type="text" class="form-control" id="defectquantity" name="defectquantity" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="normalquantity" class="col-form-label">정상:</label>
            	<input type="text" class="form-control" id="normalquantity" name="normalquantity" value="" style="margin-bottom: 10px;" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="d-grid gap-2 col-12 mx-auto">
            	<input type="submit" class="autoBtn btn btn-primary" style="margin-bottom: 10px;" value="자동 검수">
  			</div>
		</div>
		</form>
		<div class="row">
 			<div class="col">
 			<label for="lottable">LOT번호별 품질 검사:</label>
				<table class="table table-hover" id="lottable">
					<thead>
						<tr>
							<th>LOT번호</th>
							<th>정상</th>
							<th>불량</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
  			</div>
		</div>

      </div>
      <div class="modal-footer">
        <button type="button" class="closebtn btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- 생산 검수 모달창 - LOT 선택 (포장) -->

<!-- 생산 검수 모달창 데이터 - LOT 선택 (포장) -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('exampleModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let qualityid = button.getAttribute('data-qualityid'); // qualityid
        let produceid = button.getAttribute('data-produceid'); // produceid
        let auditcode = button.getAttribute('data-auditcode'); // auditcode
        let itemtype = button.getAttribute('data-itemtype'); // itemtype
        let produceprocess = button.getAttribute('data-produceprocess'); // produceprocess
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
        
        let proinputField = myModal.querySelector('input[name="produceprocess"]');
        proinputField.value = itemtype + " - " + produceprocess;
        
        let icinputField = myModal.querySelector('input[name="itemcode"]');
        icinputField.value = itemcode;
        
        let ininputField = myModal.querySelector('input[name="itemname"]');
        ininputField.value = itemname + " (" + weight + "g)";
        
        let pqinputField = myModal.querySelector('input[name="productquantity"]');
        pqinputField.value = productquantity;
        
        let winputField = myModal.querySelector('input[name="weight"]');
        winputField.value = weight; 
        
        let aqinputField = myModal.querySelector('input[name="auditquantity"]');
        aqinputField.value = auditquantity;
        
        let nqinputField = myModal.querySelector('input[name="normalquantity"]');
        nqinputField.value = normalquantity;
        
        let dqinputField = myModal.querySelector('input[name="defectquantity"]');
        dqinputField.value = defectquantity;
        
//     	const productQuantityInput = document.getElementById("productquantity");
//     	const auditQuantityInput = document.getElementById("auditquantity");
//     	const defectiveQuantityInput = document.getElementById("defectquantity");
    	
      // LOT번호와 정상/불량 데이터를 가져오는 함수
        function fetchLotData(produceid) {
            $.ajax({
                url: '/roastedBeanLot', // 실제 AJAX 엔드포인트 URL로 교체해야 함
                type: 'GET',
                data: { produceid: produceid },
                dataType: 'json',
                success: function(data) {
                	console.log(data);
                	updateTableWithData(data);
                	
                    // LOT번호가 조회될 때만 자동 검수 버튼 출력
                    var tbodyIsEmpty = $("#lottable tbody").is(':empty');

                    if (!tbodyIsEmpty) {
                        $(".autoBtn").show();
                    } else {
                        $(".autoBtn").hide();
                    }
                    
                },
                error: function(error) {
                    console.error("Error fetching data:", error);
                }
            });
        }

        // 테이블을 업데이트하는 함수
            function updateTableWithData(data) {
                const tableBody = document.querySelector('#exampleModal table tbody');
                tableBody.innerHTML = ''; // 기존 데이터 초기화

                data.forEach(function(item, index) {
                	const row = "<tr><td>" 
                	+ item.lotnumber +
                	"</td><td>" + 
					"<form class='normal-form' action='/roastedBeanDefect' method='POST'>" +
					"<c:if test='${empty param.page}'>" +
					"<input type='hidden' name='page' value='1'>" +
					"</c:if>" + 
					"<c:if test='${!empty param.page}'>" +
					"<input type='hidden' name='page' value='${param.page}'>" +
					"</c:if>" + 
					"<c:if test='${!empty param.searchBtn}'>" +
					"<input type='hidden' name='searchBtn' value='${param.searchBtn}'>" +
					"</c:if>" + 
					"<c:if test='${!empty param.startDate}'>" +
					"<input type='hidden' name='startDate' value='${param.startDate}'>" +
					"</c:if>" + 
					"<c:if test='${!empty param.endDate}'>" +
					"<input type='hidden' name='endDate' value='${param.endDate}'>" +
					"</c:if>" + 
					"<input type='hidden' name='qualityid' value='"+ qualityid + "'>" +
					"<input type='hidden' name='produceid' value='"+ produceid + "'>" +
					"<input type='hidden' name='auditcode' value='"+ auditcode + "'>" +
					"<input type='hidden' name='lotnumber' value='" + item.lotnumber + "'>" +
					"<input type='hidden' name='auditstatus' value='Y'>" +
					"<input type='hidden' name='defect' value='N'>" + 
					"<input type='hidden' name='weight' value='" + weight + "'>" +
					"<input type='hidden' name='productquantity' value='" + productquantity + "'>" +
					"<input type='hidden' id='normal1' name='auditquantity' value='" + auditquantity + "'>" +
					"<input type='hidden' id='normal2' name='normalquantity' value='" + normalquantity + "'>" +
					"<input type='hidden' id='normal3' name='defectquantity' value='" + defectquantity + "'>" +
					"<input type='submit' class='normalbtn btn btn-sm btn-primary' value='정상'></form></td><td>" +
					"<form class='defect-form' action='/roastedBeanDefect' method='POST'>" +
					"<c:if test='${empty param.page}'>" +
					"<input type='hidden' name='page' value='1'>" +
					"</c:if>" + 
					"<c:if test='${!empty param.page}'>" +
					"<input type='hidden' name='page' value='${param.page}'>" +
					"</c:if>" + 
					"<c:if test='${!empty param.searchBtn}'>" +
					"<input type='hidden' name='searchBtn' value='${param.searchBtn}'>" +
					"</c:if>" + 
					"<c:if test='${!empty param.startDate}'>" +
					"<input type='hidden' name='startDate' value='${param.startDate}'>" +
					"</c:if>" + 
					"<c:if test='${!empty param.endDate}'>" +
					"<input type='hidden' name='endDate' value='${param.endDate}'>" +
					"</c:if>" + 
					"<input type='hidden' name='qualityid' value='"+ qualityid + "'>" +
					"<input type='hidden' name='produceid' value='"+ produceid + "'>" +
					"<input type='hidden' name='auditcode' value='"+ auditcode + "'>" +
					"<input type='hidden' name='lotnumber' value='" + item.lotnumber + "'>" +
					"<input type='hidden' name='auditstatus' value='Y'>" +
					"<input type='hidden' name='defect' value='Y'>" + 
					"<input type='hidden' name='weight' value='" + weight + "'>" +
					"<input type='hidden' name='productquantity' value='" + productquantity + "'>" +
					"<input type='hidden' id='defect1' name='auditquantity' value='" + auditquantity + "'>" +
					"<input type='hidden' id='defect2' name='normalquantity' value='" + normalquantity + "'>" +
					"<input type='hidden' id='defect3' name='defectquantity' value='" + defectquantity + "'>" +
					"<input type='submit' class='defectbtn btn btn-sm btn-danger' value='불량'></form></td>";
                    tableBody.innerHTML += row;
                });
                
             // 정상/불량 버튼 처리를 위한 이벤트 리스너 추가
                $('.normal-form').on('submit', function(event) {
                    event.preventDefault();
                	auditquantity = parseInt(auditquantity) + parseInt(weight);
                	normalquantity = parseInt(normalquantity) + parseInt(weight);
                	defectquantity = parseInt(auditquantity) - parseInt(normalquantity);
                    
                    $('#normal1').val(auditquantity);
                    $('#normal2').val(normalquantity);
                    $('#normal3').val(defectquantity);
                	
                    var form = $(this);
                    var formData = form.serialize();

                    $.ajax({
                        type: form.attr('method'),
                        url: form.attr('action'),
                        data: formData,
                        success: function(response) {
                        	Swal.fire("검수가 성공적으로 저장되었습니다.");
                        	
                            aqinputField.value = auditquantity;
                            dqinputField.value = defectquantity;
                            nqinputField.value = normalquantity;
                        	
                            fetchLotData(produceid);
                        },
                        error: function(error) {
                            console.error("Error submitting form:", error);
                        	Swal.fire("검수 저장에 실패했습니다.");
                            fetchLotData(produceid);
                        }
                    });
                });
             
                $('.defect-form').on('submit', function(event) {
                    event.preventDefault();
                	auditquantity = parseInt(auditquantity) + parseInt(weight);
                	defectquantity = parseInt(defectquantity) + parseInt(weight);
                	normalquantity = parseInt(auditquantity) - parseInt(defectquantity);
                    
                    $('#defect1').val(auditquantity);
                    $('#defect2').val(normalquantity);
                    $('#defect3').val(defectquantity);
                	
                    var form = $(this);
                    var formData = form.serialize();

                    $.ajax({
                        type: form.attr('method'),
                        url: form.attr('action'),
                        data: formData,
                        success: function(response) {
							Swal.fire("검수가 성공적으로 저장되었습니다.");
                        	
                            aqinputField.value = auditquantity;
                            dqinputField.value = defectquantity;
                            nqinputField.value = normalquantity;
                        	
                            fetchLotData(produceid);
                        },
                        error: function(error) {
                            console.error("Error submitting form:", error);
                        	Swal.fire("검수 저장에 실패했습니다.");
                            fetchLotData(produceid);
                        }
                    });
                });
            }
       	// 생산ID(produceid)를 사용하여 데이터를 가져와 테이블을 업데이트
        fetchLotData(produceid);
    });
});
</script>
<!-- 생산 검수 모달창 데이터 - LOT 선택 (포장) -->

<!-- 닫기 버튼 클릭 -->
<script>
$(document).ready(function(){
	$(".closebtn").click(function(){
		var page = "${param.page}";
		var searchBtn = "${param.searchBtn}";
		var startDate = "${param.startDate}";
		var endDate = "${param.endDate}";
		
		var formData = {};
		
		if(page){
			formData.page = page;
		}else{
			formData.page = 1;
		}
		
		if(searchBtn){
			formData.searchBtn = searchBtn;
		}
		
		if(startDate){
			formData.startDate = startDate;
		}
		
		if(endDate){
			formData.endDate = endDate;
		}
		
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
<!-- 닫기 버튼 클릭 -->

<!-- 생산 검수 모달창 (포장 X) -->
<div class="modal fade" id="produceAuditModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/quality/productAudit" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">생산 검수 (블렌딩 / 로스팅)</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
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
            
      	<div class="row">
 			<div class="col">
           		<label for="qualityid3" class="col-form-label">품질관리번호:</label>
            	<input type="text" class="form-control" id="qualityid3" name="qualityid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="produceid3" class="col-form-label">생산번호:</label>
            	<input type="text" class="form-control" id="produceid3" name="produceid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="auditcode3" class="col-form-label">검수번호:</label>
            	<input type="text" class="form-control" id="auditcode3" name="auditcode" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="produceprocess3" class="col-form-label">생산단계:</label>
            	<input type="text" class="form-control" id="produceprocess3" name="produceprocess" value="" readonly>
  			</div>
		</div>
		<div class="row" style="margin-bottom: 10px;">
 			<div class="col">
           		<label for="productquantity3" class="col-form-label">생산량 (g):</label>
            	<input type="number" class="form-control" id="productquantity3" name="productquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="auditquantity3" class="col-form-label">검수량 (g):</label>
            	<input type="number" class="form-control" id="auditquantity3" name="auditquantity" value="" required>
  			</div>
		</div>
		<span>정상 / 불량 선택:</span><br>
		<div class="form-check form-check-inline" style="margin-top: 10px;">
  			<input class="form-check-input" type="radio" name="inlineRadioOptions" id="normal" value="normal" checked>
  			<label class="form-check-label" for="normal">정상</label>
		</div>
		<div class="form-check form-check-inline">
  			<input class="form-check-input" type="radio" name="inlineRadioOptions" id="defect" value="defect">
  			<label class="form-check-label" for="defect">불량</label>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="normalquantity3" class="col-form-label">정상 (g / 자동 계산):</label>
            	<input type="number" class="form-control" id="normalquantity3" name="normalquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="defectquantity3" class="col-form-label">불량 (g / 자동 계산):</label>
            	<input type="number" class="form-control" id="defectquantity3" name="defectquantity" value="" readonly>
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
$(document).ready(function() {
    let myModal = document.getElementById('produceAuditModal2');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let qualityid = button.getAttribute('data-qualityid'); // qualityid
        let produceid = button.getAttribute('data-produceid'); // produceid
        let auditcode = button.getAttribute('data-auditcode'); // auditcode
        let itemtype = button.getAttribute('data-itemtype'); // itemtype
        let produceprocess = button.getAttribute('data-produceprocess'); // produceprocess
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
        
        let proinputField = myModal.querySelector('input[name="produceprocess"]');
        proinputField.value = itemtype + " - " + produceprocess;
        
        let pqinputField = myModal.querySelector('input[name="productquantity"]');
        pqinputField.value = productquantity;
        
        let aqinputField = myModal.querySelector('input[name="auditquantity"]');
        aqinputField.value = auditquantity;
        
        let nqinputField = myModal.querySelector('input[name="normalquantity"]');
        nqinputField.value = normalquantity;
        
        let dqinputField = myModal.querySelector('input[name="defectquantity"]');
        dqinputField.value = defectquantity;
        
        // DOM 요소 선택
        const productquantityInput = document.getElementById('productquantity3');  // 생산량 입력 요소
        const auditquantityInput = document.getElementById('auditquantity3');      // 검수량 입력 요소
        const normalRadio = document.getElementById('normal');                     // 정상 라디오 버튼
        const defectRadio = document.getElementById('defect');                     // 불량 라디오 버튼
        const normalquantityInput = document.getElementById('normalquantity3');    // 정상 수량 입력 요소
        const defectquantityInput = document.getElementById('defectquantity3');    // 불량 수량 입력 요소
        const submitButton = document.querySelector('form[action="/quality/productAudit"] button[type="submit"]');  // 검수 저장 버튼

        // 기존 값 이용하여 라디오 버튼 체크
        if (parseInt(normalquantity) > 0) {
            normalRadio.checked = true;
        } else if (parseInt(defectquantity) > 0) {
            defectRadio.checked = true;
        } else if (parseInt(normalquantity) == 0 && parseInt(defectquantity) == 0) {
            normalRadio.checked = true;
        }
        
        // 라디오 버튼 선택에 따른 입력값 업데이트 함수
        function updateInputs() {
            if (normalRadio.checked) {
                normalquantityInput.value = auditquantityInput.value;  // 정상 수량은 검수량과 동일
                defectquantityInput.value = 0;                          // 불량 수량은 0
            } else if (defectRadio.checked) {
                normalquantityInput.value = 0;                          // 정상 수량은 0
                auditquantityInput.value = productquantity;             // 불량 입력 시 전체 불량 처리
                defectquantityInput.value = productquantity;    // 불량 수량은 검수량과 동일
            }
        }

        // 검수량 입력 시 생산량 초과 검사
        auditquantityInput.addEventListener('blur', function() {
            if (parseInt(auditquantityInput.value) > parseInt(productquantityInput.value)) {
            	Swal.fire('검수량은 생산량보다 많을 수 없습니다.');
                auditquantityInput.value = auditquantity;  // 검수량을 초기값으로 설정
            }else if(parseInt(auditquantityInput.value) < auditquantity){
            	Swal.fire('검수량은 기존 검수량보다 적을 수 없습니다!');
                auditquantityInput.value = auditquantity;  // 검수량을 초기값으로 설정
            }
            
            if (normalRadio.checked) {
                normalquantityInput.value = auditquantityInput.value;  // 정상 수량은 검수량과 동일
                defectquantityInput.value = 0;                          // 불량 수량은 0
            } else if (defectRadio.checked) {
                normalquantityInput.value = 0;                          // 정상 수량은 0
                auditquantityInput.value = productquantity;             // 불량 입력 시 전체 불량 처리
                defectquantityInput.value = productquantity;    // 불량 수량은 검수량과 동일
            }
            
        });

        // 라디오 버튼 변경 이벤트 리스너 추가
        normalRadio.addEventListener('change', updateInputs);
        defectRadio.addEventListener('change', updateInputs);

        // 초기 입력값 업데이트
        updateInputs();

        // 옵션: 유효성 검사 실패 시 폼 제출 방지
        submitButton.addEventListener('click', function(event) {
            if (parseInt(auditquantityInput.value) > parseInt(productquantityInput.value)) {
            	Swal.fire('검수량은 생산량을 초과할 수 없습니다.');
                event.preventDefault();  // 폼 제출 방지
            }
        });
    });
});
</script>
<!-- 생산 검수 모달창 데이터 (포장 X) -->		

<!-- 반품 검수 모달창 -->
<div class="modal fade" id="returnAuditModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/quality/returnAudit" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel2">반품 검수</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
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
      
      	<div class="row">
 			<div class="col">
           		<label for="qualityid2" class="col-form-label">품질관리번호:</label>
            	<input type="text" class="form-control" id="qualityid2" name="qualityid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="returnid2" class="col-form-label">반품번호:</label>
            	<input type="text" class="form-control" id="returnid2" name="returnid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="auditcode2" class="col-form-label">검수번호:</label>
            	<input type="text" class="form-control" id="auditcode2" name="auditcode" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="produceprocess2" class="col-form-label">상품구분:</label>
            	<input type="text" class="form-control" id="produceprocess2" name="produceprocess" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="productquantity2" class="col-form-label">반품량 (개):</label>
            	<input type="number" class="form-control" id="productquantity2" name="productquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="auditquantity2" class="col-form-label">검수량 (개):</label>
            	<input type="number" class="form-control" id="auditquantity2" name="auditquantity" value="" required>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="normalquantity2" class="col-form-label">정상 (개 / 자동 계산):</label>
            	<input type="number" class="form-control" id="normalquantity2" name="normalquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="defectquantity2" class="col-form-label">불량 입력 (개):</label>
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
$(document).ready(function() {
    let myModal = document.getElementById('returnAuditModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let qualityid = button.getAttribute('data-qualityid'); // qualityid
        let returnid = button.getAttribute('data-returnid'); // returnid
        let auditcode = button.getAttribute('data-auditcode'); // auditcode
        let itemtype = button.getAttribute('data-itemtype'); // itemtype
        let produceprocess = button.getAttribute('data-produceprocess'); // produceprocess
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
        
        let proinputField = myModal.querySelector('input[name="produceprocess"]');
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
<!-- 반품 검수 모달창 데이터 -->

<!-- 불량 입력 모달창 (생산) -->
<div class="modal fade" id="newProductDefectModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/quality//productReturnNewDefect" method="POST">
  
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
        let produceprocess = button.getAttribute('data-produceprocess'); // produceprocess
        let itemcode = button.getAttribute('data-itemcode'); // itemcode
        let itemname = button.getAttribute('data-itemname'); // itemname
        let weight = button.getAttribute('data-weight'); // weight
        let defectquantity = button.getAttribute('data-defectquantity'); // defectquantity
        
        // 모달 내부의 입력 필드에 값을 설정
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityid;
        
        let ainputField = myModal.querySelector('input[name="auditcode"]');
        ainputField.value = auditcode;
        
        let iinputField = myModal.querySelector('input[name="itemtype"]');
        iinputField.value = itemtype + " - " + produceprocess;
        
        let icinputField = myModal.querySelector('input[name="itemcode"]');
        icinputField.value = itemcode;
        
        let ininputField = myModal.querySelector('input[name="itemname"]');
        ininputField.value = itemname + " (" + weight + "g)";

        let dqinputField = myModal.querySelector('input[name="defectquantity"]');
        dqinputField.value = defectquantity;   
    });
});
</script>
<!-- 불량 입력 모달창 데이터 (생산) -->

<!-- 불량 입력 모달창 (반품) -->
<div class="modal fade" id="newReturnDefectModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/quality//productReturnNewDefect" method="POST">
    
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
        <h1 class="modal-title fs-5" id="exampleModalLabel2">불량 등록 (반품)</h1>
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
<!-- 불량 입력 모달창 (반품) -->

<!-- 불량 입력 모달창 데이터 (반품) -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('newReturnDefectModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let qualityid = button.getAttribute('data-qualityid'); // qualityid
        let produceid = button.getAttribute('data-return'); // returnid
        let auditcode = button.getAttribute('data-auditcode'); // auditcode
        let itemtype = button.getAttribute('data-itemtype'); // itemtype
        let itemcode = button.getAttribute('data-itemcode'); // itemcode
        let itemname = button.getAttribute('data-itemname'); // itemname
        let defectquantity = button.getAttribute('data-defectquantity'); // defectquantity
        
        // 모달 내부의 입력 필드에 값을 설정
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityid;
        
        let ainputField = myModal.querySelector('input[name="auditcode"]');
        ainputField.value = auditcode;
        
        let iinputField = myModal.querySelector('input[name="itemtype"]');
        iinputField.value = itemtype;
        
        let icinputField = myModal.querySelector('input[name="itemcode"]');
        icinputField.value = itemcode;
        
        let ininputField = myModal.querySelector('input[name="itemname"]');
        ininputField.value = itemname;

        let dqinputField = myModal.querySelector('input[name="defectquantity"]');
        dqinputField.value = defectquantity;
        
    });
});
</script>
<!-- 불량 입력 모달창 데이터 (반품) -->

<!-- 라디오 버튼 이동 -->
<script>
$(document).ready(function(){
    $('#productRadio').click(function(){ // 생산을 눌렀을 때
        console.log("Product radio clicked!");
		location.href="/quality/qualities";
    });
    
    $('#materialRadio').click(function(){ // 자재를 눌렀을 때
        console.log("Material radio clicked!");
		location.href="/quality/qualitiesMaterial";
    });
});
</script>
<!-- 라디오 버튼 이동 -->

<!-- 페이지 Ajax 동적 이동 (1) -->
<script>
$(document).ready(function() {
    // 블렌딩 버튼 클릭
    $("#blending").click(function() {
        fetchData("블렌딩");
    });

    // 로스팅 버튼 클릭
    $("#cooling").click(function() {
        fetchData("로스팅");
    });

    // 포장 버튼 클릭
    $("#packaging").click(function() {
        fetchData("포장");
    });

    // 반품 버튼 클릭
    $("#return").click(function() {
        fetchData("반품");
    });

    // 전체 버튼 클릭
    $("#all").click(function() {
        $.ajax({
            url: "/quality/productQualityList",
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
        url: "/quality/productQualityList",
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