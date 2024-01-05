<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 출하 수정 모달 -->
<div class="modal fade" id="modifyModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">출하 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			
			<form role="form" action="/sales/modifySH" method="post">
			<input type="hidden" id="shipid2" name="shipid">
			<div class="modal-body">
				
					<div class="mb-3">
						<label for="recipient-name" class="col-form-label"><b>출하상태</b></label>
						<select class="form-select" id="floatingSelect" name="shipsts"
							aria-label="Floating label select example">
							<optgroup label="출하상태">
								<option value="접수">접수</option>
								<option value="진행">진행</option>
								<option value="완료">완료</option>
							</optgroup>
						</select>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<b>작업지시코드</b><input id="workcode1" name="workcode" class="form-control"
								id="floatingInput" placeholder="작업지시코드">
						</div>
						<div class="col">
							<b>납품처</b><input id="clientname1" name="clientname" class="form-control"
								id="floatingInput" placeholder="납품처">
						</div>
						<div class="col">
							<b>품명</b><input id="itemname1" name="itemname" class="form-control"
								id="floatingInput" placeholder="품명">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>지시량</b><input type="number" id="pocnt1" name="pocnt" class="form-control" placeholder="숫자만 입력하세요">
					</div>
					<div class="row">
					<div class="col">
						<b>재고량 확인</b><input type="number" id="stockquantity1" name="stockquantity" class="form-control" placeholder="숫자만 입력하세요">
					</div>
					<div class="col">
							<b>LOT번호</b><input id="lotnumber1" name="lotnumber" class="form-control"
								id="floatingInput" placeholder="LOT번호">
						</div>
						</div>
						<br>
					<div class="row">
						<div class="col">
							<b>작업지시일자</b><input name="shipdate1" id="shipdate11" type="date" class="form-control"  placeholder="작업지시일자">
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<b>수정일자</b><input name="shipdate2" id="shipdate2" type="date" class="form-control"  placeholder="작업지시일자">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>담당자</b><input class="form-control" id="floatingInput" name="membercode">
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">취소</button>
				<input type="submit" class="btn btn-primary" value="저장">
			</div>
			</form>
		</div>
	</div>
</div>