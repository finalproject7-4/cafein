<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
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

<%@ include file="../include/footer.jsp" %>