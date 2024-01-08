<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 입고 등록 모달창 -->
<div class="modal fade" id="receiveDetailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">입고 상세내역</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
			</div>
				
			<input type="hidden" id="receiveid3">
			<input type="hidden" id="itemid3">
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<label for="orderscode" class="col-form-label"><b>발주코드</b></label>
						<input name="orderscode" id="orderscode3" class="form-control mb-2" readonly>
					</div>
				</div>
				<div class="row">	
					<div class="col">
						<label for="itemname" class="col-form-label"><b>품명</b></label>
						<input id="itemname3" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="ordersquantity" class="col-form-label"><b>발주수량</b></label>
						<input id="ordersquantity3" class="form-control mb-2" min="0" readonly>
					</div>
				</div>
				<div class="mb-2">
					<label for="receivestate" class="col-form-label"><b>입고상태</b></label>
					<input type="text" name="receivestate" id="receivestate3" class="form-control mb-2" readonly>
				</div>			
				<div class="row">
					<div class="col">
						<label for="receivedate" class="col-form-label"><b>입고일자</b></label>
						<input type="date" name="receivedate" id="receivedate3" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="receivequantity" class="col-form-label"><b>입고수량</b></label>
						<input type="number" name="receivequantity" id="receivequantity3" class="form-control mb-2" min="0" readonly>
					</div>
				</div>				
				<div class="row">
					<div class="col">
						<label for="storagecode" class="col-form-label"><b>창고코드</b></label>
						<input type="text" name="storagecode" id="storagecode3" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="lotnumber" class="col-form-label"><b>LOT번호</b></label>
						<input type="text" name="lotnumber" id="lotnumber3" class="form-control mb-2" readonly>
					</div>
				</div>										
				<div class="row">
					<div class="col">
						<label for="membercode" class="col-form-label"><b>담당자</b></label>
						<input type="text" name="membercode" id="membername3" class="form-control mb-2" readonly>
					</div>
				</div>										
			</div>
					
			<div class="modal-footer">
			</div>
			
		</div>
	</div>
</div>
	
<script>
</script>