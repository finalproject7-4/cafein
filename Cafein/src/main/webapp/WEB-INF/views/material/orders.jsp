<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    
<%@ include file="../include/header.jsp" %>

<!-- 발주관리 페이지 시작 -->
<div class="col-12">

	<!-- 발주 조회 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<form name="search" action="orders">
		<select name="option">
			<option value="">선택</option>
			<option value="clientname">거래처명</option>
			<option value="itemname">품명</option>
		</select>
		<input type="text" name="search">
		<span style="margin-left: 2.5%;">
			발주일자 <input type="date" class="m-2" name="orderStartDate"> ~ <input type="date" class="m-2" name="orderEndDate">			
		</span>
		<span style="margin-left: 2.5%;">
			납기일자 <input type="date" class="m-2" name="deliveryStartDate"> ~ <input type="date" class="m-2" name="deliveryEndDate">			
		</span>
		<span style="margin-left: 3.5%;">
			<button type="button" class="btn btn-sm btn-dark m-2">조회</button>
		</span>	
		</form>
	</div>
	<!-- 발주 조회 -->

	<!-- 발주 목록 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<span class="mb-4">총 ${fn:length(ordersList)} 건</span>
		
		<span style="margin-left: 95%;">
			<button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#orderRegistModal" data-bs-whatever="@getbootstrap">등록</button>
		</span>
		
		<div class="table-responsive">
			<table class="table" style="margin-top: 10px;">
				<thead>
					<tr style="text-align: center;">
						<th scope="col">번호</th>
						<th scope="col">발주코드</th>
						<th scope="col">품목코드</th>
						<th scope="col">품명</th>
						<th scope="col">거래처</th>
						<th scope="col">수량</th>
						<th scope="col">발주금액(원)</th>
						<th scope="col">발주일자</th>
						<th scope="col">납기일자</th>
						<th scope="col">담당자명</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="ordersList" items="${ordersList }">
					<tr style="text-align: center;">
						<td>${ordersList.ordersid }</td>
						<td>${ordersList.orderscode }</td>
						<td>${ordersList.itemcode }</td>
						<td>${ordersList.itemname }</td>
						<td>${ordersList.clientname }</td>
						<td>${ordersList.ordersquantity }</td>
						<td>${ordersList.ordersprice }</td>
						<td>
							<fmt:formatDate value="${ordersList.ordersdate }" dateStyle="short" pattern="yyyy-MM-dd"/>
						</td>
						<td>
							<fmt:formatDate value="${ordersList.deliverydate }" dateStyle="short" pattern="yyyy-MM-dd"/>
						</td>
						<td>${ordersList.membername }</td> <!-- session 값 사용하여 저장 -->
						<td>
							<button type="button" class="btn btn-sm btn-outline-dark m-1" data-bs-toggle="modal" data-bs-target="#ordersModifyodifyModal" data-bs-whatever="@getbootstrap" onclick="ordersModifyModal('ordersList')">수정</button>
							<button type="button" class="btn btn-sm btn-outline-dark m-1">삭제</button>
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
// 							$(document).ready(function(){
// 								$('.pageBlockPrev').click(function(e) {
// 									e.preventDefault(); // 기본 이벤트 제거
								
// 					            	let prevPage = $(this).data('page');
								
// 									let option = "${param.option}";
// 									let keyword = "${param.keyword}";

// 			                		url = "/material/orders?page=" + prevPage;
			                
// 			                		if (option && keyword) {
// 			                    		url += "&option=" + encodeURIComponent(option) + "&keyword=" + encodeURIComponent(keyword);
// 			                		}

// 			                		location.href = url;
// 								});
// 							});
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
// 						$(document).ready(function(){
// 							$('.pageBlockNum').click(function(e) {
// 								e.preventDefault(); // 기본 이벤트 제거
					
// 			            		let pageValue = $(this).data('page');
					
// 								let option = "${param.option}";
// 								let keyword = "${param.keyword}";

// 	                			url = "/material/orders?page=" + pageValue;
                
// 	                			if (option && keyword) {
// 	                    			url += "&option=" + encodeURIComponent(option) + "&keyword=" + encodeURIComponent(keyword);
// 	                			}

// 	                			location.href = url;
// 							});
// 						});
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
// 							$(document).ready(function(){
// 								$('.pageBlockNext').click(function(e) {
// 									e.preventDefault(); // 기본 이벤트 제거
				
// 		            				let nextPage = $(this).data('page');
				
// 									let option = "${param.option}";
// 									let keyword = "${param.keyword}";

//                					url = "/material/orders?page=" + nextPage;
            
//                					if (option && keyword) {
//                    					url += "&option=" + encodeURIComponent(option) + "&keyword=" + encodeURIComponent(keyword);
//                					}

//                					location.href = url;
// 								});
// 							});
						</script>
    				</c:if>
    				</li>
					<!-- 버튼 이동에 따른 파라미터 전달 (다음) -->					
			  </ul>
			</nav>
			<!-- 페이지 블럭 생성 -->			
			
		</div>
	</div>
	<!-- 발주 목록 -->
	
	<!-- 발주 등록 모달 -->
	<jsp:include page="orderRegist.jsp"/>
	
	<!-- 발주 수정 모달 -->
	<jsp:include page="orderModify.jsp"/>
	
	<!-- 공급처 모달 -->
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
    <!-- 공급처 모달 -->	
    
	<!-- 품목 모달 -->
    <div class="modal fade" id="itemModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
 				<div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLabel">품목</h5>
                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<div class="modal-body">
					<div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">품목코드</th>
										<th scope="col">품명</th>
										<th scope="col">단가(원)</th>
                                    </tr>
								</thead>
								<tbody>
								  <c:forEach var="itemList" items="${itemList}">
                                    <tr class="itemset">
                                      <td>${itemList.itemid }</td> 
                                      <td>${itemList.itemname }</td> 
                                      <td>${itemList.itemcode }</td> 
                                      <td>${itemList.itemprice }</td> 
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
	<!-- 품목 모달 -->
	       	
<script>
	var orderRegistModal = document.getElementById('orderRegistModal')
	orderRegistModal.addEventListener('show.bs.modal', function (event) {
  		var button = event.relatedTarget
  		var recipient = button.getAttribute('data-bs-whatever')
  		var modalTitle = orderRegistModal.querySelector('.modal-title')
 	 	var modalBodyInput = orderRegistModal.querySelector('.modal-body input')
	})
	
	var modifyModal = document.getElementById('modifyModal')
	modifyModal.addEventListener('show.bs.modal', function (event) {
  		var button = event.relatedTarget
  		var recipient = button.getAttribute('data-bs-whatever')
  		var modalTitle = modifyModal.querySelector('.modal-title')
 	 	var modalBodyInput = modifyModal.querySelector('.modal-body input')
	})
	
	function modifyModal(ordersList) {
        // 모달 띄우기
        $('#modifyModal').modal('show');
    }
	
    $(document).ready(function() {
	    // 공급처 모달
	    $("#clientname").click(function() {
	        $("#clientModal").modal('show');
	   	});
    	
	    $(".clientset").click(function() {
	        var columns = $(this).find('td');
	        var selectedClientName = $(columns[1]).text(); // 공급처명
	        var selectedClientCode = $(columns[2]).text(); // 공급처코드
	        $('#clientname').val(selectedClientName);
	        $('#clientModal').modal('hide');
	    });	

		// 품목 모달
    	$("#itemname").click(function() {
        	$("#itemModal").modal('show');
   		});
    
    	$(".itemset").click(function() {
        	var columns = $(this).find('td');
        	var selectedItemName = $(columns[1]).text(); // 품명
        	var selectedItemCode = $(columns[2]).text(); // 품목코드
        	var selectedItemPrice = $(columns[3]).text(); // 품목가격
        	$('#itemname').val(selectedItemName);
        	$('#itemcode').val(selectedItemCode);
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

		$('#todaypo').click(
			function() {
				var today = new Date();

				// 날짜를 YYYY-MM-DD 형식으로 포맷팅
				var formattedDate = today.getFullYear() + '-'
									+ ('0' + (today.getMonth() + 1)).slice(-2)
									+ '-' + ('0' + today.getDate()).slice(-2);
				$('#todaypo').val(formattedDate);
			});

		});
</script>	
</div>	

<%@ include file="../include/footer.jsp" %>