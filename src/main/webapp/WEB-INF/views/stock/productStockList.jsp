<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			<input type="button" class="btn btn-sm btn-warning" value="생산" id="produce">
			<input type="button" class="btn btn-sm btn-secondary" value="반품" id="return">
			<input type="button" class="btn btn-sm btn-success" value="전체" id="allproduct">
			
			<form action="/material/productStockList" method="GET">
				<c:if test="${!empty param.searchBtn }">
				<input type="hidden" name="searchBtn" value="${param.searchBtn}">
				</c:if>
				<input type="text" name="searchText" placeholder="제품명을 입력하세요">
				<input type="submit" value="검색">
			</form>
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">구분</th>
								<th scope="col">코드</th>
								<th scope="col">품명</th>
								<th scope="col">LOT</th>
								<th scope="col">중량</th>
								<th scope="col">재고량</th>
								<th scope="col">창고</th>
								<th scope="col">작업자</th>
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
									<td>${slist.lotnumber }</td>
									<td>${slist.weight }g</td>
									<td>
									<c:if test="${slist.stockquantity < 10 }">
										<b style="color: red;">${slist.stockquantity }</b>개
									</c:if>
									<c:if test="${slist.stockquantity >= 10 }">
										${slist.stockquantity }개
									</c:if>
									<button type="button" class="btn btn-primary btn-sm" 
									data-bs-toggle="modal" data-bs-target="#exampleModal"
									data-stockid="${slist.stockid}" data-qualityid="${slist.qualityid}" 
									data-stockquantity="${slist.stockquantity }" data-itemname="${slist.itemname }" 
									data-lotnumber="${slist.lotnumber }">
 									실사 변경
									</button>
									</td>
									<td>${slist.storagecode } - ${slist.storagename }
									<button type="button" class="btn btn-danger btn-sm" 
									data-bs-toggle="modal" data-bs-target="#exampleModal2"
									data-stockid="${slist.stockid }" data-qualityid="${slist.qualityid }" 
									data-itemname="${slist.itemname }" data-lotnumber="${slist.lotnumber }" 
									data-storagename="${slist.storagename }" data-storagecode="${slist.storagecode }">
									창고 이동
									</button>
									</td>
									<td>${slist.workerbycode }</td>
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
        					
        				<!-- 페이지 블럭 Ajax 동적 이동 - prev (1) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockPrev').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거
   						            var prevPage = $(this).data('page');
   									
   									var searchBtn = "${param.searchBtn}";
   									var searchTxt = "${param.searchTxt}";

   									var dataObject = {
   										"page" : prevPage	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (searchTxt) {
   									    dataObject.searchTxt = searchTxt;
   									}
   									
   									console.log("Page Block clicked!", prevPage);
   									
        						$.ajax({
       								url: "/material/productStockList",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#stockListContainer").html(data);
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
   									var searchTxt = "${param.searchTxt}";
   									
   									var dataObject = {
   										"page" : pageNum	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (searchTxt) {
   									    dataObject.searchTxt = searchTxt;
   									}
   									
   									console.log("Page Block clicked!");
   									
        						$.ajax({
       								url: "/material/productStockList",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#stockListContainer").html(data);
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
   									var searchTxt = "${param.searchTxt}";
   									
   									var dataObject = {
   										"page" : nextPage	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (searchTxt) {
   									    dataObject.searchTxt = searchTxt;
   									}
   									
   									console.log("Page Block clicked!", nextPage);
   									
        						$.ajax({
       								url: "/material/productStockList",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#stockListContainer").html(data);
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


<!-- 모달창1 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/material/updateStockQuantity" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">재고량 변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      	<div class="row">
 			<div class="col">
           		<label for="stockid" class="col-form-label">재고ID:</label>
            	<input type="text" class="form-control" id="stockid" name="stockid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="qualityid" class="col-form-label">품질관리ID:</label>
            	<input type="text" class="form-control" id="qid" name="qualityid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="itemname" class="col-form-label">제품명:</label>
            	<input type="text" class="form-control" id="itemname" name="itemname" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="lotnumber" class="col-form-label">LOT번호:</label>
            	<input type="text" class="form-control" id="lotnumber" name="lotnumber" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="nowquantity" class="col-form-label">현재 재고량:</label>
            	<input type="number" class="form-control" id="nowquantity" name="nowquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="stockquantity" class="col-form-label">변경 재고량:</label>
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
<!-- 모달창1 -->

<!-- 모달창2 -->
<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/material/updateStockStorage" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel2">창고 이동</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      	<div class="row">
 			<div class="col">
           		<label for="stockid" class="col-form-label">재고ID:</label>
            	<input type="text" class="form-control" id="stockid" name="stockid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="qualityid" class="col-form-label">품질관리ID:</label>
            	<input type="text" class="form-control" id="qid" name="qualityid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="itemname" class="col-form-label">제품명:</label>
            	<input type="text" class="form-control" id="itemname" name="itemname" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="lotnumber" class="col-form-label">LOT번호:</label>
            	<input type="text" class="form-control" id="lotnumber" name="lotnumber" value="" readonly>
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
<!-- 모달창2 -->

<script>
	// 재고 등록 성공 / 실패 알림
	var result = "${result}";
	
	if(result == "STOCKNO"){
		alert("재고 등록 실패!");
	}else if(result == "STOCKYES"){
		alert("재고 등록 성공!");
	}else if(result == "STOCKUPNO"){
		alert("재고량 변경 실패!");
	}else if(result == "STOCKUPYES"){
		alert("재고량 변경 성공!");
	}else if(result == "STOCKSUPNO"){
		alert("창고 변경 실패!");
	}else if(result == "STOCKSUPYES"){
		alert("창고 변경 성공!")
	}
</script>

<!-- 모달 1 출력 -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('exampleModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let stockId = button.getAttribute('data-stockid'); // stockid
        let qualityId = button.getAttribute('data-qualityid'); // qualityid
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
        
        let linputField = myModal.querySelector('input[name="lotnumber"]');
        linputField.value = lotNumber;
    });
});
</script>
<!-- 모달 1 출력 -->

<!-- 모달 2 출력 -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('exampleModal2');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let stockId = button.getAttribute('data-stockid'); // stockid
        let qualityId = button.getAttribute('data-qualityid'); // qualityid
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
        
        let linputField = myModal.querySelector('input[name="lotnumber"]');
        linputField.value = lotNumber;
        
        let stinputField = myModal.querySelector('input[name="nowstorage"]');
        stinputField.value = storageCode + " - " + storageName;
    });
});
</script>
<!-- 모달 2 출력 -->

<!-- 라디오 버튼 이동 -->
<script>
$(document).ready(function(){
    $('#materialRadio').click(function(){ // 자재를 눌렀을 때
        console.log("Material radio clicked!");
        $.ajax({
            url: "/material/materialStockList",
            type: "GET",
            success: function(data) {
                $("#stockListContainer").html(data);
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
    
    $('#productRadio').click(function(){ // 완제품을 눌렀을 때
        console.log("Product radio clicked!");
        $.ajax({
            url: "/material/productStockList",
            type: "GET",
            success: function(data) {
                $("#stockListContainer").html(data);
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
});
</script>
<!-- 라디오 버튼 이동 -->

<!-- 페이지 Ajax 동적 이동 (1) -->
<script>
$(document).ready(function() {
    // 원자재 버튼 클릭
    $("#produce").click(function() {
        fetchData("생산");
    });

    // 부자재 버튼 클릭
    $("#return").click(function() {
        fetchData("반품");
    });

    // 전체 버튼 클릭
    $("#allproduct").click(function() {
        $.ajax({
            url: "/material/productStockList",
            type: "GET",
            success: function(data) {
                // 성공적으로 데이터를 받아왔을 때 처리할 코드
                $("#stockListContainer").html(data);
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
});

function fetchData(searchBtnValue) {
    $.ajax({
        url: "/material/productStockList",
        type: "GET",
        data: {
        	searchBtn: searchBtnValue
        },
        success: function(data) {
            // 성공적으로 데이터를 받아왔을 때 처리할 코드
            $("#stockListContainer").html(data);
        },
        error: function(error) {
            console.error("Error fetching data:", error);
        }
    });
}
</script>
<!-- 페이지 Ajax 동적 이동 (1) -->

<!-- 페이지 Ajax 동적 이동 (2) -->
<script>
$(document).ready(function() {
    // 폼의 submit 이벤트 감지
    $("form[action='/material/productStockList']").submit(function(event) {
        event.preventDefault(); // 기본 폼 제출 동작 방지

        // 폼 데이터 수집
        let formData = {
            searchText: $("input[name='searchText']").val()
        };

        // 선택된 검색 버튼 값이 있으면 추가
        if ($("input[name='searchBtn']").length > 0) {
            formData.searchBtn = $("input[name='searchBtn']").val();
        }

        // AJAX 요청 수행
        $.ajax({
            url: "/material/productStockList",
            type: "GET",
            data: formData,
            success: function(data) {
                // 성공적으로 데이터를 받아왔을 때 처리할 코드
                $("#stockListContainer").html(data); // 결과를 화면에 표시
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
});
</script>
<!-- 페이지 Ajax 동적 이동 (2) -->