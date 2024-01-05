<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>
<br>
<fieldset>
	<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
				<form action="/sales/POList" method="GET" style="margin-bottom: 10px;">
				<h6>수주 조회</h6>
				<c:if test="${!empty param.searchBtn }">
				<input type="hidden" name="searchBtn" value="${param.searchBtn}" placeholder="납품처명을 입력하세요">
				</c:if>
				납품처조회
				<input type="text" name="searchText" placeholder="납품처명을 입력하세요">
				수주일자				
				<input type="date" id="startDate" name="startDate" required> ~
				<input type="date" id="endDate" name="endDate" required>
				<input class="search" type="submit" value="검색" data-toggle="tooltip" title="등록일이 필요합니다!">
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
	
	
	
	<br>
	<script>
	$(".search").click(function (searchBtnValue) {
	    $.ajax({
	        url: "/sales/POList",
	        type: "GET",
	        data: {
	            searchBtn: searchBtnValue
	        },
	        success: function (data) {
	            $(".table-responsive").html(data);
	        },
	        error: function (error) {
	            console.error("Error fetching data:", error);
	        }
	    });

	    $("form[action='/sales/POList']").submit(function (event) {
	        event.preventDefault(); // 기본 폼 제출 동작 방지

	        // 폼 데이터 수집
	        let formData = {
	            startDate: $("input[name='startDate']").val(),
	            endDate: $("input[name='endDate']").val()
	        };

	        // 선택된 검색 버튼 값이 있으면 추가
	        if ($("input[name='searchBtn']").length > 0) {
	            formData.searchBtn = $("input[name='searchBtn']").val();
	        }

	        // AJAX 요청 수행
	        $.ajax({
	            url: "/sales/POList",
	            type: "GET",
	            data: formData,
	            success: function (data) {
	                // 성공적으로 데이터를 받아왔을 때 처리할 코드
	                $(".table-responsive").html(data);
	            },
	            error: function (error) {
	                console.error("Error fetching data:", error);
	            }
	        });
	    });

	    /* 날짜비교 */
	    const checkDates = function () {
	        const startDateStr = document.getElementById("startDate").value;
	        const endDateStr = document.getElementById("endDate").value;

	        // 둘 다 유효한 날짜 문자열인지 확인
	        if (startDateStr && endDateStr) {
	            const startDate = new Date(startDateStr);
	            const endDate = new Date(endDateStr);

	            if (startDate > endDate) {
	                Swal.fire("종료일은 시작일과 같거나 이후여야 합니다.");
	                document.getElementById("endDate").value = "";
	            }
	        }
	    };

	    // 페이지 로드 시 한 번 실행
	    checkDates();

	    // 날짜 입력 값에서 포커스가 빠져나갈 때 실행
	    $("#startDate, #endDate").on("blur", checkDates);

	    // 툴팁
	    $('[data-toggle="tooltip"]').tooltip();
	});

	
	</script>

	
		
		<!-- 수주 리스트 테이블 조회 -->
	<div class="col-12">
		<div class="bg-light rounded h-100 p-4" id="ListID">
		<form action="POListPrint" method="GET">
			<input id="ListExcel" type="submit" value="리스트 출력(.xlsx)" class="btn btn-sm btn-success">
		</form>
			<form role="form" action="/sales/cancelUpdate" method="post">
				<h6 class="settingPO">수주 관리 [총 ${countPO}건]</h6>
				<!-- 수주 상태에 따라 필터링하는 버튼 -->
		<div class="btn-group" role="group">
			<input type="hidden" name="state" value="전체">
			<button type="button" class="btn btn-outline-dark" id="allpo">전체</button>
			<input type="hidden" name="state" value="대기">
			<button type="button" class="btn btn-outline-dark" id="stop">대기</button>
			<input type="hidden" name="state" value="진행">
			<button type="button" class="btn btn-outline-dark" id="ing">진행</button>
			<input type="hidden" name="state" value="완료">
			<button type="button" class="btn btn-outline-dark" id="complete">완료</button>
			<input type="hidden" name="state" value="취소">
			<button type="button" class="btn btn-outline-dark" id="cancel">취소</button>
		</div>
		<script>
		$("#allpo").click(function() {
		   location.href="/sales/POList";
		});

		$("#stop").click(function () {
		 	console.log("대기 버튼 클릭됨");
			event.preventDefault();
		    location.href="/sales/POList?postate=대기";
		});

		$("#ing").click(function() {
		 console.log("진행 버튼 클릭됨");
		 event.preventDefault();
		 location.href="/sales/POList?postate=진행";
		});

		$("#complete").click(function() {
			console.log("완료 버튼 클릭됨");
			 event.preventDefault();
			 location.href="/sales/POList?postate=완료";
		});

		$("#cancel").click(function() {
			console.log("취소 버튼 클릭됨");
			 event.preventDefault();
			 location.href="/sales/POList?postate=취소";
		});

		function updateTotalCount() {
			var totalCount = $(".table tbody tr:visible").length;
			$(".settingPO").text("총 " + totalCount + "건");
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
		
				 <input type="button" class="btn btn-dark m-2" data-bs-toggle="modal"
					data-bs-target="#registModal" id="regist" value="등록"> 
					<input type="hidden" class="btn btn-dark m-2" data-bs-toggle="modal"
					data-bs-target="#modifyModal" data-bs-whatever="@getbootstrap" value="수정">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">수주상태</th>
								<th scope="col">수주코드</th>
								<th scope="col">납품처</th>
								<th scope="col">품명</th>
								<th scope="col">수량</th>
								<th scope="col">수주일자</th>
								<th scope="col">수정일자</th>
								<th scope="col">완납예정일</th>
								<th scope="col">담당자</th>
								<th scope="col">관리</th>
								<th scope="col">진행</th>
								<th scope="col">납품서발행</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="counter" value="1" />
							<c:choose>
								<c:when test="${empty POList}">
									<p>No data available.</p>
								</c:when>
								<c:otherwise>
									<c:set var="counter" value="1" />
									<c:forEach items="${POList}" var="po" varStatus="status">
										<tr>
											<td id="poidCancel" style="display: none;">${po.poid }</td>
											<td>${counter }</td>
											<td>${po.postate }</td>
											<td>${po.pocode }</td>
											<td>${po.clientname}</td>
											<td>${po.itemname}</td>
											<td>${po.pocnt}</td>
											<td><fmt:formatDate value="${po.ordersdate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
											<c:choose>
												<c:when test="${empty po.updatedate}">
													<td>업데이트 날짜 없음</td>
												</c:when>
												<c:otherwise>
													<td><fmt:formatDate value="${po.updatedate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
												</c:otherwise>
											</c:choose>
											<td><fmt:formatDate value="${po.ordersduedate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
											<td>${po.membercode}</td>
											<td>
												<button type="button" class="btn btn-outline-dark"
													onclick="openModifyModal('${po.poid}','${po.clientid}','${po.itemid}','${po.clientname}', '${po.itemname}', '${po.postate}', '${po.pocnt}', '${po.ordersdate}', '${po.ordersduedate}', '${po.membercode}')">
													수정</button> <input value="취소" type="submit" class="btn btn-outline-dark cancelUpdate" data-poid="${po.poid}">
											</td>
											<td><input value="진행" type="submit" class="btn btn-outline-dark ingUpdate" data-poid="${po.poid}"></td>
											<td>
												<input value="불러오기" type="button" class="btn btn-outline-dark" onclick="receiptSend(`${po.poid}`)">

												 
											</td>
										</tr>
										<c:set var="counter" value="${counter+1 }" />
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
<script>
function receiptSend(poid) {
    $.ajax({
        url: '/sales/receipt',  // 서버에서 데이터를 가져올 URL
        type: 'GET',
        data: { poid: poid },  // poid 값을 서버에 전달
        success: function() {

            // 예시: 새로운 페이지로 이동
            location.href = "/sales/receipt?poid=" + encodeURIComponent(poid);
        },
        error: function() {
            console.error('Error fetching receipt information');
        }
    });
}

</script>
				
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

   						            	url = "/sales/POList?page=" + nextPage;

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
		                	url = "/sales/POList?page=" + pageValue;
			                
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

   				                	url = "/sales/POList?page=" + nextPage;
   				                
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
			</form>
		</div>
	</div>

	<!-- 진행 동작(수주상태 진행으로 변경) -->
	<script>
		$(".ingUpdate").click(function() {
			event.preventDefault();

			var poid = $(this).data("poid");
			var postate = $(this).closest('tr').find('td:nth-child(3)').text(); // 주문 상태 가져오기

			console.log('poid 값:', poid);
			console.log('postate 값:', postate);

			// 주문 상태가 '대기'인 경우만 진행 가능
			if (postate !== '대기') {
				Swal.fire({
					title : '이 주문은 진행할 수 없는 상태입니다.',
					text : '수주상태를 확인해주세요.',
					icon : 'error',
				});
				return;
			}

			Swal.fire({
				title : '수주를 진행하시겠습니까?',
				text : '수주가 진행상태로 업데이트 됩니다.',
				icon : 'warning',
				showCancelButton : true,
				confirmButtonColor : '#3085d6',
				cancelButtonColor : '#d33',
				confirmButtonText : '승인',
				cancelButtonText : '취소',
				reverseButtons : false,
			}).then(function(result) {
				if (result.value) { //승인시
					// Ajax 요청 실행
					$.ajax({
						type : 'POST',
						url : '/sales/ingUpdate',
						data : {
							poid : poid
						},
						success : function(response) {
							console.log('Ajax success:', response);
							location.reload();
						},
						error : function(error) {
							console.error('Error during cancellation:', error);
							Swal.fire('취소에 실패했습니다.', '다시 시도해주세요.', 'error');
						}
					});
				}
			});
		});
	</script>
	<!-- 진행 동작(수주상태 취소로 변경) -->
	<script>
		$(".cancelUpdate").click(function() {
			event.preventDefault();

			var poid = $(this).data("poid");
			var postate = $(this).closest('tr').find('td:nth-child(3)').text(); // 주문 상태 가져오기

			console.log('poid 값:', poid);
			console.log('postate 값:', postate);

			// 주문 상태가 '완료'인 경우 취소 불가
			if (postate === '완료') {
				Swal.fire({
					title : '이미 완료된 주문입니다.',
					text : '완료된 상태는 취소할 수 없습니다.',
					icon : 'error',
				});
				return;
			}
			// 주문 상태가 '완료'인 경우 취소 불가
			if (postate === '취소') {
				Swal.fire({
					title : '이미 취소된 주문입니다.',
					icon : 'error',
				});
				return; // 취소할 수 없는 상태이므로 함수 종료
			}

			Swal.fire({
				title : '수주를 취소하시겠습니까?',
				text : '수주가 취소상태로 업데이트 됩니다.',
				icon : 'warning',
				showCancelButton : true,
				confirmButtonColor : '#3085d6',
				cancelButtonColor : '#d33',
				confirmButtonText : '승인',
				cancelButtonText : '취소',
				reverseButtons : false,
			}).then(function(result) {
				if (result.value) { //승인시
					// Ajax 요청 실행
					$.ajax({
						type : 'POST',
						url : '/sales/cancelUpdate',
						data : {
							poid : poid
						},
						success : function(response) {
							console.log('Ajax success:', response);
							location.reload();
						},
						error : function(error) {
							console.error('Error during cancellation:', error);
							Swal.fire('취소에 실패했습니다.', '다시 시도해주세요.', 'error');
						}
					});
				}
			});
		});
	</script>





	<!-- 품목 등록 모달 -->
	<jsp:include page="registPO.jsp" />
	<!-- 품목 수정 모달 -->
	<jsp:include page="modifyPO.jsp" />

	<!-- 납품처 조회 모달 -->
	<div class="modal fade" id="clientSM" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">납품처 조회</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">

					납품처명 <input type="search" class="clientNS"><br> 납품처코드 <input type="search" class="clientCS">
					<button id="clibtn" type="submit" class="btn btn-dark m-2">조회</button>
					<br> <br>
					<div class="col-12">
						<div class="bg-light rounded h-100 p-4">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">납품처명</th>
										<th scope="col">납품처코드</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${cliList}" var="cli">
										<tr class="clientset">
											<td>${cli.clientname }</td>
											<td>${cli.clientcode }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="modal-footer"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 품목 조회 모달 -->
	<div class="modal fade" id="itemSM" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">품목 조회</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">

					품명 <input type="search" class="itemNS"><br> 품목코드 <input type="search" class="itemCS">
					<button id="itembtn" type="submit" class="btn btn-dark m-2">조회</button>
					<br> <br>
					<div class="col-12">
						<div class="bg-light rounded h-100 p-4">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">품명</th>
										<th scope="col">품목코드</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${iList}" var="item">
										<tr class="itemset">
											<td>${item.itemname }</td>
											<td>${item.itemcode }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="modal-footer"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</fieldset>


<script>
	/* 리스트 값 수정 모달로 값 전달 */
	function openModifyModal(poid, clientid, itemid, clientname, itemname,
			postate, pocnt, ordersdate, ordersduedate, membercode) {
		console.log('poid:', poid);
		console.log('clientid:', clientid);
		console.log('itemid:', itemid);
		console.log('clientname:', clientname);
		console.log('itemname:', itemname);
		console.log('postate:', postate);
		console.log('pocnt:', pocnt);
		console.log('ordersdate:', ordersdate);
		console.log('ordersduedate:', ordersduedate);
		console.log('membercode:', membercode);

		// 가져온 값들을 모달에 설정
		$("#poid3").val(poid);
		$("#clientid3").val(clientid);
		$("#itemid3").val(itemid);
		$("#clientid2").val(clientname);
		$("#itemid2").val(itemname);
		$("#floatingSelect2").val(postate);
		$("#pocnt2").val(pocnt);
		$("#ordersdate2").val(ordersdate);
		$("#date2").val(ordersduedate);
		$("#membercode2").val(membercode);

		// 모달 열기
		$("#openModifyModal").modal('show');
	}

	/*달력 이전날짜 비활성화*/
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];

	var clientSM = document.getElementById('clientSM');
	clientSM.addEventListener('show.bs.modal', function(event) {
		var button = event.relatedTarget;
		var recipient = button.getAttribute('data-bs-whatever');
		var modalTitle = clientSM.querySelector('.modal-title');
		var modalBodyInput = clientSM.querySelector('.modal-body input');
	});

	// 납품처 조회 모달
	$(".clientSearch1, .clientSearch2").click(function() {
		$("#clientSM").modal('show');
	});

	// 품목 조회 모달
	$(".itemSearch1, .itemSearch2").click(function() {
		$("#itemSM").modal('show');
	});

	// 클릭한 행의 정보를 가져와서 clientNS와 clientCS에 입력
	$(".clientset").click(function() {
		var clientName = $(this).find('td:eq(0)').text();
		var clientCode = $(this).find('td:eq(1)').text();

		$(".clientNS").val(clientName);
		$(".clientCS").val(clientCode);
	});

	$(".itemset").click(function() {
		var itemName = $(this).find('td:eq(0)').text();
		var itemCode = $(this).find('td:eq(1)').text();

		$(".itemNS").val(itemName);
		$(".itemCS").val(itemCode);
	});

	$("#clibtn").click(function() {
		$(".clientSearch1").val($(".clientNS").val());
		$(".clientSearch2").val($(".clientCS").val());
		$("#clientSM").modal('hide');
	});
	$("#itembtn").click(function() {
		$(".itemSearch1").val($(".itemNS").val());
		$(".itemSearch2").val($(".itemCS").val());
		$("#itemSM").modal('hide');
	});

	$('#todaypo').click(
			function() {
				var today = new Date();
				// 날짜를 YYYY-MM-DD 형식으로 포맷팅
				var formattedDate = today.getFullYear() + '-'
						+ ('0' + (today.getMonth() + 1)).slice(-2) + '-'
						+ ('0' + today.getDate()).slice(-2);
				$('#todaypo').val(formattedDate);
			});

	$("#searchbtn").click(function() {
		// 수주일자
		var podateStart = $("input[name='podateStart']").val();
		var podateEnd = $("input[name='podateEnd']").val();

		// 납품처조회
		var clientCode = $(".clientSearch1").val();
		var clientName = $(".clientSearch2").val();

		// 납품예정일
		var ordersDueDateStart = $("input[name='ordersDueDateStart']").val();
		var ordersDueDateEnd = $("input[name='ordersDueDateEnd']").val();

		// 품목조회
		var itemCode = $(".itemSearch1").val();
		var itemName = $(".itemSearch2").val();

		// Ajax를 사용해 서버로 데이터 전송 및 조회
		$.ajax({
			type : "GET",
			url : "/sales/POList",
			data : {
				podateStart : podateStart,
				podateEnd : podateEnd,
				clientCode : clientCode,
				clientName : clientName,
				ordersDueDateStart : ordersDueDateStart,
				ordersDueDateEnd : ordersDueDateEnd,
				itemCode : itemCode,
				itemName : itemName
			},
			success : function(POList) {
				// 성공 시에 테이블을 생성하고 화면에 표시
				var tableHtml = '<table>';
				for (var i = 0; i < POList.length; i++) {
					tableHtml += '<tr>';
					tableHtml += '<td>' + POList[i].poid + '</td>';
					tableHtml += '<td>' + POList[i].postate + '</td>';
					tableHtml += '<td>' + POList[i].pocode + '</td>';
					tableHtml += '<td>' + POList[i].clientname + '</td>';
					tableHtml += '<td>' + POList[i].itemname + '</td>';
					tableHtml += '<td>' + POList[i].pocnt + '</td>';
					tableHtml += '<td>' + POList[i].ordersdate + '</td>';
					tableHtml += '<td>' + POList[i].updatedate + '</td>';
					tableHtml += '<td>' + POList[i].ordersduedate + '</td>';
					tableHtml += '<td>' + POList[i].membercode + '</td>';
					tableHtml += '</tr>';
				}
				tableHtml += '</table>';

				$("#result").html(tableHtml);
			},
			error : function(error) {
				console.error("Error during search:", error);
			}
		});

	});
</script>



<%@ include file="../include/footer.jsp"%>