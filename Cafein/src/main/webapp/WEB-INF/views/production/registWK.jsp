<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 작업지시 등록 모달 -->
<div class="modal fade" id="registModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">작업지시 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			
			<form role="form" action="registWK" method="post">
			
			<div class="modal-body">
			
					<div class="mb-3">
						<label for="recipient-name" class="col-form-label"><b>작업지시상태</b></label>
						<select class="form-select" id="floatingSelect" name="worksts"
							aria-label="Floating label select example">
							<optgroup label="작업지시상태">
								<option value="접수">접수</option>
								<option value="진행">진행</option>
								<option value="완료">완료</option>
							</optgroup>
						</select>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<b>수주코드</b><input id="pocode" name="pocode" class="form-control" placeholder="클릭하세요">
						</div>
						<div class="col">
							<b>납품처</b><input id="clientcode" name="clientname" class="form-control" placeholder="납품처">
						</div>
						<div class="col">
							<b>품명</b><input id="itemcode" name="itemname" class="form-control" placeholder="품명">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>지시량</b><input type="number" id="workcount" name="pocnt" class="form-control" placeholder="숫자만 입력하세요">
					</div>
					<div class="row">
						<div class="col">
							<b>작업지시일자</b><input name="workdate1" id="workdate1" type="date" class="form-control"  placeholder="작업지시일자">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>담당자</b><input class="form-control" name="membercode" id="membercode">
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

<!-- 작업지시 등록 모달-->

<!-- 작업지시-수주불러오기 -->
<div class="modal fade" id="pocodeModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">수주목록</h5>
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
									<th scope="col">수주코드</th>
									<th scope="col">납품처</th>
									<th scope="col">품명</th>
									<th scope="col">수주량</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="counter" value="1" />
								<c:forEach items="${pcList}" var="pc" varStatus="status">
									<tr class="pocodeset">
										<td>${counter }</td>
										<td>${pc.pocode }</td>
										<td>${pc.clientname }</td>
										<td>${pc.itemname }</td>
										<td>${pc.pocnt }</td>
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

<!-- 작업지시-멤버불러오기 -->
<div class="modal fade" id="mccodeModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">직원 목록</h5>
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
									<th scope="col">직원 이름</th>
									<th scope="col">직원 코드</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="counter" value="1" />
								<c:forEach items="${mcList}" var="mc" varStatus="status">
									<tr class="mccodeset">
										<td>${counter }</td>
										<td>${mc.membername }</td>
										<td>${mc.membercode }</td>
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
	$(document).ready(
			function() {

				// 수주 불러오기
				$(document).on('click', '#pocode', function() {
					$('#pocodeModal').modal('show');
				});

				// 선택한 행 불러오기
				$('.pocodeset').click(function() {
					// 선택한 행의 데이터를 가져오기
					var pocode = $(this).find('td:eq(1)').text(); // 수주코드
					var clientcode = $(this).find('td:eq(2)').text(); // 거래처
					var itemcode = $(this).find('td:eq(3)').text(); // 품명
					var workcount = $(this).find('td:eq(4)').text(); // 

					// 첫 번째 모달의 각 입력 필드에 데이터를 설정
					$('#pocode').val(pocode);
					$('#clientcode').val(clientcode);
					$('#itemcode').val(itemcode);
					$('#workcount').val(workcount);

					$('#pocodeModal').modal('hide');
				});
				
				// 직원 불러오기
				$(document).on('click', '#membercode', function() {
					$('#mccodeModal').modal('show');
				});

				// 선택한 행 불러오기
				$('.mccodeset').click(function() {
					// 선택한 행의 데이터를 가져오기
					var membername = $(this).find('td:eq(1)').text(); // 직원이름
					var membercode = $(this).find('td:eq(2)').text(); // 직원코드

					// 첫 번째 모달의 각 입력 필드에 데이터를 설정
					$('#membername').val(membername);
					$('#membercode').val(membercode);

					$('#mccodeModal').modal('hide');
				});


			    $('#workdate1').click(function(){
			        var today = new Date();
			        // 날짜를 YYYY-MM-DD 형식으로 포맷팅
			        var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
			        $('#workdate1').val(formattedDate);
			    });
			    
			    /*달력 이전날짜 비활성화*/
				var now_utc = Date.now(); // 현재 날짜를 밀리초로
				var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
				var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
				
				//id="date"
				document.getElementById("date").setAttribute("min", today);

			});
</script>