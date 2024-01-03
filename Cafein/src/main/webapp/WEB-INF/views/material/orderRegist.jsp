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
							<option value="완료">완료</option>
						</optgroup>
					</select>
				</div>			
				<div class="row">
					<div class="col">
						<label for="ordersdate" class="col-form-label"><b>발주일자</b></label>
						<input type="text" name="ordersdate" id="todayod" class="form-control mb-2" placeholder="발주일자(클릭)">
					</div>
					<div class="col">
						<label for="deliverydate" class="col-form-label"><b>납기일자</b></label>
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
						<input type="hidden" name="itemcode" id="itemcode" class="form-control mb-2">
					</div>
				</div>
				<div class="row">
					<div class="col">
						<label for="ordersquantity" class="col-form-label"><b>수량</b></label>
						<input type="number" name="ordersquantity" id="ordersquantity" class="form-control mb-2" min="0">
					</div>
					<div class="col">
						<label for="itemprice" class="col-form-label"><b>단가(원)</b></label>
						<input type="text" name="itemprice" id="itemprice" class="form-control mb-2">
					</div>
				</div>
				<div class="row">
					<div class="col">
						<label for="orderprice" class="col-form-label"><b>발주금액</b></label>
						<input type="text" name="orderprice" id="orderprice" class="form-control mb-2" readonly>
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
// ordersquantity와 itemprice 값을 곱하여 orderprice에 설정하는 함수
function calculateOrderprice() {
    // ordersquantity와 itemprice 입력란의 값을 읽어옴
    var ordersquantity = parseFloat(document.getElementById("ordersquantity").value);
    var itemprice = parseFloat(document.getElementById("itemprice").value);
    
    // 입력값이 유효한 숫자인지 확인
    if (!isNaN(ordersquantity) && !isNaN(itemprice)) {
        // poCount와 materialPrice를 곱함
        var orderprice = ordersquantity * itemprice;
        console.log(orderprice);
        
        // 곱한 결과를 orderprice 입력란에 설정
        document.getElementById("orderprice").value = orderprice;
    } else {
        // 입력값이 숫자가 아닌 경우 또는 둘 중 하나라도 숫자가 아닌 경우
        document.getElementById("orderprice").value = "";
    }
}

// ordersquantity와 itemprice 입력란 값이 변경될 때마다 자동으로 발생하는 이벤트 리스너 등록
document.getElementById("ordersquantity").addEventListener("input", calculateOrderprice);
document.getElementById("itemprice").addEventListener("input", calculateOrderprice);	
</script>