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
	<br>단가 <input type="text" name="itemprice" id="rPrice" >
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
			<div class="modal-content rectipt-body">
			
				<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">납품서 미리보기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>


<%@ include file="../include/footer.jsp"%>