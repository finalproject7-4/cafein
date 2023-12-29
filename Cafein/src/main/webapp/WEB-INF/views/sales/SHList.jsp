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
			<form role="form1">
				<input type="hidden" name="state" value="대기">
				<button type="button" class="btn btn-outline-secondary"
					id="beforepro">대기</button>
			</form>
			<form role="form1">
				<input type="hidden" name="state" value="생산중">
				<button type="button" class="btn btn-outline-secondary" id="ingpro">진행</button>
			</form>
			<form role="form1">
				<input type="hidden" name="state" value="완료">
				<button type="button" class="btn btn-outline-secondary"
					id="completpro">완료</button>
			</form>
		</div>
		<span id="buttonset1"><button type="button" class="btn btn-dark m-2" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">신규 등록</button>
			</span>
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
						<th scope="col">관리</th>
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
							<td>
                           <button type="button" class="btn btn-outline-dark" 
                                   onclick="openModifyModal()">
                                   수정
                           </button>
                           <!-- 버튼 삭제 -->
                           <button type="button" class="btn btn-outline-dark" 
                                   onclick="openDeleteModal()">
                                   삭제
                           </button>
                           </td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
		</div>
	</div>
</div>
</form>

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
							<b>작업지시코드</b><input id="workcode" class="form-control"
								id="floatingInput" placeholder="작업지시코드">
						</div>
						<div class="col">
							<b>납품처</b><input id="clientname" class="form-control"
								id="floatingInput" placeholder="납품처">
						</div>
						<div class="col">
							<b>품명</b><input id="itemname" class="form-control"
								id="floatingInput" placeholder="품명">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>출하량</b><input type="pocnt" class="form-control"
							id="floatingInput" placeholder="숫자만 입력하세요">
					</div>
					<div class="row">
						<div class="col">
							<b>출하일자</b><input id="startdate" type="date" class="form-control"
								id="floatingInput" placeholder="출하일자">
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
									<th scope="col">수주코드</th>
									<th scope="col">납품처</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="counter" value="1" />
								<c:forEach items="${wcList}" var="wc" varStatus="status">
									<tr class="workcodeset">
										<td>${counter }</td>
										<td>${wc.workcode }</td>
										<td>${wc.clientcode }</td>
										<td>${wc.itemname }</td>
										<td>${wc.shipcount }</td>
										<td>${wc.shipdate }</td>
										<td>${wc.membercode }</td>
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

	  // 작업지시불러오기
	  $(document).ready(function() {
	
	  $('#workcode').click(function() {
	      $('#workcodeModal').modal('show');
	    });
	  
		// 선택한 행 불러오기
	    $('.workcodeset').click(function() {
	      // 선택한 행의 데이터를 가져오기
	      var workcode = $(this).find('td:eq(1)').text(); // 작업지시코드
	      var client = $(this).find('td:eq(4)').text(); // 납품처
	      var items = ''; // 여기에 품명을 가져오는 코드 추가
	      

	      // 첫 번째 모달의 각 입력 필드에 데이터를 설정
	      $('#workcode').val(workcode);
	      $('#client').val(client);
	      $('#items').val(items);
	      // (다른 필드에 대한 값을 설정하는 코드를 추가하세요)

	      // 'workcodeModal'을 닫기
	      $('#workcodeModal').modal('hide');
	    });

	
    
    $('#todaypo').click(function(){
        var today = new Date();
        // 날짜를 YYYY-MM-DD 형식으로 포맷팅
        var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
        $('#todaypo').val(formattedDate);
    });
    
    /*달력 이전||+5일 이후 날짜 비활성화*/
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
	
	var fiveDaysLater = new Date(now_utc + 5 * 24 * 60 * 60 * 1000 - timeOff).toISOString().split("T")[0];
	
	//id="date"
	var dateInput = document.getElementById("date");
	dateInput.setAttribute("min", today);
	dateInput.setAttribute("max", fiveDaysLater);

	});
</script>


<%@ include file="../include/footer.jsp"%>