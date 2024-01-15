<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<!-- SweetAlert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>
<!-- SweetAlert 추가 -->
<c:if test="${empty membercode}">
    <c:redirect url="/login" />
</c:if> 


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
<h6 class="mb-4">생산Lot 조회</h6>

<!-- LOT 조회 -->
<div >
<form name="searchForm" action="" method="get">
<div class="row">
<div class="col">
	<input class="form-control" type="text" id="searchLot" name="searchLot" placeholder="lot번호 검색">
</div>
<!-- 조회 달력 -->
<div class="col">
<input class="form-control" type="date" id="searchDate" name="searchDate">
</div>
<!-- 조회 달력 -->
<div class="col">
<button type="submit" class="btn btn-sm btn-dark m-2" id="datesubmitbtn">조회</button>
<button type="reset" class="btn btn-sm btn-dark m-2" id="dateresetbtn">취소</button>
</div>
</div>
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
        
	        var formData = $(this).serialize(); // 폼 데이터 직렬화
        
        // AJAX 요청 수행
        $.ajax({
            url: "/production/roastedDetail",
            type: "GET",
            data: formData,
            success: function(data) {
                // 성공적으로 데이터를 받아왔을 때 처리할 코드
                $("#roastedBeanList").html(data); // 결과를 화면에 표시
            },
            error: function(error) {
            	Swal.fire("검색하신 조건으로 찾을 수 없습니다.");
            	Swal.fire($("input[name='searchDate']").val()+' / 에베베 '+$("input[name='searchLot']").val());
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
			Swal.fire("목록을 불러오지 못했습니다.");
    		console.error("Error fetching quality list:", error);
		}
	});
}

/* 바코드 모달창 */

var exampleModal = document.getElementById('barcodeModal')
 exampleModal.addEventListener('show.bs.modal', function (event) {
 var button = event.relatedTarget
 var recipient = button.getAttribute('data-bs-whatever')
 var modalTitle = exampleModal.querySelector('.modal-title')
 var modalBodyInput = exampleModal.querySelector('.modal-body input')
});

//바코드 클릭시 실행될 함수
function openbarcodeModal(itemname, packvolume, lotnumber,roasteddate) {
// 모달 내부의 입력 필드에 데이터 설정
document.getElementById('itemnamebar').value = itemname;
document.getElementById('packagevolumbar').value = packvolume;
document.getElementById('lotnumberbar').value = lotnumber;
document.getElementById('roasteddatebar').value = roasteddate;
printBarcode(); //  바코드 생성 함수
// 모달 열기

$('#barcodeModal').modal('show'); 


}



//모달 내용을 인쇄하는 함수
function printModalContent() {
  var currentPage = getCurrentPageNumber();
  var printContents = document.getElementById('barcodeModal').innerHTML; // 모달 내용을 가져옵니다.
  var originalContents = document.body.innerHTML; // 현재 페이지의 내용을 저장합니다.
  document.body.innerHTML = printContents; // 모달 내용을 현재 페이지에 설정합니다.
  window.print(); // 모달 내용을 인쇄합니다.
  document.body.innerHTML = originalContents; // 원래 페이지의 내용으로 되돌립니다.
	$('#barcodeModal').modal('hide'); // 모달을 닫는 코드
	getList();
}

function close(){
	$('#barcodeModal').modal('hide'); // 모달을 닫는 코드
	getList(currentPage);
}
// btn-close 클래스를 가진 요소를 클릭했을 때 모달을 닫음
$('.btn-close').click(function() {
    $('#barcodeModal').modal('hide'); // 모달을 닫는 코드
});
</script>
 




<%@ include file="../include/footer.jsp" %>