<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>


<h2>납품서 미리보기</h2>

SELECT re.receiptid, cli.clientname, cli.businessnumber, cli.representative, cli.clientaddress, cli.clientphone, cli.clientfax, 
	ship.lotnumber, item.itemname, item.origin, item.itemweight, item.itemprice,
	rb.weight, re.ordersdate, po.ordersduedate, re.etc, re.sign
	FROM receipt re
	JOIN client cli ON re.clientid = cli.clientid
	JOIN ship ON re.shipid = ship.shipid
	JOIN item ON re.itemid = item.itemid
	JOIN roastedbean rb ON re.productid = rb.productid
	JOIN purchaseorder po ON re.poid = po.poid
	<br>
	번호   
	수주상태
	수주코드 
	납품처  
	품명   
	수량   
	수주일자 
	수정일자 
	완납예정일
	담당자  
	관리   
	납품서발행
	
	


<%@ include file="../include/footer.jsp"%>