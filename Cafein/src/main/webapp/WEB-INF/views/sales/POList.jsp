<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp"%>

<h1>수주관리</h1>
<fieldset>
	<legend>수주관리</legend>
	<form method="post">
		작업지시번호 <input type="number" name="worknumber" placeholder="숫자만 입력"> 
		작업지시일 <input type="date" name="workdate"> <br> 
		수주번호 <input type="number" name="ponumber" placeholder="숫자만 입력"> 
		납품예정일 <input type="date" name="ordersduedate"> 
		<input class="btn btn-secondary m-2" type="submit" value="조회"><br><br>


		<div class="col-12">
		<input class="btn btn-secondary m-2" type="button" value="전체">
		<input class="btn btn-secondary m-2" type="button" value="대기">
		<input class="btn btn-secondary m-2" type="button" value="진행중">
		<input class="btn btn-secondary m-2" type="button" value="완료"><br>
		<input id="insertPO" class="btn btn-primary m-2" type="button" value="신규 등록">
		<input class="btn btn-success m-2" type="button" value="수정">
		<input class="btn btn-danger m-2" type="button" value="삭제">
			<div class="bg-light rounded h-100 p-4">
				<h6 class="mb-4">총 #건</h6>
				<div class="table-responsive">
				
					<table class="table">
						<thead>
							<tr>
								<th scope="col">수주번호</th>
								<th scope="col">수주상태</th>
								<th scope="col">수주코드</th>
								<th scope="col">거래처</th>
								<th scope="col">품명</th>
								<th scope="col">수량</th>
								<th scope="col">수주일자</th>
								<th scope="col">완납예정일</th>
								<th scope="col">담당자</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${getPOList}" var="spo">
							<tr>
<%-- 								<td scope="row">${spo.poid }</td> --%>
								<td>${spo.poid }</td>
								<td>${spo.postate }</td>
								<td>${spo.pocode }</td>
								<td>${spo.clientid}</td>
								<td>${spo.itemid}</td>
								<td>${spo.pocnt}</td>
								<td>${spo.ordersdate}</td>
								<td>${spo.updatedate}</td>
								<td>${spo.ordersduedate}</td>
								<td>${spo.membercode}</td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</form>
</fieldset>

<script type="text/javascript">
$(document).ready(function() {
	$("#insertPO").click(function() {
		location.href="/sales/insertPO";
	});
});

</script>


<%@ include file="../include/footer.jsp"%>