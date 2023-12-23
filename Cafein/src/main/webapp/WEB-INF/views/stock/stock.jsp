<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<script>
$(document).ready(function() {

    $.ajax({
        url: "/stock/materialStockList",
        type: "GET",
        dataType: "html",
        success: function(data) {
            // 성공적으로 데이터를 받아왔을 때 처리할 코드
            $("#stockListContainer").html(data); // 예를 들어, id가 'stockListContainer'인 요소에 데이터를 삽입
        },
        error: function(error) {
            console.error("Error fetching quality list:", error);
        }
    });
});
</script>


<div id="stockListContainer">
    <!-- /stock/materialStockList 페이지의 데이터가 여기에 동적으로 삽입됩니다. -->
</div>

<%@ include file="../include/footer.jsp"%>