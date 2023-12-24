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

<script>
	// 재고 등록 성공 / 실패 알림
	var result = "${result}";
	
	if(result == "STOCKYES"){
		alert("재고 등록 성공!");
	}else if(result == "STOCKUPNO"){
		alert("재고량 변경 실패!");
	}else if(result == "STOCKUPYES"){
		alert("재고량 변경 성공!");
	}else if(result == "STOCKSUPNO"){
		alert("창고 변경 실패!");
	}else if(result == "STOCKSUPYES"){
		alert("창고 변경 성공!")
	}
</script>

<%@ include file="../include/footer.jsp"%>