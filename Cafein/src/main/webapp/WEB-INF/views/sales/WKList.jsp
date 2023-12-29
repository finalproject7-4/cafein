<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>

<form method="post">
	<!-- 검색 폼 -->
	<div class="col-12" style="margin-top: 20px;">
		<div class="bg-light rounded h-100 p-4">
			<h6 class="mb-4">작업지시 조회</h6>

			작업 지시 코드: <input type="text" name="poname" class="m-2"> 수주
			코드: <input type="text" name="poname" class="m-2">


			<!-- 달력 -->

			작업 지시 기간 : <input type="text" class="m-2" id="datepicker1"
				name="startDate"> ~ <input type="text" class="m-2"
				id="datepicker2" name="endDate">
			<!-- 달력 -->
			<!-- Date: <input type="text" id="datepicker3" name="startDate">
~  <input type="text" id="datepicker4" name="endDate"> -->
			<button type="submit" class="btn btn-dark m-2">조회</button>

		</div>
	</div>

	<!-- 작업지시 조회 -->
	<div class="col-12" style="margin-top: 20px;">
		<div class="bg-light rounded h-100 p-4">
			<h6 class="mb-4">작업 지시 관리</h6>

			<div class="btn-group" role="group">
				<form role="form">
					<input type="hidden" name="state" value="대기">
					<button type="button" class="btn btn-outline-secondary"
						id="beforepro">대기</button>
				</form>
				<form role="form1">
					<input type="hidden" name="state" value="생산중">
					<button type="button" class="btn btn-outline-secondary" id="ingpro">진행</button>
				</form>
				<form role="form2">
					<input type="hidden" name="state" value="완료">
					<button type="button" class="btn btn-outline-secondary"
						id="completpro">완료</button>
				</form>
			</div>
			<span id="buttonset1"><button type="button"
					class="btn btn-dark m-2" data-bs-toggle="modal"
					data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">신규
					등록</button>
				<button type="button" class="btn btn-dark m-2">수정</button>
				<button type="button" class="btn btn-dark m-2">삭제</button></span>
			<div class="table-responsive">
				<div class="table-responsive" style="text-align: center;">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">No.</th>
								<th scope="col">작업지시일</th>
								<th scope="col">작업지시코드</th>
								<th scope="col">수주코드</th>
								<th scope="col">라인명</th>
								<th scope="col">제품명</th>
								<th scope="col">지시상태</th>
								<th scope="col">지시수량</th>
								<th scope="col">완료일자</th>
								<th scope="col">담당자</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach items="${ AllWKList }" var="wk">
								<tr>
									<td>${wk.workid }</td>
									<td><fmt:formatDate value="${wk.workdate1 }"
											pattern="yyyy-MM-dd" /></td>
									<td>${wk.workcode }</td>
									<td>${wk.pocode }</td>
									<td>${wk.produceline }</td>
									<td>${wk.itemname }</td>
									<td>${wk.worksts }</td>
									<td>${wk.workcount }</td>
									<td><fmt:formatDate value="${wk.workdate2 }"
											pattern="yyyy-MM-dd" /></td>
									<td>${wk.membercode }</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
				</div>
			</div>
			</div>
		</div>
		
		<jsp:include page="registWK.jsp"/>
</form>






<%@ include file="../include/footer.jsp"%>