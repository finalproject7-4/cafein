<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<!-- 상세내역 모달창 -->
	<div class="modal fade" id="openDetailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content podetail-content">
			
				<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">상세 내역</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<input type="hidden" name="poid" id="poid4">
				<input type="hidden" name="clientid" id="clientid4">
				<input type="hidden" name="itemid" id="itemid4">
				
				<div class="modal-body" style="font-weight:bold;">
				수주코드
				<input style="background:white; color:black;" autocomplete="off" id="pocode4" name="pocode" class="form-control mb-3" type="text" readonly>
				
				<div class="row">
				<div class="col">
				납품처
				<input style="background:white; color:black;" autocomplete="off" id="clientid5" name="clientname" class="form-control mb-3" type="text"  readonly>
				</div>
				
				<div class="col">
				품목명
				<input style="background:white; color:black;" autocomplete="off" id="itemid5" name="itemname" class="form-control mb-3" type="text" readonly>
				</div>
				</div>
				
				<div class="row row1">
					<div class="col">
						<label for="postate" class="col-form-label">수주상태</label>
						<input style="background:white; color:black;" class="form-control" id="floatingSelect4" name="postate" readonly>
					</div><br><br><br>
					<div class="col col2">
					수량
					<input style="background:white; color:black;" autocomplete="off" id="pocnt4" name="pocnt" class="form-control" type="text" readonly>
					</div>
					</div>
					
					<div class="row">
					<div class="col">
					수주일자
					<input style="background:white; color:black;" name="ordersdate" id="ordersdate4"  type="text"  class="form-control"  readonly>
					</div>
					
					<div class="col">
					완납예정일
					<input style="background:white; color:black;" name="ordersduedate" type="date" id="date4" class="form-control" readonly>
					</div>
					</div><br>
					
					담당자
					<input style="background:white; color:black;" autocomplete="off" name="membercode" class="form-control mb-3 membercode4" type="number" readonly>
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
