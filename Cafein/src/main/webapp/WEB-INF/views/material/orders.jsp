<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    
<%@ include file="../include/header.jsp" %>

<div class="col-12">

	<!-- 발주 조회 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<form name="search" action="" method="get">
		<select name="option">
			<option value="">선택</option>
			<option value="clientname">거래처명</option>
			<option value="itemname">품명</option>
		</select>
		<input type="text" name="search">
		<span style="margin-left: 15%;">
			발주일자 <input type="text" class="m-2" id="datepicker1" name="startDate"> ~ <input type="text" class="m-2" id="datepicker2" name="endDate">			
		</span>
		<span style="margin-left: 14%;">
			<button type="button" class="btn btn-sm btn-dark m-2">조회</button>
		</span>	
		</form>
	</div>
	<!-- 발주 조회 -->

	<!-- 발주 목록 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<span class="mb-4">총 ${fn:length(ordersList)} 건</span>
		<span style="margin-left: 81%;">
			<button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">등록</button>
			<button type="button" class="btn btn-sm btn-dark m-1">수정</button>
			<button type="button" class="btn btn-sm btn-dark m-1">삭제</button>
		</span>
		
		<div class="table-responsive">
			<table class="table" style="margin-top: 10px;">
				<thead>
					<tr>
						<th scope="col">
							<input type="checkbox" id="delete-list-all" name="delete-list" data-group="delete-list">
						</th>					
						<th scope="col">번호</th>
						<th scope="col">발주코드</th>
						<th scope="col">품목코드</th>
						<th scope="col">품명</th>
						<th scope="col">거래처명</th>
						<th scope="col">수량</th>
						<th scope="col">발주금액</th>
						<th scope="col">발주일자</th>
						<th scope="col">납기일자</th>
						<th scope="col">담당자명</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="ordersList" items="${ordersList }">
					<tr>
						<td>
							<input type="checkbox" id="delete-list-all" name="delete-list" data-group="delete-list">
						</td>					
						<td>${ordersList.ordersid }</td>
						<td>${ordersList.orderscode }</td>
						<td>${ordersList.itemcode }</td>
						<td>${ordersList.itemname }</td>
						<td></td>
						<td>${ordersList.ordersquantity }</td>
						<td></td>
						<td>
							<fmt:formatDate value="${ordersList.ordersdate }" dateStyle="short" pattern="yyyy-MM-dd"/>
						</td>
						<td>
							<fmt:formatDate value="${ordersList.deliverydate }" dateStyle="short" pattern="yyyy-MM-dd"/>
						</td>
						<td>${ordersList.membercode }</td> <!-- session 값 사용하여 저장 -->
					</tr>
				</c:forEach>	
				</tbody>
			</table>
		</div>
	</div>
	<!-- 발주 목록 -->
	
	<!-- 발주 등록 모달 -->
	<jsp:include page="ordersRegist.jsp"/>
	
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
                                 <c:forEach var="itemList" items="${itemList }">
                                    <tr class="clientset">
                                    	<td>${itemList.itemid }</td> 
                                    	<td>${itemList.clientname }</td> 
                                    	<td>${itemList.clientcode }</td>
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
	var exampleModal = document.getElementById('exampleModal')
	exampleModal.addEventListener('show.bs.modal', function (event) {
  		var button = event.relatedTarget
  		var recipient = button.getAttribute('data-bs-whatever')
  		var modalTitle = exampleModal.querySelector('.modal-title')
 	 	var modalBodyInput = exampleModal.querySelector('.modal-body input')
	})
	
	// 체크박스 전체 선택
	var selectAllCheckbox = document.getElementById("delete-list-all");
	var checkboxes = document.querySelectorAll('[data-group="delete-list"]');
	selectAllCheckbox.addEventListener("change", function () {
    	checkboxes.forEach(function (checkbox) {
        	checkbox.checked = selectAllCheckbox.checked;
    	});
	});
	
	checkboxes.forEach(function (checkbox) {
    	checkbox.addEventListener("change", function () {
        	if (!this.checked) {
            	selectAllCheckbox.checked = false;
        	} else {
            	// 모든 체크박스가 선택되었는지 확인
            	var allChecked = true;
            	checkboxes.forEach(function (c) {
                	if (!c.checked) {
                    	allChecked = false;
                	}
            	});
            	selectAllCheckbox.checked = allChecked;
        	}
    	});
	});
	
    $(document).ready(function() {
	    // 공급처 모달
	    $("#clientcode").click(function() {
	        $("#clientModal").modal('show');
	   	});
    	
	    $(".clientset").click(function() {
	        var columns = $(this).find('td');
	        var selectedClientName = $(columns[1]).text(); // 공급처명
	        var selectedClientCode = $(columns[2]).text(); // 공급처코드
	        $('#clientcode').val(selectedClientCode);
	        $('#clientModal').modal('hide');
	    });	

		// 품목 모달    	
    	$("#items").click(function() {
        	$("#itemModal").modal('show');
   		});
    
    	$(".itemset").click(function() {
        	var columns = $(this).find('td');
        	var selectedItemName = $(columns[1]).text(); // 품명
        	var selectedItemCode = $(columns[2]).text(); // 품목코드
        	$('#items').val(selectedItemName);
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