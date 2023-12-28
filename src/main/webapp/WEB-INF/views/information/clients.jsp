<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<h1>/information/cleints.jsp</h1>

<!-- 본문 보기 시작 -->
<div class="bg-light rounded h-100 p-4">
	<h6 class="mb-4">거래처 목록</h6>
	<div>
		<button type="button" class="btn btn-primary rounded-pill m-2" style="background-color: #610B0B; border-color: #FBF8EF;">거래처 등록</button>
		<button type="button" class="btn btn-primary rounded-pill m-2" style="background-color: #610B0B; border-color: #FBF8EF;">거래처 수정</button>
		<button type="button" class="btn btn-primary rounded-pill m-2" style="background-color: #610B0B; border-color: #FBF8EF;">거래처 비활성화</button>
	</div>
	<div class="table-responsive">
		<table class="table">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">코드</th>
					<th scope="col">거래처명</th>
					<th scope="col">거래처 구분</th>
					<th scope="col">거래처 종류</th>
					<th scope="col">사업자 번호</th>
					<th scope="col">대표자</th>
					<th scope="col">담당자</th>
					<th scope="col">거래처 주소</th>
					<th scope="col">전화번호</th>
					<th scope="col">팩스번호</th>
					<th scope="col">이메일</th>
					<th scope="col">활성화 여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="vo" items="${clientList }">
					<tr>
						<th scope="row">${vo.clientid }</th>
						<td>${vo.clientcode }</td>
						<td>${vo.clientname }</td>
						<td>${vo.categoryofclient }</td>
						<td>${vo.typeofclient }</td>
						<td>${vo.businessnumber }</td>
						<td>${vo.representative }</td>
						<td>${vo.manager }</td>
						<td>${vo.clientaddress }</td>
						<td>${vo.clientphone }</td>
						<td>${vo.clientfax }</td>
						<td>${vo.clientemail }</td>
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
			location.href='/information/clients';
		});
		
		var formObj = $('form[role="form"]');
// 		alert(formObj);
		console.log(formObj);
		// alert보다는 consol log 를 통하면 더 정확한 정보를 얻을 수 있습니다.
		
		// 수정 버튼 클릭 시, 거래처 번호 정보를 가지고 submit
		// 이동하는 페이지 주소 변경, 전달방식 변경 POST -> GET
		$(".btn-warning").click(function(){
			formObj.attr("action","/information/clientUpdate");
			formObj.attr("method","GET");
			formObj.submit();
		});
		
		// 삭제 버튼 클릭 시, 거래처 번호를 사용해서 삭제 처리
		$(".btn-danger").click(function(){
			formObj.attr("action","/information/clientDelete");
			formObj.submit();
		});
	});
	
</script>

<%@ include file="../include/footer.jsp"%>