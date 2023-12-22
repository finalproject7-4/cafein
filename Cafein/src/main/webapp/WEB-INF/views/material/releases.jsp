<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="col-12">

	<!-- 출고 조회 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<form name="search" action="" method="get">
		<select name="searchoption">
			<option selected="">선택</option>
			<option value="itemtype">거래처명</option>
			<option value="itemname">품목명</option>
		</select>
			<input type="text" name="search">
		<button type="button" class="btn btn-sm btn-dark m-2">조회</button>
		</form>
	</div>
	<!-- 출고 조회 -->

	<!-- 출고 목록 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<h6>총 건</h6>
		<div style="text-align: right; margin-bottom: 10px;">
			<button type="button" class="btn btn-sm btn-dark m-1">등록</button>
			<button type="button" class="btn btn-sm btn-dark m-1">수정</button>
			<button type="button" class="btn btn-sm btn-dark m-1">삭제</button>
		</div>	
		<div class="table-responsive">
			<table class="table">
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">출고코드</th>
						<th scope="col">담당자명</th>
						<th scope="col">품목코드</th>
						<th scope="col">수량</th>
						<th scope="col">출고일자</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="releasesList" items="${releasesList }">
					<tr>
						<td>${releasesList.releaseid }</td>
						<td>${releasesList.releasecode }</td>
						<td>${releasesList.membercode }</td>
						<td>${releasesList.stockid }</td>
						<td>${releasesList.releasequantity }</td>
						<td>
							<fmt:formatDate value="${releasesList.releasedate }" dateStyle="short" pattern="yyyy-MM-dd"/>
						</td>
					</tr>
				</c:forEach>	
				</tbody>
			</table>
		</div>
	</div>
	<!-- 출고 목록 -->
	
</div>	

<%@ include file="../include/footer.jsp" %>