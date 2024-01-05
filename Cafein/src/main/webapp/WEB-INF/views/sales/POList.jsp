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

		
				 <input type="button" class="btn btn-dark m-2" data-bs-toggle="modal"
					data-bs-target="#registModal" id="regist" value="등록"> 
					<input type="hidden" class="btn btn-dark m-2" data-bs-toggle="modal"
					data-bs-target="#modifyModal" data-bs-whatever="@getbootstrap" value="수정">
					<input type="hidden" class="btn btn-dark m-2" data-bs-toggle="modal"
					data-bs-target="#openReceiptModal" data-bs-whatever="@getbootstrap" value="납품서">
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
												<input value="불러오기" type="button" class="btn btn-outline-dark" 
												onclick="openReceiptModal('${po.poid}','${po.clientid}','${po.itemid}','${po.clientname}', '${po.itemname}', '${po.postate}', '${po.pocnt}', '${po.ordersdate}', '${po.ordersduedate}', '${po.membercode}')">

												 
											</td>
										</tr>
										<c:set var="counter" value="${counter+1 }" />
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
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

<!--납품서 모달창 -->
	<div class="modal fade" id="openReceiptModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">납품서 미리보기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<form role="form" action="/sales/modifyPO" method="post">
				poid<input type="text" name="poid" id="rpoid"><br>
				clientid<input type="text" name="clientid" id="rclientid"><br>
				itemid<input type="text" name="itemid" id="ritemid"><br>
				
				<div class="modal-body">
				납품처/코드
				<input autocomplete="off" id="rclientname" name="clientname" class="form-control mb-3" type="text"  readonly="readonly">
				
				품목명/코드
				<input autocomplete="off" id="ritemname" name="itemname" class="form-control mb-3" type="text"  >
					<div class="mb-3">
						<label for="postate" class="col-form-label"><b>수주상태</b></label>
						<select class="form-select" id="rfloatingSelect" name="postate">
						    <optgroup label="수주상태">
						        <option value="대기">대기</option>
						        <option value="진행">진행</option>
						        <option value="완료">완료</option>
						        <option value="취소">취소</option>
						    </optgroup>
						</select>
					</div>	
					수량
					<input autocomplete="off" id="rpocnt" name="pocnt" class="form-control mb-3" type="number" value="">
					
					<div class="row">
					<div class="col">
					수주일자
					<input name="ordersdate" id="rordersdate"  type="text"  class="form-control"  readonly>
					</div>
					
					<div class="col">
					완납예정일
					<input name="ordersduedate" type="date" id="rdate" class="form-control" value="">
					</div>
					</div><br>
					
					<br>
					
					담당자
					<input autocomplete="off" id="rmembercode" name="membercode" class="form-control mb-3" type="number" value="">
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" id="receiptBtn">저장</button>
				</div>
				</form>
			</div>
		</div>
	</div>


<script type="text/javascript">
$(document).ready(function() {
	
	$("#receiptBtn").submit(function (event) {
	    event.preventDefault(); // 기본 동작 중지

	$.ajax({
        type: "GET",
        url: "/sales/receipt",
        data: {
            clientname: modifiedClientName,
            itemname: modifiedItemName,
            postate: modifiedPostate,
            pocnt: modifiedPocnt,
            ordersdate: modifiedOrdersDate,
            updatedate: modifiedUpdatedate,
            ordersduedate: modifiedOrdersDueDate,
            membercode: modifiedMemberCode
        },
        
        success: function(response) {
            console.log("Modification success:", response);
            $("#receiptModal").modal('hide');
        },
        error: function(error) {
        }
    });
   });
	
	
	
	});
</script>

<script>
	/* 리스트 값 납품서 모달로 값 전달 */
	function openReceiptModal(poid, clientid, itemid, clientname, itemname,
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
		$("#rpoid").val(poid);
		$("#rclientid").val(clientid);
		$("#ritemid").val(itemid);
		$("#rclientname").val(clientname);
		$("#ritemname").val(itemname);
		$("#rfloatingSelect").val(postate);
		$("#rpocnt").val(pocnt);
		$("#rordersdate").val(ordersdate);
		$("#rdate").val(ordersduedate);
		$("#rmembercode").val(membercode);

		// 모달 열기
$("#openReceiptModal").modal('show');
		console.log("납품서 모달 열기");
	}
</script>



<%@ include file="../sales/POListJS.jsp"%>
<%@ include file="../include/footer.jsp"%>