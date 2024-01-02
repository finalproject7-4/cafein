<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- BOM등록 모달창 시작-->
<div class="modal fade" id="packageModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel1">포장완료 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="updateRoastedbeanList" method="post">
						<div class="row">
							<div class="col">
								<label for="produceid" class="col-form-label">생산ID</label> 
								<input id="produceidPack" name="produceid" class="form-control" readonly="readonly">
							</div>
							<div class="col"  style="display: none;">
								<label for="itemid" class="col-form-label">아이템ID</label> 
								<input id="itemidPack" name="itemid" class="form-control" readonly="readonly">
							</div>
							<div class="col">
								<label for="itemname" class="col-form-label">제품명</label> 
								<input id="itemnamePack" name="itemname" class="form-control" readonly="readonly">
							</div>
							<div class="col" style="display: none;">
								<label for="state" class="col-form-label">생산상태</label> 
								<input id="statePack" name="state" value="완료" class="form-control" readonly="readonly">
							</div>
							<div class="col" style="display: none;">
								<label for="weight" class="col-form-label">포장량</label> 
								<input id="packagevolPack" name="weight" class="form-control">
							</div>
						</div>
							<div class="row">
							<div class="col">
								<label for="producedate" class="col-form-label">생산일</label> 
								<input type="text" name="producedate" class="form-control" id="producedatePack" min="150" max="250" step="10" readonly="readonly">
							</div>
							<div class="col">
								<label for="produceline" class="col-form-label">생산라인</label> 
								<input type="text" name="produceline" class="form-control" id="producelinePack" min="15" max="30" readonly="readonly">
							</div>
							<div class="col">
								<label for="producetime" class="col-form-label">생산시간</label> 
								<input type="text" name="producetime" class="form-control" id="producetimePack" min="15" max="30" readonly="readonly">
							</div>
							</div>
							<div class="row">
							<div class="col">
								<label for="note" class="col-form-label">특이사항</label>
								<input name="note" class="form-control" id="notePack" style="color:lightgray;" placeholder="특이사항 있을 경우 입력">
							</div>
							</div>
							<div class="row">
							<div class="col">
								<label for="memebercode" class="col-form-label">담당자(사원번호)</label>
								<input name="membercode" class="form-control" id="membercode" required="required">
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
		</div>
<!-- BOM등록 모달창 끝-->