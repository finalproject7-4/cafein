<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>

<h1>수주관리</h1>
<fieldset>
	<legend>수주관리</legend>
	<form method="post">
		작업지시번호 <input type="number" name="worknumber" placeholder="숫자만 입력"> 작업지시일 <input type="date" name="workdate"> <br> 수주번호 <input
			type="number" name="ponumber" placeholder="숫자만 입력"> 납품예정일 <input type="date" name="ordersduedate"> <input
			class="btn btn-secondary m-2" type="submit" value="조회"><br>
		<br>


		<div class="col-12">
			<input class="btn btn-secondary m-2" type="button" value="전체"> <input class="btn btn-secondary m-2" type="button" value="대기"> <input
				class="btn btn-secondary m-2" type="button" value="진행중"> <input class="btn btn-secondary m-2" type="button" value="완료"><br>
			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">신규 등록</button>

			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">수주 등록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form>
								<div class="mb-3">
									<label for="recipient-name" class="col-form-label">수주상태</label> <select class="form-select" id="floatingSelect"
										aria-label="Floating label select example">
										<optgroup label="수주상태">
											<option value="1">대기</option>
											<option value="2">진행</option>
											<option value="3">완료</option>
											<option value="3">취소</option>
										</optgroup>
									</select>
								</div>
								<div class="mb-3">
									수주코드<input id="pocode" class="form-control" id="floatingInput" placeholder="수주코드">
								</div>
								<div class="mb-3">
									거래처<input class="form-control" id="floatingInput" placeholder="거래처">
								</div>
								<div class="mb-3">
									품명<input class="form-control" id="floatingInput" placeholder="품명">
								</div>
								<div class="mb-3">
									수량<input type="number" class="form-control" id="floatingInput" placeholder="수량">
								</div>
								<div class="mb-3">
									수주일자<input type="date" class="form-control" id="floatingInput" placeholder="수주일자">
								</div>
								<div class="mb-3">
									완납예정일<input type="date" class="form-control" id="floatingInput" placeholder="완납예정일">
								</div>
								<div class="mb-3">
									담당자<input class="form-control" id="floatingInput">
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary">저장</button>
						</div>
					</div>
				</div>
			</div>

<div class="modal fade" id="pocodeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">수주 등록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<form>
								<div class="mb-3">
									<label for="recipient-name" class="col-form-label">수주상태</label> <select class="form-select" id="floatingSelect"
										aria-label="Floating label select example">
										<optgroup label="수주상태">
											<option value="1">대기</option>
											<option value="2">진행</option>
											<option value="3">완료</option>
											<option value="3">취소</option>
										</optgroup>
									</select>
								</div>
							</form>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary">확인</button>
						</div>
					</div>
				</div>
			</div>
  
  
  
  
  
  
	<script>
    var exampleModal = document.getElementById('exampleModal')
    exampleModal.addEventListener('show.bs.modal', function (event) {
      var button = event.relatedTarget
      var recipient = button.getAttribute('data-bs-whatever')
      var modalTitle = exampleModal.querySelector('.modal-title')
      var modalBodyInput = exampleModal.querySelector('.modal-body input')
    })
    
    $(document).ready(function() {
    $("#pocode").click(function() {
        $("#pocodeModal").modal('show');
    });
});
    </script>

			<input class="btn btn-success m-2" type="button" value="수정"> <input class="btn btn-danger m-2" type="button" value="삭제">
			<div class="bg-light rounded h-100 p-4">
				<h6 class="mb-4">총 ${fn:length(AllPOList)}건</h6>
				<div class="table-responsive">

					<table class="table">
						<thead>
							<tr>
								<th scope="col">수주번호</th> <th scope="col">수주상태</th> <th scope="col">수주코드</th>
								<th scope="col">거래처</th> <th scope="col">품명</th> <th scope="col">수량</th>
								<th scope="col">수주일자</th> <th scope="col">수정일자</th> <th scope="col">완납예정일</th>
								<th scope="col">담당자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${AllPOList}" var="spo">
								<tr>
									<td>${spo.poid }</td> <td>${spo.postate }</td> <td>${spo.pocode }</td>
									<td>${spo.clientname}</td> <td>${spo.itemname}</td> <td>${spo.pocnt}</td> 
									<td><fmt:formatDate value="${spo.ordersdate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
									<c:choose>
										<c:when test="${empty spo.updatedate}">
											<td>업데이트 날짜 없음</td>
										</c:when>
										<c:otherwise>
											<td><fmt:formatDate value="${spo.updatedate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
										</c:otherwise>
									</c:choose>
									<td><fmt:formatDate value="${spo.ordersduedate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
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


<%@ include file="../include/footer.jsp"%>