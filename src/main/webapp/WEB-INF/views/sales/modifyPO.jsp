<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 수주 수정 모달창 -->
	<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">수주 수정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<form role="form" action="/sales/registPO" method="post">

				<input type="hidden" name="clientid" id="clientidd">
				<input type="hidden" name="itemid" id="itemidd">

				<div class="modal-body">
				납품처/코드
				<input id="clientid" name="clientname" class="form-control mb-3" type="text"  >
				
				품목명/코드
				<input id="itemid" name="itemname" class="form-control mb-3" type="text"  >
					<div class="mb-3">
						<label for="itemtype" class="col-form-label"><b>수주상태</b></label>
						<select class="form-select" id="floatingSelect" name="postate">
						    <optgroup label="수주상태">
						        <option value="대기">대기</option>
						        <option value="진행">진행</option>
						        <option value="완료">완료</option>
						        <option value="취소">취소</option>
						    </optgroup>
						</select>
					</div>	
					수량
					<input id="pocnt" name="pocnt" class="form-control mb-3" type="number" value="">
					
					<div class="row">
					<div class="col">
					수주일자
					<input name="ordersdate" id="todaypo"  type="text" class="form-control" value="">
					</div>
					
					<div class="col">
					완납예정일
					<input name="ordersduedate" type="date" id="date" class="form-control" value="">
					</div>
					</div>
					<br>
					
					담당자
					<input id="membercode" name="membercode" class="form-control mb-3" type="number" value="">
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" id="itemRegistBtn">등록</button>
				</div>
				</form>
			</div>
		</div>
	</div>
	
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
								<c:forEach items="${cliList}" var="cli">
									<tr class="clientset">
										<td>${cli.clientid }</td>
										<td>${cli.clientname }</td>
										<td>${cli.clientcode }</td>
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
								<c:forEach items="${iList}" var="item">
									<tr class="itemset">
										<td>${item.itemid }</td>
										<td>${item.itemname }</td>
										<td>${item.itemcode }</td>
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
	
	$(".clientset").click(function() {
	    console.log("클릭 이벤트 발생");
	    var clientid = $(this).find('td:first-child').text();
	    console.log("clientid:", clientid);
	    $("#clientidd").val(clientid);
	});
	$(".itemset").click(function() {
	    console.log("클릭 이벤트 발생");
	    var itemid = $(this).find('td:first-child').text();
	    console.log("itemid:", itemid);
	    $("#itemidd").val(itemid);
	});
	
	// 클릭한 행의 정보를 가져와서 clientid에 입력
   $(".clientset").click(function() {
    var clientInfo = $(this).find('td:eq(1)').text(); //clientname
    $("#clientid").val(clientInfo);
	});
   $(".itemset").click(function() {
    var clientInfo = $(this).find('td:eq(1)').text(); //itemname
    $("#itemid").val(clientInfo);
	});
	 
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
