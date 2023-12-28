<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>

<!-- 검색 폼 -->
<div class="col-12" style="margin-top: 20px;">
	<div class="bg-light rounded h-100 p-4">
		<h6 class="mb-4">출하 일자 조회</h6>
		<form action="produceList" method="get">

			수주 코드: <input type="text" name="itemname" class="m-2">


			<!-- 달력 -->

			출하 일자 : <input type="text" class="m-2" id="datepicker1"
				name="startDate"> ~ <input type="text" class="m-2"
				id="datepicker2" name="endDate">
			<!-- 달력 -->
			<!-- Date: <input type="text" id="datepicker3" name="startDate">
~  <input type="text" id="datepicker4" name="endDate"> -->
			<button type="submit" class="btn btn-dark m-2">조회</button>

		</form>
	</div>
</div>

<!-- 출하 조회 -->
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
		<div class="table-responsive" style="text-align: center;">
			<table class="table">
				<thead>
					<tr>
						<th scope="col">No.</th>
						<th scope="col">출하일</th>
						<th scope="col">출하코드</th>
						<th scope="col">작업지시코드</th>
						<th scope="col">제품명</th>
						<th scope="col">납품처</th>
						<th scope="col">출하량</th>
						<th scope="col">출하상태</th>
						<th scope="col">담당자</th>
					</tr> 
				</thead>
				<tbody>

					<c:forEach items="${AllSHList}" var="sh">
						<tr>
							<td>${sh.shipid }</td>
							<td><fmt:formatDate value="${sh.shipdate }"
									pattern="yyyy-MM-dd" /></td>
							<td>${sh.shipcode }</td>
							<td>${sh.workcode }</td>
							<td>${sh.itemname }</td>
							<td>${sh.clientcode}</td>
							<td>${sh.shipcount }</td>
							<td>${sh.shipsts }</td>
							<td>${sh.membercode }</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
	</div>
</div>


<%@ include file="../include/footer.jsp"%>