<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>



<!-- 검색 폼 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">생산지시조회</h6>

<!-- 기타 조회 -->


<div >
<form action="produceList" method="get">
<!-- 제품명: <input type="text" name="itemname" class="m-2"> -->
<input type="radio" id="produceline" value="생산라인" name="search" checked> 생산라인
<select id="producelineSel" name="produceline">
			<option value="1">1라인</option>
			<option value="2">2라인</option>
			<option value="3">3라인</option>
			<option value="4">4라인</option>
			<option value="5">5라인</option>
			<option value="6">6라인</option>
</select>
<input type="radio" id="process" value="공정과정" name="search"> 공정과정
<select id="processSel" name="process" style="display:none;">
			<option value="블렌딩">블렌딩</option>
			<option value="로스팅">로스팅</option>
			<option value="포장">포장</option>
</select>
<input type="radio" id="itemname" value="제품명" name="search"> 제품명
<select id="itemnameSel" name="itemname" style="display:none;">
	<c:forEach var="iList" items="${itemList }" begin="0" step="1">
			<option value="${iList.itemname }">${iList.itemname}</option>
	</c:forEach>
</select>
<!-- 조회 달력 -->
<input type="date" id="startDate" name="startDate"> ~ <input type="date" id="endDate" name="endDate">
<!-- 조회 달력 -->


<button type="submit" class="btn btn-dark m-2" >조회</button>

</form>
</div>
</div>
</div>

<!-- 모달창 시작-->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">생산 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form>
						<div class="row">
							<div class="col">
								<label for="produce" class="col-form-label">공정과정</label> <select class="form-select" id="floatingSelect"
									aria-label="Floating label select example" name="process">
									<optgroup label="공정과정">
										<option value="블렌딩">블렌딩</option>
										<option value="로스팅">로스팅</option>
										<option value="포장">포장</option>
									</optgroup>
								</select>
							</div>
							<div class="col">
								<label for="producedate" class="col-form-label">생산일자</label> 
								<input type="date" name="producedate" value="today()" class="date" id="floatingInput">
							</div>
						</div>
							<div class="row">
							<div class="col">
								<label for="produce" class="col-form-label">생산라인</label> <select class="form-select" id="floatingSelect"
									aria-label="Floating label select example" name="produceline">
									<optgroup label="생산라인">
										<option value="1">1라인</option>
										<option value="2">2라인</option>
										<option value="3">3라인</option>
										<option value="4">4라인</option>
										<option value="5">5라인</option>
										<option value="6">6라인</option>
									</optgroup>
								</select>
							</div>
							<div class="col">
								<label for="produce" class="col-form-label">생산타임</label> 
								<select class="form-select" id="floatingSelect"
									aria-label="Floating label select example" name="producetime">
									<optgroup label="생산타임">
										<option value="1">1타임</option>
										<option value="2">2타임</option>
										<option value="3">3타임</option>
										<option value="4">4타임</option>
										<option value="first">★긴급★</option>
									</optgroup>
								</select>
							</div>
							</div>
					<div class="row">
							<div class="col">
								<label for="itemname" class="col-form-label">제품명</label> 
							
								<select class="form-select" id="floatingSelect" name="itemname">
								<c:forEach var="iList" items="${itemList }" begin="0" step="1">
									<option value="${iList.itemname }">${iList.itemname}</option>
								</c:forEach>
								</select>
							
						</div>
							<div class="col">
								<label for="amount" class="col-form-label">생산량</label>
								<input type="number" id="amount" class="form-control" id="floatingInput" min="20000" max="60000" step="10000" placeholder="생산량(g)">
							</div>
							</div>
							<div class="row">
							<div class="col">
								<label for="itemname1" class="col-form-label">원재료1</label>
								<input name="itemname1" type="text" class="form-control" id="floatingInput" >
							</div>
							<div class="col">
								<label for="itemname2" class="col-form-label">원재료2</label>
								<input type="text" name="itemname2" class="form-control" id="floatingInput" >
							</div>
							<div class="col">
								<label for="itemname3" class="col-form-label">원재료3</label>
								<input type="text" name="itemname3" class="form-control" id="floatingInput" >
							</div>
							</div>
							<div class="mb-3">
								<label for="memebercode" class="col-form-label">담당자(사원번호)</label>
								<input name="membercode" class="form-control" id="floatingInput">
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
<!-- 모달창 끝-->

<!-- 두번째 모달창 -->
<!-- 두번째 모달 창 -->
<div class="modal fade" id="modal2" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">생산제품목록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>제품명리스트</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- 두번째 모달창 -->

<!-- 생산조회 목록 테이블
 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">생산 지시 목록</h6>

<div class="btn-group" role="group">
<div>
<button type="button" class="btn btn-outline-secondary" id="listAll" onclick="location.href='/production/produceList'">전체</button>
</div>
<form role="form">
<input type="hidden" name="state" value="대기">
<button type="button" class="btn btn-outline-secondary " id="beforepro" value="대기">대기</button>
</form>
<form role="form1">
<input type="hidden" name="state" value="생산중">
<button type="button" class="btn btn-outline-secondary"  id="ingpro" value="생산중">생산중</button>
</form>
<form role="form2">
<input type="hidden" name="state" value="완료">
<button type="button" class="btn btn-outline-secondary" id="completpro" value="완료">완료</button>
</form>
<form role="form3">
<input type="hidden" name="qualitycheck" value="검사전">
<button type="button" class="btn btn-outline-secondary"  value="검사전" id="qccheck" style="background-color: #ffca2c; margin-left: 5px;">
검사대기</button>
</form>
<div>
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">생산지시 등록</button>
</div>
</div>
<div class="table-responsive" style="text-align: center;">
<table class="table">
<thead>
<tr>
<th scope="col">번호</th>
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

</td>
<td>${plist.state }</td>
</tr>
</c:forEach>

</tbody>
</table>
</div>
</div>
</div>

<script type="text/javascript">
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
	
	/* 라디오버튼 검색 */
	$("input[name='search']").change(function(){
	var test = $("input[name='search']:checked").val();
	if(test=='생산라인'){
	$('#producelineSel').show();
	$('#processSel').hide();
	$('#itemnameSel').hide();
	}else if(test=='공정과정'){
	$('#producelineSel').hide();
	$('#processSel').show();	
	$('#itemnameSel').hide();
	}else if(test=='제품명'){
	$('#producelineSel').hide();
	$('#processSel').hide();	
	$('#itemnameSel').show();
	}
	
	});

	
	
	
	/* 모달창 */
	
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
	/* 모달창 */
	 
 });
</script>


<%@ include file="../include/footer.jsp" %>