<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>

<h1>출하관리</h1>
<fieldset>
	<legend>출하관리</legend>
	<form method="post">
		작업지시번호 <input type="number" name="worknumber" placeholder="숫자만 입력"> 작업지시일 <input type="date" name="workdate"> <br> 출하번호 <input
			type="number" name="shnumber" placeholder="숫자만 입력"> 납품예정일 <input type="date" name="ordersduedate"> <input
			class="btn btn-secondary m-2" type="submit" value="조회"><br>
		<br>


		<div class="col-12">
			<input class="btn btn-secondary m-2" type="button" value="전체"> <input class="btn btn-secondary m-2" type="button" value="대기"> <input
				class="btn btn-secondary m-2" type="button" value="진행중"> <input class="btn btn-secondary m-2" type="button" value="완료"><br>
			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">신규 등록</button>

			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">출하 등록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form>
								<div class="mb-3">
									<label for="recipient-name" class="col-form-label">출하상태</label> <select class="form-select" id="floatingSelect"
										aria-label="Floating label select example">
										<optgroup label="출하상태">
											<option value="1">대기</option>
											<option value="2">진행</option>
											<option value="3">완료</option>
										</optgroup>
									</select>
								</div>
								<div class="mb-3">
									출하코드<input id="shipcode" class="form-control" id="floatingInput" placeholder="출하코드">
								</div>
								<div class="mb-3">
									거래처<input class="form-control" id="floatingInput" placeholder="거래처">
								</div>
								<div class="mb-3">
									수주코드<input class="form-control" id="floatingInput" placeholder="수주코드">
								</div>
								<div class="mb-3">
									출하일자<input type="date" class="form-control" id="floatingInput" placeholder="출하일자">
								</div>
								<div class="mb-3">
									수량<input type="number" class="form-control" id="floatingInput" placeholder="수량">
								</div>
								<div class="mb-3">
									담당자<input class="form-control" id="floatingInput">
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary">저장</button>
						</div>
					</div>
				</div>
			</div>

<div class="modal fade" id="pocodeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">출하 등록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form>
								<div class="mb-3">
									<label for="recipient-name" class="col-form-label">출하상태</label> <select class="form-select" id="floatingSelect"
										aria-label="Floating label select example">
										<optgroup label="수주상태">
											<option value="1">대기</option>
											<option value="2">진행</option>
											<option value="3">완료</option>
										</optgroup>
									</select>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary">확인</button>
						</div>
					</div>
				</div>
			</div>
</fieldset>
<%@ include file="../include/footer.jsp"%>