<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>

	<!-- 검색 폼 -->
		<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
			<form name="dateSearch" action="/production/SHList" method="get" onsubmit="return filterRows(event)">
				검색 <input class="shipSearch" type="text" name="shipSearch" placeholder="수주코드, 작업지시코드, 납품처, 제품명으로 검색">
				작업지시일자 <input type="date" id="startDate"
					name="shipsdate"> ~ <input type="date" id="endDate" name="shipsdate">
				<button type="submit" class="datesubmitbtn btn btn-dark m-2">조회</button>
				<br>
			</form>

		</div>
	</div>

	<!-- 작업지시 조회 -->
	<div class="col-12" style="margin-top: 20px;">
		<div class="bg-light rounded h-100 p-4">
			<h6 class="mb-4">출하 관리  <span class="mb-5">[총 ${fn:length(AllSHList)}건]</span> </h6>

		<div class="col-12">
			<div class="btn-group" role="group">
			<form role="form1">
				<input type="hidden" name="state" value="전체">
				<button type="button" class="btn btn-outline-dark"
					id="allwk">전체</button>
			</form>
			<form role="form2">
				<input type="hidden" name="state" value="대기">
				<button type="button" class="btn btn-outline-dark"
					id="stop">접수</button>
			</form>
			<form role="form3">
				<input type="hidden" name="state" value="진행">
				<button type="button" class="btn btn-outline-dark" id="ing">진행</button>
			</form>
			<form role="form4">
				<input type="hidden" name="state" value="완료">
				<button type="button" class="btn btn-outline-dark"
					id="complete">완료</button>
			</form>
		</div>
			<span id="buttonset1"><button type="button"
					class="btn btn-dark m-2" data-bs-toggle="modal"
					data-bs-target="#registModal" data-bs-whatever="@getbootstrap">신규
					등록</button></span>
					<input type="hidden" class="btn btn-dark m-2" data-bs-toggle="modal" data-bs-target="#modifyModal" data-bs-whatever="@getbootstrap" value="수정">
			<form role="form" action="/production/WKList" method="post">
			<div class="table-responsive">
				<div class="table-responsive" style="text-align: center;">
					<table class="table" id="workTable">
						<thead>
							<tr>
								<th scope="col">No.</th>
								<th scope="col">출하일</th>
								<th scope="col">출하코드</th>
								<th scope="col">작업지시코드</th>
								<th scope="col">납품처</th>
								<th scope="col">제품명</th>
								<th scope="col">LOT</th>
								<th scope="col">출하량</th>
								<th scope="col">출하상태</th>
								<th scope="col">완료일자</th>
								<th scope="col">담당자</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach items="${AllSHList}" var="sh">
						<tr>
							<td>${sh.shipid }</td>
							<td><fmt:formatDate value="${sh.shipdate1 }"
									pattern="yyyy-MM-dd" /></td>
							<td>${sh.shipcode }</td>
							<td>${sh.workcode }</td>
							<td>${sh.clientname}</td>
							<td>${sh.itemname }</td>
							<td>${sh.lotnumber }</td>
							<td>${sh.pocnt }</td>
							<td>${sh.shipsts }</td>
							<td><fmt:formatDate value="${sh.shipdate2 }"
									pattern="yyyy-MM-dd" /></td>
							<td>${sh.membercode }</td>
							<td>
								<!-- 버튼 수정 -->
									<button type="button" class="btn btn-outline-dark"
    										onclick="openModifyModal()">
                                   수정
									</button>
									</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
				</div>
			</div>
			</form>
			</div>
		</div>
	</div>
		
 		<jsp:include page="registSH.jsp"/> 
<%-- 		<jsp:include page="modifySH.jsp"/> --%>

<!-- 검색 -->
<script>

$('.shipSearch').on('input', function(event) {
    filterRows(event);
});
    
function filterRows(event) {
	// 기본 폼 제출 동작 방지
	event.preventDefault();

	// 입력된 키워드 가져오기
	var keyword = $('.shipSearch').val().toLowerCase();

	// 시작일자와 종료일자 가져오기
	var startDate = $('#startDate').val() ? new Date($('#startDate').val())
			: null;
	var endDate = $('#endDate').val() ? new Date($('#endDate').val())
			: null;

	// 테이블의 모든 행 가져오기
	var rows = $('.table tbody tr');

	// 각 행에 대해 키워드 및 날짜 포함 여부 확인
	rows.each(function() {
		var clientName = $(this).find('td:nth-child(5)').text()
				.toLowerCase();
		var itemName = $(this).find('td:nth-child(6)').text()
		.toLowerCase();
		var lotNumber = $(this).find('td:nth-child(7)').text()
		.toLowerCase();
		var shipCode = $(this).find('td:nth-child(3)').text().toLowerCase();
        var workCode = $(this).find('td:nth-child(4)').text().toLowerCase();
		var workDateStr = $(this).find('td:nth-child(2)').text();
		var workDate = workDateStr ? new Date(workDateStr) : null;

		var keywordMatch = keyword === '' || clientName.includes(keyword) || itemName.includes(keyword) || lotNumber.includes(keyword) || shipCode.includes(keyword) || workCode.includes(keyword);
		var dateMatch = (startDate === null || (workDate !== null
				&& workDate >= startDate && workDate <= endDate));

		if (keywordMatch && dateMatch) {
			$(this).show(); // 키워드 및 날짜가 포함된 경우 행을 표시
		} else {
			$(this).hide(); // 키워드 또는 날짜가 포함되지 않은 경우 행을 숨김
		}
		console.log('거래처명:', clientName, '품목명:', itemName, '출하코드:', shipCode, '작업코드:', workCode, '작업일자:', workDate,
	            '키워드 일치:', keywordMatch, '날짜 일치:', dateMatch);
	});

	// 번호 업뎃
	updateRowNumbers();
	// 총 건수 업뎃
	updateTotalCount();
	// 폼이 실제로 제출되지 않도록 false 반환
	return false;
}

// 테이블에 표시되는 행의 번호를 업데이트하는 함수
function updateRowNumbers() {
	// 표시된 행만 선택하여 번호 업데이트
	var visibleRows = $('.table tbody tr:visible');
	visibleRows.each(function(index) {
		// 첫 번째 자식 요소인 td 엘리먼트를 찾아 번호를 업데이트
		$(this).find('td:first').text(index + 1);
	});
}
// 총 건수 업데이트 함수
function updateTotalCount() {
	var totalCount = $('.table tbody tr:visible').length;
	$('.mb-5').text('[총 ' + totalCount + '건]');
}



$("#allwk").click(function() {
	$(".table tbody tr").show();
	updateTotalCount();
});

$("#stop").click(function() {
	$(".table tbody tr").hide();
	$(".table tbody tr:has(td:nth-child(7):contains('접수'))").show();
	updateTotalCount();
});

$("#ing").click(function() {
	$(".table tbody tr").hide();
	$(".table tbody tr:has(td:nth-child(7):contains('진행'))").show();
	updateTotalCount();
});

$("#complete").click(function() {
	$(".table tbody tr").hide();
	$(".table tbody tr:has(td:nth-child(7):contains('완료'))").show();
	updateTotalCount();
});



function updateTotalCount() {
	var totalCount = $(".table tbody tr:visible").length;
	$(".mb-5").text("[총 " + totalCount + "건]");
}


</script>

<script>
// 수정된 값을 서버로 전송
$("#modifyButton").click(function() {
    // 가져온 값들을 변수에 저장
    var modifiedWorkid = $("#workid2").val();
    var modifiedPocode = $("#pocode2").val();
    var modifiedClientName = $("#clientcode2").val();
    var modifiedItemName = $("#itemcode2").val();
    var modifiedWorksts = $("#worksts2").val();
    var modifiedPocnt = $("#pocnt2").val();
    var modifiedWorkdate1 = $("#workdate11").val();
    var modifiedWorkupdate = $("#workupdate2").val();
    var modifiedMemberCode = $("#membercode2").val();

    // Ajax를 사용하여 서버로 수정된 값 전송
    $.ajax({
        type: "POST",
        url: "/production/modifyWK",
        data: {
        	 workid: modifiedWorkid,
        	 pocode: modifiedPocode,
        	 clientname: modifiedClientName,
             itemname: modifiedItemName,
             worksts: modifiedWorksts,
             pocnt: modifiedPocnt,
             workdate1: modifiedworkDate1,
             workupdate: modifiedWorkupDate,
             membercode: modifiedMemberCode
        },
        success: function(response) {
            console.log("Modification success:", response);
            $("#modifyModal").modal('hide');
        },
        error: function(error) {
            console.error("Error during modification:", error);
        }
    });
});
	   
	   function openModifyModal(workid, pocode, clientname, itemname, worksts, pocnt, workdate1, workupdate, membercode) {

		   
		   // 가져온 값들을 모달에 설정
		   $("#workid2").val(workid);
		    $("#pocode2").val(pocode);
		    $("#clientcode2").val(clientname);
		    $("#itemcode2").val(itemname);
		    $("#worksts2").val(worksts);
		    $("#pocnt2").val(pocnt);
		    $("#workdate11").val(workdate1);
		    $("#workupdate2").val(workupdate);
		    $("#membercode2").val(membercode);

		    // 모달 열기
		    $("#modifyModal").modal('show');
		    
		}
	   
	    $('#workdate11').click(function(){
	        var today = new Date();
	        // 날짜를 YYYY-MM-DD 형식으로 포맷팅
	        var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
	        $('#workdate11').val(formattedDate);
	    });
	    
	    $('#workupdate2').click(function(){
	        var today = new Date();
	        // 날짜를 YYYY-MM-DD 형식으로 포맷팅
	        var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
	        $('#workupdate2').val(formattedDate);
	    });
	    
	   </script>
	   


<%@ include file="../include/footer.jsp"%>