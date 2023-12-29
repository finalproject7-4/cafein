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
			<option value="">선택</option>
			<option value="1">1라인</option>
			<option value="2">2라인</option>
			<option value="3">3라인</option>
			<option value="4">4라인</option>
			<option value="5">5라인</option>
			<option value="6">6라인</option>
</select>
<input type="radio" id="process" value="공정과정" name="search"> 공정과정
<select id="processSel" name="process" style="display:none;">
			<option value="">선택</option>
			<option value="블렌딩">블렌딩</option>
			<option value="로스팅">로스팅</option>
			<option value="포장">포장</option>
</select>
<input type="radio" id="itemname" value="제품명" name="search"> 제품명
<select id="itemnameSel" name="itemname" style="display:none;">
			<option value="">선택</option>
	<c:forEach var="iList" items="${itemList }" >
	<c:if test="${iList.itemtype=='완제품' }">
			<option value="${iList.itemname }">${iList.itemname}</option>
	</c:if>
	</c:forEach>
</select>
<!-- 조회 달력 -->
<input type="date" id="startDate" name="startDate"> ~ <input type="date" id="endDate" name="endDate">
<!-- 조회 달력 -->
<button type="submit" class="btn btn-dark m-2" id="submitbtn">조회</button>

</form>
</div>
</div>
</div>
<!-- 생산지시 등록 모달 -->
<jsp:include page="produceReg.jsp"/>
<!-- 생산지시 등록 모달 -->

<!-- 품목(BOM) 조회 모달 시작 -->
    <div class="modal fade" id="itemModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
 				<div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLabel">품목</h5>
                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<div class="modal-body">
					<div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">품목코드</th>
										<th scope="col">품명</th>
										<th scope="col" style="display: none;">비율</th>
										<th scope="col" style="display: none;">온도</th>
										<th scope="col" style="display: none;">원재료1</th>
										<th scope="col" style="display: none;">원재료2</th>
										<th scope="col" style="display: none;">원재료3</th>
                                    </tr>
								</thead>
								<tbody>
								  <c:forEach var="bList" items="${bomList}">
                                    <tr class="bomset">
                                      <td>${bList.bomid }</td> 
                                      <td>${bList.itemcode }</td> 
                                      <td>${bList.itemname }</td> 
                                      <td style="display: none;">${bList.rate }</td> 
                                      <td style="display: none;">${bList.temper }</td> 
                                      <td style="display: none;">${bList.itemname1 }</td> 
                                      <td style="display: none;">${bList.itemname2 }</td> 
                                      <td style="display: none;">${bList.itemname3 }</td> 
                                    </tr>
								  </c:forEach>
								</tbody>
							</table>
                        </div>
                        
                        <div class="modal-footer">
                        </div>
					</div>
				</div>
			</div>
		</div>
    </div>
	<!-- 품목(BOM) 조회 모달 끝 -->

<!-- BOM 등록 모달 -->
<jsp:include page="bomReg.jsp"/>
<!-- BOM 등록 모달 -->

<!-- BOM 등록시 사용하는 제품명 조회 모달 시작 -->
    <div class="modal fade" id="itemModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
 				<div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLabel">품목</h5>
                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<div class="modal-body">
					<div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">품목코드</th>
										<th scope="col">품명</th>
										</tr>
								</thead>
								<tbody>
								  <c:forEach var="iList" items="${newItemList}">
                                    <tr class="itemset">
								      <td>${iList.itemid }</td> 
                                      <td>${iList.itemcode }</td> 
                                      <td>${iList.itemname }</td>                                    
                                    </tr>
								  </c:forEach>
								</tbody>
							</table>
                        </div>
                        
                        <div class="modal-footer">
                        </div>
					</div>
				</div>
			</div>
		</div>
    </div>
	<!-- BOM 등록시 사용하는 제품명 조회 모달 끝 -->


<!-- 생산지시 목록 테이블 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">생산 지시 목록</h6>
<h6 class="mb-4">총 지시량 : ${pageVO.totalCount }</h6>

<!-- 생산 상태에 따른 페이지 출력 (버튼) 시작 -->
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
<div>
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal1" data-bs-whatever="@getbootstrap">BOM등록</button>
</div>
</div>
<!-- 생산 상태에 따른 페이지 출력 (버튼) 끝 -->

<!-- 생산지시 테이블 내용 시작 -->
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
<td>${plist.qualitycheck }</td>
<td>${plist.state }</td>
</tr>
</c:forEach>
</tbody>
</table>
<!-- 생산지시 테이블 내용 끝 -->
</div>
</div>
</div>

	<!-- 페이지 블럭 시작 -->
<nav aria-label="Page navigation example">
  <ul class="pagination">
	
    <!-- 이전 버튼 : if 시작 위치 -->
    <c:if test="${pageVO.prev }">
    <li class="page-item">
      <a class="page-link" href="/production/produceList2?page=${pageVO.startPage -1 }" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    </c:if>
    <!-- 이전 버튼 : if 종료 위치 -->

    <!-- 페이지 블럭 (숫자) : foreach 시작 위치 -->
    <c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
    <li ${pageVO.cri.page == i? "class='activ'":"" } class="page-item"><a class="page-link" href="/production/produceList2?page=${i}">${i }</a></li>
    </c:forEach>
    <!-- 페이지 블럭 (숫자) : foreach 종료 위치 -->

    <!-- 다음 버튼 : if 시작 위치 -->
    <c:if test="${pageVO.next }">
    <li class="page-item">
      <a class="page-link" href="/production/produceList2?page=${pageVO.endPage +1 }" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
    </c:if>
    <!-- 다음 버튼 : if 종료 위치 -->

  </ul>
</nav>
<!-- 페이지 블럭 종료 -->




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
	}
	else if(test=='공정과정'){
	$('#producelineSel').hide();
	$('#processSel').show();	
	$('#itemnameSel').hide();
	}
	else if(test=='제품명'){
	$('#producelineSel').hide();
	$('#processSel').hide();	
	$('#itemnameSel').show();
	}
	
	});

	
	
	
	/* 생산지시 모달창 */
	
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
	/* 생산지시 모달창 */
	
	// 품목 모달    	
	$("#itemname").click(function() {
    	$("#itemModal").modal('show');
		});

	$(".bomset").click(function() {
    	var columns = $(this).find('td');
    	var selectedItemName = $(columns[2]).text(); // 품명
    	var selectedRate = $(columns[3]).text(); // 콩비율
    	var firstItem = $(columns[5]).text(); // 첫번째 원재료
    	var secondItem = $(columns[6]).text(); // 두번째 원재료
    	var thirdItem = $(columns[7]).text(); // 세번째 원재료
    	var temper = $(columns[4]).text(); // 온도
    	
    	$('#itemcode').val(selectedItemName);
    	$('#rate').val(selectedRate);
    	$('#itemname1').val(firstItem);
    	$('#itemname2').val(secondItem);
    	$('#itemname3').val(thirdItem);
    	$('#temper').val(temper);
    	
    	$('#itemModal').modal('hide');
	});
	

	
	/* BOM 등록 모달창 */
	
	var exampleModal = document.getElementById('exampleModal1')
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
	/* BOM 등록 모달창 */
	
	// BOM 등록에 사용하는 item 모달    	
	$("#itemname1").click(function() {
		$("#itemModal1").modal('show');
	});

	$(".itemset").click(function() {
		var columns = $(this).find('td');
		var selectedItemCode = $(columns[1]).text(); // 제품코드 품명
		var selectedItemName = $(columns[2]).text(); // 제품명
		

		$('#itemcode1').val(selectedItemCode);
		$('#itemname12').val(selectedItemName);

		$('#itemModal1').modal('hide');
	});
    
	 
 });
</script>


<%@ include file="../include/footer.jsp" %>