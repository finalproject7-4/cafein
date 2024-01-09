<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 입고 등록 모달창 -->
<div class="modal fade" id="releaseModifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			
			<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">출고 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
			</div>
				
			<form action="releaseModify" method="post">
			<input type="hidden" name="releaseid" id="releaseid2">
			<input type="hidden" name="stockid" id="stockid2">
			<input type="hidden" name="itemid" id="itemid2">
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<label for="releasecode2" class="col-form-label"><b>출고코드</b></label>
						<input id="releasecode2" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="producecode2" class="col-form-label"><b>생산지시코드</b></label>
						<input id="producecode2" class="form-control mb-2" readonly>
					</div>
				</div>
				<div class="row">	
					<div class="col">
						<label for="itemname2" class="col-form-label"><b>품명</b></label>
						<input id="itemname2" class="form-control mb-2" readonly>
					</div>
					<div class="col">
						<label for="stockquantity2" class="col-form-label"><b>재고수량</b></label>
						<input id="stockquantity2" class="form-control mb-2" min="0" readonly>
					</div>
				</div>
				<div class="mb-2">
					<label for="receivestate" class="col-form-label"><b>출고상태</b></label>
					<select class="form-select mb-2" id="releasestate2" name="releasestate"
							aria-label="Floating label select example">
						<optgroup label="출고상태">
							<option value="완료">완료</option>
						</optgroup>
					</select>
				</div>			
				<div class="row">
					<div class="col">
						<label for="releasedate2" class="col-form-label"><b>출고일자</b></label>
						<input type="date" id="releasedate2" class="form-control mb-2" placeholder="출고일자" readonly>
					</div>
					<div class="col">
						<label for="releasequantity2" class="col-form-label"><b>출고수량</b></label>
						<input type="number" name="releasequantity" id="releasequantity2" class="form-control mb-2" min="0" readonly>
					</div>
				</div>				
				<div class="row">
					<div class="col">
						<label for="membername2" class="col-form-label"><b>담당자</b></label>
						<input type="text" id="membername2" class="form-control mb-2" readonly>
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