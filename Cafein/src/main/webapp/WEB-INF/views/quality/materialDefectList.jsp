<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<br>
	<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
			<h2>자재 불량 현황</h2>
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">불량현황ID</th>
								<th scope="col">품질관리ID</th>
								<th scope="col">상품구분</th>
								<th scope="col">품목코드</th>
								<th scope="col">제품명</th>
								<th scope="col">불량</th>
								<th scope="col">불량사유</th>
								<th scope="col">처리방식</th>
								<th scope="col">등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dlist" items="${defectList }" varStatus="loop">
								<tr>
									<th>${dlist.defectid }</th>
									<td>${dlist.qualityid }</td>
									<!-- 상품 구분 출력 -->
									<c:if test="${empty dlist.process }"> <!-- 반품인 경우 (process == null) -->
										<td>${dlist.itemtype }</td>									
									</c:if>
									<c:if test="${!empty dlist.process }"> <!-- 생산인 경우 (process != null) -->
										<td>${dlist.itemtype }-${dlist.process }</td>									
									</c:if>
									<td>${dlist.itemcode }</td>
									<td>${dlist.itemname }</td>
									<!-- 불량 출력 -->
									<td>
									<c:if test="${!empty dlist.itemtype && dlist.itemtype.equals('반품')}">
										<b style="color: red;">${dlist.defectquantity }</b>(개)
									</c:if>
									<c:if test="${!empty dlist.process && dlist.process.equals('포장')}">
										<b style="color: red;">${dlist.defectquantity }</b>(개)
									</c:if>
									<c:if test="${!empty dlist.process && !dlist.process.equals('포장') }">
										<b style="color: red;">${dlist.defectquantity }</b>(g)
									</c:if>
									</td>
									<td>${dlist.defecttype }</td>
									<td>${dlist.processmethod }</td>
									<td>${dlist.registerationdate }</td>
								</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>	