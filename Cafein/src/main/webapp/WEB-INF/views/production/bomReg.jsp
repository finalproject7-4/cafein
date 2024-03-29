<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- BOM등록 모달창 시작-->
<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel1">레시피 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="bomReg" method="post">
						<div class="row">
							<div class="col">
								<label for="itemcode" class="col-form-label">제품코드</label> 
								<input id="itemcodeBom" name="itemcode" class="form-control" readonly>
							</div>
							<div class="col">
								<label for="itemname" class="col-form-label">제품명</label> 
								<input id="itemnameBom" value="클릭하세요." name="itemname" class="form-control" readonly>
							</div>
							<div class="col" style="display: none;">
								<label for="itemid" class="col-form-label">아이템ID</label> 
								<input id="itemidBom" name="itemid" class="form-control" readonly>
							</div>
						</div>
							<div class="row">
							<div class="col">
								<label for="temper" class="col-form-label">생산온도</label> 
								<input type="number" name="temper" class="form-control" id="temper" min="150" max="250" step="10">
							</div>
							<div class="col">
								<label for="roastedtime" class="col-form-label">로스팅시간(분)</label> 
								<input type="number" name="roastedtime" class="form-control" id="roastedtime" min="15" max="30">
							</div>
							</div>
							<div class="row">
							<div class="col">
								<label for="itemid1" class="col-form-label">원재료1</label> 
								<select id="itemnameSel1" name="itemid1" class="form-select">
								<option value="">선택</option>
								<c:forEach var="iList" items="${itemList }">
									<c:if test="${iList.itemtype=='원자재' }">
										<option value="${iList.itemid }">${iList.itemname}</option>
									</c:if>
								</c:forEach>
								</select> 
							</div>
							<div class="col">
								<label for="itemid2" class="col-form-label">원재료2</label>
								<select id="itemnameSel2" name="itemid2" class="form-select">
								<option value="">선택</option>
								<c:forEach var="iList" items="${itemList }">
									<c:if test="${iList.itemtype=='원자재' }">
										<option value="${iList.itemid }">${iList.itemname}</option>
									</c:if>
								</c:forEach>
								</select> 
							</div>
							<div class="col">
								<label for="itemid3" class="col-form-label">원재료3</label>
								<select id="itemnameSel3" name="itemid3" class="form-select">
								<option value="">선택</option>
								<c:forEach var="iList" items="${itemList }">
									<c:if test="${iList.itemtype=='원자재' }">
										<option value="${iList.itemid }">${iList.itemname}</option>
									</c:if>
								</c:forEach>
								</select> 
							</div>
							</div>
							<div class="row">
							<div class="col">
								<label for="rate" class="col-form-label">비율</label>
								<input type="text" name="rate" class="form-control" id="rate">
							</div>
							<div class="col" style="display: none;">
								<label for="memebercode" class="col-form-label">담당자(사원번호)</label>
								<input name="membercode" class="form-control" id="membercode" value="${membercode }" readonly="readonly">
							</div>
							</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<input type="submit" class="btn btn-primary" value="등록">
					</div>
						</form>
					</div>
				</div>
			</div>
		</div>
<!-- BOM등록 모달창 끝-->