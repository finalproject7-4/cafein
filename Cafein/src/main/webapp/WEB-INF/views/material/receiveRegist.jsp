<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- SweetAlert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>

<!-- 입고 등록 모달창 -->
<div class="modal fade" id="receiveRegistModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">입고 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
			</div>
				
			<form action="receiveRegist" method="post">
			<input type="hidden" name="itemid" id="itemid">
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<label for="orderscode" class="col-form-label"><b>발주코드</b></label>
						<input name="orderscode" id="orderscode" class="form-control mb-2" readonly>
					</div>
				</div>
				<div class="row">	
					<div class="col">
						<label for="itemname" class="col-form-label"><b>품명</b></label>
						<input id="itemname" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="ordersquantity" class="col-form-label"><b>발주수량</b></label>
						<input id="ordersquantity" class="form-control mb-2" min="0" readonly>
					</div>
				</div>
				<div class="mb-2">
					<label for="receivestate" class="col-form-label"><b>입고상태</b></label>
					<select class="form-select mb-2" id="floatingSelect" name="receivestate"
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
						<input type="date" name="receivedate" id="receivedate" class="form-control mb-2" placeholder="납기일자" required>
					</div>
					<div class="col">
						<label for="receivequantity" class="col-form-label"><b>입고수량</b></label>
						<input type="number" name="receivequantity" id="receivequantity" class="form-control mb-2" min="0" required>
					</div>
				</div>				
				<div class="row">
					<div class="col">
						<label for="storagecode" class="col-form-label"><b>창고코드</b></label>
						<input type="text" name="storagecode" id="storagecode" class="form-control mb-2" required>
					</div>
					<div class="col">
						<label for="membercode" class="col-form-label"><b>담당자 (사원번호)</b></label>
						<input type="text" name="membercode" value="${membercode}" id="membercode" class="form-control mb-2" required>
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
        	Swal.fire({
        		icon: "error",
        		text: "입고수량은 발주수량을 초과할 수 없습니다.",
        	});
            $(this).val(oCount); // rCount로 값을 변경
        }
    });
});
</script>