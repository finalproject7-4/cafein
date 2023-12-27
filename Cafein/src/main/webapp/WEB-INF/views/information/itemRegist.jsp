<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 품목 등록 모달창 -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">품목 등록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<form role="form" action="/information/itemRegist" method="post">
				<div class="modal-body">
					<div class="mb-3">
						<label for="itemtype" class="col-form-label"><b>품목유형</b></label>
						<select class="form-select" id="floatingSelect" name="itemtype"
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
							<b>품명</b><input id="itemname" name="itemname" class="form-control" id="floatingInput">
						</div>
					</div><br>
					<div class="row">
						<div class="col">
							<b>공급처 코드</b><input id="clientcode" name="clientcode" class="form-control" id="floatingInput">
						</div>
						<div class="col">
							<b>원산지</b><input id="origin" name="origin" class="form-control" id="floatingInput">
						</div>
					</div><br>
					<div class="row">
						<div class="col">
							<b>중량(g)</b><input id="itemweight" name="itemweight" class="form-control" id="floatingInput">
						</div>
						<div class="col">
							<b>단가(원)</b><input id="itemprice" name="itemprice" class="form-control" id="floatingInput">
						</div>
					</div>
				</div>
					
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" id="itemRegistBtn">등록</button>
				</div>
				</form>
			</div>
		</div>
	</div>
	
<script>
</script>