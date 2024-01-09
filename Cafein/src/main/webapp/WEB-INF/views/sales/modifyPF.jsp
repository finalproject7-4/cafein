<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 실적 수정 모달 -->
<div class="modal fade" id="modifyModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">실적 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			
			<form role="form" action="/sales/modifyPF" method="post">
			<input type="hidden" id="workid3" name="workid">
			<div class="modal-body">
					<br>
					<div class="row">
						<div class="col">
							<b>작업지시코드</b><input id="workcode3" name="workcode" class="form-control"
								id="floatingInput" placeholder="작업지시코드" readonly="readonly">
						</div>
						<div class="col">
							<b>납품처</b><input id="clientname3" name="clientname" class="form-control"
								id="floatingInput" placeholder="납품처" readonly="readonly">
						</div>
						<div class="col">
							<b>품명</b><input id="itemname3" name="itemname" class="form-control"
								id="floatingInput" placeholder="품명" readonly="readonly">
						</div>
					</div>
					<br>
					<div class="mb-3">
						<b>지시량</b><input type="number" id="pocnt3" name="pocnt" class="form-control" placeholder="숫자만 입력하세요" readonly="readonly">
					</div>
					<div class="row">
						<div class="col">
							<b>완료일자</b><input name="workdate2" id="workdate23" type="date" class="form-control"  placeholder="작업완료일자" readonly="readonly">
						</div>
					</div>
					<br>
					<div class="row">
						<div class="col">
							<b>반품 사유</b>
						<select class="form-select" id="returnyn" name="returnyn"
							aria-label="Floating label select example">
							<optgroup label="반품여부">
								<option value="반품건있음">제품불량</option>
								<option value="">주문오류</option>
							</optgroup>
						</select>
						</div>
						<div class="col">
							<b>반품수량</b><input name="returncount" id="returncount3" type="number" class="form-control"  placeholder="불량 수량" >
						</div>
						<br>
						<div class=col>
						<b>반품 사유</b>
						<select class="form-select" id="returnreason3" name="returnreason"
							aria-label="Floating label select example">
							<optgroup label="반품사유">
								<option value="제품불량">제품불량</option>
								<option value="주문오류">주문오류</option>
							</optgroup>
						</select>
					</div>	
					</div>
					<br>
					<div class="mb-3">
						<b>담당자</b><input class="form-control" id="membercode3" name="membercode">
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

<!-- 멤버불러오기 -->
<div class="modal fade" id="mccodeModal2" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">직원 목록</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="col-12">
					<div class="bg-light rounded h-100 p-4">
						<table class="table">
							<thead>
								<tr>
									<th scope="col">No.</th>
									<th scope="col">직원 이름</th>
									<th scope="col">직원 코드</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="counter" value="1" />
								<c:forEach items="${mcList}" var="mc" varStatus="status">
									<tr class="mccodeset2">
										<td>${counter }</td>
										<td>${mc.membername }</td>
										<td>${mc.membercode }</td>
									</tr>
									<c:set var="counter" value="${counter+1 }" />
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="modal-footer"></div>
				</div>
			</div>
		</div>
	</div>
</div>
