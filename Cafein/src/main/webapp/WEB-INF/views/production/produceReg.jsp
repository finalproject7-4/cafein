<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!-- 생산지시 모달창 시작-->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">생산 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="produceReg" method="post">
						<div class="row">
							<div class="col">
								<label for="process" class="col-form-label">공정과정</label> 
								<select class="form-select" id="processSelect"
									aria-label="Floating label select example" name="process" onchange="chageLangSelect()">
									<optgroup label="공정과정">
										<option value="블렌딩">블렌딩</option>
										<option value="로스팅">로스팅</option>
										<option value="포장">포장</option>
									</optgroup>
								</select>
							</div>
							<div class="col">
								<label for="producedate" class="col-form-label">생산일자</label> 
								<input type="date" name="producedate" class="date form-control" id="producedate">
							</div>
						</div>
							<div class="row">
							<div class="col">
								<label for="produceline" class="col-form-label">생산라인</label> 
								<select class="form-select" id="producelineSelect"
									aria-label="Floating label select example" name="produceline">
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
									aria-label="Floating label select example" name="producetime">
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
								<input id="itemnamePro" name="itemname" class="form-control" readonly>
							</div>
							<div class="col">
								<label for="amount" class="col-form-label">생산량</label>
								<input type="number"  name="amount" id="amount" class="form-control" min="20000" max="60000" step="10000" placeholder="생산량(g)">
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
							<div class="col">
								<label for="memebercode" class="col-form-label">담당자(사원번호)</label>
								<input name="membercode" class="form-control" id="membercode">
							</div>
							<div class="col" style="display:none;">
								<label for="itemid" class="col-form-label">아이템ID</label>
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



<script type="text/javascript">

/* 공정과정 선택에 따라 출력 */
$("#processSelect").change(function(){
var test = $("#processSelect option:selected").val();
if(test=='블렌딩'){
$('#temperh').hide();
}
else if(test=='로스팅'){
$('#temperh').show();
}
else if(test=='포장'){
$('#temperh').hide();
}

});

/*모달창 달력 이전날짜 비활성화*/
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];

	// class="date"인 모든 요소에 날짜 비활성화
	document.querySelectorAll('.date').forEach(function(input) {
		input.setAttribute('min', today);
	});


</script>




