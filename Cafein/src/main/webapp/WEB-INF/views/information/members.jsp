<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<jsp:useBean id="date" class="java.util.Date" />
<%@ page import="java.text.SimpleDateFormat"%>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<%
	SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd", java.util.Locale.KOREA);
	pageContext.setAttribute("format", format);
%>
<!-- 본문 보기 시작 -->

<!-- 직원 조회 -->
<div class="col-12">
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<form action="/information/members" method="get">
			<div class="input-group mb-3">
				<select name="option" class="form-select mb-3"
					aria-label="Default select example">
					<option value="membername">직원명</option>
					<option value="departmentname">부서명</option>
				</select>&nbsp;&nbsp; <input type="text" class="form-control" name="keyword"
					placeholder="검색어를 입력하세요.">
				<button class="btn btn-sm btn-dark m-2" type="submit">조회</button>
			</div>
		</form>
	</div>
</div>
<br>
<!-- 직원 조회 -->

<!-- 직원 목록 -->
<div class="col-12">
	<div class="bg-light rounded h-100 p-4">
		<span class="mb-4">총 ${pageVO.totalCount} 건</span>
		<span style="margin-left: 82%;">
		<c:if test="${sessionScope.membername eq '최윤지' }">
			<button type="button" class="btn btn-sm btn-dark m-2"
				data-bs-toggle="modal" data-bs-target="#memberJoinModal"
				data-bs-whatever="@getbootstrap">직원 등록</button>
		</c:if>		
		</span>

		<div class="table-responsive">
			<table class="table">
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">코드</th>
						<th scope="col">이름</th>
						<th scope="col">생년월일</th>
						<th scope="col">입사일</th>
						<th scope="col">부서</th>
						<th scope="col">직급</th>
						<th scope="col">이메일</th>
						<th scope="col">내선 번호</th>
						<th scope="col">전화 번호</th>
						
						<c:if test="${sessionScope.membername eq '최윤지' }">
							<th scope="col">관리</th>
						</c:if>	
						
					</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${memberList }">
						<tr>
							<th scope="row">${vo.memberid }</th>
							<td>${vo.membercode }</td>
							<td>${vo.membername }</td>
							<td>${vo.memberbirth}</td>
							<td>${vo.memberhire}</td>
							<td>${vo.departmentname }</td>
							<td>${vo.memberposition }</td>
							<td>${vo.memberemail }</td>
							<td>${vo.memberdeptphone }</td>
							<td>${vo.memberphone }</td>
							
							<c:if test="${sessionScope.membername eq '최윤지' }">
								<td>
									<button type="button" class="btn btn-sm btn-dark m-2"
										data-bs-toggle="modal" data-bs-target="#memberUpdateModal"
										data-bs-whatever="@getbootstrap"
										onclick="memberUpdateModal('${vo.memberid }', '${vo.membercode }', '${vo.memberpw }', '${vo.membername }', '${vo.memberbirth }', '${vo.memberhire }', 
														'${vo.departmentname }', '${vo.memberposition }', '${vo.memberemail }', '${vo.memberdeptphone }', '${vo.memberphone }', '${vo.available }')">수정</button>
									<button type="button" class="btn btn-sm btn-dark m-2"
										data-bs-toggle="modal" data-bs-target="#memberDeleteModal"
										data-bs-whatever="@getbootstrap"
										onclick="memberDeleteModal('${vo.memberid }', '${vo.membercode }', '${vo.membername }', '${vo.memberbirth }', '${vo.memberhire }', 
														'${vo.departmentname }', '${vo.memberposition }', '${vo.memberemail }', '${vo.memberdeptphone }', '${vo.memberphone }')">비활성화</button>
								</td>
							</c:if>			
									
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<!-- 직원 목록 페이징 처리 -->
		<!-- 페이지 블럭 생성 -->
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">

				<!-- 버튼 이동에 따른 파라미터 전달 (이전) -->
				<li class="page-item"><c:if test="${pageVO.prev }">
						<a class="page-link pageBlockPrev" href="" aria-label="Previous"
							data-page="${pageVO.startPage - 1}"> <span aria-hidden="true">&laquo;</span>
						</a>

						<script>
							$(document)
									.ready(
											function() {
												$('.pageBlockPrev')
														.click(
																function(e) {
																	e
																			.preventDefault(); // 기본 이벤트 제거

																	let prevPage = $(
																			this)
																			.data(
																					'page');

																	let keyword = "${param.keyword}";

																	url = "/information/members?page="
																			+ prevPage;

																	if (keyword) {
																		url += "&keyword="
																				+ encodeURIComponent(keyword);
																	}

																	location.href = url;
																});
											});
						</script>
					</c:if></li>
				<!-- 버튼 이동에 따른 파라미터 전달 (이전) -->

				<!-- 버튼 이동에 따른 파라미터 전달 (현재) -->
				<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }"
					step="1" var="i">
					<li class="page-item ${pageVO.cri.page == i? 'active' : ''}">
						<a class="page-link pageBlockNum" href="" data-page="${i}">${i }</a>
					</li>

					<script>
						$(document)
								.ready(
										function() {
											$('.pageBlockNum')
													.click(
															function(e) {
																e
																		.preventDefault(); // 기본 이벤트 제거

																let pageValue = $(
																		this)
																		.data(
																				'page');

																let keyword = "${param.keyword}";

																url = "/information/members?page="
																		+ pageValue;

																if (keyword) {
																	url += "&keyword="
																			+ encodeURIComponent(keyword);
																}

																location.href = url;
															});
										});
					</script>
				</c:forEach>
				<!-- 버튼 이동에 따른 파라미터 전달 (현재) -->

				<!-- 버튼 이동에 따른 파라미터 전달 (다음) -->
				<li class="page-item"><c:if test="${pageVO.next }">
						<a class="page-link pageBlockNext" href="" aria-label="Next"
							data-page="${pageVO.endPage + 1}"> <span aria-hidden="true">&raquo;</span>
						</a>

						<script>
							$(document)
									.ready(
											function() {
												$('.pageBlockNext')
														.click(
																function(e) {
																	e
																			.preventDefault(); // 기본 이벤트 제거

																	let nextPage = $(
																			this)
																			.data(
																					'page');

																	let keyword = "${param.keyword}";

																	url = "/information/members?page="
																			+ nextPage;

																	if (keyword) {
																		url += "&keyword="
																				+ encodeURIComponent(keyword);
																	}

																	location.href = url;
																});
											});
						</script>
					</c:if></li>
				<!-- 버튼 이동에 따른 파라미터 전달 (다음) -->
			</ul>
		</nav>
		<!-- 페이지 블럭 생성 -->
		<!-- 직원 목록 페이징 처리 -->

	</div>
</div>
<!-- 직원 목록 -->

<!-- 직원 등록 모달 -->
<jsp:include page="memberJoin.jsp" />

<!-- 직원 수정 모달 -->
<jsp:include page="memberUpdate.jsp" />

<!-- 직원 비활성화 모달 -->
<jsp:include page="memberDelete.jsp" />

<!-- 본문 보기 끝 -->

<script type="text/javascript">
	// 직원 수정 모달
	function memberUpdateModal(memberid, membercode, memberpw, membername,
			memberbirth, memberhire, departmentname, memberposition,
			memberemail, memberdeptphone, memberphone, available) {

		// 가져온 값들을 모달에 설정
		$("#memberid").val(memberid);
		$("#membercode").val(membercode);
		$("#memberpw").val(memberpw);
		$("#membername").val(membername);
		$("#memberbirth").val(memberbirth);
		$("#memberhire").val(memberhire);
		$("#departmentname").val(departmentname);
		$("#memberposition").val(memberposition);
		$("#memberemail").val(memberemail);
		$("#memberdeptphone").val(memberdeptphone);
		$("#memberphone").val(memberphone);
		$("#available").val(available);

		// 모달 띄우기
		$('#memberUpdateModal').modal('show');
	}

	// 직원 삭제 모달
	function memberDeleteModal(memberid2, membercode2, membername2,
			memberbirth2, memberhire2, departmentname2, memberposition2,
			memberemail2, memberdeptphone2, memberphone2) {

		// 가져온 값들을 모달에 설정
		$("#memberid2").val(memberid2);
		$("#membercode2").val(membercode2);
		$("#membername2").val(membername2);
		$("#memberbirth2").val(memberbirth2);
		$("#memberhire2").val(memberhire2);
		$("#departmentname2").val(departmentname2);
		$("#memberposition2").val(memberposition2);
		$("#memberemail2").val(memberemail2);
		$("#memberdeptphone2").val(memberdeptphone2);
		$("#memberphone2").val(memberphone2);

		// 모달 띄우기
		$('#memberDeleteModal').modal('show');
	}

	// 작업 완료 후 alert
	var result = "${result}";

	if (result == "JOINOK") {
		Swal.fire({
			title : "직원 등록 완료!",
			text : "새로운 직원을 등록했습니다.",
			icon : "success"
		});
	}

	if (result == "UPDATEOK") {
		Swal.fire({
			title : "직원 수정 완료!",
			text : "직원 정보를 수정했습니다.",
			icon : "success"
		});
	}

	if (result == "DELETEOK") {
		Swal.fire({
			title : "직원 비활성화 완료!",
			text : "직원을 비활성화 했습니다.",
			icon : "success"
		});
	}
</script>

<!-- 검색 css -->
<style>
.input-group>.form-control, .input-group>.form-select {
	position: relative;
	flex: none;
	width: 20%;
	min-width: 0;
}
</style>
<!-- 검색 css -->

<%@ include file="../include/footer.jsp"%>