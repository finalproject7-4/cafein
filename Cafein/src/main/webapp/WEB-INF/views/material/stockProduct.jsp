<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<!-- SweetAlert 추가 -->
<script src="
https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js
"></script>
<!-- SweetAlert 추가 -->

<!-- 세션에 정보 없는 경우 로그인 페이지로 이동 -->
<c:if test="${empty sessionScope.membercode }">
	<script>
		location.href="/main/login";
	</script>
</c:if>
<!-- 세션에 정보 없는 경우 로그인 페이지로 이동 -->

<!-- 재고 조회 -->
<div class="col-12">
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<h2>완제품 재고 관리</h2>
		<div class="form-check form-check-inline">
  			<input class="form-check-input" type="radio" name="stocktype" id="materialRadio" value="자재">
  			<label class="form-check-label" for="materialRadio">자재</label>
		</div>
		<div class="form-check form-check-inline">
  			<input class="form-check-input" type="radio" name="stocktype" id="productRadio" value="완제품" checked>
  			<label class="form-check-label" for="productRadio">완제품</label>
		</div>
		<br>
		<div class="buttonarea2" style="margin-bottom: 10px;">
			<input type="button" class="btn btn-sm btn-warning" value="생산" id="produce">
			<input type="button" class="btn btn-sm btn-secondary" value="반품" id="return">
			<input type="button" class="btn btn-sm btn-success" value="전체" id="allproduct">
		</div>
		<div class="buttonarea4" style="margin-bottom: 10px">
		<form action="/material/stockProduct" method="GET">
			<c:if test="${!empty param.searchBtn }">
				<input type="hidden" name="searchBtn" value="${param.searchBtn}">
			</c:if>
			<input type="text" name="searchText" placeholder="제품명을 입력하세요" required>
			<input type="submit" value="조회" data-toggle="tooltip" title="제품명이 필요합니다!">
		</form>
		</div>
			<form action="/productStockPrint" method="GET">
				<c:if test="${!empty param.searchBtn }">
					<input type="hidden" name="searchBtn" value="${param.searchBtn }">
				</c:if>
				<c:if test="${!empty param.searchText }">
					<input type="hidden" name="searchText" value="${param.searchText }">
				</c:if>
				<input type="submit" class="btn btn-sm btn-success" value="엑셀 파일 다운로드">
			</form>
	</div>
</div>
<!-- 재고 조회 -->

<!-- 재고 내역 -->
		<div class="col-12">
		<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">상품구분</th>
								<th scope="col">품목코드</th>
								<th scope="col">제품명</th>
								<th scope="col">중량</th>
								<th scope="col">생산/반품번호</th>
								<th scope="col">재고량</th>
								<th scope="col">창고명</th>
								<th scope="col">최종 작업자</th>
								<th scope="col">등록일</th>
								<th scope="col">변경일</th>
								<th scope="col">최근 변경 내역</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="slist" items="${list }" varStatus="loop">
								<tr>
									<th>${slist.stockid }</th>
									<td>${slist.itemtype }</td>
									<td>${slist.itemcode }</td>
									<td>${slist.itemname }</td>
									<c:if test="${slist.weight != 0 }">
									<td>${slist.weight }(g)</td>
									</c:if>
									<c:if test="${slist.weight == 0 }">
									<td></td>
									</c:if>
									<td>
									<c:if test="${!empty slist.itemtype && slist.itemtype.equals('반품') }">
										${slist.returnid }
									</c:if>
									<c:if test="${!empty slist.itemtype && slist.itemtype.equals('생산') }">
										<a href="" class="BeanInfo" data-produceid="${slist.produceid }">${slist.produceid }
										</a>
									</c:if>
									</td>
									<td>
									<c:if test="${slist.stockquantity < 10 }">
										<b style="color: red;">${slist.stockquantity }</b>개
									</c:if>
									<c:if test="${slist.stockquantity >= 10 }">
										${slist.stockquantity }개
									</c:if>
									<c:if test="${(sessionScope.departmentname == '자재' && sessionScope.memberposition == '팀장') || sessionScope.membername.equals('admin') || sessionScope.membername.equals('강호룡') }">
									<button type="button" class="btn btn-primary btn-sm" 
									data-bs-toggle="modal" data-bs-target="#exampleModal"
									data-stockid="${slist.stockid}" data-qualityid="${slist.qualityid}" 
									data-produceid="${slist.produceid }" data-returnid="${slist.returnid}" 
									data-stockquantity="${slist.stockquantity }" data-itemname="${slist.itemname }" 
									data-lotnumber="${slist.lotnumber }">
 									실사 변경
									</button>
									</c:if>
									</td>
									<td>
									<c:if test="${!empty slist.storagecode }">
									${slist.storagecode } - ${slist.storagename }
									</c:if>
									<c:if test="${(sessionScope.departmentname == '자재' && sessionScope.memberposition == '팀장') || sessionScope.membername.equals('admin') || sessionScope.membername.equals('강호룡') }">
									<button type="button" class="btn btn-danger btn-sm" 
									data-bs-toggle="modal" data-bs-target="#exampleModal2"
									data-stockid="${slist.stockid }" data-qualityid="${slist.qualityid }" 
									data-itemname="${slist.itemname }" data-produceid="${slist.produceid }" 
									data-returnid="${slist.returnid }" 
									data-storagename="${slist.storagename }" data-storagecode="${slist.storagecode }">
									창고 이동
									</button>
									</c:if>
									</td>
									<c:if test="${slist.workerbycode != 0 }">
									<td>${slist.workerbycode }</td>
									</c:if>
									<c:if test="${slist.workerbycode == 0 }">
									<td></td>
									</c:if>
									<td>${slist.registerationdate }</td>
									<td>${slist.updatedate }</td>
									<td>${slist.updatehistory }</td>
								</tr>
						</c:forEach>
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

   				                		url = "/material/stockProduct?page=" + prevPage;
   				                
   				                		if (searchBtn) {
   				                    		url += "&searchBtn=" + encodeURIComponent(searchBtn);
   				                		}
   				                
   				                		if (searchText) {
   				                    		url += "&searchText=" + encodeURIComponent(searchText);
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

			                let pageValue = $(this).data('page');
			                	url = "/material/stockProduct?page=" + pageValue;
			                
			                if (searchBtn) {
			                    url += "&searchBtn=" + encodeURIComponent(searchBtn);
			                }
			                
			                if (searchText) {
			                    url += "&searchText=" + encodeURIComponent(searchText);
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

   				                	url = "/material/stockProduct?page=" + nextPage;
   				                
   				                	if (searchBtn) {
   				                    	url += "&searchBtn=" + encodeURIComponent(searchBtn);
   				                	}
   				                
   				                	if (searchText) {
   				                    	url += "&searchText=" + encodeURIComponent(searchText);
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
<!-- 재고 내역 -->

<!-- 재고량 변경 모달창 (생산) -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/material/updateStockQuantity" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">재고량 변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      <!-- 파라미터 확인 -->
      <input type="hidden" name="type" value="생산">
      <c:if test="${!empty param.page }">
      	<input type="hidden" name="page" value="${param.page }">
      </c:if>
      <c:if test="${!empty param.searchText }">
      	<input type="hidden" name="searchText" value="${param.searchText }">
      </c:if>
      <c:if test="${!empty param.searchBtn }">
     	<input type="hidden" name="searchBtn" value="${param.searchBtn }">
      </c:if>
      <!-- 파라미터 확인 -->
      
      	<div class="row">
 			<div class="col">
           		<label for="stockid" class="col-form-label">재고번호:</label>
            	<input type="text" class="form-control" id="stockid" name="stockid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="qualityid" class="col-form-label">품질관리번호:</label>
            	<input type="text" class="form-control" id="qid" name="qualityid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="itemname" class="col-form-label">제품명:</label>
            	<input type="text" class="form-control" id="itemname" name="itemname" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="produceid" class="col-form-label">생산/반품번호:</label>
            	<input type="text" class="form-control" id="produceid" name="produceid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="nowquantity" class="col-form-label">현재 재고량 (개):</label>
            	<input type="number" class="form-control" id="nowquantity" name="nowquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="stockquantity" class="col-form-label">변경 재고량 (개):</label>
            	<input type="number" class="form-control" id="qid" name="stockquantity" value="" required>
  			</div>
		</div>
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">재고량 변경</button>
      </div>
    </div>
   </form>
  </div>
</div>
<!-- 재고량 변경 모달창 (생산) -->

<!-- 재고량 변경 모달창 데이터 (생산) -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('exampleModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let stockId = button.getAttribute('data-stockid'); // stockid
        let qualityId = button.getAttribute('data-qualityid'); // qualityid
        let produceId = button.getAttribute('data-produceid'); // produceid
        let returnId = button.getAttribute('data-returnid'); // returnid
        let nowQuantity = button.getAttribute('data-stockquantity'); // stockquantity
        let itemName = button.getAttribute('data-itemname'); // stockquantity
        let lotNumber = button.getAttribute('data-lotnumber'); // stockquantity
        
        // 모달 내부의 입력 필드에 값을 설정
        let sinputField = myModal.querySelector('input[name="stockid"]');
        sinputField.value = stockId;
        
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityId;
        
        let ninputField = myModal.querySelector('input[name="nowquantity"]');
        ninputField.value = nowQuantity;
        
        let iinputField = myModal.querySelector('input[name="itemname"]');
        iinputField.value = itemName;
        
        let pinputField = myModal.querySelector('input[name="produceid"]');
        if(produceId != 0){
        	pinputField.value = produceId;
        }else if(returnId != 0){
        	pinputField.value = returnId;
        }
    });
});
</script>
<!-- 재고량 변경 모달창 데이터 (생산) -->

<!-- 창고 이동 모달창 (생산) -->
<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/material/updateStockStorage" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel2">창고 이동</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      <!-- 파라미터 확인 -->
      <input type="hidden" name="type" value="생산">
      <c:if test="${!empty param.page }">
      	<input type="hidden" name="page" value="${param.page }">
      </c:if>
      <c:if test="${!empty param.searchText }">
      	<input type="hidden" name="searchText" value="${param.searchText }">
      </c:if>
      <c:if test="${!empty param.searchBtn }">
     	<input type="hidden" name="searchBtn" value="${param.searchBtn }">
      </c:if>
      <!-- 파라미터 확인 -->
      
      	<div class="row">
 			<div class="col">
           		<label for="stockid" class="col-form-label">재고번호:</label>
            	<input type="text" class="form-control" id="stockid" name="stockid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="qualityid" class="col-form-label">품질관리번호:</label>
            	<input type="text" class="form-control" id="qualityid" name="qualityid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="itemname" class="col-form-label">제품명:</label>
            	<input type="text" class="form-control" id="itemname" name="itemname" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="produceid" class="col-form-label">생산/반품번호:</label>
            	<input type="text" class="form-control" id="produceid" name="produceid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="nowstorage" class="col-form-label">현재창고:</label>
            	<input type="text" class="form-control" id="nowstorage" name="nowstorage" value="" readonly>
  			</div>
  			<div class="col">
           		<label for="storageid" class="col-form-label">이동창고:</label>
				<select class="form-select" aria-label="Default select example" id="storageid" name="storageid">
				<c:forEach var="str" items="${slist }">
  					<option value="${str.storageid }">${str.storagecode } - ${str.storagename }</option>
  				</c:forEach>	
				</select>
  			</div>
		</div>	
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">창고 이동</button>
      </div>
    </div>
   </form>
  </div>
</div>
<!-- 창고 이동 모달창 (생산) -->

<!-- 창고 이동 모달창 데이터 (생산) -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('exampleModal2');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let stockId = button.getAttribute('data-stockid'); // stockid
        let qualityId = button.getAttribute('data-qualityid'); // qualityid
        let produceId = button.getAttribute('data-produceid'); // produceid
        let returnId = button.getAttribute('data-returnid'); // returnid
        let itemName = button.getAttribute('data-itemname'); // stockquantity
        let lotNumber = button.getAttribute('data-lotnumber'); // stockquantity
        let storageName = button.getAttribute('data-storagename'); // storagename
        let storageCode = button.getAttribute('data-storagecode'); // storagecode
        
        // 모달 내부의 입력 필드에 값을 설정
        let sinputField = myModal.querySelector('input[name="stockid"]');
        sinputField.value = stockId;
        
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityId;
        
        let iinputField = myModal.querySelector('input[name="itemname"]');
        iinputField.value = itemName;
        
        let pinputField = myModal.querySelector('input[name="produceid"]');
        if(produceId != 0){
        	pinputField.value = produceId;
        }else if(returnId != 0){
        	pinputField.value = returnId;
        }
        
        let stinputField = myModal.querySelector('input[name="nowstorage"]');
        if(storageCode != ""){
        	stinputField.value = storageCode + " - " + storageName;        	
        }else{
        	stinputField.value = "생산 / 반품 라인";
        }
    });
});
</script>
<!-- 창고 이동 모달창 데이터 (생산) -->

<!-- 완제품 정보 확인 모달창 (생산) -->
<div class="modal fade" id="roastedBeanInfo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form>
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel2">제품 정보 확인</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      	<div class="row">
 			<div class="col">
           		<label for="infoproductid" class="col-form-label">완제품번호:</label>
            	<input type="text" class="form-control" id="infoproductid" name="productid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="infoproduceid" class="col-form-label">생산번호:</label>
            	<input type="text" class="form-control" id="infoproduceid" name="produceid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="infoitemname" class="col-form-label">제품명:</label>
            	<input type="text" class="form-control" id="infoitemname" name="itemname" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="infolotnumber" class="col-form-label">LOT번호:</label>
            	<input type="text" class="form-control" id="infolotnumber" name="lotnumber" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="infoweight" class="col-form-label">중량 (g):</label>
            	<input type="text" class="form-control" id="infoweight" name="weight" value="" readonly>
  			</div>
 			<div class="col">
           		<label for="inforoasteddate" class="col-form-label">로스팅일:</label>
            	<input type="text" class="form-control" id="inforoasteddate" name="roasteddate" value="" readonly>
  			</div>
		</div>
		<div class="row">
  			<div class="col">
           		<label for="infonote" class="col-form-label">비고:</label>
				<input type="text" class="form-control" id="infonote" name="note" value="" readonly>
  			</div>
		</div>		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
   </form>
  </div>
</div>
<!-- 완제품 정보 확인 모달창 (생산) -->

<!-- 완제품 정보 확인 모달창 데이터 (생산) -->
<script>
$(document).ready(function($) {
    $(".roastedBean").click(function(event) {
        event.preventDefault();  // 기본 동작 (페이지 이동) 방지

        // 클릭된 a 태그의 data-produceid 값 가져오기
        var produceid = $(this).data("produceid");

        // AJAX 요청
        $.ajax({
            url: "/roastedBeanInfo",
            type: "GET",
            data: { produceid: produceid },  // 파라미터 전송
            dataType: "JSON",
            success: function(data) {
            	console.log(data);
            	$("#infoproductid").val(data.productid);
            	$("#infoproduceid").val(data.produceid);
            	$("#infoitemname").val(data.itemname);
            	$("#infolotnumber").val(data.lotnumber);
            	$("#infoweight").val(data.weight);
            	$("#infoitemprice").val(data.itemprice);
            	
            	var roasteddate = new Date(data.roasteddate);
            	var formattedDate = roasteddate.getFullYear() + "-" + 
                String(roasteddate.getMonth() + 1).padStart(2, '0') + "-" + 
                String(roasteddate.getDate()).padStart(2, '0');
            	
            	$("#inforoasteddate").val(formattedDate);
            	$("#infonote").val(data.note);
            	
            	 $("#roastedBeanInfo").modal("show");
            	
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
});
</script>
<!-- 완제품 정보 확인 모달창 데이터 (생산) -->

<!-- 완제품 정보 확인 모달창 (생산) 추가 -->
<div class="modal fade" id="BeanInfo" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form>
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel2">제품 정보 확인</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      <div class="col-12">
		<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<div class="table-responsive">
		<table class="table table-hover">
      		<thead>
      			<tr>
      				<th scope="col">LOT번호 조회</th>
      			</tr>
      		</thead>
      		<tbody>
      		</tbody>	
      	</table>
      	</div>
      	</div>
      </div>
			
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
   </form>
  </div>
</div>
<!-- 완제품 정보 확인 모달창 (생산) 추가 -->

<!-- 완제품 정보 확인 모달창 데이터 (생산) 추가 -->
<script>
$(document).ready(function($) {
    $(".BeanInfo").click(function(event) {
        event.preventDefault();  // 기본 동작 (페이지 이동) 방지

        // 클릭된 a 태그의 data-produceid 값 가져오기
        var produceid = $(this).data("produceid");

        // AJAX 요청
        $.ajax({
            url: "/normalLot",
            type: "GET",
            data: { produceid: produceid },  // 파라미터 전송
            dataType: "JSON",
            success: function(data) {
            	console.log(data);
            	// 기존에 있는 데이터 삭제
            	$("#BeanInfo tbody").empty();
            	
            	// 데이터를 테이블에 삽입
            	$.each(data, function(index, item) {
            		var row = "<tr><td><a href='' class='lotinfo' data-lotnumber='" + item.lotnumber + "'>" + item.lotnumber + "</a></td></tr>";
            		$("#BeanInfo tbody").append(row);
            	});
            	
            	 $("#BeanInfo").modal("show");
            	 
                 $(".lotinfo").click(function(event) {
                     event.preventDefault();  // 기본 동작 (페이지 이동) 방지
                     var lotnumber = $(this).data("lotnumber");
                     
                     $.ajax({
                    	 url : "/roastedBeanInfo",
                    	 type : "GET",
                    	 data : {
                    		 lotnumber : lotnumber
                    	 },
                    	 success : function(data){
                         	$("#infoproductid").val(data.productid);
                        	$("#infoproduceid").val(data.produceid);
                        	$("#infoitemname").val(data.itemname);
                        	$("#infolotnumber").val(data.lotnumber);
                        	$("#infoweight").val(data.weight);
                        	$("#infoitemprice").val(data.itemprice);
                        	
                        	var roasteddate = new Date(data.roasteddate);
                        	var formattedDate = roasteddate.getFullYear() + "-" + 
                            String(roasteddate.getMonth() + 1).padStart(2, '0') + "-" + 
                            String(roasteddate.getDate()).padStart(2, '0');
                        	
                        	$("#inforoasteddate").val(formattedDate);
                        	$("#infonote").val(data.note);
                        	
                    		$("#BeanInfo").modal("hide");
                    		$("#roastedBeanInfo").modal("show");
                    	 }
                     });

                 });
            	
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
});
</script>
<!-- 완제품 정보 확인 모달창 데이터 (생산) 추가 -->

<!-- 라디오 버튼 이동 -->
<script>
$(document).ready(function(){
    $('#materialRadio').click(function(){ // 자재를 눌렀을 때
        console.log("Material radio clicked!");
		location.href="/material/stock";
    });
    
    $('#productRadio').click(function(){ // 완제품을 눌렀을 때
        console.log("Product radio clicked!");
		location.href="/material/stockProduct";
    });
});
</script>
<!-- 라디오 버튼 이동 -->

<!-- 페이지 버튼 이동 -->
<script>
$(document).ready(function() {
    // 생산 버튼 클릭
    $("#produce").click(function() {
        location.href="/material/stockProduct?searchBtn=생산";
    });

    // 반품 버튼 클릭
    $("#return").click(function() {
        location.href="/material/stockProduct?searchBtn=반품";        
    });

    // 전체 버튼 클릭
    $("#allproduct").click(function() {
        location.href="/material/stockProduct";
    });
});
</script>
<!-- 페이지 버튼 이동 -->

<!-- 재고 수정 관련 알림창 -->
<script>
	var result = "${result}";
	
	if(result == "STOCKNO"){
		Swal.fire("재고 등록 실패!");
	}else if(result == "STOCKYES"){
		Swal.fire("재고 등록 성공!");
	}else if(result == "STOCKUPNO"){
		Swal.fire("재고량 변경 실패!");
	}else if(result == "STOCKUPYES"){
		Swal.fire("재고량 변경 성공!");
	}else if(result == "STOCKSUPNO"){
		Swal.fire("창고 변경 실패!");
	}else if(result == "STOCKSUPYES"){
		Swal.fire("창고 변경 성공!")
	}
</script>
<!-- 재고 수정 관련 알림창 -->

<!-- 토스트창 ajax 호출 (30초 간격) -->
<script>
$(document).ready(function(){
    function fetchProductStockToast() {
        $.ajax({
            url: "/material/productStockToast",
            type: "GET",
            dataType: "html",
            success: function(data) {
                // 토스트 삽입
                $("body").append(data);
            },
            error: function(error) {
                console.error("Error fetching quality list:", error);
            }
        });
    }

    // 초기 호출
    fetchProductStockToast();

    // 1분마다 호출
    setInterval(fetchProductStockToast, 60000); // 60,000 밀리초 = 1분
});
</script>
<!-- 토스트창 ajax 호출 (60초 간격) -->

<!-- 툴팁 추가 -->
<script>
$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip(); 
});
</script>
<!-- 툴팁 추가 -->

<%@ include file="../include/footer.jsp"%>