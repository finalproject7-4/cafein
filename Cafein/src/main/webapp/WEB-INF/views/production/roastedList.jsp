<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>



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
            $("#roastedBeanList").html(data);
        },
        error: function(error) {
            console.error("Error fetching roasted list:", error);
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





</script>
 




<%@ include file="../include/footer.jsp" %>