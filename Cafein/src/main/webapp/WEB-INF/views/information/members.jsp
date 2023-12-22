<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<h1>/information/members.jsp</h1>

<!-- 본문 보기 시작 -->
<div class="bg-light rounded h-100 p-4">
	<h6 class="mb-4">직원 목록</h6>
	<div>
		<button type="button" class="btn btn-primary rounded-pill m-2" style="background-color: #610B0B; border-color: #FBF8EF;">직원 등록</button>
		<button type="button" class="btn btn-primary rounded-pill m-2" style="background-color: #610B0B; border-color: #FBF8EF;">직원 수정</button>
		<button type="button" class="btn btn-primary rounded-pill m-2" style="background-color: #610B0B; border-color: #FBF8EF;">직원 비활성화</button>
	</div>
	<div class="table-responsive">
		<table class="table">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">코드</th>
					<th scope="col">이름</th>
					<th scope="col">생년월일</th>
					<th scope="col">입사일</th>
					<th scope="col">부서</th>
					<th scope="col">직급</th>
					<th scope="col">이메일</th>
					<th scope="col">내선 번호</th>
					<th scope="col">전화 번호</th>
					<th scope="col">활성화 여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="vo" items="${memberList }">
					<tr>
						<th scope="row">${vo.memberid }</th>
						<td>${vo.membercode }</td>
						<td>${vo.membername }</td>
						<td>${vo.memberbirth }</td>
						<td>${vo.memberhire }</td>
						<td>${vo.departmentname }</td>
						<td>${vo.memberposition }</td>
						<td>${vo.memberemail }</td>
						<td>${vo.memberdeptphone }</td>
						<td>${vo.memberphone }</td>
						<td>${vo.available }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<!-- 본문 보기 끝 -->
<script type="text/javascript">
	$(document).ready(function(){
		
		// 목록 버튼 클릭 시 목록으로 페이지 이동
		$(".btn-primary").click(function(){
			location.href='/board/listAll';
		});
		
		var formObj = $('form[role="form"]');
		console.log(formObj);
		
		// 수정 버튼 클릭 시, 직원 번호 정보를 가지고 submit
		// 이동하는 페이지 주소 변경, 전달방식 변경 POST -> GET
		$(".btn-warning").click(function(){
			formObj.attr("action","/member/update");
			formObj.attr("method","GET");
			formObj.submit();
		});
		
		// 삭제 버튼 클릭 시, 글 번호를 사용해서 삭제 처리
		$(".btn-danger").click(function(){
			formObj.attr("action","/member/delete");
			formObj.submit();
		});
	});
	
</script>



<%@ include file="../include/footer.jsp"%>