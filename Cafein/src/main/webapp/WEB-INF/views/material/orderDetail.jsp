<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 발주 수정 모달창 -->
<div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">발주 상세내역</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
			</div>
				
			<input type="hidden" id="ordersid3" name="ordersid">
			<div class="modal-body">
				<div class="mb-3">
					<label for="orderstate" class="col-form-label"><b>발주상태</b></label>
					<input type="text" name="orderstate" id="orderstate3" class="form-control mb-2" readonly>
				</div>				
				<div class="row">
					<div class="col">
						<label for="ordersdate" class="col-form-label"><b>발주일자</b></label>
						<input type="text" name="ordersdate" id="todayod3" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="deliverydate" class="col-form-label"><b>납기일자</b></label>
						<input type="date" name="deliverydate" value="" id="deliverydate3" class="form-control mb-2" placeholder="납기일자" readonly>
					</div>
				</div>				
				<div class="row">
					<div class="col">
						<label for="clientname" class="col-form-label"><b>공급처</b></label>
						<input id="clientname3" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="itemname" class="col-form-label"><b>품명</b></label>
						<input id="itemname3" class="form-control mb-2" readonly>
						<input type="hidden" name="itemcode" id="itemcode3" class="form-control mb-2">
					</div>
				</div>
				<div class="row">
					<div class="col">
						<label for="ordersquantity" class="col-form-label"><b>수량</b></label>
						<input type="number" name="ordersquantity" value="" id="ordersquantity3" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="itemprice" class="col-form-label"><b>단가(원)</b></label>
						<input type="text" name="itemprice" id="itemprice3" class="form-control mb-2" readonly>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<label for="orderprice" class="col-form-label"><b>발주금액(원)</b></label>
						<input type="text" name="orderprice" id="orderprice3" class="form-control mb-2" readonly>
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