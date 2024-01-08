<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 입고 등록 모달창 -->
<div class="modal fade" id="releaseDetailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">출고 상세내역</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
			</div>
				
			<input type="hidden" id="releaseid3">
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<label for="releasecode" class="col-form-label"><b>출고코드</b></label>
						<input name="releasecode" id="releasecode3" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="producecode" class="col-form-label"><b>생산지시코드</b></label>
						<input name="producecode" id="producecode3" class="form-control mb-2" readonly>
					</div>
				</div>
				<div class="row">	
					<div class="col">
						<label for="itemname" class="col-form-label"><b>품명</b></label>
						<input id="itemname3" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="stockquantity" class="col-form-label"><b>재고수량</b></label>
						<input id="stockquantity3" class="form-control mb-2" min="0" readonly>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<label for="releasedate" class="col-form-label"><b>출고일자</b></label>
						<input type="date" name="releasedate" id="releasedate3" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="releasequantity" class="col-form-label"><b>출고수량</b></label>
						<input type="number" name="releasequantity" id="releasequantity3" class="form-control mb-2" min="0" readonly>
					</div>
				</div>				
				<div class="row">
					<div class="col">
						<label for="membername" class="col-form-label"><b>담당자</b></label>
						<input type="text" name="membername" id="membername3" class="form-control mb-2" readonly>
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