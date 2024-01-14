<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
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

<script>
$(document).ready(function() {
	var page = "${page}";
	var searchBtn = "${searchBtn}";
	var startDate = "${startDate}";
	var endDate =  "${endDate}";
	
	var dataObject = {};
				
	if(page){
		dataObject.page = page;
	}else{
		dataObject.page = 1;
	}
	
	if (searchBtn) {
		dataObject.searchBtn = searchBtn;
	}
	
	if (startDate) {
		dataObject.startDate = startDate;
	}
	
	if (endDate) {
	 dataObject.endDate = endDate;
	}
	
    // 첫 번째 페이지 가져오기
    $.ajax({
        url: "/quality/materialQualityList",
        type: "GET",
        data: dataObject,
        dataType: "html",
        success: function(data) {
            // 성공적으로 데이터를 받아왔을 때 처리할 코드
            $("#qualityListContainer").html(data); // 예를 들어, id가 'qualityListContainer'인 요소에 데이터를 삽입
        },
        error: function(error) {
            console.error("Error fetching quality list:", error);
        }
    });

    // 두 번째 페이지 가져오기
    $.ajax({
        url: "/quality/materialDefectList",
        type: "GET",
        dataType: "html",
        success: function(data) {
            // 성공적으로 데이터를 받아왔을 때 처리할 코드
            $("#defectListContainer").html(data); // 예를 들어, id가 'defectListContainer'인 요소에 데이터를 삽입
        },
        error: function(error) {
            console.error("Error fetching defect list:", error);
        }
    });
});
</script>


<div id="qualityListContainer">
    <!-- /quality/productQualityList 페이지의 데이터가 여기에 동적으로 삽입됩니다. -->
</div>

<div id="defectListContainer">
    <!-- /quality/productDefectList 페이지의 데이터가 여기에 동적으로 삽입됩니다. -->
</div>

<!-- 경고 메세지 출력 -->	
<script>
 var result = "${result}";
 var resultAudit = "${AUDIT}";
 var resultDefect = "${DEFECT}";
 
 if(result == "duplicate"){
	 Swal.fire("이미 불량 정보가 등록된 검수 내역입니다.");
 }else if(result == "duplicateStock"){
	 Swal.fire("이미 재고 정보가 등록된 검수 내역입니다."); 
 }else if(result == "STOCKNO"){
	 Swal.fire("상품의 재고 등록이 실패했습니다.");
 }
 
 if(resultAudit == "O"){
	 Swal.fire("검수가 성공적으로 저장되었습니다.");
 }else if(resultAudit == "X"){
	 Swal.fire("검수 저장에 실패했습니다.");
 }
 
 if(resultDefect == "O"){
	 Swal.fire("상품의 불량 현황이 등록되었습니다.");
 }else if(resultDefect == "X"){
	 Swal.fire("상품 불량 등록이 실패했습니다.")
 }
</script>
<!-- 경고 메세지 출력 -->

<!-- 토스트창 ajax 호출 (30초 간격) -->
<script>
$(document).ready(function(){
    function fetchmaterialQualityToast() {
        $.ajax({
            url: "/quality/materialQualityToast",
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
    fetchmaterialQualityToast();

    // 1분마다 호출
    setInterval(fetchmaterialQualityToast, 60000); // 60,000 밀리초 = 1분
});
</script>
<!-- 토스트창 ajax 호출 (60초 간격) -->

<%@ include file="../include/footer.jsp" %>