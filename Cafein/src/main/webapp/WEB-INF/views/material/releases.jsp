<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp" %>

<!-- 출고관리 페이지 시작 -->
<div class="col-12">

	<!-- 출고 조회 시작 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
	<h6 class="mb-4">출고 조회</h6>
	<form name="search" method="get">
		<div class="row align-items-stretch">
		  <div class="form-group col">
		    <div class="input-group" style="width: 220px;">
				<label style="margin: 5px 10px 0 0;">품명</label>
				<input type="text" name="keyword" placeholder="검색어를 입력하세요" class="form-control" style="border-radius: 5px;">
			</div>
		  </div>
		  <div class="form-group col">
		    <div class="input-group">
				<label style="margin: 5px 10px 0 0;">출고일자</label>
				<input type="date" name="releaseStartDate" class="form-control" style="border-radius: 5px;">
				<label>&nbsp;~&nbsp;</label>
				<input type="date" name="releaseEndDate" class="form-control" style="border-radius: 5px;">	
		  	</div>
		  </div>
		  <div class="col-1 align-items-stretch">			
			<input type="submit" class="btn btn-sm btn-dark" value="조회">
		  </div>	
		</div>
	</form>
	</div>
	<!-- 출고 조회 끝 -->

	<!-- 출고 목록 시작 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		
		<form action="releaseListExcelDownload" method="GET">
		<div class="buttonarea1">
			<b>총 ${pageVO.totalCount} 건</b>		
			<span style="float: right;">
				<input type="submit" value="엑셀 파일 다운로드" class="btn btn-sm btn-success">
				<!-- <button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#releaseRegistModal" data-bs-whatever="@getbootstrap">등록</button> -->
				<!-- <input type="hidden" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#releaseModifyModal" data-bs-whatever="@getbootstrap" value="수정"> -->
				<input type="hidden" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#releaseDetailModal" data-bs-whatever="@getbootstrap" value="상세내역">
			</span>
		</div>	
		</form>
		
		<div class="table-responsive">
			<table class="table" style="margin-top: 20px;">
				<thead>
					<tr style="text-align: center;">
						<th scope="col">번호</th>
						<th scope="col">출고코드</th>
						<th scope="col">생산지시코드</th>
						<th scope="col">품명</th>
						<th scope="col">재고수량</th>
						<th scope="col">출고수량</th>
						<th scope="col">출고일자</th>
						<th scope="col">담당자</th>
						<th scope="col">출고상태</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="rl" items="${releasesList }" varStatus="status">
					<tr style="text-align: center;">
						<td>
							<c:out value="${pageVO.totalCount - ((pageVO.cri.page - 1) * pageVO.cri.pageSize + status.index)}"/>
						</td>
						<td>${rl.releasecode }</td>
						<td>${rl.producecode }</td>
						<td>${rl.itemname }</td>
						<td>
							<fmt:formatNumber value="${rl.stockquantity }" pattern="#,###"/>
						</td>
						<td>${rl.releasequantity }</td>
						<td>
							<fmt:formatDate value="${rl.releasedate }" dateStyle="short" pattern="yyyy-MM-dd"/>
						</td>
						<td>${rl.membername }</td>
						<c:if test="${rl.releasestate == '완료'}">						
							<td><b>${rl.releasestate }</b></td>
						</c:if>
						<c:if test="${rl.releasestate == '대기'}">						
							<td>${rl.releasestate }</td>
						</c:if>
						<td>
							<button type="button" class="btn btn-sm btn-dark m-1"
								onclick="releaseDetailModal('${rl.releaseid }', '${rl.releasecode }', '${rl.producecode }', '${rl.itemname }', '${rl.stockquantity }', '${rl.releasequantity }', '${rl.releasedate }', '${rl.membername }')">상세내역
							</button>
						</td>
					</tr>
				</c:forEach>	
				</tbody>
			</table>

			<!-- 페이지 블럭 생성 -->
			<nav aria-label="Page navigation example">
  				<ul class="pagination justify-content-center">
    				
        			<!-- 버튼 이동에 따른 파라미터 전달 (이전) -->
    				<li class="page-item">
    				  <c:if test="${pageVO.prev }">
      					<a class="page-link pageBlockPrev" href="" aria-label="Previous" data-page="${pageVO.startPage - 1}">
        					<span aria-hidden="true">&laquo;</span>
      					</a>
        					
						<script>
							$(document).ready(function(){
								$('.pageBlockPrev').click(function(e) {
									e.preventDefault(); // 기본 이벤트 제거
								
					            	let prevPage = $(this).data('page');
								
									let keyword = "${param.keyword}";
									let releaseStartDate = "${param.releaseStartDate}";
									let releaseEndDate = "${param.releaseEndDate}";

			                		url = "/material/releases?page=" + prevPage;
			                
			                		if (keyword) {
			                    		url += "&keyword=" + encodeURIComponent(keyword);
			                		}
			                		
			                		if (releaseStartDate && releaseEndDate) {
			                			url += "&releaseStartDate=" + encodeURIComponent(releaseStartDate) + "&releaseEndDate=" + encodeURIComponent(releaseEndDate)
			                		}

			                		location.href = url;
								});
							});
						</script>
    				  </c:if>
    				</li>
        			<!-- 버튼 이동에 따른 파라미터 전달 (이전) -->
    		
    				<!-- 버튼 이동에 따른 파라미터 전달 (현재) -->
					<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1" var="i">
    					<li class="page-item ${pageVO.cri.page == i? 'active' : ''}">
    						<a class="page-link pageBlockNum" href="" data-page="${i}">${i }</a>
    					</li>
    					
					<script>
						$(document).ready(function(){
							$('.pageBlockNum').click(function(e) {
								e.preventDefault(); // 기본 이벤트 제거
					
			            		let pageValue = $(this).data('page');
					
								let keyword = "${param.keyword}";
								let releaseStartDate = "${param.releaseStartDate}";
								let releaseEndDate = "${param.releaseEndDate}";

	                			url = "/material/releases?page=" + pageValue;
                
		                		if (keyword) {
		                    		url += "&keyword=" + encodeURIComponent(keyword);
		                		}
		                		
		                		if (releaseStartDate && releaseEndDate) {
		                			url += "&releaseStartDate=" + encodeURIComponent(releaseStartDate) + "&releaseEndDate=" + encodeURIComponent(releaseEndDate)
		                		}

	                			location.href = url;
							});
						});
					</script>
    				</c:forEach>
					<!-- 버튼 이동에 따른 파라미터 전달 (현재) -->
    		
    				<!-- 버튼 이동에 따른 파라미터 전달 (다음) -->
    				<li class="page-item">
    				  <c:if test="${pageVO.next }">
      					<a class="page-link pageBlockNext" href="" aria-label="Next" data-page="${pageVO.endPage + 1}">
        					<span aria-hidden="true">&raquo;</span>
      					</a>
      					
						<script>
							$(document).ready(function(){
								$('.pageBlockNext').click(function(e) {
									e.preventDefault(); // 기본 이벤트 제거
				
		            				let nextPage = $(this).data('page');
				
									let keyword = "${param.keyword}";
									let releaseStartDate = "${param.releaseStartDate}";
									let releaseEndDate = "${param.releaseEndDate}";

               						url = "/material/releases?page=" + nextPage;
            
		                			if (keyword) {
		                    			url += "&keyword=" + encodeURIComponent(keyword);
		                			}
		                		
		                			if (releaseStartDate && releaseEndDate) {
		                				url += "&releaseStartDate=" + encodeURIComponent(releaseStartDate) + "&releaseEndDate=" + encodeURIComponent(releaseEndDate)
		                			}

               					location.href = url;
								});
							});
						</script>
    				</c:if>
    				</li>
					<!-- 버튼 이동에 따른 파라미터 전달 (다음) -->					
			  </ul>
			</nav>
			<!-- 페이지 블럭 생성 -->					
			
		</div>
	</div>
	<!-- 출고 목록 끝 -->
	
	<!-- 출고 등록 모달 -->
	<%-- <jsp:include page="releaseRegist.jsp"/> --%>
	
	<!-- 출고 수정 모달 -->
	<%-- <jsp:include page="releaseModify.jsp"/> --%>
	
	<!-- 출고 상세내역 모달 -->
	<jsp:include page="releaseDetail.jsp"/>	
	
</div>
<!-- 출고관리 페이지 시작 -->

<script>
// 출고 상세내역
function releaseDetailModal(releaseid, releasecode, producecode, itemname, stockquantity, releasequantity, releasedate, membername) {
	// 가져온 값들을 모달에 설정
	$("#releaseid3").val(releaseid);
	$("#releasecode3").val(releasecode);
	$("#producecode3").val(producecode);
	$("#itemname3").val(itemname);
	$("#stockquantity3").val(stockquantity);
	$("#releasequantity3").val(releasequantity);
	$("#releasedate3").val(releasedate);
	$("#membername3").val(membername);
	
    // 출고 상세내역 모달 띄우기
    $('#releaseDetailModal').modal('show');
}
</script>


<%@ include file="../include/footer.jsp" %>