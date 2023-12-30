<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 발주 등록 모달창 -->
<div class="modal fade" id="orderRegistModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">발주 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
			</div>
				
			<form action="orderRegist" method="post">
			<div class="modal-body">
				<div class="mb-3">
					<label for="orderstate" class="col-form-label"><b>발주상태</b></label>
					<select class="form-select mb-2" id="floatingSelect" name="orderstate"
							aria-label="Floating label select example">
						<optgroup label="발주상태">
							<option value="대기">대기</option>
							<option value="진행">진행</option>
							<option value="완료">완료</option>
							<option value="취소">취소</option>
						</optgroup>
					</select>
				</div>			
				<div class="row">
					<div class="col">
						<label for="itemname" class="col-form-label"><b>발주일자</b></label>
						<input type="text" name="ordersdate" id="todaypo" class="form-control mb-2" placeholder="발주일자(클릭)">
					</div>
					<div class="col">
						<label for="itemname" class="col-form-label"><b>납기일자</b></label>
						<input type="date" name="deliverydate" id="deliverydate" class="form-control mb-2" placeholder="납기일자">
					</div>
				</div>				
				<div class="row">
					<div class="col">
						<label for="clientname" class="col-form-label"><b>공급처</b></label>
						<input id="clientname" class="form-control mb-2">
					</div>
					<div class="col">
						<label for="itemname" class="col-form-label"><b>품명</b></label>
						<input id="itemname" class="form-control mb-2">
						<input type="hidden" id="itemcode" name="itemcode" class="form-control mb-2">
					</div>
				</div>
				<div class="row">
					<div class="col">
						<label for="ordersquantity" class="col-form-label"><b>수량</b></label>
						<input type="number" name="ordersquantity" class="form-control mb-2">
					</div>
					<div class="col">
						<label for="itemprice" class="col-form-label"><b>단가(원)</b></label>
						<input id="itemprice" class="form-control mb-2">
					</div>
				</div>
				<div class="row">
					<div class="col">
						<label for="orderprice" class="col-form-label"><b>발주금액</b></label>
						<input type="text" id="orderprice" class="form-control mb-2">
					</div>
				</div>
				<div class="row">
					<div class="col">
						<label for="membercode" class="col-form-label"><b>담당자</b></label>
						<input type="text" name="membercode" id="orderprice" class="form-control mb-2">
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
	
</script>