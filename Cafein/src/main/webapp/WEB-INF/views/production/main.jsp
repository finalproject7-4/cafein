<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<%-- 	<h1>${membercode }</h1> --%>


<div class="col-12" style="margin-top:20px;">
<div class="row g-4">
<div class="col-sm-6 col-xl-3">
<div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
<i class="fa fa-chart-line fa-3x text-primary"></i>
<div class="ms-3">
<p class="mb-2">오늘 생산량</p>
<h6 class="mb-0" style="color: red;"><fmt:formatNumber value="${today }"/> g</h6>
</div>
</div>
</div>
<div class="col-sm-6 col-xl-3">
<div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
<i class="fa fa-chart-bar fa-3x text-primary"></i>
<div class="ms-3">
<p class="mb-2">당월 생산량</p>
<h6 class="mb-0"><fmt:formatNumber value="${thisMonth }"/> g</h6>
</div>
</div>
</div>
<div class="col-sm-6 col-xl-3">
<div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
<i class="fa fa-chart-area fa-3x text-primary"></i>
<div class="ms-3">
<p class="mb-2">올해 생산량</p>
<h6 class="mb-0"><fmt:formatNumber value="${thisYear }"/> g</h6>
</div>
</div>
</div>
<div class="col-sm-6 col-xl-3">
<div class="bg-light rounded d-flex align-items-center justify-content-between p-4">
<i class="fa fa-chart-pie fa-3x text-primary"></i>
<div class="ms-3">
<p class="mb-2">Total Revenue</p>
<h6 class="mb-0">$1234</h6>
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
<div class="table-responsive">
<table class="table text-start align-middle table-bordered table-hover mb-0">
<thead>
<tr class="text-dark">
<th scope="col">번호</th>
<th scope="col">생산라인</th>
<th scope="col">생산타임</th>
<th scope="col">제품명</th>
<th scope="col">생산량</th>
<th scope="col">Action</th>
</tr>
</thead>
<tbody>
<c:forEach var="pList" items="${produceList }">
<tr>
<td>${pList.producecode }</td>
<td>${pList.produceline }</td>
<td>${pList.producetime }</td>
<td>${pList.itemname }</td>
<td>${pList.amount }</td>
<td><a class="btn btn-sm btn-primary" href="">Detail</a></td>
</tr>
</c:forEach>
</tbody>
</table>
</div>
</div>
</div>

<%@ include file="../include/footer.jsp" %>