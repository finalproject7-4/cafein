<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- 로그인 여부(세션정보)에 따라서 페이지 이동 -->
<c:if test="${empty membercode}">
	<c:redirect url="/login" />
</c:if>

<!-- 본문 보기 시작 -->

	<!-- 거래처 조회 -->
	<div class="col-12">
		<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
			<form action="/information/clients" method="get">
				<h6>거래처 조회</h6>
				<div class="d-flex align-items-center">
				  <div class="me-2">
					<select name="option" class="form-select" style="width: 150px;" aria-label="Default select example">
						<option value="clientname">거래처명</option>
						<option value="categoryofclient">거래처 구분</option>
						<option value="typeofclient">거래처 종류</option>
						<option value="manager">담당자</option>
					</select>
				  </div>
				  <div class="me-2">
					<input type="text" class="form-control" name="keyword" placeholder="검색어를 입력하세요.">
				  </div>
				  <div>
					<button class="btn btn-sm btn-dark m-2" type="submit">조회</button>
				  </div>
				</div>
			</form>
		</div>
	</div><br>	
	<!-- 거래처 조회 -->
	
	<!-- 거래처 목록 -->
	<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
			<span style="color: black;"><b>거래처 관리 [총 ${pageVO.totalCount}건]</b></span>
			<span style="float: right;">
			<c:if test="${memberposition eq '팀장' or membername eq 'admin'}">
				<button type="button" class="btn btn-sm btn-dark m-2" 
					data-bs-toggle="modal" data-bs-target="#clientJoinModal" 
					data-bs-whatever="@getbootstrap">거래처 등록</button>
			</c:if>			
			</span>
			
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">코드</th>
							<th scope="col">거래처명</th>
							<th scope="col">구분</th>
							<th scope="col">종류</th>
							<th scope="col">담당자</th>
							<th scope="col">전화번호</th>
							<th scope="col">팩스번호</th>
							<th scope="col">이메일</th>
							
							<c:if test="${memberposition eq '팀장' or membername eq 'admin'}">
								<th scope="col">관리</th>
							</c:if>
							
						</tr>
					</thead>
					<tbody>
						<c:forEach var="vo" items="${clientList }" varStatus="status">
							<tr>
								<th scope="row">${vo.clientid }</th>
								<td>${vo.clientcode }</td>
								<td>${vo.clientname }</td>
								<td>${vo.categoryofclient }</td>
								<td>${vo.typeofclient }</td>
								<td>${vo.manager }</td>
								<td>${vo.clientphone.substring(0,3)}−${vo.clientphone.substring(3,7)}−${vo.clientphone.substring(7)}</td>
								
								<td>
									<c:if test="${!empty vo.clientfax}">
										${vo.clientfax.substring(0,3)}) ${vo.clientfax.substring(3,6)}−${vo.clientfax.substring(6)}
									</c:if>
								</td>
								
								<td>${vo.clientemail }</td>
							
								<c:if test="${memberposition eq '팀장' or membername eq 'admin'}">
									<td>
										<button type="button" class="btn btn-sm btn-warning m-1" 
												onclick="clientUpdateModal('${vo.clientid }', '${vo.clientname }', '${vo.categoryofclient }', '${vo.typeofclient }', '${vo.businessnumber }', 
														'${vo.representative }', '${vo.manager }', '${vo.clientaddress }', '${vo.clientphone }', '${vo.clientfax }',
														'${vo.clientemail }', '${vo.available }')">수정</button>
										<button type="button" class="btn btn-sm btn-secondary m-1" 
												onclick="clientDeleteModal('${vo.clientid }', '${vo.clientcode }', '${vo.clientname }', '${vo.categoryofclient }', '${vo.typeofclient }', '${vo.businessnumber }', 
														'${vo.representative }', '${vo.manager }', '${vo.clientaddress }', '${vo.clientphone }', '${vo.clientfax }',
														'${vo.clientemail }')">비활성화</button>
									</td>
								</c:if>
										
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<!-- 거래처 목록 페이징 처리 -->
				<!-- 페이지 블럭 생성 -->
				<nav aria-label="Page navigation example">
	  				<ul class="pagination justify-content-center">
	    				
	        			<!-- 버튼 이동에 따른 파라미터 전달 (이전) -->
	    				<li class="page-item">
	    				  <c:if test="${pageVO.prev }">
	      					<a class="page-link pageBlockPrev" href="" aria-label="Previous" data-page="${pageVO.startPage - 1}">
	        					<span aria-hidden="true">&laquo;</span>
	      					</a>
	        					
							<script>
								$(document).ready(function(){
									$('.pageBlockPrev').click(function(e) {
										e.preventDefault(); // 기본 이벤트 제거
									
						            	let prevPage = $(this).data('page');
									
										let keyword = "${param.keyword}";
	
				                		url = "/information/clients?page=" + prevPage;
				                
				                		if (keyword) {
				                    		url += "&keyword=" + encodeURIComponent(keyword);
				                		}
	
				                		location.href = url;
									});
								});
							</script>
	    				  </c:if>
	    				</li>
	        			<!-- 버튼 이동에 따른 파라미터 전달 (이전) -->
	    		
	    				<!-- 버튼 이동에 따른 파라미터 전달 (현재) -->
						<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1" var="i">
	    					<li class="page-item ${pageVO.cri.page == i? 'active' : ''}">
	    						<a class="page-link pageBlockNum" href="" data-page="${i}">${i }</a>
	    					</li>
	    					
						<script>
							$(document).ready(function(){
								$('.pageBlockNum').click(function(e) {
									e.preventDefault(); // 기본 이벤트 제거
						
				            		let pageValue = $(this).data('page');
						
									let keyword = "${param.keyword}";
	
		                			url = "/information/clients?page=" + pageValue;
	                
		                			if (keyword) {
		                    			url += "&keyword=" + encodeURIComponent(keyword);
		                			}
	
		                			location.href = url;
								});
							});
						</script>
	    				</c:forEach>
						<!-- 버튼 이동에 따른 파라미터 전달 (현재) -->
	    		
	    				<!-- 버튼 이동에 따른 파라미터 전달 (다음) -->
	    				<li class="page-item">
	    				  <c:if test="${pageVO.next }">
	      					<a class="page-link pageBlockNext" href="" aria-label="Next" data-page="${pageVO.endPage + 1}">
	        					<span aria-hidden="true">&raquo;</span>
	      					</a>
	      					
							<script>
								$(document).ready(function(){
									$('.pageBlockNext').click(function(e) {
										e.preventDefault(); // 기본 이벤트 제거
					
			            				let nextPage = $(this).data('page');
					
										let keyword = "${param.keyword}";
	
	               					url = "/information/clients?page=" + nextPage;
	            
	               					if (keyword) {
	                   					url += "&keyword=" + encodeURIComponent(keyword);
	               					}
	
	               					location.href = url;
									});
								});
							</script>
	    				</c:if>
	    				</li>
						<!-- 버튼 이동에 따른 파라미터 전달 (다음) -->					
				  </ul>
				</nav>
				<!-- 페이지 블럭 생성 -->	
			<!-- 거래처 목록 페이징 처리 -->
			
		</div>
	</div>	
	<!-- 거래처 목록 -->
	
<!-- 거래처 등록 모달 -->
<jsp:include page="clientJoin.jsp"/>

<!-- 거래처 수정 모달 -->
<jsp:include page="clientUpdate.jsp"/>

<!-- 거래처 비활성화 모달 -->
<jsp:include page="clientDelete.jsp"/>	
	
<!-- 본문 보기 끝 -->

<script type="text/javascript">
	
	// 거래처 등록 모달 유효성 검사
	function validateFormCInsert() {
		// 각 필수 입력 필드 값
	    var clientname = document.getElementById("insertClientName").value;
	    var categoryofclient = document.getElementById("insertCategory").value;
	    var representative = document.getElementById("insertRepresentative").value;
	    var manager = document.getElementById("insertManager").value;
	    var clientphone = document.getElementById("insertPhone").value;
	    var clientemail = document.getElementById("insertEmail").value;
	      
		// 빈 필드 검사
	    if (clientname === "" || categoryofclient === "" || representative === "" || 
	    	manager === "" || clientphone === "" || clientemail === "") {
	
	        Swal.fire({
				title : "거래처 등록 오류",
				text : "필수 내용을 입력해주세요.",
				icon : "info"
			});
	        
	        return false; // 제출 방지
	    }
	    return true;
	}
	
	// 거래처 수정 모달 유효성 검사
	function validateFormCUpdate() {
		// 각 필수 입력 필드 값
	    var clientname = document.getElementById("clientname").value;
	    var categoryofclient = document.getElementById("updateCategory").value;
	    var representative = document.getElementById("representative").value;
	    var manager = document.getElementById("manager").value;
	    var clientphone = document.getElementById("clientphone").value;
	    var clientemail = document.getElementById("clientemail").value;
	    var available = document.getElementById("available").value;
	      
		// 빈 필드 검사
	    if (clientname === "" || categoryofclient === "" || representative === "" || 
		    manager === "" || clientphone === "" || clientemail === "" || available === "") {

	        Swal.fire({
				title : "거래처 수정 오류",
				text : "필수 내용을 입력해주세요.",
				icon : "info"
			});
	        
	        return false; // 제출 방지
	    }
	    return true;
	}

	// 거래처 수정 모달
	function clientUpdateModal(clientid, clientname, categoryofclient, typeofclient, businessnumber, representative, manager,
							   clientaddress, clientphone, clientfax, clientemail, available) {
		   
		// 가져온 값들을 모달에 설정
		$("#clientid").val(clientid);
		$("#clientname").val(clientname);
		$("#categoryofclient").val(categoryofclient);
		$("#typeofclient").val(typeofclient);
		$("#businessnumber").val(businessnumber);
		$("#representative").val(representative);
		$("#manager").val(manager);
		$("#clientaddress").val(clientaddress);
		$("#clientphone").val(clientphone);
		$("#clientfax").val(clientfax);
		$("#clientemail").val(clientemail);
		$("#available").val(available);
	
		// 모달 띄우기
	    $('#clientUpdateModal').modal('show');
	}
	
	// 거래처 삭제 모달
	function clientDeleteModal(clientid2, clientcode, clientname2, categoryofclient2, typeofclient2, businessnumber2, representative2, manager2,
							   clientaddress2, clientphone2, clientfax2, clientemail2) {
		   
		// 가져온 값들을 모달에 설정
		$("#clientid2").val(clientid2);
		$("#clientcode").val(clientcode);
		$("#clientname2").val(clientname2);
		$("#categoryofclient2").val(categoryofclient2);
		$("#typeofclient2").val(typeofclient2);
		$("#businessnumber2").val(businessnumber2);
		$("#representative2").val(representative2);
		$("#manager2").val(manager2);
		$("#clientaddress2").val(clientaddress2);
		$("#clientphone2").val(clientphone2);
		$("#clientfax2").val(clientfax2);
		$("#clientemail2").val(clientemail2);
	
		// 모달 띄우기
	    $('#clientDeleteModal').modal('show');
	}

	// 작업 완료 후 alert
	var result = "${result}";
	
	if(result == "JOINOK"){
		Swal.fire({
			  title: "거래처 등록 완료!",
			  text: "새로운 거래처를 등록했습니다.",
			  icon: "success"
		});
	}
	
	if(result == "UPDATEOK"){
		Swal.fire({
			  title: "거래처 수정 완료!",
			  text: "거래처 정보를 수정했습니다.",
			  icon: "success"
		});
	}
	
	if(result == "DELETEOK"){
		Swal.fire({
			  title: "거래처 비활성화 완료!",
			  text: "거래처를 비활성화 했습니다.",
			  icon: "success"
		});
	}
	
</script>

<!-- 검색 css -->
<style>
	.input-group>.form-control, .input-group>.form-select {
	    position: relative;
	    flex: none;
	    width: 20%;
	    min-width: 0;
	}
</style>
<!-- 검색 css -->

<%@ include file="../include/footer.jsp"%>