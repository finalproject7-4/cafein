<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>
<link href="../resources/css/po.css" rel="stylesheet">

<!-- 로그인 여부(세션정보)에 따라서 페이지 이동 -->
<c:if test="${empty membercode}">
    <c:redirect url="/main/login" />
</c:if> 

<br>
<fiedset>
	<!-- 검색 폼 -->
		<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
				<form action="/production/WKList" method="GET" style="margin-bottom: 10px;">
				<h6>작업지시 조회</h6>
				<c:if test="${!empty param.searchBtn }">
				<input type="hidden" name="searchBtn" value="${param.searchBtn}" placeholder="납품처명을 입력하세요">
				</c:if>
				<span style="display:flex;">
				<label style="margin: 5px 10px 0 0;">검색</label>
				<input type="text" name="searchText" placeholder="검색어를 입력하세요" class="form-control fcsearch">
				<label style="margin: 5px 10px 0 0; margin-left:10em;">
				작업지시일자</label>		
				<input type="date" id="startDate" name="startDate" class="form-control fc fcsearch"> &nbsp; ~ &nbsp;
				<input type="date" id="endDate" name="endDate" class="form-control fc fcsearch">
				<input class="btn btn-sm btn-dark m-2 searchmini" type="submit" value="조회" data-toggle="tooltip" title="등록일이 필요합니다!" style="margin-left:2em"></span>
			</form>	
			<form action="POList" method="GET">
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
			<h6 class="mb-4">작업지시 관리  <span class="settingWK">[총 ${countWK}건]</span> </h6>

		<div class="col-12">
		<div class="buttonarea1" style="margin-bottom: 10px;">
			<input type="hidden" name="state" value="전체">
			<button type="button" class="btn btn-sm btn-primary"  id="allwk">전체</button>
			<input type="hidden" name="state" value="접수">
			<button type="button" class="btn btn-sm btn-success" id="stop">접수</button>
			<input type="hidden" name="state" value="진행">
			<button type="button" class="btn btn-sm btn-danger" id="ing">진행</button>
			<input type="hidden" name="state" value="완료">
			<button type="button" class="btn btn-sm btn-warning" id="complete">완료</button>
			
		</div>
		
				<script>
		$("#allwk").click(function() {
		   location.href="/production/WKList";
		});

		$("#stop").click(function () {
		 	console.log("접수 버튼 클릭됨");
			event.preventDefault();
		    location.href="/production/WKList?worksts=접수";
		});

		$("#ing").click(function() {
		 console.log("진행 버튼 클릭됨");
		 event.preventDefault();
		 location.href="/production/WKList?worksts=진행";
		});

		$("#complete").click(function() {
			console.log("완료 버튼 클릭됨");
			 event.preventDefault();
			 location.href="/production/WKList?worksts=완료";
		});

		function updateTotalCount() {
			var totalCount = $(".table tbody tr:visible").length;
			$(".settingWK").text("총 " + totalCount + "건");
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
		
					<c:if test="${departmentname eq '생산' and memberposition eq '팀장' or membername eq 'admin'}">
					<input type="button" class="btn btn-sm btn-dark" data-bs-toggle="modal"
					data-bs-target="#registModal" id="regist" value="등록">
					</c:if>
					<input type="hidden" class="btn btn-dark m-2" data-bs-toggle="modal" data-bs-target="#modifyModal" data-bs-whatever="@getbootstrap" value="수정">
			<form role="form" action="/production/modifyWK" method="post">
			<div class="table-responsive">
				<div class="table-responsive" style="text-align: center;">
					<table class="table" id="workTable">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">작업지시일</th>
								<th scope="col">작업지시코드</th>
								<th scope="col">수주코드</th>
								<th scope="col">납품처</th>
								<th scope="col">제품명</th>
								<th scope="col">지시상태</th>
								<th scope="col">지시수량</th>
								<th scope="col">완료일자</th>
								<th scope="col">담당자</th>
								<c:if test="${departmentname eq '생산' and memberposition eq '팀장' or membername eq 'admin'}">
								<th scope="col">관리</th>
								</c:if>
							</tr>
						</thead>
						<tbody>
						<c:set var="counter" value="1" />
							<c:choose>
								<c:when test="${empty WKList}">
									<p>No data available.</p>
								</c:when>
								<c:otherwise>
									<c:set var="counter" value="1" />
							<c:forEach items="${ WKList }" var="wk">
								<tr>
									<td>${wk.workid }</td>
									<td><fmt:formatDate value="${wk.workdate1 }"
											pattern="yyyy-MM-dd" /></td>
									<td>${wk.workcode }</td>
									<td>${wk.pocode }</td>
									<td>${wk.clientname}</td>
									<td>${wk.itemname }</td>
									<td style="font-weight: bold; ${wk.worksts == '완료'? 'color:red;' : ''}${wk.worksts == '진행'? 'color:blue;' : ''}">${wk.worksts }</td>
									<td>${wk.pocnt }</td>
									<c:choose>
									<c:when test="${empty wk.workdate2}">
										<td><b>업데이트 없음</b></td>
									</c:when>
									<c:otherwise>
										<td><fmt:formatDate value="${wk.workdate2}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
									</c:otherwise>
									</c:choose>
									<td>${wk.membername }</td>
									<!-- 버튼 수정 -->
									<c:if test="${sessionScope.membercode eq '1006' or membername eq 'admin'}">
									<td style="font-weight: bold; ${wk.worksts == '완료'? 'color:red;' : ''}">
									<c:if test="${wk.worksts == '완료'}">
									작업지시 완료
									</c:if>
									<c:if test="${wk.worksts == '접수'}">
									<button type="button" class="btn btn-sm btn-warning"
									onclick="openModifyModal('${wk.workid}', '${wk.worksts}', '${wk.workcode }', '${wk.pocode}', '${wk.clientname}', '${wk.itemname}',  '${wk.pocnt}', '${wk.workdate1}', '${wk.membercode}')">
									수정
									</button>
									<input type="button" class="btn btn-sm btn-secondary" value="삭제" id="deleteBtn">
									</c:if>
									<c:if test="${wk.worksts == '진행'}">
									<button type="button" class="btn btn-sm btn-warning"
									onclick="openModifyModal('${wk.workid}', '${wk.worksts}', '${wk.workcode }', '${wk.pocode}', '${wk.clientname}', '${wk.itemname}',  '${wk.pocnt}', '${wk.workdate1}', '${wk.membercode}')">
									수정
									</button>
									</c:if>
									</c:if>
								</tr>
							</c:forEach>
							</c:otherwise>
						</c:choose>
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

   						            	url = "/production/WKList?page=" + nextPage;

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
		                	url = "/production/WKList?page=" + pageValue;
			                
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

   				                	url = "/production/WKList?page=" + nextPage;
   				                
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
	</div>
</fiedset>
		<jsp:include page="registWK.jsp"/>
		<jsp:include page="modifyWK.jsp"/>



<script>
// 수정된 값을 서버로 전송

				// 직원 불러오기
				$(document).on('click', '#membercode2', function() {
					$('#mccodeModal1').modal('show');
				});

				// 선택한 행 불러오기
				$('.mccodeset1').click(function() {
					// 선택한 행의 데이터를 가져오기
					var membercode = $(this).find('td:eq(2)').text(); // 직원코드

					// 첫 번째 모달의 각 입력 필드에 데이터를 설정
					$('#membercode2').val(membercode);

					$('#mccodeModal1').modal('hide');
				});

			
$("#modifyButton").click(function() {
	
	
    // 가져온 값들을 변수에 저장
    var modifiedWorkid = $("#workid2").val();
    var modifiedWorksts = $("#worksts2").val();
    var modifiedWorkcode = $("#workcode2").val();
    var modifiedPocode = $("#pocode2").val();
    var modifiedClientName = $("#clientcode2").val();
    var modifiedItemName = $("#itemcode2").val();
    var modifiedPocnt = $("#pocnt2").val();
    var modifiedWorkdate1 = $("#workdate11").val();
    var modifiedMemberCode = $("#membercode2").val();

    
    // Ajax를 사용하여 서버로 수정된 값 전송
    $.ajax({
        type: "POST",
        url: "/production/modifyWK",
        data: {
        	 workid: modifiedWorkid,
             worksts: modifiedWorksts,
        	 workcode: modifiedWorkcode,
        	 pocode: modifiedPocode,
        	 clientname: modifiedClientName,
             itemname: modifiedItemName,
             pocnt: modifiedPocnt,
             workdate1: modifiedworkDate1,
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
	   
	   function openModifyModal(workid, worksts, workcode, pocode, clientname, itemname, pocnt, workdate1, membercode) {

		   
			console.log("workid:", workid);
			console.log("worksts:", worksts);
			console.log("workcode:", workcode);
			console.log("pocode:", pocode);
			console.log("clientname:", clientname);
			console.log("itemname:", itemname);
			console.log("pocnt:", pocnt);
			console.log("workdate1:", workdate1);
			console.log("membercode:", membercode);
			
		   
		   // 가져온 값들을 모달에 설정
		   $("#workid2").val(workid);
		    $("#worksts2").val(worksts);
		    $("#workcode2").val(workcode);
		    $("#pocode2").val(pocode);
		    $("#clientcode2").val(clientname);
		    $("#itemcode2").val(itemname);
		    $("#pocnt2").val(pocnt);
		    $("#workdate11").val(workdate1);
		    $("#membercode2").val(membercode);

		    // 모달 열기
		    $("#modifyModal").modal('show');
		    
		}
	   
	   // 작업지시 상태가 진행일 경우 다시 접수로 수정 불가능
	    $('#modifyModal').on('shown.bs.modal', function() {
	        // 현재 선택된 작업지시상태를 가져옴
	        var selectedStatus = $('#worksts2').val();

	        // 만약 선택된 상태가 '진행'이면 '접수'를 비활성화
	        if (selectedStatus === '진행') {
	            $('#worksts2 option[value="접수"]').prop('disabled', true);
	        }
	    });

	    // 작업지시상태가 변경될 때
	    $('#worksts2').change(function() {
	        // 선택된 상태가 '진행'이면 '접수'를 비활성화
	        if ($(this).val() === '진행') {
	            $('#worksts2 option[value="접수"]').prop('disabled', true);
	        } else {
	            // 선택된 상태가 '진행'이 아니면 '접수'를 활성화
	            $('#worksts2 option[value="접수"]').prop('disabled', false);
	        }
	    });

	    // 모달이 닫힐 때
	    $('#modifyModal').on('hidden.bs.modal', function() {
	        // 비활성화된 옵션을 해제
	        $('#worksts2 option[value="접수"]').prop('disabled', false);
	    });
	   
	    // 작업지시일자 클릭시 현재 날짜로 업데이트
	    $('#workdate11').click(function(){
	        var today = new Date();
	        // 날짜를 YYYY-MM-DD 형식으로 포맷팅
	        var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
	        $('#workdate11').val(formattedDate);
	    });
	    
		// 작업지시 삭제 (작업지시가 대기일 경우에만 삭제 가능)
	    $("td").on("click", "#deleteBtn", function() {
	    	
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
	        	
	        	var workid = $(this).closest("tr").find("td:first").text();
				console.log(workid);
	        	
	        	// AJAX 요청 수행
	        	$.ajax({
	           		url : "/production/WKDelete",
	           		type : "POST",
	           		data : {
	           			workid : workid
	           		},
	          		success : function(response) {
	              		// 성공적으로 처리된 경우 수행할 코드
	              		console.log("삭제 성공");
	              		location.reload();
	           		},
	           		error : function(error) {
	              		// 요청 실패 시 수행할 코드
	              		console.error("삭제 실패:", error);
	           		}
				});
	        	
	        	} 
	   		 })
	   		 
	     });		
	    
	   </script>
	   


<%@ include file="../include/footer.jsp"%>