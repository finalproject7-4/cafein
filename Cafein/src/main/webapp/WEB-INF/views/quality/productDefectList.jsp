<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<!-- SweetAlert 추가 -->
<script src="
https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js
"></script>
<!-- SweetAlert 추가 -->
	<div class="col-12">
		<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
			<h2>생산 / 반품 불량 현황</h2>
			
			<div class="buttonarea2" style="margin-bottom: 10px;">
				<input type="button" class="btn btn-sm btn-primary" value="블렌딩" id="blending2nd">
				<input type="button" class="btn btn-sm btn-danger" value="로스팅" id="cooling2nd">
				<input type="button" class="btn btn-sm btn-warning" value="포장" id="packaging2nd">
				<input type="button" class="btn btn-sm btn-secondary" value="반품" id="return2nd">
				<input type="button" class="btn btn-sm btn-success" value="전체" id="all2nd">
			</div>
			
			<div class="buttonarea4" style="margin-bottom: 10px;">
			<form action="/quality/productDefectList" method="GET">
				<c:if test="${!empty param.searchBtn }">
				<input type="hidden" name="searchBtn" value="${param.searchBtn}">
				</c:if>
				<input type="text" name="searchText" placeholder="제품명을 입력하세요" required>
				<input type="submit" value="조회">
			</form>
			</div>
			<form action="/productDefectPrint" method="GET">
				<c:if test="${!empty param.searchBtn }">
					<input type="hidden" name="searchBtn" value="${param.searchBtn }">
				</c:if>
				<c:if test="${!empty param.searchText }">
					<input type="hidden" name="searchText" value="${param.searchText }">
				</c:if>
				<input type="submit" class="btn btn-sm btn-success" value="엑셀 파일 다운로드">
			</form>
			<br>						
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">품질관리번호</th>
								<th scope="col">상품구분</th>
								<th scope="col">품목코드</th>
								<th scope="col">제품명</th>
								<th scope="col">중량</th>				
								<th scope="col">불량</th>
								<th scope="col">불량사유</th>
								<th scope="col">처리방식</th>
								<th scope="col">등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="dlist" items="${defectList }" varStatus="loop">
								<tr>
									<th>${dlist.defectid }</th>
									<td>${dlist.qualityid }</td>
									<!-- 상품 구분 출력 -->
									<c:if test="${empty dlist.produceprocess }"> <!-- 반품인 경우 (produceprocess == null) -->
										<td>${dlist.itemtype }</td>									
									</c:if>
									<c:if test="${!empty dlist.produceprocess }"> <!-- 생산인 경우 (produceprocess != null) -->
										<td>${dlist.itemtype } - ${dlist.produceprocess }</td>									
									</c:if>
									<td>${dlist.itemcode }</td>
									<td>${dlist.itemname }</td>
									<c:if test="${dlist.weight != 0 }">
									<td>${dlist.weight }(g)</td>
									</c:if>
									<c:if test="${dlist.weight == 0 }">
									<td></td>
									</c:if>
									<!-- 불량 출력 -->
									<td>
									<c:if test="${!empty dlist.itemtype && dlist.itemtype.equals('반품')}">
										<b style="color: red;">${dlist.defectquantity }</b>(개)
									</c:if>
									<c:if test="${!empty dlist.produceprocess && dlist.produceprocess.equals('포장')}">
										<b style="color: red;">${dlist.defectquantity }</b>(g)
									</c:if>
									<c:if test="${!empty dlist.produceprocess && !dlist.produceprocess.equals('포장') }">
										<b style="color: red;">${dlist.defectquantity }</b>(g)
									</c:if>
									</td>
									<td>${dlist.defecttype }</td>
									<td>${dlist.processmethod }</td>
									<td>${dlist.registerationdate }</td>
								</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<!-- 페이지 블럭 생성 -->
			<nav aria-label="Page navigation example">
  				<ul class="pagination justify-content-center">
    				<li class="page-item">
    					<c:if test="${pageVO2.prev }">
      					<a class="page-link pageBlockPrev2" href="" aria-label="Previous" data-page="${pageVO2.startPage - 1}">
        					<span aria-hidden="true">&laquo;</span>
      					</a>
        					
        				<!-- 페이지 블럭 Ajax 동적 이동 - prev (1) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockPrev2').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거
   						            var prevPage = $(this).data('page');
   									
   									var searchBtn = "${param.searchBtn}";
   									var searchText = "${param.searchText}";

   									var dataObject = {
   										"page" : prevPage	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (searchText) {
   									    dataObject.searchText = searchText;
   									}
   									
   									console.log("Page Block clicked!", prevPage);
   									
        						$.ajax({
       								url: "/quality/productDefectList",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#defectListContainer").html(data);
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
					<c:forEach begin="${pageVO2.startPage }" end="${pageVO2.endPage }" step="1" var="i">
    				<li class="page-item ${pageVO2.cri.page == i? 'active' : ''}"><a class="page-link pageBlockNum2" href="" data-page="${i}">${i }</a></li>
    					
    					<!-- 페이지 블럭 Ajax 동적 이동 - num (2) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockNum2').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거

   						            var pageNum = $(this).data('page');
   									
   									var searchBtn = "${param.searchBtn}";
   									var searchText = "${param.searchText}";
   									
   									var dataObject = {
   										"page" : pageNum	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (searchText) {
   									    dataObject.searchText = searchText;
   									}
   									
   									console.log("Page Block clicked!");
   									
        						$.ajax({
       								url: "/quality/productDefectList",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#defectListContainer").html(data);
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
    					<c:if test="${pageVO2.next }">
      					<a class="page-link pageBlockNext2" href="" aria-label="Next" data-page="${pageVO2.endPage + 1}">
        				<span aria-hidden="true">&raquo;</span>
      					</a>
      					
    					<!-- 페이지 블럭 Ajax 동적 이동 - next (3) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockNext2').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거
   						            var nextPage = $(this).data('page');
   									
   									var searchBtn = "${param.searchBtn}";
   									var searchText = "${param.searchText}";
   									
   									var dataObject = {
   										"page" : nextPage	
   									};
   									
   									if (searchBtn) {
   									    dataObject.searchBtn = searchBtn;
   									}
   									if (searchText) {
   									    dataObject.searchText = searchText;
   									}
   									
   									console.log("Page Block clicked!", nextPage);
   									
        						$.ajax({
       								url: "/quality/productDefectList",
            						type: "GET",
            						data: dataObject,
            						success: function(data) {
                						$("#defectListContainer").html(data);
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
	
<!-- 페이지 Ajax 동적 이동 (1) -->
<script>
$(document).ready(function() {
    // 블렌딩 버튼 클릭
    $("#blending2nd").click(function() {
        fetchData2("블렌딩");
    });

    // 로스팅 버튼 클릭
    $("#cooling2nd").click(function() {
        fetchData2("로스팅");
    });

    // 포장 버튼 클릭
    $("#packaging2nd").click(function() {
        fetchData2("포장");
    });

    // 반품 버튼 클릭
    $("#return2nd").click(function() {
        fetchData2("반품");
    });

    // 전체 버튼 클릭
    $("#all2nd").click(function() {
        $.ajax({
            url: "/quality/productDefectList",
            type: "GET",
            success: function(data) {
                // 성공적으로 데이터를 받아왔을 때 처리할 코드
                $("#defectListContainer").html(data);
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
});

function fetchData2(searchBtnValue) {
    $.ajax({
        url: "/quality/productDefectList",
        type: "GET",
        data: {
        	searchBtn: searchBtnValue
        },
        success: function(data) {
            // 성공적으로 데이터를 받아왔을 때 처리할 코드
            $("#defectListContainer").html(data);
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
    $("form[action='/quality/productDefectList']").submit(function(event) {
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
            url: "/quality/productDefectList",
            type: "GET",
            data: formData,
            success: function(data) {
                // 성공적으로 데이터를 받아왔을 때 처리할 코드
                $("#defectListContainer").html(data); // 결과를 화면에 표시
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
});
</script>
<!-- 페이지 Ajax 동적 이동 (2) -->