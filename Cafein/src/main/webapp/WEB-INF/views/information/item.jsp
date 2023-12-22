<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div class="col-12">
	<!-- 품목 조회 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<form name="search" method="post">
		<select name="option">
			<option value="">선택</option>
			<option value="itemtype">품목유형</option>
			<option value="itemname">품목명</option>
		</select>
			<input type="text" name="keyword">
			<input type="submit" class="btn btn-sm btn-dark m-2" value="조회">
		</form>
	</div>

	<!-- 품목 목록 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<h6>총 건</h6>
		<div style="text-align: right; margin-bottom: 10px;">
			<button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">등록</button>
			<button type="button" class="btn btn-sm btn-dark m-1">수정</button>
			<button type="button" class="btn btn-sm btn-dark m-1">삭제</button>
		</div>
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">품목 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form>
							<div class="mb-3">
								<label for="itemtype" class="col-form-label">품목유형</label>
								<select class="form-select" id="floatingSelect"
									aria-label="Floating label select example">
									<optgroup label="품목유형">
										<option value="1">원자재</option>
										<option value="2">부자재</option>
										<option value="3">완제품</option>
									</optgroup>
								</select>
							</div>
							<div class="mb-3">
								제품코드<input id="client" class="form-control" id="floatingInput" placeholder="제품코드">
							</div>
							<div class="mb-3">
								제품명<input id="items" class="form-control" id="floatingInput" placeholder="제품명">
							</div>
							<div class="mb-3">
								원산지<input type="text" class="form-control" id="floatingInput" placeholder="원산지">
							</div>
							<div class="mb-3">
								담당자<input class="form-control" id="floatingInput">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary">등록</button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="table-responsive">
			<table class="table">
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">품목코드</th>
						<th scope="col">품목유형</th>
						<th scope="col">품목명</th>
						<th scope="col">거래처명</th>
						<th scope="col">원산지</th>
						<th scope="col">중량(g)</th>
						<th scope="col">단가(원)</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="itemList" items="${itemList }">
					<tr>
						<td>${itemList.itemid }</td>
						<td>${itemList.itemcode }</td>
						<td>${itemList.itemtype }</td>
						<td>${itemList.itemname }</td>
						<td>${itemList.clientcode }</td>
						<td>${itemList.origin }</td>
						<td>${itemList.itemweight }</td>
						<td>${itemList.itemprice }</td>
					</tr>
				</c:forEach>	
				</tbody>
			</table>
		</div>
	</div>
	<!-- 품목 목록 -->
</div>

<script type="text/javascript">
var exampleModal = document.getElementById('exampleModal')
exampleModal.addEventListener('show.bs.modal', function (event) {
  // Button that triggered the modal
  var button = event.relatedTarget
  // Extract info from data-bs-* attributes
  var recipient = button.getAttribute('data-bs-whatever')
  // If necessary, you could initiate an AJAX request here
  // and then do the updating in a callback.
  //
  // Update the modal's content.
  var modalTitle = exampleModal.querySelector('.modal-title')
  var modalBodyInput = exampleModal.querySelector('.modal-body input')
});
</script>

<%@ include file="../include/footer.jsp" %>