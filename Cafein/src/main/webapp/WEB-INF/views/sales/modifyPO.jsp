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
				
				<form role="form" action="/sales/modifyPO" method="post">
				
				<input type="hidden" name="poid" value="${po.poid}">
				
				<div class="modal-body">
				납품처/코드
				<input autocomplete="off" id="clientid2" name="clientname" class="form-control mb-3" type="text"  readonly="readonly">
				
				품목명/코드
				<input autocomplete="off" id="itemid2" name="itemname" class="form-control mb-3" type="text"  >
					<div class="mb-3">
						<label for="itemtype" class="col-form-label"><b>수주상태</b></label>
						<select class="form-select" id="floatingSelect2" name="postate">
						    <optgroup label="수주상태">
						        <option value="대기">대기</option>
						        <option value="진행">진행</option>
						        <option value="완료">완료</option>
						        <option value="취소">취소</option>
						    </optgroup>
						</select>
					</div>	
					수량
					<input autocomplete="off" id="pocnt2" name="pocnt" class="form-control mb-3" type="number" value="">
					
					<div class="row">
					<div class="col">
					수정일자
					<input name="updatedate" id="todaypo2"  type="text" class="form-control" value="" placeholder="수정일자(클릭)">
					</div>
					
					<div class="col">
					완납예정일
					<input name="ordersduedate" type="date" id="date2" class="form-control" value="">
					</div>
					</div>
					<br>
					
					담당자
					<input autocomplete="off" id="membercode2" name="membercode" class="form-control mb-3" type="number" value="">
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" id="ModifyBtn">저장</button>
				</div>
				</form>
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
							<c:set var="counter" value="1" />
								<c:forEach items="${iList}" var="item">
									<tr class="itemset">
										<td>${counter }</td>
										<td>${item.itemname }</td>
										<td>${item.itemcode }</td>
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
$(document).ready(function() {
	

    // 수정된 값을 서버로 전송
    $("#ModifyBtn").click(function() {
        // 가져온 값들을 변수에 저장
        var modifiedPOid = $("#poid ").val();
        var modifiedClientName = $("#clientid2").val();
        var modifiedItemName = $("#itemid2").val();
        var modifiedPostate = $("#floatingSelect2").val();
        var modifiedPocnt = $("#pocnt2").val();
        var modifiedUpdateDate = formatDate($("#todaypo2").val());
        var modifiedOrdersDueDate = formatDate($("#date2").val());
        var modifiedMemberCode = $("#membercode2").val();
    
        // Ajax를 사용하여 서버로 수정된 값 전송
        $.ajax({
            type: "POST",
            url: "/sales/modifyPO",
            data: {
                POID: modifiedPOid,
                clientname: modifiedClientName,
                itemname: modifiedItemName,
                postate: modifiedPostate,
                pocnt: modifiedPocnt,
                updatedate: modifiedUpdateDate,
                ordersduedate: modifiedOrdersDueDate,
                membercode: modifiedMemberCode
            },
            success: function(response) {
                console.log("Modification success:", response);
                $("#modifyModal").modal('hide');
            },
            error: function(error) {
                console.error("Error during modification:", error);
            }
        });
    });
	
	$(".itemset").click(function() {
	    var itemid = $(this).find('td:first-child').text();
	    $("#itemid2").val(itemid);
	});
	
	// 클릭한 행의 정보를 가져와서 clientid에 입력
   $(".itemset").click(function() {
    var clientInfo = $(this).find('td:eq(1)').text(); //itemname
    $("#itemid2").val(clientInfo);
	});
	 
	// 품목 모달    	
    $("#itemid2").click(function() {
    	$("#itemModal").modal('show');
    });
    
    $(".itemset").click(function() {
        var columns = $(this).find('td');
        var selectedItemName = $(columns[1]).text(); // 품명
        $('#items').val(selectedItemName);
        $('#itemModal').modal('hide');
    });
    
    $('#todaypo2').click(function(){
        var today = new Date();
        // 날짜를 YYYY-MM-DD 형식으로 포맷팅
        var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
        $('#todaypo2').val(formattedDate);
    });
	
	/*달력 이전||+5일 이후 날짜 비활성화*/
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
	
	var fiveDaysLater = new Date(now_utc + 5 * 24 * 60 * 60 * 1000 - timeOff).toISOString().split("T")[0];
	
	//id="date"
	var dateInput = document.getElementById("date2");
	dateInput.setAttribute("min", today);
	dateInput.setAttribute("max", fiveDaysLater);
	
	});
</script>


