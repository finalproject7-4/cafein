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
									aria-label="Floating label select example" name="process" onchange="chageLangSelect()" required="required">
									<optgroup label="공정과정">
										<option value="블렌딩">블렌딩</option>
										<option value="로스팅">로스팅</option>
										<option value="포장">포장</option>
									</optgroup>
								</select>
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

<!-- 생산지시 수정(블렌딩-> 로스팅) 모달창 시작-->
<div class="modal fade" id="updateModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">로스팅 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form action="processUpdateRoasting" method="post">
						<div class="row">
							<div class="col">
								<label for="produceid" class="col-form-label">생산ID</label> 
								<input type="text" name="produceid" class="date form-control" id="produceidUpdate" readonly="readonly">
							</div>
							<div class="col">
								<label for="process" class="col-form-label">공정과정</label> 
								<input type="text" value="로스팅" name="process" class="date form-control" id="processUpdate" readonly="readonly">
							</div>
							<div class="col">
								<label for="producedateUp" class="col-form-label">생산일자</label> 
								<input type="date" name="producedateUp" class="date form-control" id="producedateUpdate" readonly="readonly">
							</div>
						</div>
							<div class="row">
							<div class="col">
								<label for="produceline" class="col-form-label">생산라인</label> 
								<input type="text" name="produceline" class="date form-control" id="producelineUpdate" readonly="readonly">
							</div>
							<div class="col">
								<label for="producetime" class="col-form-label">생산타임</label> 
								<input type="text" name="producetime" class="date form-control" id="producetimeUpdate" readonly="readonly">
							</div>
							</div>
					<div class="row">
							<div class="col">
								<label for="itemname" class="col-form-label">제품명</label> 
								<input type="text" id="itemnameUpdate" name="itemname" class="form-control" readonly="readonly">
							</div>
							<div class="col" style="display: none;">
								<label for="itemid" class="col-form-label">제품ID</label> 
								<input type="text" id="itemidUpdate" name="itemid" class="form-control" >
							</div>					
							<div class="col" id="tempeup">
								<label for="temper" class="col-form-label">온도</label>
								<input type="text" name="temper" class="form-control" <%-- value="${tlist.temper }" --%>>
							</div>
							<div class="col" id="packagevolrh" style="display: none;">
								<label for="temppackagevoler" class="col-form-label">포장량</label>
								<input type="number" value="0" name="packagevol" class="form-control">
							</div>
					</div>
					<div class="row">
							<div class="col">
								<label for="memebercode" class="col-form-label">담당자(사원번호)</label>
								<input name="membercode" class="form-control" id="membercode1">
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
<!-- 생산지시 수정(블렌딩-> 로스팅) 모달창 끝-->


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

/* 공정과정 선택에 따라 출력 */
$("#processSelect").change(function(){
var test = $("#processSelect option:selected").val();
if(test=='블렌딩'){
$('#temperh').hide();
$('#packageam').hide();
}
else if(test=='로스팅'){
$('#temperh').show();
$('#packageam').hide();
}
else if(test=='포장'){
$('#packageam').show();
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




