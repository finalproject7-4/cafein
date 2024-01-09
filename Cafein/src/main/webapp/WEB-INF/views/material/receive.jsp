<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>      
<%@ include file="../include/header.jsp" %>
<!-- SweetAlert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>

<!-- 입고관리 페이지 시작 -->
<div class="col-12">

	<!-- 입고 조회 시작 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
	<h6 class="mb-4">입고 조회</h6>
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
				<label style="margin: 5px 10px 0 0;">입고일자</label>
				<input type="date" name="receiveStartDate" class="form-control" style="border-radius: 5px;">
				<label>&nbsp;~&nbsp;</label>
				<input type="date" name="receiveEndDate" class="form-control" style="border-radius: 5px;">	
		  	</div>
		  </div>
		  <div class="col-1 align-items-stretch">			
			<input type="submit" class="btn btn-sm btn-dark" value="조회">
		  </div>	
		</div>
	</form>
	</div>
	<!-- 입고 조회 끝 -->

	<!-- 입고 목록 시작 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		
		<form action="receiveListExcelDownload" method="GET">
		<div class="buttonarea1">
			<b>총 ${pageVO.totalCount} 건</b>
			<span style="float: right;">
				<button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#receiveRegistModal" data-bs-whatever="@getbootstrap">등록</button>
				<input type="submit" value="엑셀 파일 다운로드" class="btn btn-sm btn-success">
				<input type="hidden" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#receiveModifyModal" data-bs-whatever="@getbootstrap" value="수정">
				<input type="hidden" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#receiveDetailModal" data-bs-whatever="@getbootstrap" value="상세내역">
			</span>
		</div>
		</form>
		
		<div class="table-responsive">
			<table class="table" style="margin-top: 10px;">
				<thead>
					<tr style="text-align: center;">
						<th scope="col" style="display: none;"></th>
						<th scope="col">번호</th>
						<th scope="col">입고코드</th>
						<th scope="col">발주코드</th>
						<th scope="col">품명</th>
						<th scope="col">발주수량</th>
						<th scope="col">미입고수량</th>
						<th scope="col">입고수량</th>
						<th scope="col">입고일자</th>
						<th scope="col">담당자</th>
						<th scope="col">입고상태</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="rcl" items="${receiveList }" varStatus="status">
					<tr style="text-align: center;">
						<td style="display: none;">${rcl.receiveid }</td>
						<td>
							<c:out value="${pageVO.totalCount - ((pageVO.cri.page - 1) * pageVO.cri.pageSize + status.index)}"/>
						</td>
						<td>${rcl.receivecode }</td>
						<td>${rcl.orderscode }</td>
						<td>${rcl.itemname }</td>
						<td>${rcl.ordersquantity }</td>
						<c:if test="${rcl.ordersquantity - rcl.receivequantity == 0}">
							<td>-</td>
						</c:if>
						<c:if test="${rcl.ordersquantity - rcl.receivequantity != 0}">
							<td style="color: red;">${rcl.ordersquantity - rcl.receivequantity }</td>
						</c:if>
						<td><b>${rcl.receivequantity }</b></td>
						<td>
							<fmt:formatDate value="${rcl.receivedate }" dateStyle="short" pattern="yyyy-MM-dd"/>
						</td>
						<td>${rcl.membername }</td>
						<c:choose>
							<c:when test="${rcl.receivestate == '완료'}">
								<td><b>${rcl.receivestate }</b></td>
								<td>
									<button type="button" class="btn btn-sm btn-dark m-1" 
										onclick="receiveDetailModal('${rcl.receiveid }', '${rcl.itemid }', '${rcl.orderscode }', '${rcl.itemname }', '${rcl.ordersquantity }', '${rcl.receivestate }', '${rcl.receivedate }', '${rcl.receivequantity }', '${rcl.storagecode }', '${rcl.lotnumber }', '${rcl.membername }')">상세내역
									</button>
								</td>
							</c:when>
							<c:otherwise>
								<td>${rcl.receivestate }</td>
								<td>
									<button type="button" class="btn btn-sm btn-warning m-1" 
										onclick="receiveModifyModal('${rcl.receiveid }', '${rcl.itemid }', '${rcl.orderscode }', '${rcl.itemname }', '${rcl.ordersquantity }', '${rcl.receivestate }', '${rcl.receivedate }', '${rcl.receivequantity }', '${rcl.storagecode }', '${rcl.lotnumber }', '${rcl.membername }')">수정
									</button>
									<input type="button" class="btn btn-sm btn-secondary m-1" value="삭제" id="deleteBtn">
								</td>
							</c:otherwise>
						</c:choose>						
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
									let receiveStartDate = "${param.receiveStartDate}";
									let receiveEndDate = "${param.receiveEndDate}";

			                		url = "/material/receive?page=" + prevPage;
			                
			                		if (keyword) {
			                    		url += "&keyword=" + encodeURIComponent(keyword);
			                		}
			                		
			                		if (receiveStartDate && receiveEndDate) {
			                			url += "&receiveStartDate=" + encodeURIComponent(receiveStartDate) + "&receiveEndDate=" + encodeURIComponent(receiveEndDate)
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
								let receiveStartDate = "${param.receiveStartDate}";
								let receiveEndDate = "${param.receiveEndDate}";

	                			url = "/material/receive?page=" + pageValue;
                
		                		if (keyword) {
		                    		url += "&keyword=" + encodeURIComponent(keyword);
		                		}
		                		
		                		if (receiveStartDate && receiveEndDate) {
		                			url += "&receiveStartDate=" + encodeURIComponent(receiveStartDate) + "&receiveEndDate=" + encodeURIComponent(receiveEndDate)
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
									let receiveStartDate = "${param.receiveStartDate}";
									let receiveEndDate = "${param.receiveEndDate}";

               						url = "/material/receive?page=" + nextPage;
            
		                			if (keyword) {
		                    			url += "&keyword=" + encodeURIComponent(keyword);
		                			}
		                		
		                			if (receiveStartDate && receiveEndDate) {
		                				url += "&receiveStartDate=" + encodeURIComponent(receiveStartDate) + "&receiveEndDate=" + encodeURIComponent(receiveEndDate)
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
	<!-- 입고 목록 끝 -->

	<!-- 입고 등록 모달 -->
	<jsp:include page="receiveRegist.jsp"/>
	
	<!-- 입고 수정 모달 -->
	<jsp:include page="receiveModify.jsp"/>
	
	<!-- 입고 상세내역 모달 -->
	<jsp:include page="receiveDetail.jsp"/>
	
	<!-- 발주 목록 모달 시작 -->
    <div class="modal fade" id="ordersListModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">발주 목록</h5>
                	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <div class="modal-body">
                	<div class="col-12">
                    	<div class="bg-light rounded h-100 p-4">
                        	<table class="table">
                            	<thead>
                                	<tr>
                                	   <th style="display: none;"></th>
                                	   <th style="display: none;"></th>
                                       <th scope="col">발주코드</th>
                                       <th scope="col">품명</th>
                                       <th scope="col">수량</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                  <c:forEach var="ol" items="${ordersList }">
                                    <tr class="orderslist">
                                    	<td style="display: none;">${ol.itemid }</td>
                                    	<td>${ol.orderscode}</td>
                                    	<td>${ol.itemname }</td> 
                                    	<td>${ol.ordersquantity }</td>
                                    </tr>
                                  </c:forEach>
                                 </tbody>
                        	</table>
                    	</div>
                        <div class="modal-footer">
                        </div>
                	</div>
                </div>
        	</div>
    	</div>
    </div>
    <!-- 발주 목록 모달 끝 -->	
	
	<!-- 창고 목록 모달 시작 -->
    <div class="modal fade" id="storageListModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">창고 목록</h5>
                	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <div class="modal-body">
                	<div class="col-12">
                    	<div class="bg-light rounded h-100 p-4">
                        	<table class="table">
                            	<thead>
                                	<tr>
                                       <th scope="col">번호</th>
                                       <th scope="col">창고코드</th>
                                       <th scope="col">창고명</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                  <c:forEach var="sl" items="${storageList }">
                                    <tr class="storagelist">
                                    	<td>${sl.storageid}</td>
                                    	<td>${sl.storagecode }</td>
                                    	<td>${sl.storagename }</td> 
                                    </tr>
                                  </c:forEach>
                                 </tbody>
                        	</table>
                    	</div>
                        <div class="modal-footer">
                        </div>
                	</div>
                </div>
        	</div>
    	</div>
    </div>
    <!-- 창고 목록 모달 끝 -->
    
</div>
<!-- 입고관리 페이지 끝 -->

<script>
	var receiveRegistModal = document.getElementById('receiveRegistModal')
	receiveRegistModal.addEventListener('show.bs.modal', function (event) {
  		var button = event.relatedTarget
  		var recipient = button.getAttribute('data-bs-whatever')
  		var modalTitle = receiveRegistModal.querySelector('.modal-title')
 	 	var modalBodyInput = receiveRegistModal.querySelector('.modal-body input')
	})
	
	// 입고 수정
	function receiveModifyModal(receiveid, itemid, orderscode, itemname, ordersquantity, receivestate, receivedate, receivequantity, storagecode, lotnumber, membername) {
		console.log('receiveid:', receiveid);
		console.log('itemid:', itemid);
		console.log('orderscode:', orderscode);
		console.log('itemname:', itemname);
		console.log('ordersquantity:', ordersquantity);
		console.log('receivestate:', receivestate);
		console.log('receivedate:', receivedate);
		console.log('receivequantity:', receivequantity);
		console.log('storagecode:', storagecode);
		console.log('lotnumber:', lotnumber);
		console.log('membername:', membername);
		   
		// 가져온 값들을 모달에 설정
		$("#receiveid2").val(receiveid);
		$("#itemid2").val(itemid);
		$("#orderscode2").val(orderscode);
		$("#itemname2").val(itemname);
		$("#ordersquantity2").val(ordersquantity);
		$("#receivestate2").val(receivestate);
		$("#receivedate2").val(receivedate);
		$("#receivequantity2").val(receivequantity);
		$("#storagecode2").val(storagecode);		
		$("#lotnumber2").val(lotnumber);
		$("#membername2").val(membername);
		
        // 입고 수정 모달 띄우기
        $('#receiveModifyModal').modal('show');
    }	
	
	// 입고 상세내역
	function receiveDetailModal(receiveid, itemid, orderscode, itemname, ordersquantity, receivestate, receivedate, receivequantity, storagecode, lotnumber, membername) {
		// 가져온 값들을 모달에 설정
		$("#receiveid3").val(receiveid);
		$("#itemid3").val(itemid);
		$("#orderscode3").val(orderscode);
		$("#itemname3").val(itemname);
		$("#ordersquantity3").val(ordersquantity);
		$("#receivestate3").val(receivestate);
		$("#receivedate3").val(receivedate);
		$("#receivequantity3").val(receivequantity);
		$("#storagecode3").val(storagecode);		
		$("#lotnumber3").val(lotnumber);
		$("#membername3").val(membername);
		
        // 입고 상세내역 모달 띄우기
        $('#receiveDetailModal').modal('show');
    }

    // 입고 등록 완료 시 뜨는 알림창
	var result = "${result}";
	
	if(result == "REGISTOK"){
		Swal.fire({
			  title: "입고 등록 완료",
			  text: "정상적으로 등록되었습니다.",
			  icon: "success"
		});
	}	
	
	// 입고 삭제 (입고상태가 대기일 경우에만 삭제 가능)
    $("td").on("click", "#deleteBtn", function() {
    	
    	Swal.fire({
  		  title: '삭제하시겠습니까?',
  		  text: "",
  		  icon: 'warning',
  		  showCancelButton: true,
  		  confirmButtonColor: '#3085d6',
  		  cancelButtonColor: '#d33',
  		  confirmButtonText: '삭제',
  		  cancelButtonText: '취소'
  		}).then((result) => {
  			if (result.value) {
        	
        	var receiveid = $(this).closest("tr").find("td:first").text(); // 입고id
			console.log(receiveid);
        	
        	// AJAX 요청 수행
        	$.ajax({
           		url : "/material/receiveDelete",
           		type : "POST",
           		data : {
           			receiveid : receiveid
           		},
          		success : function(response) {
              		// 성공적으로 처리된 경우 수행할 코드
              		console.log("삭제 성공");
              		location.reload();
           		},
           		error : function(error) {
              		// 요청 실패 시 수행할 코드
              		console.error("삭제 실패:", error);
           		}
			});
        	
        	} 
   		 })
   		 
     });		
	
    /* 달력 이전날짜 비활성화 */
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];	

	// id="receivedate"
	document.getElementById("receivedate").setAttribute("min", today);
	
    $(document).ready(function() {
    	
    	// 발주 목록 모달
	    $("#orderscode").click(function() {
	        $("#ordersListModal").modal('show');
	   	});
    	
	    $(".orderslist").click(function() {
	        var columns = $(this).find('td');
	        var selectedItemId = $(columns[0]).text(); // 품목ID
	        var selectedOrdersCode = $(columns[1]).text(); // 발주코드
	        var selectedItemName = $(columns[2]).text(); // 품목명
	        var selectedOrdersQuantity = $(columns[3]).text(); // 발주수량      
	        $('#itemid').val(selectedItemId);
	        $('#orderscode').val(selectedOrdersCode);
	        $('#itemname').val(selectedItemName);
	        $('#ordersquantity').val(selectedOrdersQuantity);
	        $('#ordersListModal').modal('hide');
	    });
	    
	    // 창고 목록 모달
	    $("#storagecode").click(function() {
	        $("#storageListModal").modal('show');
	   	});
    	
	    $(".storagelist").click(function() {
	        var columns = $(this).find('td');
	        var selectedStorageCode = $(columns[1]).text(); // 창고코드
	        var selectedStorageName = $(columns[2]).text(); // 창고명        
	        $('#storagecode').val(selectedStorageCode);
	        $('#storageListModal').modal('hide');
	    });
	    
    });
</script>	

<%@ include file="../include/footer.jsp" %>