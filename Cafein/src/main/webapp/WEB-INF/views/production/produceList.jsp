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
        url: "/production/produceList3",
        type: "GET",
        dataType: "html",
        success: function(data) {
            // 성공적으로 데이터를 받아왔을 때 처리할 코드
            $("#produceListAll").html(data);
        },
        error: function(error) {
            console.error("Error fetching produce list:", error);
        }
    });
}

// 현재 활성화 페이지 가져오기
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
		 url: "/production/produceList3",
		 type: "GET",
		 data: {
  		  page: pageNumber // 현재 페이지 번호 전달
   		 // 나머지 필요한 데이터도 전달 가능
		 },
		 dataType: "html",
		 success: function(data) {
  		  $("#produceListAll").html(data);
		 },
		error: function(error) {
			Swal.fire("페이지를 찾을 수 없습니다.");
    		console.error("Error fetching quality list:", error);
		}
	});
}

</script>

<!-- 검색 폼 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">생산지시조회</h6>

<!-- 기타 조회 -->


<div >
<form name="dateSearch" action="/production/produceList3" method="get">
<select class="form-control" id="itemnameSelSearch" name="itemname">
			<option value="">제품명</option>
	<c:forEach var="iList" items="${itemList }" >
			<option value="${iList.itemname }">${iList.itemname}</option>
	</c:forEach>
</select>

<!-- 조회 달력 -->
<input type="date" id="startDate" name="startDate"> ~ <input type="date" id="endDate" name="endDate">
<!-- 조회 달력 -->
<button type="submit" class="btn btn-dark m-2" id="datesubmitbtn">조회</button>
<button type="reset" class="btn btn-dark m-2" id="dateresetbtn">취소</button>
</form>
</div>
</div>
</div>

<div id="produceListAll">
</div>


<!-- 페이지 Ajax 동적 이동 (2) -->
<script>
$(document).ready(function() {
    // 검색폼의 submit 이벤트 감지
    $("form[name='dateSearch']").submit(function(event) {
        event.preventDefault(); // 기본 폼 제출 동작 방지

        // 폼 데이터 수집
        let formData = {
            itemname: $("select[name='itemname']").val(),
            startDate: $("input[name='startDate']").val(),
            endDate: $("input[name='endDate']").val()
        };


        // AJAX 요청 수행
        $.ajax({
            url: "/production/produceList3",
            type: "GET",
            data: formData,
            success: function(data) {
                // 성공적으로 데이터를 받아왔을 때 처리할 코드
                $("#produceListAll").html(data); // 결과를 화면에 표시
            },
            error: function(error) {
            	Swal.fire("검색하신 조건으로 만족하는 결과가 없습니다.");
                console.error("Error fetching data:", error);
            	console.log(formData);
            }
        });
    });
  
});

</script>



	




<script type="text/javascript">

	/* 생산지시 모달창 시작 */
	
	var exampleModal = document.getElementById('exampleModal')
	exampleModal.addEventListener('show.bs.modal', function (event) {
	  var button = event.relatedTarget
	  var recipient = button.getAttribute('data-bs-whatever')
	  var modalTitle = exampleModal.querySelector('.modal-title')
	  var modalBodyInput = exampleModal.querySelector('.modal-body input')
	});
	/* 생산지시 모달창 끝 */
	
	
	
	/* 생산지시 수정(블렌딩 -> 로스팅) 모달창 시작*/
	
	var exampleModal = document.getElementById('updateModal1')
	exampleModal.addEventListener('show.bs.modal', function (event) {
	  var button = event.relatedTarget
	  var recipient = button.getAttribute('data-bs-whatever')
	  var modalTitle = exampleModal.querySelector('.modal-title')
	  var modalBodyInput = exampleModal.querySelector('.modal-body input')
	});
	
	// 생산지시 수정(블렌딩 -> 로스팅)  클릭시 실행될 함수
	function openUpdateModal1(produceid, producedate, producetime, produceline, itemname, itemid, packagevol) {
    // 모달 내부의 입력 필드에 데이터 설정
    document.getElementById('produceidUpdate').value = produceid;
    document.getElementById('producedateUpdate').value = producedate;
    document.getElementById('producetimeUpdate').value = producetime;
    document.getElementById('producelineUpdate').value = produceline;
    document.getElementById('itemnameUpdate').value = itemname;
    document.getElementById('itemidUpdate').value = itemid;

    // 모달 열기
    $('#updateModal1').modal('show');
}
	/* 생산지시 수정(블렌딩 -> 로스팅) 모달창 끝 */
	
	
	/* 생산지시 수정(로스팅 -> 포장) 모달창 시작*/
	
	var exampleModal = document.getElementById('updateModal2')
	exampleModal.addEventListener('show.bs.modal', function (event) {
	  var button = event.relatedTarget
	  var recipient = button.getAttribute('data-bs-whatever')
	  var modalTitle = exampleModal.querySelector('.modal-title')
	  var modalBodyInput = exampleModal.querySelector('.modal-body input')
	});
	
	// 생산지시 수정(로스팅 -> 포장)  클릭시 실행될 함수
	function openUpdateModal2(produceid, producedate, producetime, produceline, itemname, itemid, packagevol, amount) {
    // 모달 내부의 입력 필드에 데이터 설정
    document.getElementById('produceidUpdate2').value = produceid;
    document.getElementById('producedateUpdate2').value = producedate;
    document.getElementById('producetimeUpdate2').value = producetime;
    document.getElementById('producelineUpdate2').value = produceline;
    document.getElementById('itemnameUpdate2').value = itemname;
    document.getElementById('itemidUpdate2').value = itemid;
    document.getElementById('amountPack2').value = amount;

    // 모달 열기
    $('#updateModal2').modal('show');
}
	/* 생산지시 수정(로스팅 -> 포장) 모달창 끝 */
	
	
	
	/* BOM 등록 모달창 */
	
	var exampleModal = document.getElementById('exampleModal1')
	exampleModal.addEventListener('show.bs.modal', function (event) {
	  var button = event.relatedTarget
	  var recipient = button.getAttribute('data-bs-whatever')
	  var modalTitle = exampleModal.querySelector('.modal-title')
	  var modalBodyInput = exampleModal.querySelector('.modal-body input')
	});
	/* BOM 등록 모달창 */
	
	/* 포장완료 등록 모달창 */
	
	 var exampleModal = document.getElementById('packageModal')
	  exampleModal.addEventListener('show.bs.modal', function (event) {
	  var button = event.relatedTarget
	  var recipient = button.getAttribute('data-bs-whatever')
	  var modalTitle = exampleModal.querySelector('.modal-title')
	  var modalBodyInput = exampleModal.querySelector('.modal-body input')
	});
	
	// 포장완료 등록 모달창 
	
	// 포장완료 클릭시 실행될 함수
 	function openPackageModal(produceid, producedate, producetime, produceline, itemname, itemid, packagevol, amount) {
    // 모달 내부의 입력 필드에 데이터 설정
    document.getElementById('produceidPack').value = produceid;
    document.getElementById('producedatePack').value = producedate;
    document.getElementById('producetimePack').value = producetime;
    document.getElementById('producelinePack').value = produceline;
    document.getElementById('itemnamePack').value = itemname;
    document.getElementById('itemidPack').value = itemid;
    document.getElementById('packagevolPack').value = packagevol;
    document.getElementById('amountPack').value = amount;

    // 모달 열기
    $('#packageModal').modal('show'); 
} 
	
    

</script>


<%@ include file="../include/footer.jsp" %>