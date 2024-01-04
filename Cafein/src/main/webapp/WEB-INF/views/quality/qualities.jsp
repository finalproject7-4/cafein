<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<!-- SweetAlert 추가 -->
<script src="
https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js
"></script>
<!-- SweetAlert 추가 -->

<script>
$(document).ready(function() {
    // 첫 번째 페이지 가져오기
    $.ajax({
        url: "/quality/productQualityList",
        type: "GET",
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
        url: "/quality/productDefectList",
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

<%@ include file="../include/footer.jsp" %>