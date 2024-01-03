<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 로스팅제품 목록 테이블 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">로스팅 제품 목록(lot)</h6>
<h6 class="mb-4">총 수량 : ${pageVO.totalCount }</h6>



<!-- 생산완료된 로스팅 제품 테이블 내용 시작 -->
<div class="table-responsive" style="text-align: center;">
<table class="table">
<thead>
<tr>
<th scope="col">번호</th>
<th scope="col">제품명</th>
<th scope="col">포장중량(g)</th>
<th scope="col">로스팅일</th>
<th scope="col">LOT번호</th>
</tr>
</thead>
<tbody>

<c:forEach var="rlist" items="${roastedList }">
<tr>
<td>${rlist.productid }</td>
<td>${rlist.itemname }</td>
<td>${rlist.weight }</td>
<td><fmt:formatDate value="${rlist.roasteddate }" pattern="yyyy-MM-dd" /></td>
<td>${rlist.lotnumber }</td>
</tr>
</c:forEach>
</tbody>
</table>
<!-- 생산완료된 로스팅 제품 테이블 내용 끝 -->
</div>


<!-- 페이지 블럭 생성 -->
			<nav aria-label="Page navigation example">
  				<ul class="pagination justify-content-center">
    				<li class="page-item">
    					<c:if test="${pageVO.prev }">
      					<a class="page-link pageBlockPrev" href="" aria-label="Previous" data-page="${pageVO.startPage - 1}">
        					<span aria-hidden="true">&laquo;</span>
      					</a>
        					
        				<!-- 페이지 블럭 Ajax 동적 이동 - prev (1) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockPrev').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거
   						            var prevPage = $(this).data('page');
   									
   									var searchBtn = "${param.searchBtn}";
   									var startDate = "${param.startDate}";
   									var endDate = "${param.endDate}";

   									var dataObject = {
   										"page" : prevPage	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (startDate) {
   									    dataObject.startDate = startDate;
   									}
   									if (endDate) {
   									    dataObject.endDate = endDate;
   									}
   									
   									console.log("Page Block clicked!", prevPage);
   									
        						$.ajax({
       								url: "/production/roastedDetail",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#roastedBeanList").html(data);
            						},
           						 	error: function(error) {
                						console.error("Error fetching data:", error);
            						}
        							});
    							});
							});
						</script>
						<!-- 페이지 블럭 Ajax 동적 이동 - prev (1) -->
    					</c:if>
    				</li>
					<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1" var="i">
    				<li class="page-item ${pageVO.cri.page == i? 'active' : ''}"><a class="page-link pageBlockNum" href="" data-page="${i}">${i }</a></li>
    					
    					<!-- 페이지 블럭 Ajax 동적 이동 - num (2) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockNum').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거

   						            var pageNum = $(this).data('page');
   									
   									var searchBtn = "${param.searchBtn}";
   									var startDate = "${param.startDate}";
   									var endDate = "${param.endDate}";

   									var dataObject = {
   										"page" : pageNum	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (startDate) {
   									    dataObject.startDate = startDate;
   									}
   									if (endDate) {
   									    dataObject.endDate = endDate;
   									}
   									
   									console.log("Page Block clicked!");
   									
        						$.ajax({
       								url: "/production/roastedDetail",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#roastedBeanList").html(data);
            						},
           						 	error: function(error) {
                						console.error("Error fetching data:", error);
            						}
        							});
    							});
							});
						</script>
						<!-- 페이지 블럭 Ajax 동적 이동 - num (2) -->

					</c:forEach>
    				<li class="page-item">
    					<c:if test="${pageVO.next }">
      					<a class="page-link pageBlockNext" href="" aria-label="Next" data-page="${pageVO.endPage + 1}">
        				<span aria-hidden="true">&raquo;</span>
      					</a>
      					
    					<!-- 페이지 블럭 Ajax 동적 이동 - next (3) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockNext').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거
   						            var nextPage = $(this).data('page');
   									
   									var searchBtn = "${param.searchBtn}";
   									var startDate = "${param.startDate}";
   									var endDate = "${param.endDate}";

   									var dataObject = {
   										"page" : nextPage	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (startDate) {
   									    dataObject.startDate = startDate;
   									}
   									if (endDate) {
   									    dataObject.endDate = endDate;
   									}
   									
   									console.log("Page Block clicked!", nextPage);
   									
        						$.ajax({
       								url: "/production/roastedDetail",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#roastedBeanList").html(data);
            						},
           						 	error: function(error) {
                						console.error("Error fetching data:", error);
            						}
        							});
    							});
							});
						</script>
						<!-- 페이지 블럭 Ajax 동적 이동 - next (3) -->      					
    					</c:if>
    				</li>
  				</ul>
			</nav>
			<!-- 페이지 블럭 생성 -->
</div>
</div>


<script type="text/javascript">

// 생산지시에 사용하는 품목 모달   	
	$("#itemnamePro").click(function() {
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
    	var itemid = $(columns[8]).text(); // 아이템ID
    	
    	$('#itemnamePro').val(selectedItemName);
    	$('#rate').val(selectedRate);
    	$('#itemnameOri1').val(firstItem);
    	$('#itemnameOri2').val(secondItem);
    	$('#itemnameOri3').val(thirdItem);
    	$('#temper').val(temper);
    	$('#itemidPro').val(itemid);
    	
    	$('#itemModal').modal('hide');
	});
	
// bom 등록에 사용하는 품목 모달   	
	$("#itemnameBom").click(function() {
		$("#itemModal1").modal('show');
	});

	$(".itemset").click(function() {
		var columns = $(this).find('td');
		var selectedItemCode = $(columns[0]).text(); // 제품코드 품명
		var selectedItemName = $(columns[1]).text(); // 제품명
		

		$('#itemcodeBom').val(selectedItemCode);
		$('#itemnameBom').val(selectedItemName);

		$('#itemModal1').modal('hide');
	});

		  
	// 생산 상태 변경 버튼 클릭 이벤트 처리
	$(document).ready(function() {
		$("td").on("click", "#ingBtn, #completBtn", function() {
			
			var produceId = $(this).closest("tr").find("td:first").text(); // 생산아이디 값
			var stateValue = $(this).val(); // 버튼의 value 값(생산중 or 완료)

			// AJAX 요청 수행
			$.ajax({
				url : "/production/AJAXupdateProduceState",
				type : "POST",
				data : {
					state : stateValue,
					produceid : produceId
				},
				success : function(response) {
					// 성공적으로 처리된 경우 수행할 코드
					console.log("상태 업데이트 성공!");
					alert('변경완료!');
					getList();
					

				},
				error : function(error) {
					// 요청 실패 시 수행할 코드
					alert('못한다. 못간다.');
					console.error("상태 업데이트 실패:", error);
				}
			});
		});

		
	// 생산 공정 수정(블렌딩->로스팅) 변경 버튼 클릭 이벤트 처리

			$("td").on("click", "#roastingBtn", function() {
			var produceId = $(this).closest("tr").find("td:first").text(); // 생산아이디 값
			 var itemID = $(this).closest("tr").find("td:eq(9)").text(); // 아이템id 값
			
			// AJAX 요청 수행
			$.ajax({
				url : "/production/processUpdateRoasting",
				type : "POST",
				data : {
					produceid : produceId,
					itemid : itemID,
					process : "로스팅"
				},
				success : function(response) {
					// 성공적으로 처리된 경우 수행할 코드
					console.log("상태 업데이트 성공!");
					alert('변경완료!');
					getList();
					

				},
				error : function(error) {
					// 요청 실패 시 수행할 코드
					alert('못한다. 못간다.');
					console.error("상태 업데이트 실패:", error);
				}
			});
		});
		
	}); 

</script>


