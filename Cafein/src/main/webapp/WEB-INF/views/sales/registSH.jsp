<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 출하 등록 모달 -->
<div class="modal fade" id="registModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">출하 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			
			<form role="form" action="registSH" method="post">
			
			<div class="modal-body">
				
					<div class="mb-3">
						<label for="recipient-name" class="col-form-label"><b>출하상태</b></label>
						<select class="form-select" id="floatingSelect" name="shipsts"
							aria-label="Floating label select example">
							<optgroup label="출하상태">
								<option value="접수">접수</option>
								<option value="진행">진행</option>
								<option value="완료">완료</option>
								<option value="취소">취소</option>
							</optgroup>
						</select>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<b>작업지시코드</b><input id="workcode" name="workcode" class="form-control"
								id="floatingInput" placeholder="작업지시코드">
						</div>
						<div class="col">
							<b>납품처</b><input id="clientname" name="clientname" class="form-control"
								id="floatingInput" placeholder="납품처">
						</div>
						<div class="col">
							<b>품명</b><input id="itemname" name="itemname" class="form-control"
								id="floatingInput" placeholder="품명">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>지시량</b><input type="number" id="pocnt" name="pocnt" class="form-control" placeholder="숫자만 입력하세요">
					</div>
					<div class="row">
					<div class="col">
						<b>재고량 확인</b><input type="number" id="stockquantity" name="stockquantity" class="form-control" placeholder="숫자만 입력하세요">
					</div>
						</div>
						<br>
					<div class="row">
						<div class="col">
							<b>작업지시일자</b><input name="shipdate1" id="shipdate1" type="date" class="form-control"  placeholder="작업지시일자">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>담당자</b><input class="form-control" id="floatingInput" name="membercode">
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">취소</button>
				<input type="submit" class="btn btn-primary" value="등록">
			</div>
			</form>
		</div>
	</div>
</div>

<!-- 출하 등록 모달-->

<!-- 출하등록 - 작업지시 모달 -->
<div class="modal fade" id="workcodeModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">작업지시목록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="col-12">
					<div class="bg-light rounded h-100 p-4">
						<table class="table">
							<thead>
								<tr>
									<th scope="col">No.</th>
									<th scope="col">작업지시코드</th>
									<th scope="col">작업지시일자</th>
									<th scope="col">납품처</th>
									<th scope="col">제품명</th>
									<th scope="col">지시량</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="counter" value="1" />
								<c:forEach items="${wcList}" var="wc" varStatus="status">
									<tr class="workcodeset">
										<td>${counter }</td>
										<td>${wc.workcode }</td>
										<td>${wc.workdate1 }</td>
										<td>${wc.clientname }</td>
										<td>${wc.itemname }</td>
										<td>${wc.pocnt }</td>
									</tr>
									<c:set var="counter" value="${counter+1 }" />
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="modal-footer"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 출하등록 - 재고량 모달 -->
<div class="modal fade" id="stockModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">재고량 목록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="col-12">
					<div class="bg-light rounded h-100 p-4">
						<table class="table">
							<thead>
								<tr>
									<th scope="col">No.</th>
									<th scope="col">제품명</th>
									<th scope="col">재고량</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="counter" value="1" />
								<c:forEach items="${stList}" var="st" varStatus="status">
									<tr class="stockset">
										<td>${counter }</td>
										<td>${st.itemname }</td>
										<td>${st.stockquantity }</td>
									</tr>
									<c:set var="counter" value="${counter+1 }" />
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="modal-footer"></div>
				</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">

	  var pocnt, workcode, clientname, itemname;
	  
	  // 작업지시불러오기
	  $(document).ready(function() {
	
	  $('#workcode').click(function() {
	      $('#workcodeModal').modal('show');
	    });
	  
		// 선택한 행 불러오기
	    $('.workcodeset').click(function() {
	      // 선택한 행의 데이터를 가져오기
	      workcode = $(this).find('td:eq(1)').text();
          clientname = $(this).find('td:eq(3)').text();
          itemname = $(this).find('td:eq(4)').text();
	      pocnt = $(this).find('td:eq(5)').text(); // 전역 변수에 값할당
	      

	      // 첫 번째 모달의 각 입력 필드에 데이터를 설정
	      $('#workcode').val(workcode).prop('readonly', true);
   		  $('#clientname').val(clientname).prop('readonly', true);
    	  $('#itemname').val(itemname).prop('readonly', true);
    	  $('#pocnt').val(pocnt).prop('readonly', true);

	      // 'workcodeModal'을 닫기
	      $('#workcodeModal').modal('hide');
	    });
		
		
		  // 재고량 불러오기
		  $('#stockquantity').click(function() {
		      $('#stockModal').modal('show');
		    });
		  
			// 선택한 행 불러오기
		    $('.stockset').click(function() {
		    	
		      // 선택한 행의 데이터를 가져오기
		      var stockquantity = $(this).find('td:eq(2)').text();

		      // 첫 번째 모달의 각 입력 필드에 데이터를 설정
		      $('#stockquantity').val(stockquantity).prop('readonly', true);

		      if (parseInt(pocnt) > parseInt(stockquantity)) {
		            alert('재고가 부족합니다. 지시량을 다시 확인하세요.');
		            // readonly 속성 해제하고 초기화
		            $('#pocnt').prop('readonly', false).val('');
		            $('#stockquantity').prop('readonly', false).val('');
		            $('#workcode').prop('readonly', false).val('');
		            $('#clientname').prop('readonly', false).val('');
		            $('#itemname').prop('readonly', false).val('');
		        }

		      // 'workcodeModal'을 닫기
		      $('#stockModal').modal('hide');
		    });


	
    
    $('#shipdate1').click(function(){
        var today = new Date();
        // 날짜를 YYYY-MM-DD 형식으로 포맷팅
        var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
        $('#shipdate1').val(formattedDate);
    });
    
    /*달력 이전날짜 비활성화*/
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
	
	//id="date"
	document.getElementById("date").setAttribute("min", today);

	});
</script>