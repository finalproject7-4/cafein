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
	var searchDate = "${param.searchDate}";

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
		var searchDate = "${param.searchDate}";
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
				Swal.fire("페이지를 찾을 수 없습니다.");
		}
	});
	});
	
	// 다음 페이지 클릭시 이동
	$('.pageBlockNext').click(function(e) {
		e.preventDefault(); // 기본 이벤트 제거
	    var nextPage = $(this).data('page');
				
	    var searchLot = "${param.searchLot}";
		var searchDate = "${param.searchDate}";

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
			Swal.fire("페이지를 찾을 수 없습니다.");
		}
		});
		});
		
	 
	 function printBarcode(){
		 var value = $("#lotnumberbar").val();
		 var btype = "code128";
		 var renderer = "css";
		 var settings={
				 output : renderer,
				 bgColor: "#FFFFFF", // 바코드 배경색
				 color: "#000000", // 바코드 색
				 barWidth: "2", // 바코드 넓이
				 barHeight: "70", // 바코드 높이
				 moduleSize: "2",
				 addQuietZone: "100",
		 };
		$("#barcodePrint").barcode(value, "code128", settings);
	 }
	 
	 $('.btn-close').click(function() {
		    $('#barcodeModal').modal('hide'); // 모달을 닫는 코드
		});
	 
	     
</script>
<script type="text/javascript" src="../resources/js/barcorde.js"></script>


<!-- 로스팅제품 목록 테이블 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">로스팅 제품(lot) 관리 [총 ${pageVO.totalCount }건]</h6>



<!-- 생산완료된 로스팅 제품 테이블 내용 시작 -->
<div class="table-responsive" style="text-align: center;">
<table class="table">
<thead>
<tr>
<th scope="col">번호</th>
<th scope="col">제품명</th>
<th scope="col">포장중량(g)</th>
<th scope="col">로스팅일</th>
<th scope="col">품질검수</th>
<th scope="col">LOT번호</th>
<th scope="col">바코드</th>
</tr>
</thead>
<tbody>

<c:forEach var="rlist" items="${roastedList }" varStatus="status">
<tr>
<td>${rlist.productid }</td>
<td>${rlist.itemname }</td>
<td>${rlist.weight }</td>
<td><fmt:formatDate value="${rlist.roasteddate }" pattern="yyyy-MM-dd" /></td>
<td>${rlist.auditstatus =='Y' ? '정상' : '-' } </td>
<td>${rlist.lotnumber }</td>
<td id="barcode${status.index }">
<input type="button" class="btn btn-sm btn-primary" value="출력" id="barcodeButton" onclick="openbarcodeModal('${rlist.itemname}','${rlist.weight }', '${rlist.lotnumber }','${rlist.roasteddate }' )" data-bs-toggle="modal" data-bs-target="#barcodeModal" data-bs-whatever="@getbootstrap">
</td>
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


<!-- 바코드 모달창 시작-->
<div class="modal fade" id="barcodeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel"> 제품 바코드 출력 </h5>
						<button type="button" class="btn-close" aria-label="Close" ></button>
					<!-- onclick="location.href='/production/roastedList';"  -->
					</div>
					<div class="modal-body">
						<form action="" >
							<div class="row" style="display: none;">
							<div class="col">
								<label for="itemnamebar" class="col-form-label">제품명</label> 
								<input type="text" name="itemnamebar" class="date form-control" id="itemnamebar" readonly="readonly">
							</div>
							<div class="col">
								<label for="packagevolumbar" class="col-form-label">중량</label> 
								<input type="text" name="packagevolumbar" class="date form-control" id="packagevolumbar" readonly="readonly">
							</div>
							</div>
					<div class="row" style="display: none;">
							<div class="col" >
								<label for="lotnumberbar" class="col-form-label">LOT번호</label> 
								<input type="text" id="lotnumberbar" name="lotnumberbar" class="form-control" readonly="readonly">
							</div>
							<div class="col">
								<label for="roasteddatebar" class="col-form-label">로스팅일</label> 
								<input type="text" id="roasteddatebar" name="roasteddatebar" class="form-control" readonly="readonly">
							</div>
					</div>
					<div class="row">
							<div class="col">
								<div><label for="barcode" class="col-form-label"></label> 
								</div>
								<div id="barcodePrint" style="float: left; margin-left: 20px;">
 								</div>
					
							</div>					
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-primary" onclick="printModalContent()" value="인쇄" >
					</div>
						</form>
					</div>
				</div>
			</div>
		</div>
<!-- 바코드 모달창 끝-->


