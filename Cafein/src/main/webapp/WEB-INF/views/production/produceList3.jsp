<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- SweetAlert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>
<!-- SweetAlert 추가 -->

<!-- 생산지시 등록 모달 -->
<jsp:include page="produceReg.jsp"/>
<!-- 생산지시 등록 모달 -->

<!-- 생산지시에 사용할 품목(BOM) 조회 모달 시작 -->
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
										<th scope="col" style="display: none;">번호</th>
										<th scope="col">품목코드</th>
										<th scope="col">품명</th>
										<th scope="col" style="display: none;">비율</th>
										<th scope="col" style="display: none;">온도</th>
										<th scope="col" style="display: none;">원재료1</th>
										<th scope="col" style="display: none;">원재료2</th>
										<th scope="col" style="display: none;">원재료3</th>
										<th scope="col" style="display: none;">원재료ID1</th>
										<th scope="col" style="display: none;">원재료ID2</th>
										<th scope="col" style="display: none;">원재료ID3</th>
										<th scope="col" style="display: none;">재고ID1</th>
										<th scope="col" style="display: none;">재고ID2</th>
										<th scope="col" style="display: none;">재고ID3</th>
										<th scope="col"  style="display: none;">아이템ID</th>
                                    </tr>
								</thead>
								<tbody>
								  <c:forEach var="bList" items="${bomList}">
                                    <tr class="bomset">
                                      <td style="display: none;">${bList.bomid }</td> 
                                      <td>${bList.itemcode }</td> 
                                      <td>${bList.itemname }</td> 
                                      <td style="display: none;">${bList.rate }</td> 
                                      <td style="display: none;">${bList.temper }</td> 
                                      <td style="display: none;">${bList.itemname1 }</td> 
                                      <td style="display: none;">${bList.itemname2 }</td> 
                                      <td style="display: none;">${bList.itemname3 }</td> 
                                      <td style="display: none;">${bList.itemid1 }</td> 
                                      <td style="display: none;">${bList.itemid2 }</td> 
                                      <td style="display: none;">${bList.itemid3 }</td> 
                                      <td style="display: none;">${bList.stockid1 }</td> 
                                      <td style="display: none;">${bList.stockid2 }</td> 
                                      <td style="display: none;">${bList.stockid3 }</td> 
                                      <td style="display: none;">${bList.itemid }</td> 
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
	<!-- 생산지시에 사용할 품목(BOM) 조회 모달 끝 -->

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
										<th scope="col">품목코드</th>
										<th scope="col">품명</th>
										<th scope="col" style="display: none;">제품ID</th>
										</tr>
								</thead>
								<tbody>
								  <c:forEach var="iList" items="${newItemList}">
                                    <tr class="itemset">
                                      <td>${iList.itemcode }</td> 
                                      <td>${iList.itemname }</td>                                    
                                      <td style="display: none;">${iList.itemid }</td>                                    
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

<!-- 포장완료시 사용하는 모달-->
<jsp:include page="packageReg.jsp" />
<!-- 포장완료시 사용하는 모달-->

<!-- 생산지시 목록 테이블 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">생산 지시 관리 [총 ${pageVO.totalCount }건]</h6>

<!-- 생산 상태에 따른 페이지 출력 (버튼) 시작 -->
<div class="buttonarea1" style="margin-bottom: 10px;">
				<input type="button" class="btn btn-sm btn-primary" value="전체" id="allList">
				<input type="button" class="btn btn-sm btn-info" value="오늘" id="todayList">
				<input type="button" class="btn btn-sm btn-success" value="대기" id="proWait">
				<input type="button" class="btn btn-sm btn-danger" value="생산중" id="proIng">
				<input type="button" class="btn btn-sm btn-warning" value="검사대기" id="qccWait">
			

				<span style="float: right;">
				<c:if test="${(departmentname eq '생산' and memberposition eq '팀장') or membername eq 'admin'}">
				<button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">생산지시 등록</button>
				<button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#exampleModal1" data-bs-whatever="@getbootstrap">BOM등록</button>
				</c:if>
				</span>

</div>

<!-- 페이지 Ajax 동적 이동 (1) -->
<script>
$(document).ready(function() {
    // 대기 버튼 클릭
    $("#proWait").click(function() {
        fetchData("대기");
    });

    // 생산중 버튼 클릭
    $("#proIng").click(function() {
        fetchData("생산중");
    });
    
    // 검사대기 버튼 클릭
    $("#qccWait").click(function() {
        fetchData("검사전");
    });
    // 오늘 버튼 클릭
    $("#todayList").click(function() {
        fetchData("오늘");
    });
    
 // 전체 버튼 클릭
    $("#allList").click(function() {
        $.ajax({
            url: "/production/produceList3",
            type: "GET",
            success: function(data) {
                // 성공적으로 데이터를 받아왔을 때 처리할 코드
                $("#produceListAll").html(data);
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });

});

function fetchData(searchBtnValue) {
	
    $.ajax({
        url: "/production/produceList3",
        type: "GET",
        data: {
        	searchBtn: searchBtnValue
        },
        success: function(data) {
            // 성공적으로 데이터를 받아왔을 때 처리할 코드
            $("#produceListAll").html(data);
        },
        error: function(error) {
            console.error("Error fetching data:", error);
        }
    });
}
</script>
<!-- 페이지 Ajax 동적 이동 (1) -->



<!-- 생산 상태에 따른 페이지 출력 (버튼) 끝 -->

<!-- 생산지시 테이블 내용 시작 -->
<div class="table-responsive" style="text-align: center;">
<table class="table">
<thead>
<tr>
<th scope="col">번호</th>
<th scope="col" style="display: none;">등록일</th>
<th scope="col">생산일</th>
<th scope="col">제품명</th>
<th scope="col">생산라인</th>
<th scope="col">공정과정</th>
<th scope="col">품질검수</th>
<th scope="col">상태</th>
<th scope="col">생산타임</th>
<th scope="col" style="display: none;">아이템ID</th>
<th style="display: none;">포장지시량</th>
<th>생산량(g)</th>

<c:if test="${(departmentname eq '생산' and memberposition eq '팀장') or memberposition eq 'admin'}">
<th scope="col">상태변경</th>
<th scope="col">공정관리</th>
</c:if>
<th scope="col" style="display: none;">생산코드</th>
<th scope="col" style="display: none;">재고ID1</th>
<th scope="col" style="display: none;">재고ID2</th>
<th scope="col" style="display: none;">재고ID3</th>
</tr>
</thead>
<tbody>

<c:forEach var="plist" items="${produceList }">
<tr>
<td>${plist.produceid }</td>
<td style="display: none;"><fmt:formatDate value="${plist.submitdate }" pattern="yyyy-MM-dd" /> </td>
<td><fmt:formatDate value="${plist.producedate }" pattern="yyyy-MM-dd" /></td>
<td> ${plist.itemname }</td>
<td>${plist.produceline }</td>
<td>${plist.process }</td>
<td style="${plist.qualitycheck == '정상'? 'style=color:red; font-weight: bold;' : ''}">${plist.qualitycheck }</td>
<td style="font-weight: bold; ${plist.state == '완료'? 'color:red;' : ''} ${plist.state == '생산중'? 'color:blue;' : ''}">${plist.state }</td>
<td>${plist.producetime }</td>
<td style="display: none;">${plist.itemid }</td>
<td style="display: none;">${plist.packagevol }</td>
<td> ${plist.amount }</td>


<c:if test="${(departmentname eq '생산' and memberposition eq '팀장') or memberposition eq 'admin'}">
<td>

	<!-- 블렌딩 대기 상태일때, 상태변경 버튼 '대기' 인경우 표시해서 클릭시 '완료'로 변경 -->
	<c:if test="${plist.process == '블렌딩' && plist.state == '대기'}">
	<input id="BingBtn" type="button" class="btn btn-sm btn-dark m-1" name="state" value="생산중">
	</c:if>
	<!-- 상태변경 버튼은 '대기' 인경우 표시해서 클릭시 '완료'로 변경 -->
	<c:if test="${ plist.process != '블렌딩' && plist.state == '대기'}">
	<input id="ingBtn" type="button" class="btn btn-sm btn-dark m-1" name="state" value="생산중">
	</c:if>
	<!-- 상태변경 버튼은 '생산중'인 경우 표시해서 클릭시 '완료'로 변경 -->
	<c:if test="${plist.state == '생산중' && plist.process !='포장'}">
	<input id="completBtn" type="button" class="btn btn-sm btn-dark m-1" name="state" value="완료">
	</c:if>
	<!-- 포장이 생산중에서 완료되었을때, 누를 '완료' 버튼 -->
	<c:if test="${plist.state == '생산중'&& plist.process =='포장' }">
	<input id="packageBtn" type="button" onclick="openPackageModal('${plist.produceid}', '${plist.producedate}', '${plist.producetime }', '${plist.produceline}',  '${plist.itemname }', '${plist.itemid }', '${plist.packagevol }', '${plist.amount }')" data-bs-toggle="modal" data-bs-target="#packageModal" data-bs-whatever="@getbootstrap" class="btn btn-sm btn-danger m-1" name="state" value="완료"> 
	</c:if>

	
</td>

<td>	

	<!-- 삭제 버튼은 생산공정이 블렌딩이고, 상태가 대기중일 때만 표시 -->
	<c:if test="${plist.state == '대기' && plist.process=='블렌딩' && plist.qualitycheck == '검사전'}">
	<input type="submit" id="deletProduceBtn" class="btn btn-sm btn-dark m-1" value="삭제">
	</c:if>
	<c:if test="${plist.state == '완료' && plist.process=='블렌딩' && plist.qualitycheck == '정상'}">
	<input type="button" id="roastingBtn" class="btn btn-sm btn-dark m-1" name="process" value="수정">
	</c:if>
	<c:if test="${plist.state == '완료' &&  plist.process =='로스팅' && plist.qualitycheck == '정상' }">
	<input type="button" onclick="openUpdateModal2('${plist.produceid}', '${plist.producedate}', '${plist.produceline}', '${plist.producetime }', '${plist.itemname }', '${plist.itemid }', '${plist.state }','${plist.amount }')" data-bs-toggle="modal" data-bs-target="#updateModal2" data-bs-whatever="@getbootstrap" class="btn btn-sm btn-dark m-1" name="process" value="수정">
	</c:if>	

</td>
</c:if>
<td style="display: none;">${plist.producecode }</td>
<td style="display: none;">${plist.stockid1 }</td>
<td style="display: none;">${plist.stockid2 }</td>
<td style="display: none;">${plist.stockid3 }</td>
</tr>
</c:forEach>
</tbody>
</table>
<!-- 생산지시 테이블 내용 끝 -->
</div>

<!-- 엑셀파일 다운로드 -->
<div style="float: right">
	<form action="/production/excelPrint" method="post">
		<input class="btn btn-sm btn-success" type="submit" value="엑셀 파일 다운로드">
	</form>
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
       								url: "/production/produceList3",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#produceListAll").html(data);
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
       								url: "/production/produceList3",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#produceListAll").html(data);
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
       								url: "/production/produceList3",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#produceListAll").html(data);
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
    	var firstItemId = $(columns[8]).text(); // 첫번째 원재료 id (등록에 사용)
    	var secondItemId = $(columns[9]).text(); // 두번째 원재료 id (등록에 사용)
    	var thirdItemId = $(columns[10]).text(); // 세번째 원재료 id (등록에 사용)
    	var firstStockId = $(columns[11]).text(); // 첫번째 재고 id (출고 등록에 사용)
    	var secondStockId = $(columns[12]).text(); // 두번째 재고 id (출고 등록에 사용)
    	var thirdStockId = $(columns[13]).text(); // 세번째 재고 id (출고 등록에 사용)
    	var temper = $(columns[4]).text(); // 온도
    	var itemid = $(columns[14]).text(); // 아이템ID
    	
    	$('#itemnamePro').val(selectedItemName);
    	$('#rate').val(selectedRate);
    	$('#itemnameOri1').val(firstItem);
    	$('#itemnameOri2').val(secondItem);
    	$('#itemnameOri3').val(thirdItem);
    	$('#itemidOri1').val(firstItemId);
    	$('#itemidOri2').val(secondItemId);
    	$('#itemidOri3').val(thirdItemId);
    	$('#stockid1').val(firstStockId);
    	$('#stockid2').val(secondStockId);
    	$('#stockid3').val(thirdStockId);
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
		var selectedItemId = $(columns[2]).text(); // 제품아이디
		

		$('#itemcodeBom').val(selectedItemCode);
		$('#itemnameBom').val(selectedItemName);
		$('#itemidBom').val(selectedItemId);

		$('#itemModal1').modal('hide');
	});

		  
	// 생산 상태 변경 버튼 클릭 이벤트 처리
	$(document).ready(function() {
		$("td").on("click", "#ingBtn, #completBtn", function() {
			
			var produceId = $(this).closest("tr").find("td:first").text(); // 생산아이디 값
			var stateValue = $(this).val(); // 버튼의 value 값(생산중 or 완료)
			
				
				var searchBtn = "${param.searchBtn}";
				var startDate = "${param.startDate}";
				var endDate = "${param.endDate}";

				var dataObject = {
					"produceid" : produceId,
					"state" : stateValue					
				};
				
				
				var currentPage = getCurrentPageNumber();
				var dataObjectCom = {
						"page" : currentPage	
					};
		        if (searchBtn) {
		        	dataObjectCom.searchBtn = searchBtn;
				}
		        if (startDate) {
		        	dataObjectCom.startDate = startDate;
				}
				if (endDate) {
					dataObjectCom.endDate = endDate;
				}
				
			// AJAX 요청 수행
			$.ajax({
				url : "/production/AJAXupdateProduceState",
				type : "POST",
				data : dataObject,
				success : function(response) {
					// 성공적으로 처리된 경우 수행할 코드
					console.log("상태 업데이트 성공!");
					Swal.fire('변경완료!');
					
					$.ajax({
						url: "/production/produceList3",
						type: "GET",
						data: dataObjectCom,
						success: function(data) {
    						$("#produceListAll").html(data);
						},
						 	error: function(error) {
    						console.error("Error fetching data:", error);
						}
						});
					
				},
				error : function(error) {
					// 요청 실패 시 수행할 코드
					Swal.fire("변경할 수 없습니다.");
					console.error("상태 업데이트 실패:", error);
				}
			});
		});
		
	// 블렌딩일때만!! 생산 상태 변경 버튼 클릭 이벤트 처리

		$("td").on("click", "#BingBtn", function() {
			
			var produceId = $(this).closest("tr").find("td:first").text(); // 생산아이디 값
			var itemID = $(this).closest("tr").find("td:eq(9)").text(); // 아이템id 값
			var amount = $(this).closest("tr").find("td:eq(11)").text(); // 생산량 값
			var producecode = $(this).closest("tr").find("td:eq(14)").text(); // 생산코드 값
			var stockId1 = $(this).closest("tr").find("td:eq(15)").text(); // 재고ID1 값
			var stockId2 = $(this).closest("tr").find("td:eq(16)").text(); // 재고ID2 값
			var stockId3 = $(this).closest("tr").find("td:eq(17)").text(); // 재고ID3 값
			var stateValue = $(this).val(); // 버튼의 value 값(생산중 or 완료)
			
			
			var searchBtn = "${param.searchBtn}";
			var startDate = "${param.startDate}";
			var endDate = "${param.endDate}";

			var dataObject = {
				"produceid" : produceId,
				"state" : stateValue,
				"itemid" : itemID,
				"amount" : amount,
				"producecode" : producecode,
				"stockid1" : stockId1,
				"stockid2" : stockId2,
				"stockid3" : stockId3				
			};

			var currentPage = getCurrentPageNumber();
			var dataObjectCom = {
					"page" : currentPage	
				};
			if (searchBtn) {
	        	dataObjectCom.searchBtn = searchBtn;
			}
	        if (startDate) {
	        	dataObjectCom.startDate = startDate;
			}
			if (endDate) {
				dataObjectCom.endDate = endDate;
			}
			// AJAX 요청 수행
			$.ajax({
				url : "/production/BupdateProduceState",
				type : "POST",
				data : dataObject,
				success : function(response) {
					// 성공적으로 처리된 경우 수행할 코드
					console.log("상태 업데이트 성공!");
					Swal.fire('변경완료!');
					$.ajax({
						url: "/production/produceList3",
					type: "GET",
					data: dataObjectCom,
					success: function(data) {
						$("#produceListAll").html(data);
					},
					 	error: function(error) {
						console.error("Error fetching data:", error);
					}
					});
					
				},
				error : function(error) {
					// 요청 실패 시 수행할 코드
					Swal.fire("변경할 수 없습니다.");
					console.error("상태 업데이트 실패:", error);
				}
			});
		});
		
		// 공정 삭제 버튼 클릭시 이벤트
		$("td").on("click", "#deletProduceBtn", function() {
			Swal.fire({
		          title: '삭제하시겠습니까?',
		          text: "",
		          icon: 'warning',
		          showCancelButton: true,
		          confirmButtonColor: '#3085d6',
		          cancelButtonColor: '#d33',
		          confirmButtonText: '삭제',
		          cancelButtonText: '취소'
		        }).then((result) => {
		          if (result.value) {

			var produceId = $(this).closest("tr").find("td:first").text(); // 생산아이디 값
			var produceCode = $(this).closest("tr").find("td:eq(14)").text();
			
			var searchBtn = "${param.searchBtn}";
			var startDate = "${param.startDate}";
			var endDate = "${param.endDate}";

					
			var currentPage = getCurrentPageNumber();
			var dataObjectCom = {
					"page" : currentPage	
				};
			if (searchBtn) {
	        	dataObjectCom.searchBtn = searchBtn;
			}
	        if (startDate) {
	        	dataObjectCom.startDate = startDate;
			}
			if (endDate) {
				dataObjectCom.endDate = endDate;
			}
			// AJAX 요청 수행
			$.ajax({
				url : "/production/deletePlan",
				type : "POST",
				data : {
					produceid : produceId,
					producecode : produceCode
				},
				success : function(response) {
					// 성공적으로 처리된 경우 수행할 코드
					console.log("상태 업데이트 성공!");
					Swal.fire('삭제완료!');
					$.ajax({
						url: "/production/produceList3",
					type: "GET",
					data: dataObjectCom,
					success: function(data) {
						$("#produceListAll").html(data);
					},
					 	error: function(error) {
						console.error("Error fetching data:", error);
					}
					});
					

				},
				error : function(error) {
					// 요청 실패 시 수행할 코드
					Swal.fire("삭제할 수 없습니다.");
					console.error("상태 업데이트 실패:", error);
				}
			});
			}
		});
		});
		
	// 생산 공정 수정(블렌딩->로스팅) 변경 버튼 클릭 이벤트 처리

			$("td").on("click", "#roastingBtn", function() {
			var produceId = $(this).closest("tr").find("td:first").text(); // 생산아이디 값
			var itemID = $(this).closest("tr").find("td:eq(9)").text(); // 아이템id 값
			var amount = $(this).closest("tr").find("td:eq(11)").text(); // 생산량 값
			
 			

			var dataObject = {
					"produceid" : produceId,	
					"itemid" : itemID,
					"amount" : amount,
					process : "로스팅"
				};
			
			var searchBtn = "${param.searchBtn}";
			var startDate = "${param.startDate}";
			var endDate = "${param.endDate}"; 
			var currentPage = getCurrentPageNumber();
			var dataObjectCom = {
						"page" : currentPage	
					};
				if (searchBtn) {
		        	dataObjectCom.searchBtn = searchBtn;
				}
		        if (startDate) {
		        	dataObjectCom.startDate = startDate;
				}
				if (endDate) {
					dataObjectCom.endDate = endDate;
				}
			// AJAX 요청 수행
			$.ajax({
				url : "/production/processUpdateRoasting",
				type : "POST",
				data : dataObject,
				success : function(response) {
					// 성공적으로 처리된 경우 수행할 코드
					console.log("상태 업데이트 성공!");
					Swal.fire('변경완료!');
					$.ajax({
						url: "/production/produceList3",
					type: "GET",
					data: dataObjectCom,
					success: function(data) {
						$("#produceListAll").html(data);
					},
					 	error: function(error) {
						console.error("Error fetching data:", error);
					}
					});
					

				},
				error : function(error) {
					// 요청 실패 시 수행할 코드
					Swal.fire("변경 할 수 없습니다.");
					console.error("상태 업데이트 실패:", error);
				}
			});
		});
		
	}); 

</script>

