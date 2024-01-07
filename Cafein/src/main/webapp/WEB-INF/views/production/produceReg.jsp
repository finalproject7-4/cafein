<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- SweetAlert 추가 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>
<!-- SweetAlert 추가 -->
    
<!-- 생산지시 모달창 시작-->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">생산 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="" method="post">
						<div class="row">
							<div class="col">
								<label for="process" class="col-form-label">공정과정</label> 
								<input type="text" value="블렌딩" name="process" class="date form-control" id="process" readonly="readonly">
							</div>
							<div class="col">
								<label for="producedate" class="col-form-label">생산일자</label> 
								<input type="date" name="producedate" class="date form-control" id="producedate" required="required">
							</div>
						</div>
							<div class="row">
							<div class="col">
								<label for="produceline" class="col-form-label">생산라인</label> 
								<select class="form-select" id="producelineSelect"
									aria-label="Floating label select example" name="produceline" required="required">
									<optgroup label="생산라인">
										<option value="1">1라인</option>
										<option value="2">2라인</option>
										<option value="3">3라인</option>
										<option value="4">4라인</option>
										<option value="5">5라인</option>
										<option value="6">6라인</option>
									</optgroup>
								</select>
							</div>
							<div class="col">
								<label for="producetime" class="col-form-label">생산타임</label> 
								<select class="form-select" id="producetimeSelect"
									aria-label="Floating label select example" name="producetime" required="required">
									<optgroup label="생산타임">
										<option value="1">1타임</option>
										<option value="2">2타임</option>
										<option value="3">3타임</option>
										<option value="4">4타임</option>
										<option value="0">★긴급★</option>
									</optgroup>
								</select>
							</div>
							</div>
					<div class="row">
							<div class="col">
								<label for="itemname" class="col-form-label">제품명</label> 
								<input id="itemnamePro" name="itemname" class="form-control" readonly placeholder="클릭하세요.">
							</div>
							<div class="col">
								<label for="amount" class="col-form-label">생산량</label>
								<input type="number" required="required"  name="amount" id="amount" class="form-control" min="20000" max="60000" step="10000" placeholder="생산량(g)">
							</div>
							</div>
							<div class="row">
							<div class="col">
								<label for="itemname1" class="col-form-label">원재료1</label>
								<input name="itemname1" type="text" class="form-control" id="itemnameOri1" readonly>
							</div>
							<div class="col">
								<label for="itemname2" class="col-form-label">원재료2</label>
								<input type="text" name="itemname2" class="form-control" id="itemnameOri2" readonly>
							</div>
							<div class="col">
								<label for="itemname3" class="col-form-label">원재료3</label>
								<input type="text" name="itemname3" class="form-control" id="itemnameOri3" readonly>
							</div>
							<!-- 아래가 실제 등록될 itemid1~3 값 -->
							</div>
							<div class="row" style="display:none;">
							<div class="col">
								<label for="itemid1" class="col-form-label">원재료1</label>
								<input name="itemid1" type="text" class="form-control" id="itemidOri1" readonly>
							</div>
							<div class="col">
								<label for="itemid2" class="col-form-label">원재료2</label>
								<input type="text" name="itemid2" class="form-control" id="itemidOri2" readonly>
							</div>
							<div class="col">
								<label for="itemid3" class="col-form-label">원재료3</label>
								<input type="text" name="itemid3" class="form-control" id="itemidOri3" readonly>
							</div>
							</div>
							<!-- 출고대기등록할 때 쓸 stockid -->
							<div class="row" style="display: none;">
							<div class="col">
								<label for="stockid1" class="col-form-label">재고ID1</label>
								<input name="stockid1" type="text" class="form-control" id="stockid1" readonly>
							</div>
							<div class="col">
								<label for="stockid2" class="col-form-label">재고ID2</label>
								<input type="text" name="stockid2" class="form-control" id="stockid2" readonly>
							</div>
							<div class="col">
								<label for="stockid3" class="col-form-label">재고ID3</label>
								<input type="text" name="stockid3" class="form-control" id="stockid3" readonly>
							</div>
							</div>
							<div class="row">
							<div class="col">
								<label for="rate" class="col-form-label">비율</label>
								<input type="text" name="rate" class="form-control" id="rate" readonly>
							</div>						
							<div class="col" id="temperh" style="display: none;">
								<label for="temper" class="col-form-label">온도</label>
								<input type="text" name="temper" class="form-control" id="temper" readonly>
							</div>
							<div class="col" id="packageam" style="display: none;">
								<label for="packagevol" class="col-form-label">포장용량</label>
								<input type="number" name="packagevol" class="form-control" id="packagevol" value="500" min="500" max="1000" step="500">
							</div>
							<div class="col">
								<label for="memebercode" class="col-form-label">담당자(사원번호)</label>
								<input name="membercode" class="form-control" id="membercode">
							</div>
							<div class="col" style="display:none;">
								<label for="itemid" class="col-form-label" >아이템ID</label>
								<input name="itemid" class="form-control" id="itemidPro">
							</div>
							</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<input type="submit" class="btn btn-primary" value="등록">
					</div>
						</form>
					</div>
				</div>
			</div>
		</div>
<!-- 생산지시 모달창 끝-->


<!-- 생산지시 수정(로스팅-> 포장) 모달창 시작-->
<div class="modal fade" id="updateModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">포장 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="processUpdatePackage" method="post">
						<div class="row">
							<div class="col">
								<label for="produceid" class="col-form-label">생산ID</label> 
								<input type="text" name="produceid" class="date form-control" id="produceidUpdate2" readonly="readonly">
							</div>
							<div class="col">
								<label for="process" class="col-form-label">공정과정</label> 
								<input type="text" value="포장" name="process" class="date form-control" id="processUpdate2" readonly="readonly">
							</div>
							<div class="col">
								<label for="producedateUp" class="col-form-label">생산일자</label> 
								<input type="date" name="producedateUp" class="date form-control" id="producedateUpdate2" readonly="readonly">
							</div>
						</div>
							<div class="row">
							<div class="col">
								<label for="produceline" class="col-form-label">생산라인</label> 
								<input type="text" name="produceline" class="date form-control" id="producelineUpdate2" readonly="readonly">
							</div>
							<div class="col">
								<label for="producetime" class="col-form-label">생산타임</label> 
								<input type="text" name="producetime" class="date form-control" id="producetimeUpdate2" readonly="readonly">
							</div>
							</div>
					<div class="row">
							<div class="col">
								<label for="itemname" class="col-form-label">제품명</label> 
								<input type="text" id="itemnameUpdate2" name="itemname" class="form-control" readonly="readonly">
							</div>
							<div class="col" style="display: none;">
								<label for="itemid" class="col-form-label">제품ID</label> 
								<input type="text" id="itemidUpdate2" name="itemid" class="form-control" >
							</div>					
							<div class="col" id="packagevolup">
								<label for="packagevol" class="col-form-label">1팩당 포장량</label>
								<input type="number" min="500" max="1000" step="500" name=packagevol class="form-control">
							</div>
							<div class="col" id="packagevolup" style="display: none;">
								<label for="amount" class="col-form-label">지시 생산량</label>
								<input type="text" id="amountPack2" name="amount" class="form-control" >
							</div>
					</div>
					<div class="row">
							<div class="col">
								<label for="memebercode" class="col-form-label">담당자(사원번호)</label>
								<input name="membercode" class="form-control" id="membercode2">
							</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<input type="submit" class="btn btn-primary" value="등록">
					</div>
						</form>
					</div>
				</div>
			</div>
		</div>
<!-- 생산지시 수정(로스팅-> 포장) 모달창 끝-->



<script type="text/javascript">


/*모달창 달력 이전날짜 비활성화*/
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];

	// class="date"인 모든 요소에 날짜 비활성화
	document.querySelectorAll('.date').forEach(function(input) {
		input.setAttribute('min', today);
	});
	
	$(document).ready(function() {
		// 생산지시 등록 AJAX 처리
	    $('#exampleModal form').submit(function(e) {
	        e.preventDefault(); // 기본 제출 동작 방지

	        var formData = $(this).serialize(); // 폼 데이터 직렬화

	        $.ajax({
	            url: '/production/produceReg',
	            type: 'POST',
	            data: formData,
	            success: function(response) {
	            	console.log('생산지시 등록 성공!');
	                Swal.fire("등록 완료");
	                var currentPage = getCurrentPageNumber(); // 현재 페이지 번호를 가져옴
					getList(currentPage);
	                $('#exampleModal').modal('hide');
	            },
	            error: function(error) {
	            	 console.error('생산지시 등록 실패:', error);
		                Swal.fire("이미 작업 지시가 등록된 시간대입니다.");
	                 $('#exampleModal form')[0].reset(); // 폼에 입력한 것 초기화. 사용자 실수 줄이기 위해서.
	            }
	        });
	    });
	             
	    
	    // 포장공정 등록 AJAX
	    $('#updateModal2 form').submit(function(e) {
	        e.preventDefault(); // 기본 제출 동작 방지

	        var formData = $(this).serialize(); // 폼 데이터 직렬화

	        $.ajax({
	            url: '/production/processUpdatePackage',
	            type: 'POST',
	            data: formData,
	            success: function(response) {
	            	console.log('포장공정 등록 성공!');
	                Swal.fire("포장공정 등록 완료");
	                
	                var currentPage = getCurrentPageNumber(); // 현재 페이지 번호를 가져옴
					getList(currentPage);
	                $('#updateModal2').modal('hide');
	            },
	            error: function(error) {
	            	console.error('포장공정 등록 실패:', error);
	                Swal.fire("이미 포장이 완료되었습니다.");	      
	                 $('#updateModal2 form')[0].reset(); // 폼에 입력한 것 초기화. 사용자 실수 줄이기 위해서.
	            }
	        });
	    });
	  });




</script>




