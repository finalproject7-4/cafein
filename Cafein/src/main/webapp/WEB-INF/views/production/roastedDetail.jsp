<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- SweetAlert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>
<!-- SweetAlert 추가 -->

<script>
	
	// 페이지 이전 클릭시 이동
	$('.pageBlockPrev').click(function(e) {
	e.preventDefault(); // 기본 이벤트 제거
   var prevPage = $(this).data('page');
	
	var searchLot = "${param.searchLot}";
	var searchDate = "${param.startDate}";

	var dataObject = {
		"page" : prevPage	
	};
	
	if (searchLot) {
	    dataObject.searchLot = searchLot;
	}
	if (searchDate) {
	    dataObject.searchDate = searchDate;
	}
	console.log("Page Block clicked!", prevPage);
	
	$.ajax({
		url: "/production/roastedDetail",
	type: "GET",
	data: dataObject,
	success: function(data) {
		$("#roastedBeanList").html(data);
	},
	 	error: function(error) {
		console.error("Error fetching data:", error);
	}
	});
	});
	
	
	//  페이지번호 블럭 클릭시 이동
	$('.pageBlockNum').click(function(e){
		e.preventDefault();
		
		var pageNum = $(this).data('page');
		var searchLot = "${param.searchLot}";
		var searchDate = "${param.satrtDate}";
		var dataObject = {
				"page" : pageNum
		};
		if(searchLot){
			dataObject.searchLot = searchLot;
		}
		if(searchDate){
			dataObject.searchDate = searchDate;
		}
		console.log("Page Block clicked!");
		
	$.ajax({
		url: "/production/roastedDetail",
		type: "GET",
		data: dataObject,
		success: function(data){
			$("#roastedBeanList").html(data);
		},
		error: function(error){
				console.error("Error fetching data: ", error);
				Swal.fire("못가요");
		}
	});
	});
	
	// 다음 페이지 클릭시 이동
	$('.pageBlockNext').click(function(e) {
		e.preventDefault(); // 기본 이벤트 제거
	    var nextPage = $(this).data('page');
				
	    var searchLot = "${param.searchLot}";
		var searchDate = "${param.startDate}";

		var dataObject = {
			"page" : nextPage	
		};
				
		if (searchLot) {
		  	dataObject.searchLot = searchLot;
			}
		if (searchDate) {
			dataObject.searchDate = searchDate;
			}	
		console.log("Page Block clicked!", nextPage);
		$.ajax({
			url: "/production/roastedDetail",
		type: "GET",
		data: dataObject,
		success: function(data) {
			$("#roastedBeanList").html(data);
		},
		 	error: function(error) {
			console.error("Error fetching data:", error);
			Swal.fire("못갔어요");
		}
		});
		});
		

</script>

<!-- 로스팅제품 목록 테이블 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">로스팅 제품 목록(lot)</h6>
<h6 class="mb-4">총 수량 : ${pageVO.totalCount }</h6>



<!-- 생산완료된 로스팅 제품 테이블 내용 시작 -->
<div class="table-responsive" style="text-align: center;">
<table class="table">
<thead>
<tr>
<th scope="col">번호</th>
<th scope="col">제품명</th>
<th scope="col">포장중량(g)</th>
<th scope="col">로스팅일</th>
<th scope="col">LOT번호</th>
</tr>
</thead>
<tbody>

<c:forEach var="rlist" items="${roastedList }">
<tr>
<td>${rlist.productid }</td>
<td>${rlist.itemname }</td>
<td>${rlist.weight }</td>
<td><fmt:formatDate value="${rlist.roasteddate }" pattern="yyyy-MM-dd" /></td>
<td>${rlist.lotnumber }</td>
</tr>
</c:forEach>
</tbody>
</table>
<!-- 생산완료된 로스팅 제품 테이블 내용 끝 -->
</div>



<!-- 페이지 블럭 생성 -->
			<nav aria-label="Page navigation example">
  				<ul class="pagination justify-content-center">
    				<li class="page-item">
    					<c:if test="${pageVO.prev }">
      					<a class="page-link pageBlockPrev" href="" aria-label="Previous" data-page="${pageVO.startPage - 1}">
        					<span aria-hidden="true">&laquo;</span>
      					</a>
        					
    					</c:if>
    				</li>
					<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1" var="i">
    				<li class="page-item ${pageVO.cri.page == i? 'active' : ''}"><a class="page-link pageBlockNum" href="" data-page="${i}">${i }</a></li>
    					
					</c:forEach>
    				<li class="page-item">
    					<c:if test="${pageVO.next }">
      					<a class="page-link pageBlockNext" href="" aria-label="Next" data-page="${pageVO.endPage + 1}">
        				<span aria-hidden="true">&raquo;</span>
      					</a>
      				    					
    					</c:if>
    				</li>
  				</ul>
			</nav>
			<!-- 페이지 블럭 생성 -->
</div>
</div>




