<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>

<form method="post">
	<!-- 검색 폼 -->
	<div class="col-12" style="margin-top: 20px;">
		<div class="bg-light rounded h-100 p-4">
			<h6 class="mb-4">작업지시 조회</h6>

			검색: <input type="text" id="clientname" class="m-2" onkeyup="searchWork()">


			<!-- 달력 -->

			작업 지시 기간 : <input type="date" class="m-2" id="workstartdate"
				name="startDate"> ~ <input type="date" class="m-2"
				id="shipdate" name="endDate">
			<!-- 달력 -->
			<!-- Date: <input type="text" id="datepicker3" name="startDate">
~  <input type="text" id="datepicker4" name="endDate"> -->
			<button type="submit" class="btn btn-dark m-2">조회</button>

		</div>
	</div>

	<!-- 작업지시 조회 -->
	<div class="col-12" style="margin-top: 20px;">
		<div class="bg-light rounded h-100 p-4">
			<h6 class="mb-4">작업 지시 관리  <span class="mb-4">[총 ${fn:length(AllWKList)}건]</span> </h6>

		<div class="col-12">
			<div class="btn-group" role="group">
			<form role="form1">
				<input type="hidden" name="state" value="전체">
				<button type="button" class="btn btn-outline-dark"
					id="allpo">전체</button>
			</form>
			<form role="form2">
				<input type="hidden" name="state" value="대기">
				<button type="button" class="btn btn-outline-dark"
					id="stop">접수</button>
			</form>
			<form role="form3">
				<input type="hidden" name="state" value="진행">
				<button type="button" class="btn btn-outline-dark" id="ingpro">진행</button>
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
			<div class="table-responsive">
				<div class="table-responsive" style="text-align: center;">
					<table class="table" id="workTable">
						<thead>
							<tr>
								<th scope="col">No.</th>
								<th scope="col">작업지시일</th>
								<th scope="col">작업지시코드</th>
								<th scope="col">수주코드</th>
								<th scope="col">납품처</th>
								<th scope="col">제품명</th>
								<th scope="col">지시상태</th>
								<th scope="col">지시수량</th>
								<th scope="col">수정일자</th>
								<th scope="col">완료일자</th>
								<th scope="col">담당자</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach items="${ AllWKList }" var="wk">
								<tr>
									<td>${wk.workid }</td>
									<td><fmt:formatDate value="${wk.workdate1 }"
											pattern="yyyy-MM-dd" /></td>
									<td>${wk.workcode }</td>
									<td>${wk.pocode }</td>
									<td>${wk.clientname}</td>
									<td>${wk.itemname }</td>
									<td>${wk.worksts }</td>
									<td>${wk.pocnt }</td>
									<td><fmt:formatDate value="${wk.workupdate }"
											pattern="yyyy-MM-dd" /></td>
									<td><fmt:formatDate value="${wk.workdate2 }"
											pattern="yyyy-MM-dd" /></td>
									<td>${wk.membercode }</td>
									<td>
									<!-- 버튼 수정 -->
									<button type="button" class="btn btn-outline-dark"
    										onclick="openModifyModal('${wk.workid}','${wk.pocode}', '${wk.clientname}', '${wk.itemname}', '${wk.worksts}', '${wk.pocnt}', '${wk.workdate1}', '${wk.workupdate}', '${wk.membercode}')">
    										수정
									</button>
									</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
				</div>
			</div>
			</div>
		</div>
		
		<jsp:include page="registWK.jsp"/>
		<jsp:include page="modifyWK.jsp"/>
</form>

<script>

$("#clientname").on("input", function() {
    var keyword = $(this).val();
    searchWork(keyword);
});

function searchWork(keyword) {
	var keyword = $("#clientname").val();
    $.ajax({
        type: "POST",
        url: "/production/WKList",
        data: { keyword: keyword },
        success: function (result) {
            // 결과 처리 (새 데이터로 테이블 업데이트)
            updateTable(result);
        },
        error: function (xhr, status, error) {
            console.error("AJAX 요청 중 오류 발생:", status, error);
            console.log("서버 응답:", xhr.responseText);
        }
    });
}
    
    function updateTable(data) {
        var tableBody = $("#workTable tbody");
        tableBody.empty(); // 기존 행 지우기

        // 새로운 데이터로 테이블 업데이트
        for (var i = 0; i < data.length; i++) {
            var row = "<tr>" +
                      "<td>" + data[i].workid + "</td>" +
                      "<td>" + formatDate(data[i].workdate1) + "</td>" +
                      "<td>" + data[i].workcode + "</td>" +
                      "<td>" + data[i].pocode + "</td>" +
                      "<td>" + data[i].clientname + "</td>" +
                      "<td>" + data[i].itemname + "</td>" +
                      "<td>" + data[i].worksts + "</td>" +
                      "<td>" + data[i].pocnt + "</td>" +
                      "<td>" + formatDate(data[i].workupdate) + "</td>" +
                      "<td>" + formatDate(data[i].workdate2) + "</td>" +
                      "<td>" + data[i].membercode + "</td>" +
                      "<td><button type='button' class='btn btn-outline-dark' onclick='openModifyModal(\"" + data[i].workid + "\", \"" + data[i].pocode + "\", \"" + data[i].clientname + "\", \"" + data[i].itemname + "\", \"" + data[i].worksts + "\", \"" + data[i].pocnt + "\", \"" + data[i].workdate1 + "\", \"" + data[i].workupdate + "\", \"" + data[i].membercode + "\")'>수정</button></td>" +
                      "</tr>";
            tableBody.append(row);
        }
    }

    // 날짜 형식을 변환하는 함수
    function formatDate(dateString) {
        var date = new Date(dateString);
        var year = date.getFullYear();
        var month = (date.getMonth() + 1).toString().padStart(2, '0');
        var day = date.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }

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