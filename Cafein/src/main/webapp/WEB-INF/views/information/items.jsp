<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp" %>
<!-- SweetAlert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>

<!-- 로그인 여부(세션정보)에 따라서 페이지 이동 -->
<c:if test="${empty membercode}">
    <c:redirect url="/login" />
</c:if> 

<!-- 품목관리 페이지 시작 -->
<div class="col-12">

	<!-- 품목 조회 시작 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
	<h6 class="mb-4">품목 조회</h6>
		<form name="search" action="items">
			<div class="d-flex align-items-center">
				<div class="me-2">
					<select name="option" class="form-select" style="width: 120px;">
						<option value="">선택</option>
						<option value="itemtype">품목유형</option>
						<option value="itemname">품명</option>
					</select>
				</div>
				<div class="me-2">
					<input type="text" name="keyword" class="form-control"
						style="width: 200px;" placeholder="검색어를 입력하세요">
				</div>
				<div>
					<input type="submit" class="btn btn-sm btn-dark" value="조회">
				</div>
			</div>
		</form>
	</div>
	<!-- 품목 조회 끝 -->

	<!-- 품목 목록 시작 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		
		<form action="itemListExcelDownload" method="GET">
		<div class="buttonarea1">
			<span style="color: black;"><b>품목 관리 [총 ${pageVO.totalCount}건]</b></span>
			<span style="float: right;">
			  <c:if test="${departmentname eq '자재' and memberposition eq '팀장' or membername eq 'admin'}">
				<button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#itemRegistModal" data-bs-whatever="@getbootstrap">등록</button>
			  </c:if>
				<input type="submit" value="엑셀 파일 다운로드" class="btn btn-sm btn-success">
				<input type="hidden" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#itemModifyModal" data-bs-whatever="@getbootstrap" value="수정">
			</span>
		</div>
		</form>
		
		<div class="table-responsive">
			<table class="table" style="margin-top: 10px;">
				<thead>
					<tr style="text-align: center;">
						<th scope="col" style="display: none;"></th>
						<th scope="col">번호</th>
						<th scope="col">품목유형</th>
						<th scope="col">품목코드</th>
						<th scope="col">품명</th>
						<th scope="col">거래처</th>
						<th scope="col">원산지</th>
						<th scope="col">중량(g)</th>
						<th scope="col">단가(원)</th>
					    <c:if test="${departmentname eq '자재' and memberposition eq '팀장' or membername eq 'admin'}">
						<th scope="col">관리</th>
					    </c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="il" items="${itemList }" varStatus="status">
						<tr style="text-align: center;">
							<td style="display: none;">${il.itemid }</td>
							<td>
								<c:out value="${pageVO.totalCount - ((pageVO.cri.page - 1) * pageVO.cri.pageSize + status.index)}"/>
							</td>
							<td>${il.itemtype }</td>
							<td>${il.itemcode }</td>
							<td>${il.itemname }</td>
							<c:if test="${il.clientname == null}">
								<td>-</td>
							</c:if>
							<c:if test="${il.clientname != null}">
								<td>${il.clientname }</td>
							</c:if>
							<td>${il.origin }</td>
							<td>${il.itemweight }</td>
							<td>
								<fmt:formatNumber value="${il.itemprice }" pattern="#,###"/>
							</td>
							<c:if test="${departmentname eq '자재' and memberposition eq '팀장' or membername eq 'admin'}">
							<td>
								<button type="button" class="btn btn-sm btn-warning m-1" 
									onclick="itemModifyModal('${il.itemid }', '${il.itemcode }', '${il.itemtype }', '${il.itemname }', '${il.clientname }', '${il.origin }', '${il.itemweight }', '${il.itemprice }')">수정
								</button>
								<input type="button" class="btn btn-sm btn-secondary m-1" value="삭제" id="deleteBtn">
							</td>
							</c:if>
						</tr>
					</c:forEach>	
				</tbody>
			</table>
			
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
								
									let option = "${param.option}";
									let keyword = "${param.keyword}";

			                		url = "/information/items?page=" + prevPage;
			                
			                		if (option && keyword) {
			                    		url += "&option=" + encodeURIComponent(option) + "&keyword=" + encodeURIComponent(keyword);
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
					
								let option = "${param.option}";
								let keyword = "${param.keyword}";

	                			url = "/information/items?page=" + pageValue;
                
	                			if (option && keyword) {
	                    			url += "&option=" + encodeURIComponent(option) + "&keyword=" + encodeURIComponent(keyword);
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
				
									let option = "${param.option}";
									let keyword = "${param.keyword}";

               					url = "/information/items?page=" + nextPage;
            
               					if (option && keyword) {
                   					url += "&option=" + encodeURIComponent(option) + "&keyword=" + encodeURIComponent(keyword);
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
			
		</div>
	</div>
	<!-- 품목 목록 끝 -->
	
		
	<!-- 품목 등록 모달 -->
	<jsp:include page="itemRegist.jsp"/>
	
	<!-- 품목 수정 모달 -->
	<jsp:include page="itemModify.jsp"/>
		
	<!-- 공급처 모달 -->
    <div class="modal fade" id="clientModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">공급처 목록</h5>
                	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <div class="modal-body">
                	<div class="col-12">
                    	<div class="bg-light rounded h-100 p-4">
                        	<table class="table">
                            	<thead>
                                	<tr>
                                       <th scope="col">번호</th>
                                       <th scope="col">유형</th>
                                       <th scope="col">공급처명</th>
                                       <th scope="col">공급처코드</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                 <c:set var="counter" value="1" />                                 
                                 <c:forEach var="clientList" items="${clientList }" varStatus="status">
                                  <c:if test="${clientList.categoryofclient eq '공급'}">
                                    <tr class="clientset">
                                    	<td>${counter }</td> 
                                    	<td>${clientList.typeofclient }</td> 
                                    	<td>${clientList.clientname }</td> 
                                    	<td>${clientList.clientcode }</td>
                                    </tr>
                                   <c:set var="counter" value="${counter + 1}" />
                                  </c:if>                                    
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
    <!-- 공급처 모달 -->
    
</div>
<!-- 품목관리 페이지 끝 -->

<script>
	var itemRegistModal = document.getElementById('itemRegistModal')
	itemRegistModal.addEventListener('show.bs.modal', function (event) {
  		var button = event.relatedTarget
  		var recipient = button.getAttribute('data-bs-whatever')
  		var modalTitle = itemRegistModal.querySelector('.modal-title')
 	 	var modalBodyInput = itemRegistModal.querySelector('.modal-body input')
	})
	
	// 품목 수정
	function itemModifyModal(itemid, itemcode, itemtype, itemname, clientname, origin, itemweight, itemprice) {
		console.log('itemid:', itemid);
		console.log('itemcode:', itemcode);
		console.log('itemtype:', itemtype);
		console.log('itemname:', itemname);
		console.log('clientname:', clientname);
		console.log('origin:', origin);
		console.log('itemweight:', itemweight);
		console.log('itemprice:', itemprice); 
		   
		// 가져온 값들을 모달에 설정
		$("#itemid").val(itemid);
		$("#itemcode2").val(itemcode);
		$("#itemtype2").val(itemtype);
		$("#itemname2").val(itemname);
		$("#clientname2").val(clientname);
		$("#origin2").val(origin);
		$("#itemweight2").val(itemweight);
		$("#itemprice2").val(itemprice);

		// 모달 띄우기
        $('#itemModifyModal').modal('show');
    }	
	
    // 공급처 모달
    $(document).ready(function() {
	    $("#clientcode").click(function() {
	        $("#clientModal").modal('show');
	   	});
    	
	    $(".clientset").click(function() {
	        var columns = $(this).find('td');
	        var selectedClientName = $(columns[2]).text(); // 공급처명
	        var selectedClientCode = $(columns[3]).text(); // 공급처코드
	        $('#clientcode').val(selectedClientCode);
	        $('#clientModal').modal('hide');
	    });

    });
    
    // 품목 등록 완료 시 뜨는 알림창
	var result1 = "${result1}";
	
	if(result1 == "REGISTOK"){
		Swal.fire({
			  title: "품목 등록 완료",
			  text: "정상적으로 등록되었습니다.",
			  icon: "success"
		});
	}
	
    // 품목 수정 완료 시 뜨는 알림창
	var result2 = "${result2}";
	
	if(result2 == "MODIFYOK"){
		Swal.fire({
			  title: "품목 수정 완료",
			  text: "정상적으로 수정되었습니다.",
			  icon: "success"
		});
	}	
    
    // 품목 삭제
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
  			  
        	var itemid = $(this).closest("tr").find("td:first").text(); // 품목id
        	console.log(itemid);

        	// AJAX 요청 수행
        	$.ajax({
           		url : "/information/itemDelete",
           		type : "POST",
           		data : {
        	   		itemid : itemid
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

<%@ include file="../include/footer.jsp" %>