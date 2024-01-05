<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>


<h2>납품서 미리보기</h2>


	<%--     번호<input type="text" name="poid" id="rPOid" value="${poid}">
	<br>수주상태<input type="text" name="state" id="rState" >
	<br>납품처코드  <input type="text" name="clientid" id="rClientid" >
	<br>납품처  <input type="text" name="clientname" id="rClientname" >
	<br>품목코드  <input type="text" name="itemid" id="rItemid" > 
	<br>품명  <input type="text" name="itemname" id="rItemname" > 
	<br>수량  <input type="text" name="pocnt" id="rPOcnt" > 
	<br>수주일자 <input type="text" name="ordersdate" id="rOrdersdate" >
	<br>완납예정일<input type="text" name="ordersduedate" id="rOrdersduedate" >
	<br>담당자  <input type="text" name="membername" id="rMembername" >

	<br>원산지  <input type="text" name="origin" id="rOrigin" >
	<br>중량 <input type="text" name="itemweight" id="rWeight" >
	<br>중량 <input type="text" name="itemprice" id="rPrice" >
	<br>수주총액  <input type="text" id="rSum" > 
	<br>수주세액  <input type="text" id="rTax" > 
	<br>수주합계금액  <input type="text" id="rTotal" > 


	<br>사업자번호<input type="text" name="businessnumber" id="rBN" >
	<br>대표자<input type="text" name="representative" id="rRE" >
	<br>주소<input type="text" name="clientaddress" id="rADD" >
	<br>전화번호<input type="text" name="clientphone" id="rPhone" >
	<br>팩스번호<input type="text" name="clientfax" id="rFax" >
	<br>LOT번호<input type="text" name="lotnumber" id="rLOT" > --%>
	
	<!--납품서 모달창 -->
	<div class="modal fade" id="openReceiptModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">수주 수정</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<form role="form" action="/sales/modifyPO" method="post">
				<input type="hidden" name="poid" id="rpoid">
				<input type="hidden" name="clientid" id="rclientid">
				<input type="hidden" name="itemid" id="ritemid">
				
				<div class="modal-body">
				납품처/코드
				<input autocomplete="off" id="rclientid" name="clientname" class="form-control mb-3" type="text"  readonly="readonly">
				
				품목명/코드
				<input autocomplete="off" id="ritemid" name="itemname" class="form-control mb-3" type="text"  >
					<div class="mb-3">
						<label for="postate" class="col-form-label"><b>수주상태</b></label>
						<select class="form-select" id="rfloatingSelect" name="postate">
						    <optgroup label="수주상태">
						        <option value="대기">대기</option>
						        <option value="진행">진행</option>
						        <option value="완료">완료</option>
						        <option value="취소">취소</option>
						    </optgroup>
						</select>
					</div>	
					수량
					<input autocomplete="off" id="rpocnt" name="pocnt" class="form-control mb-3" type="number" value="">
					
					<div class="row">
					<div class="col">
					수주일자
					<input name="ordersdate" id="rordersdate"  type="text"  class="form-control"  readonly>
					</div>
					
					<div class="col">
					완납예정일
					<input name="ordersduedate" type="date" id="rdate" class="form-control" value="">
					</div>
					</div><br>
					
					<br>
					
					담당자
					<input autocomplete="off" id="rmembercode" name="membercode" class="form-control mb-3" type="number" value="">
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" id="receiptBtn">저장</button>
				</div>
				</form>
			</div>
		</div>
	</div>


<script type="text/javascript">
$(document).ready(function() {
	
	$("#receiptBtn").submit(function (event) {
	    event.preventDefault(); // 기본 동작 중지

	$.ajax({
        type: "GET",
        url: "/sales/receipt",
        data: {
            clientname: modifiedClientName,
            itemname: modifiedItemName,
            postate: modifiedPostate,
            pocnt: modifiedPocnt,
            ordersdate: modifiedOrdersDate,
            updatedate: modifiedUpdatedate,
            ordersduedate: modifiedOrdersDueDate,
            membercode: modifiedMemberCode
        },
        
        success: function(response) {
            console.log("Modification success:", response);
            $("#receiptModal").modal('hide');
        },
        error: function(error) {
        }
    });
   });
	
	
	
	});
</script>

<%@ include file="../include/footer.jsp"%>