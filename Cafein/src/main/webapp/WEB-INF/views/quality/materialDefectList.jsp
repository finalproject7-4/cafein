<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<br>
	<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
			<h2>자재 불량 현황</h2>
			<input type="button" class="btn btn-sm btn-primary" value="원자재" id="rawmaterial2nd">
			<input type="button" class="btn btn-sm btn-danger" value="부자재" id="submaterial2nd">
			<input type="button" class="btn btn-sm btn-success" value="전체" id="allmaterial2nd">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">불량현황ID</th>
								<th scope="col">품질관리ID</th>
								<th scope="col">상품구분</th>
								<th scope="col">품목코드</th>
								<th scope="col">제품명</th>
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
									<td>${dlist.itemtype }</td>									
									<td>${dlist.itemcode }</td>
									<td>${dlist.itemname }</td>
									<!-- 불량 출력 -->
									<td><b style="color: red;">${dlist.defectquantity }</b>(개)</td>
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

   									var dataObject = {
   										"page" : prevPage	
   									};
   									
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
   									
   									var dataObject = {
   										"page" : pageNum	
   									};
   									
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
   									
   									var dataObject = {
   										"page" : nextPage	
   									};
   									
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
    // 원자재 버튼 클릭
    $("#rawmaterial2nd").click(function() {
        fetchData2("원자재");
    });

    // 부자재 버튼 클릭
    $("#submaterial2nd").click(function() {
        fetchData2("부자재");
    });

    // 전체 버튼 클릭
    $("#allmaterial2nd").click(function() {
        $.ajax({
            url: "/quality/materialDefectList",
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
        url: "/quality/materialDefectList",
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
	