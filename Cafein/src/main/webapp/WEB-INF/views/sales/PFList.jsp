<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>
<br>
<fiedset>
	<!-- 검색 폼 -->
		<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
			<form name="dateSearch" action="/sales/PFList" method="get">
				<c:if test="${!empty param.searchBtn }">
				<input type="hidden" name="searchBtn" value="${param.searchBtn}" placeholder="검색">
				</c:if>
				검색 <input class="pfSearch" type="text" name="searchText" placeholder="검색">
				작업지시일자 
				<input type="date" id="startDate" name="startDate" required> ~
				<input type="date" id="endDate" name="endDate" required>
				<input class="search" type="submit" value="검색" data-toggle="tooltip" title="등록일이 필요합니다!">
				<br>
			</form>
				<form action="PFList" method="GET">
					<c:if test="${!empty param.searchBtn }">
						<input type="hidden" name="searchBtn" value="${param.searchBtn}">
					</c:if>
					<c:if test="${!empty param.startDate }">
						<input type="hidden" value="${param.startDate }" name="startDate">
					</c:if>
					<c:if test="${!empty param.endDate }">
						<input type="hidden" value="${param.endDate }" name="endDate">
					</c:if>
				</form>

		</div>
	</div>

	<!-- 작업지시 조회 -->
	<div class="col-12" style="margin-top: 20px;">
		<div class="bg-light rounded h-100 p-4">
			<h6 class="mb-4">실적 관리  <span class="settingPF">[총 ${countPF}건]</span> </h6>

		<div class="col-12">
			<input type="hidden" name="state" value="전체">
			<button type="button" class="btn btn-outline-dark" id="allpf">전체</button>
			<input type="hidden" name="state" value="불량">
			<button type="button" class="btn btn-outline-dark" id="stop">불량</button>
		</div>
		
						<script>
		$("#allpf").click(function() {
		   location.href="/sales/PFList";
		});

		$("#stop").click(function () {
		 	console.log("불량 버튼 클릭됨");
			event.preventDefault();
		    location.href="/sales/PFList=불량";
		});

		function updateTotalCount() {
			var totalCount = $(".table tbody tr:visible").length;
			$(".settingPF").text("총 " + totalCount + "건");
		}

		// 필터링할 때마다 호출하여 업데이트
		function updateRowNumbers() {
			var counter = 1;
			$(".table tbody tr:visible").each(function() {
				$(this).find('td:nth-child(2)').text(counter);
				counter++;
			});

			// 총 건수 업데이트 호출
			updateTotalCount();
		}
		</script>
					<input type="hidden" class="btn btn-dark m-2" data-bs-toggle="modal" data-bs-target="#modifyModal" data-bs-whatever="@getbootstrap" value="수정">
			<form role="form" action="/sales/PFList" method="post">
			<div class="table-responsive">
				<div class="table-responsive" style="text-align: center;">
					<table class="table" id="pfTable">
						<thead>
							<tr>
								<th scope="col">No.</th>
								<th scope="col">지시완료일자</th>
								<th scope="col">작업지시코드</th>
								<th scope="col">납품처</th>
								<th scope="col">제품명</th>
								<th scope="col">지시수량</th>
								<th scope="col">불량수량</th>
								<th scope="col">불량사유</th>
								<th scope="col">담당자</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="counter" value="1" />
							<c:forEach items="${ AllPFList }" var="pf">
								<tr>
									<td>${pf.workid }</td>
									<td><fmt:formatDate value="${pf.workdate2 }"
											pattern="yyyy-MM-dd" /></td>
									<td>${pf.workcode }</td>
									<td>${pf.clientname}</td>
									<td>${pf.itemname }</td>
									<td>${pf.pocnt }</td>
									<td>${pf.returncount }</td>
									<td>${pf.returnreason }</td>
									<td>${pf.membercode }</td>
									<td>
									<!-- 버튼 수정 -->
									<button type="button" class="btn btn-outline-dark"
										onclick="openModifyModal('${pf.workid}', '${pf.workcode }', '${pf.clientname}', '${pf.itemname}', '${pf.pocnt}', '${pf.returnreason}', '${pf.returncount}', '${pf.workdate2}', '${pf.membercode}')">
   										수정
									</button>
									</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
				</div>
			</div>
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
      						
							<!-- 버튼에 파라미터 추가 이동 (이전) -->
							<script>
								$(document).ready(function(){
   									$('.pageBlockPrev').click(function(e) {
   										e.preventDefault(); // 기본 이벤트 제거
   									
   						            	let prevPage = $(this).data('page');
   									
   						            	let searchBtn = "${param.searchBtn}";
   						            	let searchText = "${param.searchText}";
   						            	let startdate = "${param.startdate}";
   						            	let enddate = "${param.enddate}";

   						            	url = "/sales/PFList?page=" + nextPage;

   						            	if (searchBtn) {
   						            	  url += "&searchBtn=" + encodeURIComponent(searchBtn);
   						            	}

   						            	if (searchText) {
   						            	  url += "&searchText=" + encodeURIComponent(searchText);
   						            	}

   						            	if (startdate) {
   						            	  url += "&startdate=" + encodeURIComponent(startdate);
   						            	}

   						            	if (enddate) {
   						            	  url += "&enddate=" + encodeURIComponent(enddate);
   						            	}

   				                		location.href = url;
    								});
								});
							</script>
							<!-- 버튼에 파라미터 추가 이동 (이전) -->
      						
    					</c:if>
    				</li>
					<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1" var="i">
    				<li class="page-item ${pageVO.cri.page == i? 'active' : ''}"><a class="page-link pageBlockNum" href="" data-page="${i}">${i }</a></li>
					
					<!-- 버튼에 파라미터 추가 이동 (번호) -->
					<script>
					$(document).ready(function(){
			            $('.pageBlockNum[data-page="${i}"]').click(function (e) {
			                e.preventDefault(); // 기본 이벤트 방지
			                
			               	let searchText = "${param.searchText}";	
			                let searchBtn = "${param.searchBtn}";
			                let startdate = "${param.startdate}";
			            	let enddate = "${param.enddate}";

			                let pageValue = $(this).data('page');
		                	url = "/sales/PFList?page=" + pageValue;
			                
			                if (searchBtn) {
			                    url += "&searchBtn=" + encodeURIComponent(searchBtn);
			                }
			                
			                if (searchText) {
			                    url += "&searchText=" + encodeURIComponent(searchText);
			                }
			                if (startdate) {
			            	  url += "&startdate=" + encodeURIComponent(startdate);
			            	}

			            	if (enddate) {
			            	  url += "&enddate=" + encodeURIComponent(enddate);
			            	}
			                
			                location.href = url;
			            });
					});	
					</script>
					<!-- 버튼에 파라미터 추가 이동 (번호) -->
					
					</c:forEach>
    				<li class="page-item">
    					<c:if test="${pageVO.next }">
      						<a class="page-link pageBlockNext" href="" aria-label="Next" data-page="${pageVO.endPage + 1}">
        						<span aria-hidden="true">&raquo;</span>
      						</a>	
      					<!-- 버튼에 파라미터 추가 이동 (이후) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockNext').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거
   									
   						            let nextPage = $(this).data('page');
   									
   									let searchBtn = "${param.searchBtn}";
   									let searchText = "${param.searchText}";
   									let startdate = "${param.startdate}";
					            	let enddate = "${param.enddate}";

   				                	url = "/sales/PFList?page=" + nextPage;
   				                
   				                	if (searchBtn) {
   				                    	url += "&searchBtn=" + encodeURIComponent(searchBtn);
   				                	}
   				                
   				                	if (searchText) {
   				                    	url += "&searchText=" + encodeURIComponent(searchText);
   				                	}
   				                	if (startdate) {
					            	  url += "&startdate=" + encodeURIComponent(startdate);
					            	}

					            	if (enddate) {
					            	  url += "&enddate=" + encodeURIComponent(enddate);
					            	}
   				                
   				                	location.href = url;
    							});
							});
						</script>
						<!-- 버튼에 파라미터 추가 이동 (이전) -->  					
    					</c:if>
    				</li>
  				</ul>
			</nav>
			<!-- 페이지 블럭 생성 -->
		</div>
</fiedset>

		<jsp:include page="modifyPF.jsp"/>

<!-- 검색 -->
<script>

$('.workSearch').on('input', function(event) {
    filterRows(event);
});
    
function filterRows(event) {
	// 기본 폼 제출 동작 방지
	event.preventDefault();

	// 입력된 키워드 가져오기
	var keyword = $('.workSearch').val().toLowerCase();

	// 시작일자와 종료일자 가져오기
	var startDate = $('#startDate').val() ? new Date($('#startDate').val())
			: null;
	var endDate = $('#endDate').val() ? new Date($('#endDate').val())
			: null;

	// 테이블의 모든 행 가져오기
	var rows = $('.table tbody tr');

	// 각 행에 대해 키워드 및 날짜 포함 여부 확인
	rows.each(function() {
		var clientName = $(this).find('td:nth-child(5)').text()
				.toLowerCase();
		var itemName = $(this).find('td:nth-child(6)').text()
		.toLowerCase();
		var workCode = $(this).find('td:nth-child(3)').text().toLowerCase(); // 필요에 따라 열 위치 조절
        var poCode = $(this).find('td:nth-child(4)').text().toLowerCase(); // 필요에 따라 열 위치 조절
		var workDateStr = $(this).find('td:nth-child(2)').text();
		var workDate = workDateStr ? new Date(workDateStr) : null;

		var keywordMatch = keyword === '' || clientName.includes(keyword) || itemName.includes(keyword)|| workCode.includes(keyword) || poCode.includes(keyword);
		var dateMatch = (startDate === null || (workDate !== null
				&& workDate >= startDate && workDate <= endDate));

		if (keywordMatch && dateMatch) {
			$(this).show(); // 키워드 및 날짜가 포함된 경우 행을 표시
		} else {
			$(this).hide(); // 키워드 또는 날짜가 포함되지 않은 경우 행을 숨김
		}
		console.log('거래처명:', clientName, '품목명:', itemName, '작업코드:', workCode, 'PO코드:', poCode, '작업일자:', workDate,
	            '키워드 일치:', keywordMatch, '날짜 일치:', dateMatch);
	});

	// 번호 업뎃
	updateRowNumbers();
	// 총 건수 업뎃
	updateTotalCount();
	// 폼이 실제로 제출되지 않도록 false 반환
	return false;
}

// 테이블에 표시되는 행의 번호를 업데이트하는 함수
function updateRowNumbers() {
	// 표시된 행만 선택하여 번호 업데이트
	var visibleRows = $('.table tbody tr:visible');
	visibleRows.each(function(index) {
		// 첫 번째 자식 요소인 td 엘리먼트를 찾아 번호를 업데이트
		$(this).find('td:first').text(index + 1);
	});
}
// 총 건수 업데이트 함수
function updateTotalCount() {
	var totalCount = $('.table tbody tr:visible').length;
	$('.mb-5').text('[총 ' + totalCount + '건]');
}



$("#allwk").click(function() {
	$(".table tbody tr").show();
	updateTotalCount();
});

$("#stop").click(function() {
	$(".table tbody tr").hide();
	$(".table tbody tr:has(td:nth-child(7):contains('대기'))").show();
	updateTotalCount();
});

$("#ing").click(function() {
	$(".table tbody tr").hide();
	$(".table tbody tr:has(td:nth-child(7):contains('진행'))").show();
	updateTotalCount();
});

$("#complete").click(function() {
	$(".table tbody tr").hide();
	$(".table tbody tr:has(td:nth-child(7):contains('완료'))").show();
	updateTotalCount();
});



function updateTotalCount() {
	var totalCount = $(".table tbody tr:visible").length;
	$(".mb-5").text("[총 " + totalCount + "건]");
}


</script>

<script>
// 수정된 값을 서버로 전송
									
$("#modifyButton").click(function() {
    // 가져온 값들을 변수에 저장
    var modifiedWorkid = $("#workid3").val();
    var modifiedWorkCode = $("#workcode3").val();
    var modifiedClientName = $("#clientname3").val();
    var modifiedItemName = $("#itemname3").val();
    var modifiedPocnt = $("#pocnt3").val();
    var modifiedReturnCount = $("#returncount3").val();
    var modifiedReturnReason = $("#returnreason3").val();
    var modifiedWorkdate2 = $("#workdate23").val();
    var modifiedMemberCode = $("#membercode3").val();

    // Ajax를 사용하여 서버로 수정된 값 전송
    $.ajax({
        type: "POST",
        url: "/sales/modifyPF",
        data: {
        	 workid: modifiedWorkid,
        	 workcode: modifiedWorkCode,
        	 clientname: modifiedClientName,
             itemname: modifiedItemName,
             pocnt: modifiedPocnt,
             returncount: modifiedReturnCount,
             returnreason: modifiedReturnReason,
             workdate2: modifiedworkdate2,
             membercode: modifiedMemberCode
        },
        success: function(response) {
            console.log("Modification success:", response);
            $("#modifyModal").modal('hide');
        },
        error: function(error) {
            console.error("Error during modification:", error);
        }
    });
});
	   function openModifyModal(workid, workcode, clientname, itemname, pocnt, returnreason, returncount, workdate2, membercode) {

		   console.log('workid', workid);
		   console.log('workcode', workcode);
		   console.log('clientname', clientname);
		   console.log('itemname', itemname);
		   console.log('pocnt', pocnt);
		   console.log('returncount', returncount);
		   console.log('returnreason', returnreason);
		   console.log('workdate23', workdate2);
		   console.log('membercode', membercode);
		   
		   // 가져온 값들을 모달에 설정
		   $("#workid3").val(workid);
		   $("#workcode3").val(workcode);
		    $("#clientname3").val(clientname);
		    $("#itemname3").val(itemname);
		    $("#pocnt3").val(pocnt);
		    $("#returncount3").val(returncount);
		    $("#returnreason3").val(returnreason);
		    $("#workdate23").val(workdate2);
		    $("#membercode3").val(membercode);

		    // 모달 열기
		    $("#modifyModal").modal('show');
		    
		}
	    
	   </script>
	   


<%@ include file="../include/footer.jsp"%>