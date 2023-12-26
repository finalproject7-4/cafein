<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp"%>

<h1>수주등록</h1>

<form role="form" method="post"> 
<div class="col-sm-12 col-xl-6">
<div class="bg-light rounded h-100 p-4">

<!-- 납품처/코드 -->
<div class="form-floating mb-3">
<input name="clientid" type="text" class="form-control" id="clientid" placeholder="납품처/코드(클릭)" autocomplete="off" >
<label for="floatingInput">납품처/코드</label>
</div>

품목명/코드
<div class="form-floating mb-3">
<input name="itemid" type="text" class="form-control" id="itemid" placeholder="Password">
<label for="floatingPassword">품목명/코드</label>
</div>

수주상태
<select name="postate" class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
<optgroup label="수주상태">
<option value="1">대기</option>
<option value="2">진행</option>
<option value="3">완료</option>
<option value="4">취소</option>
</optgroup>
</select>

수량
<div class="form-floating mb-3">
<input name="pocnt" type="number" class="form-control" id="pocnt" placeholder="숫자만 입력하세요">
</div>

<div class="row">
<div class="col">
수주일자
<input name="ordersdate" id="todaypo" autocomplete="off" type="text" class="form-control" placeholder="수주일자(클릭)">
</div>

<div class="col">
완납예정일
<input name="ordersduedate" type="date" id="date" class="form-control" placeholder="완납예정일">
</div>
</div>
<br>

담당자
<div class="form-floating mb-3">
<input name="membercode" type="text" class="form-control" id="membercode" placeholder="담당자" autocomplete="off">
</div>

<div class="modal-footer">
<button type="button" class="btn btn-secondary" onclick="location.href='/sales/POList';">취소</button>
<button type="submit" class="btn btn-primary">등록</button>
</div>
</div>
</div>
</form>



<!-- 수주등록 - 납품처 모달 -->
<div class="modal fade" id="clientModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">납품처</h5>
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
									<th scope="col">납품처명</th>
									<th scope="col">납품처코드</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${cliPick}" var="cp">
									<tr class="clientset">
										<td>${cp.poid }</td>
										<td>${cp.clientname }</td>
										<td>${cp.clientcode }</td>
									</tr>
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

<!-- 수주등록 - 품목 모달 -->
<div class="modal fade" id="itemModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">품목</h5>
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
									<th scope="col">품명</th>
									<th scope="col">품목코드</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${cliPick}" var="cp">
									<tr class="itemset">
										<td>${cp.poid }</td>
										<td>${cp.itemname }</td>
										<td>${cp.itemcode }</td>
									</tr>
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
$(document).ready(function() {
	//납품처 모달
	$("#clientid").click(function() {
	    $("#clientModal").modal('show');
		});
	
	$(".clientset").click(function() {
	    var columns = $(this).find('td');
	    var selectedClientName = $(columns[1]).text(); // 납품처명
	    var selectedClientCode = $(columns[2]).text(); // 납품처코드
	    $('#client').val(selectedClientName);
	    $('#clientModal').modal('hide');
	});
	
	// 품목 모달    	
    $("#itemid").click(function() {
        $("#itemModal").modal('show');
   	});
    
    $(".itemset").click(function() {
        var columns = $(this).find('td');
        var selectedItemName = $(columns[1]).text(); // 품명
        var selectedItemCode = $(columns[2]).text(); // 품목코드
        $('#items').val(selectedItemName);
        $('#itemModal').modal('hide');
    });
    
    $('#todaypo').click(function(){
        var today = new Date();
        // 날짜를 YYYY-MM-DD 형식으로 포맷팅
        var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
        $('#todaypo').val(formattedDate);
    });
    
    /*달력 이전날짜 비활성화*/
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
	
	//id="date"
	document.getElementById("date").setAttribute("min", today);

	});
</script>


<%@ include file="../include/footer.jsp"%>