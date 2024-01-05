<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 입고 등록 모달창 -->
<div class="modal fade" id="releaseModifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">입고 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
			</div>
				
			<form action="receiveModify" method="post">
			<input type="hidden" name="receiveid2" id="receiveid">
			<input type="hidden" id="itemid2">
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<label for="orderscode" class="col-form-label"><b>발주코드</b></label>
						<input name="orderscode" id="orderscode2" class="form-control mb-2" readonly>
					</div>
				</div>
				<div class="row">	
					<div class="col">
						<label for="itemname" class="col-form-label"><b>품명</b></label>
						<input id="itemname2" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="ordersquantity" class="col-form-label"><b>발주수량</b></label>
						<input id="ordersquantity2" class="form-control mb-2" min="0" readonly>
					</div>
				</div>
				<div class="mb-2">
					<label for="receivestate" class="col-form-label"><b>입고상태</b></label>
					<select class="form-select mb-2" id="receivestate2" name="receivestate"
							aria-label="Floating label select example">
						<optgroup label="입고상태">
							<option value="대기">대기</option>
							<option value="완료">완료</option>
						</optgroup>
					</select>
				</div>			
				<div class="row">
					<div class="col">
						<label for="receivedate" class="col-form-label"><b>입고일자</b></label>
						<input type="date" name="receivedate" id="receivedate2" class="form-control mb-2" placeholder="납기일자">
					</div>
					<div class="col">
						<label for="receivequantity" class="col-form-label"><b>입고수량</b></label>
						<input type="number" name="receivequantity" id="receivequantity2" class="form-control mb-2" min="0">
					</div>
				</div>				
				<div class="row">
					<div class="col">
						<label for="storagecode" class="col-form-label"><b>창고코드</b></label>
						<input type="text" name="storagecode" id="storagecode2" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="lotnumber" class="col-form-label"><b>LOT번호</b></label>
						<input type="text" name="lotnumber" id="lotnumber2" class="form-control mb-2" readonly>
					</div>
				</div>										
				<div class="row">
					<div class="col">
						<label for="membercode" class="col-form-label"><b>담당자</b></label>
						<input type="text" name="membercode" id="membercode2" class="form-control mb-2" readonly>
					</div>
				</div>										
			</div>
					
			<div class="modal-footer">
				<button type="button" class="btn btn-sm btn-secondary" data-bs-dismiss="modal">취소</button>
				<input type="submit" class="btn btn-sm btn-primary" value="등록">
			</div>
			</form>
			
		</div>
	</div>
</div>
	
<script>
$(document).ready(function() {
    // 입고수량 입력값이 발주수량을 초과하지 못하도록 제한
    $("#receivequantity").on("input", function() {
        var oCount = parseInt($("#ordersquantity").val());
        var rCount = parseInt($(this).val());
        
        if (rCount > oCount) {
            alert("입고수량은 발주수량을 초과할 수 없습니다.");
            $(this).val(oCount); // rCount로 값을 변경
        }
    });
});
</script>