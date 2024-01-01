<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>


<!-- SweetAlert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>
<!-- SweetAlert 추가 -->
<script>
$(document).ready(function() {
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
            console.error("Error fetching quality list:", error);
        }
    });

   
});
</script>

<!-- 검색 폼 -->
<div class="col-12" style="margin-top:20px;">
<div class="bg-light rounded h-100 p-4">
<h6 class="mb-4">생산지시조회</h6>

<!-- 기타 조회 -->


<div >
<form name="dateSearch" action="/production/produceList3" method="get">
<select id="itemnameSelSearch" name="itemname">
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
    // 기간조회 검색폼의 submit 이벤트 감지
    $("form[name='dateSearch']").submit(function(event) {
        event.preventDefault(); // 기본 폼 제출 동작 방지

        // 폼 데이터 수집
        let formData = {
            startDate: $("input[name='startDate']").val(),
            endDate: $("input[name='endDate']").val(),
            itemname: $("select[name='itemname']").val()
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
            	alert('못간다 :'+$("select[name='produceline']").val()+'/ '+$("select[name='process']").val()
            			+' /'+$("input[name='startDate']").val()+' /'+$("input[name='endDate']").val()+
            			'/ '+ $("select[name='itemname']").val());
            	alert(formData+' / '+error);
                console.error("Error fetching data:", error);
            	console.log(formData);
            }
        });
    });
  
});

</script>



	




<script type="text/javascript">

	/* 생산지시 모달창 */
	
	var exampleModal = document.getElementById('exampleModal')
	exampleModal.addEventListener('show.bs.modal', function (event) {
	  var button = event.relatedTarget
	  var recipient = button.getAttribute('data-bs-whatever')
	  var modalTitle = exampleModal.querySelector('.modal-title')
	  var modalBodyInput = exampleModal.querySelector('.modal-body input')
	});
	/* 생산지시 모달창 */
	
	
	
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
	/* 포장완료 등록 모달창 */
	
	
    

</script>


<%@ include file="../include/footer.jsp" %>