<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 발주 등록 모달창 -->
<div class="modal fade" id="registModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">발주 등록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
			</div>
				
			<form role="form" action="/information/itemRegist" method="post">
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<b>공급처 코드</b><input id="clientcode" name="clientcode" class="form-control" id="floatingInput">
					</div>
					<div class="col">
						<b>품목 코드</b><input id="itemcode" name="itemcode" class="form-control" id="floatingInput">
					</div>
				</div><br>
				<div class="row">
					<div class="col">
						<b>발주일자</b><input type="text" name="ordersdate" id="todaypo" class="form-control" placeholder="발주일자(클릭)">
					</div>
					<div class="col">
						<b>납기일자</b><input type="date" name="deliverydate" id="deliverydate" class="form-control" id="floatingInput" placeholder="납기일자">
					</div>
				</div><br>					
				<div class="row">
					<div class="col">
						<b>수량</b><input type="number" name="ordersquantity" class="form-control" id="floatingInput">
					</div>
					<div class="col">
						<b>단가(원)</b><input id="itemprice" name="itemprice" class="form-control" id="floatingInput">
					</div>
				</div>
			</div>
					
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				<input type="submit" class="btn btn-primary" value="등록">
			</div>
			</form>
			
		</div>
	</div>
</div>
	
<script>
	
</script>