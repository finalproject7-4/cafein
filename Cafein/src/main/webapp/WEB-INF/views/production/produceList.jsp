<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>



<!-- 검색 폼 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">생산지시조회</h6>
<form action="produceList" method="get">

제품명: <input type="text" name="itemname" class="m-2">


<!-- 달력 -->

생산기간 : <input type="text" class="m-2" id="datepicker1" name="startDate">
~ <input type="text" class="m-2" id="datepicker2" name="endDate">
<!-- 달력 -->
<!-- Date: <input type="text" id="datepicker3" name="startDate">
~  <input type="text" id="datepicker4" name="endDate"> -->
<button type="submit" class="btn btn-dark m-2" >조회</button>

</form>
</div>
</div>

<!-- 생산조회 목록 테이블
 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">생산 지시 목록</h6>

<div class="btn-group" role="group">
<form role="form">
<input type="hidden" name="state" value="대기">
<button type="button" class="btn btn-outline-secondary" id="beforepro" >대기</button>
</form>
<form role="form1">
<input type="hidden" name="state" value="생산중">
<button type="button" class="btn btn-outline-secondary" id="ingpro">생산중</button>
</form>
<form role="form2">
<input type="hidden" name="state" value="완료">
<button type="button" class="btn btn-outline-secondary" id="completpro">완료</button>
</form>
<form role="form3">
<input type="hidden" name="qualitycheck" value="검사전">
<button type="button" class="btn btn-outline-secondary id="qccheck" style="background-color: #ffca2c; margin-left: 5px;">
검사대기</button>
</form>
</div>
<div class="table-responsive" style="text-align: center;">
<table class="table">
<thead>
<tr>
<th scope="col">No.</th>
<th scope="col">등록일</th>
<th scope="col">생산일</th>
<th scope="col">제품명</th>
<th scope="col">생산라인</th>
<th scope="col">공정과정</th>
<th scope="col">품질검수</th>
<th scope="col">상태</th>
</tr>
</thead>
<tbody>

<c:forEach var="plist" items="${produceList }">
<tr>
<td>${plist.produceid }</td>
<td><fmt:formatDate value="${plist.submitdate }" pattern="yyyy-MM-dd" /> </td>
<td><fmt:formatDate value="${plist.producedate }" pattern="yyyy-MM-dd" /></td>
<td>${plist.itemname }</td>
<td>${plist.produceline }</td>
<td>${plist.process }</td>
<td>${plist.qualitycheck }<br>
<c:if test="${plist.qualitycheck == '검사전'}">
<button class="btn btn-success">정상</button>
<button class="btn btn-danger">불량</button>
</c:if>
</td>
<td>${plist.state }</td>
</tr>
</c:forEach>

</tbody>
</table>
</div>
</div>
</div>

<<script type="text/javascript">
/* 버튼 값별 생산지시 목록 출력 */
 $(document).ready(function(){
	 var formObj = $('form[role="form"]');
	 var formObj1 = $('form[role="form1"]');
	 var formObj2 = $('form[role="form2"]');
	 var formObj3 = $('form[role="form3"]');
		 
 	$('#beforepro').click(function(){
 		formObj.attr("action","/production/produceList");
 		formObj.attr("method","GET");
 		formObj.submit();
 	});
	$('#ingpro').click(function(){
 		formObj1.attr("action","/production/produceList");
 		formObj1.attr("method","GET");
 		formObj1.submit();
 	});
	$('#completpro').click(function(){
 		formObj2.attr("action","/production/produceList");
 		formObj2.attr("method","GET");
 		formObj2.submit();
 	});
	$('#qccheck').click(function(){
 		formObj3.attr("action","/production/produceList");
 		formObj3.attr("method","GET");
 		formObj3.submit();
 	});
	 
 });
</script>


<%@ include file="../include/footer.jsp" %>