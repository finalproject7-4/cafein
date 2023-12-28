<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>

<form method="post">
<!-- 검색 폼 -->
<div class="col-12" style="margin-top: 20px;">
	<div class="bg-light rounded h-100 p-4">
		<h6 class="mb-4">출하 일자 조회</h6>

			수주 코드: <input type="text" name="itemname" class="m-2">


			<!-- 달력 -->

			출하 일자 : <input type="text" class="m-2" id="datepicker1"
				name="startDate"> ~ <input type="text" class="m-2"
				id="datepicker2" name="endDate">
			<!-- 달력 -->
			<!-- Date: <input type="text" id="datepicker3" name="startDate">
~  <input type="text" id="datepicker4" name="endDate"> -->
			<button type="submit" class="btn btn-dark m-2">조회</button>

	</div>
</div>


<!-- 출하 조회 -->
<div class="col-12" style="margin-top: 20px;">
	<div class="bg-light rounded h-100 p-4">
		<h6 class="mb-4">출하 관리</h6>

		<div class="btn-group" role="group">
			<form role="form">
				<input type="hidden" name="state" value="대기">
				<button type="button" class="btn btn-outline-secondary"
					id="beforepro">대기</button>
			</form>
			<form role="form1">
				<input type="hidden" name="state" value="생산중">
				<button type="button" class="btn btn-outline-secondary" id="ingpro">진행</button>
			</form>
			<form role="form2">
				<input type="hidden" name="state" value="완료">
				<button type="button" class="btn btn-outline-secondary"
					id="completpro">완료</button>
			</form>
		</div>
		<span id="buttonset1"><button type="button" class="btn btn-dark m-2" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">신규 등록</button>
			<button type="button" class="btn btn-dark m-2">수정</button>
			<button type="button" class="btn btn-dark m-2">삭제</button></span>
				<div class="table-responsive">
		<div class="table-responsive" style="text-align: center;">
			<table class="table">
				<thead>
					<tr>
						<th scope="col">No.</th>
						<th scope="col">출하일</th>
						<th scope="col">출하코드</th>
						<th scope="col">작업지시코드</th>
						<th scope="col">제품명</th>
						<th scope="col">납품처</th>
						<th scope="col">출하량</th>
						<th scope="col">출하상태</th>
						<th scope="col">담당자</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach items="${AllSHList}" var="sh">
						<tr>
							<td>${sh.shipid }</td>
							<td><fmt:formatDate value="${sh.shipdate }"
									pattern="yyyy-MM-dd" /></td>
							<td>${sh.shipcode }</td>
							<td>${sh.workcode }</td>
							<td>${sh.itemname }</td>
							<td>${sh.clientcode}</td>
							<td>${sh.shipcount }</td>
							<td>${sh.shipsts }</td>
							<td>${sh.membercode }</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>


<!-- 출하 등록 모달 -->
<div class="modal fade" id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">출하 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form>
					<div class="mb-3">
						<label for="recipient-name" class="col-form-label"><b>출하상태</b></label>
						<select class="form-select" id="floatingSelect"
							aria-label="Floating label select example">
							<optgroup label="출하상태">
								<option value="1">대기</option>
								<option value="2">진행</option>
								<option value="3">완료</option>
								<option value="4">취소</option>
							</optgroup>
						</select>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<b>작업지시코드</b><input id="client" class="form-control"
								id="floatingInput" placeholder="납품처">
						</div>
						<div class="col">
							<b>납품처</b><input id="client" class="form-control"
								id="floatingInput" placeholder="납품처">
						</div>
						<div class="col">
							<b>품명</b><input id="items" class="form-control"
								id="floatingInput" placeholder="품명">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>출하량</b><input type="number" class="form-control"
							id="floatingInput" placeholder="숫자만 입력하세요">
					</div>
					<div class="row">
						<div class="col">
							<b>출하일자</b><input id="startdate" type="text" class="form-control"
								id="floatingInput" placeholder="출하일자(클릭)">
						</div>
						<div class="col">
							<b>완납예정일</b><input type="date" id="date" class="form-control"
								id="floatingInput" placeholder="완납예정일">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>담당자</b><input class="form-control" id="floatingInput">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-primary">저장</button>
			</div>
		</div>
	</div>
</div>
<!-- 출하 등록 모달-->

	</div>
</div>
</form>

  <!-- 모달 js&jq -->
   <script>
   /*달력 이전날짜 비활성화*/
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
	
	//id="date"
	document.getElementById("date").setAttribute("min", today);
	
	// class="date"인 모든 요소에 날짜 비활성화
	document.querySelectorAll('.date').forEach(function(input) {
	  input.setAttribute('min', today);
	});
	   
   
    var exampleModal = document.getElementById('exampleModal')
    exampleModal.addEventListener('show.bs.modal', function (event) {
      var button = event.relatedTarget
      var recipient = button.getAttribute('data-bs-whatever')
      var modalTitle = exampleModal.querySelector('.modal-title')
      var modalBodyInput = exampleModal.querySelector('.modal-body input')
    })
    
    $(document).ready(function() {
    	// 납품처 모달
	    $("#client").click(function() {
	        $("#clientModal").modal('show');
	   	});
    	
	    $(".clientset").click(function() {
	        var columns = $(this).find('td');
	        var selectedClientName = $(columns[1]).text(); // 납품처명
	        var selectedClientCode = $(columns[2]).text(); // 납품처코드
	        $('#client').val(selectedClientName);
	        $('#clientModal').modal('hide');
	    });
	    
	 	// 납품처 조회 모달
	    $(".clientSearch").click(function() {
	        $("#clientSM").modal('show');
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
	    
	 // 품목 조회 모달
	    $(".itemSearch").click(function() {
	        $("#itemSM").modal('show');
	   	});
	 
	 $('#todaypo').click(function(){
            var today = new Date();
            // 날짜를 YYYY-MM-DD 형식으로 포맷팅
            var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
            $('#todaypo').val(formattedDate);
        });
	 
    });
    </script>


<%@ include file="../include/footer.jsp"%>