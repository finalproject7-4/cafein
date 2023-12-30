<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 품목 등록 모달창 -->
	<div class="modal fade" id="itemRegistModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">품목 등록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<form action="itemRegist" method="post">
				<div class="modal-body">
					<div class="mb-3">
						<label for="itemtype" class="col-form-label"><b>품목유형</b></label>
						<select class="form-select mb-3" id="floatingSelect" name="itemtype"
							aria-label="Floating label select example">
							<optgroup label="품목유형">
								<option value="원자재">원자재</option>
								<option value="부자재">부자재</option>
								<option value="완제품">완제품</option>
							</optgroup>
						</select>
					</div>	
					<div class="row">
						<div class="col">
							<label for="itemname" class="col-form-label"><b>품명</b></label>
							<input id="itemname" name="itemname" class="form-control mb-3">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label for="clientname" class="col-form-label"><b>공급처</b></label>
							<input id="clientcode" name="clientcode" class="form-control mb-3">
						</div>
						<div class="col">
							<label for="origin" class="col-form-label"><b>원산지</b></label>
							<input id="origin" name="origin" class="form-control mb-3">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label for="itemweight" class="col-form-label"><b>중량(g)</b></label>
							<input id="itemweight" name="itemweight" class="form-control mb-3">
						</div>
						<div class="col">
							<label for="itemprice" class="col-form-label"><b>단가(원)</b></label>
							<input id="itemprice" name="itemprice" class="form-control mb-3">
						</div>
					</div>
				</div>
					
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<input type="submit" class="btn btn-primary" value="등록">
				</div>
				</form>
			</div>
		</div>
	</div>
	
<script>
</script>