<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<!-- 품목 수정 모달 시작 -->
	<div class="modal fade" id="itemModifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">품목 수정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<form action="itemModify" method="post">
				<input type="hidden" id="itemid" name="itemid">
				<div class="modal-body">
					<label for="itemtype" class="col-form-label"><b>품목유형</b></label>
					<input autocomplete="off" id="itemtype2" name="itemtype" class="form-control mb-3" type="text" readonly="readonly">
					<div class="row">
						<div class="col">
							<label for="itemname" class="col-form-label"><b>품명</b></label>
							<input type="text" id="itemname2" name="itemname" class="form-control mb-3" value="">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label for="clientname" class="col-form-label"><b>공급처</b></label>
							<input autocomplete="off" id="clientname2" name="clientname" class="form-control mb-3" readonly="readonly">
						</div>
						<div class="col">
							<label for="origin" class="col-form-label"><b>원산지</b></label>
							<input autocomplete="off" id="origin2" name="origin" class="form-control mb-3" readonly="readonly">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label for="itemweight" class="col-form-label"><b>중량(g)</b></label>
							<input type="text" id="itemweight2" name="itemweight" class="form-control mb-3" value="">
						</div>
						<div class="col">
							<label for="itemprice" class="col-form-label"><b>단가(원)</b></label>
							<input type="text" id="itemprice2" name="itemprice" class="form-control mb-3" value="">
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
	<!-- 품목 수정 모달 끝 -->