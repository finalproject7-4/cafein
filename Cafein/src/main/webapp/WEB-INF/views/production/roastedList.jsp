<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>


<!-- SweetAlert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>
<!-- SweetAlert 추가 -->
<script>
$(document).ready(function() {
	getList();
   
});

function getList(){
    // 첫 번째 페이지 가져오기
    $.ajax({
        url: "/production/roastedDetail",
        type: "GET",
        dataType: "html",
        success: function(data) {
            // 성공적으로 데이터를 받아왔을 때 처리할 코드
            alert("@@@");
            $("#roastedBeanList").html(data);
        },
        error: function(error) {
            console.error("Error fetching quality list:", error);
        }
    });
}

</script>

<!-- 검색 폼 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">생산Lot조회</h6>

<!-- LOT 조회 -->
<div >
<form name="searchForm" action="" method="get">
	<input type="text" id="lotnumber" name="lotnumber" placeholder="lot번호 검색">

<!-- 조회 달력 -->
<input type="date" id="searchDate" name="searchDate">
<!-- 조회 달력 -->
<button type="submit" class="btn btn-dark m-2" id="datesubmitbtn">조회</button>
<button type="reset" class="btn btn-dark m-2" id="dateresetbtn">취소</button>
</form>
</div>
</div>
</div>

<div id="roastedBeanList">
</div>


<!-- 페이지 Ajax 동적 이동 (2) -->
<script>
$(document).ready(function() {
    // 기간조회 검색폼의 submit 이벤트 감지
    $("form[name='searchForm']").submit(function(event) {
        event.preventDefault(); // 기본 폼 제출 동작 방지

        // 폼 데이터 수집
        let formData = {
            lotnumber: $("input[name='lotnumber']").val(),
            searchDate: $("input[name='searchDate']").val()
        };


        // AJAX 요청 수행
        $.ajax({
            url: "/production/roastedDetail",
            type: "GET",
            data: formData,
            success: function(data) {
                // 성공적으로 데이터를 받아왔을 때 처리할 코드
                $("#roastedBeanList").html(data); // 결과를 화면에 표시
                alert("성공했지롱");
                alert($("input[name='lotnumber']").val());
            },
            error: function(error) {
            	alert("못간다 ");
            	alert($("input[name='searchDate']").val()+' / '+$("input[name='lotnumber']").val());
                console.error("Error fetching data:", error);
            	console.log(formData);
            }
        });
    });
  
});

//현재 활성화 페이지 가져오기
function getCurrentPageNumber() {
	var currentPage = 1; // 기본적으로 1페이지로 설정

	 // 현재 활성화된 페이지 번호를 찾기 위한 로직
	  $(".page-item").each(function() {
		  if ($(this).hasClass("active")) {
 		   currentPage = $(this).find(".page-link").data("page"); // 활성화된 페이지 번호 가져오기
 		   return false; // 반복문 종료
		  }
	});

	return currentPage;
	 }

function getList(pageNumber) {
	$.ajax({
		 url: "/production/roastedDetail",
		 type: "GET",
		 data: {
  		  page: pageNumber // 현재 페이지 번호 전달
   		 // 나머지 필요한 데이터도 전달 가능
		 },
		 dataType: "html",
		 success: function(data) {
  		  $("#roastedBeanList").html(data);
		 },
		error: function(error) {
			alert("못한다");
    		console.error("Error fetching quality list:", error);
		}
	});
}

</script>





<%@ include file="../include/footer.jsp" %>