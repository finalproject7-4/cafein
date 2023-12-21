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
												<input type="button" value="생산검수" onclick="location.href='/quality/paudit?produceid=${clist.produceid}';">
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