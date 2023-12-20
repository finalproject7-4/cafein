<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp"%>

<h1>수주등록</h1>
<fieldset>
	<legend>수주등록</legend>
<!-- 	<form role="form" method="post">  -->
	<form method="post"> 
		<input id="cancel" class="btn btn-danger m-2" type="button" value="취소">
		
		<input id="save" class="btn btn-primary m-2" type="button" value="저장">
	</form>
</fieldset>


<script type="text/javascript">
$(document).ready(function() {
	$("#cancel").click(function() {
		location.href="/sales/POList";
	});
	
// 	var formObj = $('form[role="form"]');
// 	console.log(formObj);
		
// 	$("#save").click(function() {
// 		formObj.attr("action","/sales/POList");
// 		formObj.attr("method","GET");
// 		formObj.submit(); 
// 	});
});

</script>


<%@ include file="../include/footer.jsp"%>