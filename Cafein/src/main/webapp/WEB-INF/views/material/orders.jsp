<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    
<%@ include file="../include/header.jsp" %>
<!-- SweetAlert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>

<!-- 발주관리 페이지 시작 -->
<div class="col-12">

	<!-- 발주 조회 시작 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
    <form name="search" action="/material/orders">
       <div class="d-flex align-items-center align-items-stretch">
            <div class="me-2">
                <select name="option" class="form-select" style="width: 120px;">
                    <option value="">선택</option>
                    <option value="clientname">거래처명</option>
                    <option value="itemname">품명</option>
                </select>
            </div>
            <div class="me-2">
                <input type="text" name="keyword" class="form-control" style="width: 180px;" placeholder="검색어를 입력하세요">
            </div>
        <div class="row align-items-stretch">
		  <div class="form-group col">
    		<div class="input-group">
    		<label for="orderDate" style="margin: 5px 5px 0 10px;">발주일자</label>
        		<input type="date" name="orderStartDate" class="form-control" style="border-radius: 5px;"> 
        		<label>&nbsp;~&nbsp;</label>
        		<input type="date" name="orderEndDate" class="form-control" style="border-radius: 5px;">
    		</div>
		  </div> 
		  <div class="form-group col">
    		<div class="input-group">
    		<label for="deliveryDate" style="margin: 5px 5px 0 0;">납기일자</label>
        		<input type="date" name="deliveryStartDate" class="form-control" style="border-radius: 5px;"> 
        		<label>&nbsp;~&nbsp;</label>
        		<input type="date" name="deliveryEndDate" class="form-control" style="border-radius: 5px;">
    		</div>
		  </div>
		  <div class="col-1 align-items-stretch">
			<input type="submit" class="btn btn-sm btn-dark" value="조회">
		  </div>
		</div>
       </div>
	</form>
	</div>
	<!-- 발주 조회 끝 -->

	<!-- 발주 목록 시작 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<span class="mb-4">총 ${fn:length(ordersList)} 건</span>
		
		<form action="orderListExcelDownload" method="GET">		
		<span style="margin-left: 990px;">
			<button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#orderRegistModal" data-bs-whatever="@getbootstrap">등록</button>
			<input type="submit" value="엑셀 파일 다운로드" class="btn btn-sm btn-success">
			<input type="hidden" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#orderModifyModal" data-bs-whatever="@getbootstrap" value="수정">
			<input type="hidden" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#orderDetailModal" data-bs-whatever="@getbootstrap" value="상세내역">
		</span>
		</form>
		
		<div class="table-responsive">
			<table class="table" style="margin-top: 10px;">
				<thead>
					<tr style="text-align: center;">
						<th scope="col" style="display: none;"></th>
						<th scope="col">번호</th>
						<th scope="col">발주코드</th>
						<th scope="col">품목코드</th>
						<th scope="col">품명</th>
						<th scope="col">거래처</th>
						<th scope="col">수량</th>
						<th scope="col">발주금액(원)</th>
						<th scope="col">발주일자</th>
						<th scope="col">납기일자</th>
						<th scope="col">담당자</th>
						<th scope="col">발주상태</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="ol" items="${ordersList }" varStatus="status">
					<tr style="text-align: center;">
						<td style="display: none;">${ol.ordersid }</td>
						<td>
							<c:out value="${pageVO.totalCount - ((pageVO.cri.page - 1) * pageVO.cri.pageSize + status.index)}"/>
						</td>					
						<td>${ol.orderscode }</td>
						<td>${ol.itemcode }</td>
						<td>${ol.itemname }</td>
						<td>${ol.clientname }</td>
						<td>${ol.ordersquantity }</td>
						<td>
							<fmt:formatNumber value="${ol.orderprice }" pattern="#,###"/>
						</td>
						<td>
							<fmt:formatDate value="${ol.ordersdate }" dateStyle="short" pattern="yyyy-MM-dd"/>
						</td>
						<td>
							<fmt:formatDate value="${ol.deliverydate }" dateStyle="short" pattern="yyyy-MM-dd"/>
						</td>
						<td>${ol.membername }</td> <!-- session 값 사용하여 저장 -->
						<c:choose>
							<c:when test="${ol.orderstate == '완료'}">
								<td><b>${ol.orderstate }</b></td>
								<td>
									<button type="button" class="btn btn-sm btn-outline-dark m-1" 
										onclick="orderDetailModal('${ol.ordersid }', '${ol.orderstate }', '${ol.ordersdate }', '${ol.deliverydate }', '${ol.clientname }', '${ol.itemname }', '${ol.ordersquantity }', '${ol.itemprice }', '${ol.orderprice }', '${ol.membername }')">상세내역
									</button>
								</td>
							</c:when>
							<c:otherwise>
								<td>${ol.orderstate }</td>
								<td>
									<button type="button" class="btn btn-sm btn-outline-dark m-1" 
										onclick="orderModifyModal('${ol.ordersid }', '${ol.orderstate }', '${ol.ordersdate }', '${ol.deliverydate }', '${ol.clientname }', '${ol.itemname }', '${ol.ordersquantity }', '${ol.itemprice }', '${ol.orderprice }', '${ol.membername }')">수정
									</button>
									<input type="button" class="btn btn-sm btn-outline-dark m-1" value="삭제" id="deleteBtn">
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
								
									let option = "${param.option}";
									let keyword = "${param.keyword}";
									let orderStartDate = "${param.orderStartDate}";
									let orderEndDate = "${param.orderEndDate}";
									let deliveryStartDate = "${param.deliveryStartDate}";
									let deliveryEndDate = "${param.deliveryEndDate}";
									
			                		url = "/material/orders?page=" + prevPage;
			                
			                		if (option && keyword) {
			                    		url += "&option=" + encodeURIComponent(option) + "&keyword=" + encodeURIComponent(keyword);
			                		}

			                		if (orderStartDate && orderEndDate) {
			                			url += "&orderStartDate=" + encodeURIComponent(orderStartDate) + "&orderEndDate=" + encodeURIComponent(orderEndDate)
			                		}
			                		
			                		if (deliveryStartDate && deliveryEndDate) {
			                			url += "&deliveryStartDate=" + encodeURIComponent(deliveryStartDate) + "&deliveryEndDate=" + encodeURIComponent(deliveryEndDate)
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
					
								let option = "${param.option}";
								let keyword = "${param.keyword}";
								let orderStartDate = "${param.orderStartDate}";
								let orderEndDate = "${param.orderEndDate}";
								let deliveryStartDate = "${param.deliveryStartDate}";
								let deliveryEndDate = "${param.deliveryEndDate}";
								
	                			url = "/material/orders?page=" + pageValue;
                
	                			if (option && keyword) {
	                    			url += "&option=" + encodeURIComponent(option) + "&keyword=" + encodeURIComponent(keyword);
	                			}

		                		if (orderStartDate && orderEndDate) {
		                			url += "&orderStartDate=" + encodeURIComponent(orderStartDate) + "&orderEndDate=" + encodeURIComponent(orderEndDate)
		                		}
		                		
		                		if (deliveryStartDate && deliveryEndDate) {
		                			url += "&deliveryStartDate=" + encodeURIComponent(deliveryStartDate) + "&deliveryEndDate=" + encodeURIComponent(deliveryEndDate)
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
				
									let option = "${param.option}";
									let keyword = "${param.keyword}";
									let orderStartDate = "${param.orderStartDate}";
									let orderEndDate = "${param.orderEndDate}";
									let deliveryStartDate = "${param.deliveryStartDate}";
									let deliveryEndDate = "${param.deliveryEndDate}";
									
               					url = "/material/orders?page=" + nextPage;
            
               					if (option && keyword) {
                   					url += "&option=" + encodeURIComponent(option) + "&keyword=" + encodeURIComponent(keyword);
               					}

		                		if (orderStartDate && orderEndDate) {
		                			url += "&orderStartDate=" + encodeURIComponent(orderStartDate) + "&orderEndDate=" + encodeURIComponent(orderEndDate)
		                		}
		                		
		                		if (deliveryStartDate && deliveryEndDate) {
		                			url += "&deliveryStartDate=" + encodeURIComponent(deliveryStartDate) + "&deliveryEndDate=" + encodeURIComponent(deliveryEndDate)
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
	<!-- 발주 목록 끝 -->
	
	<!-- 발주 등록 모달 -->
	<jsp:include page="orderRegist.jsp"/>
	
	<!-- 발주 수정 모달 -->
	<jsp:include page="orderModify.jsp"/>
	
	<!-- 발주 상세내역 모달 -->
	<jsp:include page="orderDetail.jsp"/>
	
	<!-- 공급처 모달 시작 -->
    <div class="modal fade" id="clientModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">공급처</h5>
                	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <div class="modal-body">
                	<div class="col-12">
                    	<div class="bg-light rounded h-100 p-4">
                        	<table class="table">
                            	<thead>
                                	<tr>
                                       <th scope="col">번호</th>
                                       <th scope="col">유형</th>
                                       <th scope="col">공급처명</th>
                                       <th scope="col">공급처코드</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                 <c:set var="counter" value="1" />
                                  <c:forEach var="clientList" items="${clientList }" varStatus="status">
                                   <c:if test="${clientList.categoryofclient eq '공급'}">
                                    <tr class="clientset">
                                    	<td>${counter}</td>
                                    	<td>${clientList.typeofclient }</td>
                                    	<td>${clientList.clientname }</td> 
                                    	<td>${clientList.clientcode }</td>
                                    </tr>
                                    <c:set var="counter" value="${counter + 1}" />
                                   </c:if>	
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
    <!-- 공급처 모달 끝 -->	
    
	<!-- 품목 모달 시작 -->
    <div class="modal fade" id="itemModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
 				<div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLabel">품목</h5>
                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<div class="modal-body">
					<div class="col-12">
                        <div class="bg-light rounded h-100 p-3">
							<table class="table">
								<thead>
									<tr style="text-align: center;">
										<th scope="col">번호</th>
										<th scope="col" style="display: none;">품목코드</th>
										<th scope="col">유형</th>
										<th scope="col">품명</th>
										<th scope="col">단가(원)</th>
                                    </tr>
								</thead>
								<tbody>
								  <c:set var="counter" value="1" />
								  <c:forEach var="itemList" items="${itemList}" varStatus="status">
                                    <tr class="itemset" style="text-align: center;">
                                      <td>${counter }</td> 
                                      <td style="display: none;">${itemList.itemcode }</td> 
                                      <td>${itemList.itemtype }</td> 
                                      <td>${itemList.itemname }</td> 
                                      <td>${itemList.itemprice }</td> 
                                    </tr>
                                  <c:set var="counter" value="${counter + 1}" />  
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
	<!-- 품목 모달 끝 -->

</div>
<!-- 발주관리 페이지 끝 -->	
	       	
<script>
	var orderRegistModal = document.getElementById('orderRegistModal')
	orderRegistModal.addEventListener('show.bs.modal', function (event) {
  		var button = event.relatedTarget
  		var recipient = button.getAttribute('data-bs-whatever')
  		var modalTitle = orderRegistModal.querySelector('.modal-title')
 	 	var modalBodyInput = orderRegistModal.querySelector('.modal-body input')
	})
	
	// 발주 수정
	function orderModifyModal(ordersid, orderstate, ordersdate, deliverydate, clientname, itemname, ordersquantity, itemprice, orderprice, membername) {
		console.log('ordersid:', ordersid);
		console.log('orderstate:', orderstate);
		console.log('ordersdate:', ordersdate);
		console.log('deliverydate:', deliverydate);
		console.log('clientname:', clientname);
		console.log('itemname:', itemname);
		console.log('ordersquantity:', ordersquantity);
		console.log('itemprice:', itemprice);
		console.log('orderprice:', orderprice);
		console.log('membername:', membername);
		   
		// 가져온 값들을 모달에 설정
		$("#ordersid").val(ordersid);
		$("#orderstate2").val(orderstate);
		$("#todayod2").val(ordersdate);
		$("#deliverydate2").val(deliverydate);
		$("#clientname2").val(clientname);
		$("#itemname2").val(itemname);
		$("#ordersquantity2").val(ordersquantity);
		$("#itemprice2").val(itemprice);		
		$("#orderprice2").val(orderprice);
		$("#membername2").val(membername);
		
        // 발주 수정 모달 띄우기
        $('#orderModifyModal').modal('show');
    }
	
	// 발주 상세내역
	function orderDetailModal(ordersid, orderstate, ordersdate, deliverydate, clientname, itemname, ordersquantity, itemprice, orderprice, membername) {
		// 가져온 값들을 모달에 설정
		$("#ordersid3").val(ordersid);
		$("#orderstate3").val(orderstate);
		$("#todayod3").val(ordersdate);
		$("#deliverydate3").val(deliverydate);
		$("#clientname3").val(clientname);
		$("#itemname3").val(itemname);
		$("#ordersquantity3").val(ordersquantity);
		$("#itemprice3").val(itemprice);		
		$("#orderprice3").val(orderprice);
		$("#membername3").val(membername);
		
        // 발주 상세내역 모달 띄우기
        $('#orderDetailModal').modal('show');
    }
	
	// 발주 삭제 (발주상태가 대기일 경우에만 삭제 가능)
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
    			  
        		var ordersid = $(this).closest("tr").find("td:first").text(); // 발주id
				console.log(ordersid);
        	
        		// AJAX 요청 수행
        		$.ajax({
           			url : "/material/orderDelete",
           			type : "POST",
           			data : {
        	   			ordersid : ordersid
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
	
    $(document).ready(function() {
	    // 공급처 모달
	    $("#clientname").click(function() {
	        $("#clientModal").modal('show');
	   	});
    	
	    $(".clientset").click(function() {
	        var columns = $(this).find('td');
	        var selectedClientName = $(columns[2]).text(); // 공급처명
	        var selectedClientCode = $(columns[3]).text(); // 공급처코드
	        $('#clientname').val(selectedClientName);
	        $('#clientModal').modal('hide');
	    });	

		// 품목 모달
    	$("#itemname").click(function() {
        	$("#itemModal").modal('show');
   		});
    
    	$(".itemset").click(function() {
        	var columns = $(this).find('td');
        	var selectedItemCode = $(columns[1]).text(); // 품목코드
        	var selectedItemName = $(columns[3]).text(); // 품명
        	var selectedItemPrice = $(columns[4]).text(); // 품목가격
        	$('#itemcode').val(selectedItemCode);
        	$('#itemname').val(selectedItemName);
        	$('#itemprice').val(selectedItemPrice);
        	$('#itemModal').modal('hide');
    	});
    
    	/* 달력 이전날짜 비활성화 */
		var now_utc = Date.now(); // 현재 날짜를 밀리초로
		var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
		var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
	
		// id="deliverydate"
		document.getElementById("deliverydate").setAttribute("min", today);
	
		// class="date"인 모든 요소에 날짜 비활성화
		document.querySelectorAll('.deliverydate').forEach(function(input) {
	  		input.setAttribute('min', today);
		});

		// 현재 날짜에서 3일을 더한 날짜를 계산
		var threeDaysLater = new Date(now_utc - timeOff);
		threeDaysLater.setDate(threeDaysLater.getDate() + 3);

		// ISO 형식의 문자열로 변환하고 날짜 부분만 가져오기
		var minDate = threeDaysLater.toISOString().split("T")[0];

		// id가 'deliverydate'인 HTML 요소에 min 속성 설정
		document.getElementById("deliverydate").setAttribute("min", minDate);

		// 클래스가 'deliverydate'인 모든 HTML 요소에 min 속성 설정
		document.querySelectorAll('.deliverydate').forEach(
			function(input) {
				input.setAttribute('min', minDate);
			});

		$('#todayod').click(function() {
				var today = new Date();

				// 날짜를 YYYY-MM-DD 형식으로 포맷팅
				var formattedDate = today.getFullYear() + '-'
									+ ('0' + (today.getMonth() + 1)).slice(-2)
									+ '-' + ('0' + today.getDate()).slice(-2);
				$('#todayod').val(formattedDate);
		});

	});
</script>	

<%@ include file="../include/footer.jsp" %>