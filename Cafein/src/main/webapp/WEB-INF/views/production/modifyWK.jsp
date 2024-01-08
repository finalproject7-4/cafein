<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 작업지시 수정 모달창 -->
	<div class="modal fade" id="modifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">작업지시 수정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<form role="form" action="/production/modifyWK" method="post">
				<input type="hidden" id="workid2" name="workid">
			
			<div class="modal-body">
			
					<div class="mb-3">
						<label for="workstate" class="col-form-label"><b>작업지시상태</b></label>
						<select class="form-select" id="worksts2" name="worksts"
							aria-label="Floating label select example">
							<optgroup label="작업지시상태">
								<option value="접수">대기</option>
								<option value="진행">진행</option>
								<option value="완료">완료</option>
							</optgroup>
						</select>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<b>수주코드</b><input id="pocode2" name="pocode" class="form-control" readonly="readonly">
						</div>
						<div class="col">
							<b>납품처</b><input id="clientcode2" name="clientname" class="form-control" placeholder="납품처" readonly="readonly">
						</div>
						<div class="col">
							<b>품명</b><input id="itemcode2" name="itemname" class="form-control" placeholder="품명" readonly="readonly">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>지시량</b><input type="number" id="pocnt2" name="pocnt" class="form-control" readonly="readonly">
					</div>
					<div class="row">
						<div class="col">
							<b>작업지시일자</b><input name="workdate1" id="workdate11" type="date" class="form-control"  placeholder="작업지시일자">
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<b>수정일자</b><input name="workupdate" id="workupdate2" type="date" class="form-control"  placeholder="수정일자">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>담당자</b><input class="form-control" name="membercode" id="membercode2">
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">취소</button>
				<input type="submit" class="btn btn-primary" id="ModifyBtn" value="저장">
			</div>
		</form>
			</div>
		</div>
	</div>

