<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&display=swap">

<!-- 로그인 여부(세션정보)에 따라서 페이지 이동 -->
<c:if test="${empty membercode}">
	<c:redirect url="/main/login" />
</c:if>


<div class="col-12" style="margin-top: 20px;">
	<div class="row g-4">
		<div class="col-sm-6 col-xl-3">
			<div
				class="bg-light rounded d-flex align-items-center justify-content-between p-4">
				<i class="fa fa-chart-pie fa-3x text-primary"></i>
				<div class="ms-3">
					<p class="mb-2">금일 목표량</p>
					<h6 class="mb-0">
						<fmt:formatNumber value="${todayGoal }" />
						g
					</h6>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-xl-3">
			<div
				class="bg-light rounded d-flex align-items-center justify-content-between p-4">
				<i class="fa fa-chart-line fa-3x text-primary"></i>
				<div class="ms-3">
					<p class="mb-2">금일 생산량</p>
					<h6 class="mb-0" style="color: red;">
						<fmt:formatNumber value="${today }" />
						g
					</h6>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-xl-3">
			<div
				class="bg-light rounded d-flex align-items-center justify-content-between p-4">
				<i class="fa fa-chart-bar fa-3x text-primary"></i>
				<div class="ms-3">
					<p class="mb-2">당월 생산량</p>
					<h6 class="mb-0">
						<fmt:formatNumber value="${thisMonth }" />
						g
					</h6>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-xl-3">
			<div
				class="bg-light rounded d-flex align-items-center justify-content-between p-4">
				<i class="fa fa-chart-area fa-3x text-primary"></i>
				<div class="ms-3">
					<p class="mb-2">올해 생산량</p>
					<h6 class="mb-0">
						<fmt:formatNumber value="${thisYear }" />
						g
					</h6>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="container-fluid pt-4 px-4">
	<div class="bg-light text-center rounded p-4">
		<div class="d-flex align-items-center justify-content-between mb-4">
			<h6 class="mb-0">오늘의 생산계획</h6>
			<a href="/production/produceList">더보기</a>
		</div>

		<!-- 오늘의 작업지시 리스트 -->
		<div class="table-responsive">
			<table
				class="table text-start align-middle table-bordered table-hover mb-0">
				<thead>
					<tr class="text-dark" style="border-color: lightgray;">
						<th scope="col">생산코드</th>
						<th scope="col">생산라인</th>
						<th scope="col">생산타임</th>
						<th scope="col">제품명</th>
						<th scope="col">생산량</th>
						<th scope="col">공정</th>
						<th scope="col">상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="pList" items="${produceList }">
						<tr style="border-color: lightgray;">
							<td>${pList.producecode }</td>
							<td>${pList.produceline }</td>
							<td>${pList.producetime }</td>
							<td>${pList.itemname }</td>
							<td>${pList.amount }</td>
							<td>${pList.process }</td>
							<td>${pList.state }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>


<!-- 그래프 -->
<div class="container-fluid pt-4 px-4">
	<div class="row g-4">
		<div class="col-sm-12 col-xl-6">
			<div class="bg-light text-center rounded p-4">
				<div class="d-flex align-items-center justify-content-between mb-4">
					<h6 class="mb-0">생산 실적(2013~2023)</h6>
				</div>
				<canvas id="worldwide-sales"
					style="display: block; box-sizing: border-box; height: 274.4px; width: 550.4px;"
					width="688" height="343"></canvas>
			</div>
		</div>
		<div class="col-sm-12 col-xl-6">
			<div class="bg-light text-center rounded p-4">
				<div class="d-flex align-items-center justify-content-between mb-4">
					<h6 class="mb-0">라인별 생산 실적(2024)</h6>
				</div>
				<canvas id="salse-revenue"
					style="display: block; box-sizing: border-box; height: 274.4px; width: 550.4px;"
					width="688" height="343"></canvas>
			</div>
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp"%>