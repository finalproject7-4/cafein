<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <title>반품 관리</title>
    <style>
        .tab-content {
            display: none;
        }

        .active {
            display: block;
        }
         form {
        border-radius: 0.25rem;    /* 모서리 깍임 정도 설정 */
        padding: 20px;             /* 내부 여백 설정 */
  		}
		.table td input[type="checkbox"] {
			/* 수직으로 셀 내부에 체크박스를 가운데로 정렬합니다. */
			vertical-align: middle;

			/* 선택적으로 수평 정렬을 조정합니다. */
			text-align: center; /* 셀 내부에 체크박스를 가운데로 정렬합니다. */
			/* 또는 */
			margin-left: auto; /* 체크박스를 오른쪽으로 정렬합니다. */
			margin-right: auto; /* 체크박스를 왼쪽으로 정렬합니다. */
		}
    </style>
   
</head>
<body>

     <!-- 검색창 -->
   		<div class="col-12" style="margin-top:20px;">
		<div class="bg-light rounded h-100 p-4">
        <form action="" method="get">
        <h6 class="mb-4">반품조회</h6>
	<div class="row">
            <div class="form-group" style="width: 200px; margin-right: 20px;">
                <label for="returncode">반품 코드</label>
                <input type="text" class="form-control" id="returncode" name="returncode" value="${returnVO.returncode }" placeholder="반품 코드">
            </div>
            
            <div class="form-group" style="width: 200px; margin-right: 20px;">
                <label for="reuturntype">품목</label>
                <select name="returntype" class="form-control" id="returntype">
                	<option ${returnVO.returntype eq "전체" ? "selected" : "" }>전체</option>
                	<option ${returnVO.returntype eq "MOT" ? "selected" : "" }>MOT</option>
                	<option ${returnVO.returntype eq "PRO" ? "selected" : "" }>PRO</option>
                </select>
            </div>
	
            <div class="form-group " style="width: 400px;">
                <label for="returndate">반품 날짜</label>
                <div class="input-group" style="width: 400px">
                    <input type="date" class="form-control" id="startDate" name="startDate" value="${not empty returnVO.startDate ? returnVO.startDate : ''}">
                <div >
                &nbsp;~&nbsp;
                </div>
                    <input type="date" class="form-control" id="endDate" name="endDate" value="${not empty returnVO.endDate ? returnVO.endDate : ''}">
                </div>
            </div>
	</div>
            
           <div class="d-flex justify-content-end">
            <button type="submit" class="btn btn-outline-dark m-2">조회</button>
           </div>
        </form>
		</div>
		</div>
     <!-- 검색창 -->
     
	<!-- 반품 등록 모달창 -->   
    <div class="modal fade" id="returnAuditModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">반품 등록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<form role="form" action="/quality/returnRegist" method="post">
				<div class="modal-body">
					<div class="row">
					<div class="col">
						<label for="returntype" class="col-form-label"><b>반품유형</b></label>
						<select class="form-select" id="returnTypeSelect" name="returntype"
							aria-label="Floating label select example">
							<optgroup label="반품유형">
								<option value="원자재">원자재</option>
								<option value="부자재">부자재</option>
								<option value="완제품">완제품</option>
							</optgroup>
						</select>
					</div>
					
						
					<div class=col>
						<label for="returnReason" class="col-form-label"><b>반품사유</b></label>
						<select class="form-select" id="returnReasonSelect" name="returnReason"
							aria-label="Floating label select example">
							<optgroup label="반품사유">
								<option value="제품불량">제품불량</option>
								<option value="주문오류">주문오류</option>
							</optgroup>
						</select>
					</div>	
				</div>
					<div class="row">
						<div class="col">
							<label for="returnname" class="col-form-label">제품명</label> 
							
								<select class="form-select" id="floatingSelect" name="returnname">
									<c:forEach var="itList" items="${itList }" begin="0" step="1">
										<c:if test="${itList.itemtype eq '원자재'}">
											<option value="${itList.itemname }">${itList.itemname }</option>
										</c:if>
									</c:forEach>
								</select>
						</div>
						<div class="col">
							<b>수량</b><input id="returnquantity" name="returnquantity" class="form-control" id="floatingInput">
						</div>
					</div><br>
						<div class="col">
							<b>반납날짜</b><input type="date" id="returndate" name="returndate" class="form-control" id="returnDateInput" readonly>
						</div><br>
				</div>
					
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" id="returnRegistBtn">등록</button>
				</div>
				</form>
			</div>
		</div>
	</div> 
	<!-- 반품 등록 모달창 끝 -->
	
	
	
	<!-- 반품 등록 반품 날짜를 오늘날짜로 지정 -->
	<script>
	
	//오늘의 날짜를 returnDateInput에 자동으로 설정
	$(document).ready(() => $('#returnAuditModal').on('show.bs.modal', () => $('#returndate').val(new Date().toISOString().split('T')[0])));

	</script>
	<!-- 반품 등록 반품 날짜를 오늘날짜로 지정 끝 -->
	
	
	
	<!-- 수정 등록 모달창 -->	
    <div class="modal fade" id="ModifyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			
				<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">수정 등록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				
				<form role="form" action="/quality/returnModify" method="post">
				<input type="hidden" id="returnid" name="returnid">
				<div class="modal-body">
					<div class="row">
					<div class="col">
						<label for="returntype" class="col-form-label"><b>반품유형</b></label>
						<select class="form-select" id="returnTypeSelect2" name="returntype"
							aria-label="Floating label select example" >
							<optgroup label="반품유형">
								<option value="원자재">원자재</option>
								<option value="부자재">부자재</option>
								<option value="완제품">완제품</option>
							</optgroup>
						</select>
					</div>
					
						
					<div class=col>
						<label for="returnReason" class="col-form-label"><b>반품사유</b></label>
						<select class="form-select" id="returnReasonSelect2" name="returnReason"
							aria-label="Floating label select example" >
							<optgroup label="반품사유">
								<option value="제품불량">제품불량</option>
								<option value="주문오류">주문오류</option>
							</optgroup>
						</select>
					</div>	
				</div>
					<div class="row">
						<div class="col">
							<label for="returnname" class="col-form-label">제품명</label> 
							
								<select class="form-select" id="returnname" name="itemid">
									<c:forEach var="iList" items="${itemList }" begin="0" step="1">
										<c:if test="${iList.itemtype eq '원자재'}">
											<option value="${iList.returnname }">${iList.returnname}</option>
										</c:if>
									</c:forEach>
								</select>
						</div>
					</div><br>
					<div class="row">
						<div class="col">
							<b>수량</b><input id="returnquantity2" name="returnquantity" class="form-control" id="floatingInput" value="">
						</div>
						<div class="col">
							<b>반납날짜</b><input type="date" id="returndate2" name="returndate" class="form-control" id="floatingInput" value="">
						</div>
					</div><br>
						<div class="col">
							<b>교환날짜</b><input type="date" id="exchangedate2" name="exchangedate" class="form-control" id="floatingInput" value="">
						</div><br>
				</div>
					
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" id="ModifyBtn">저장</button>
				</div>
				</form>
			</div>
		</div>
	</div> 
	<!-- 수정 등록 모달창 끝 -->	
	
        
	
	<!-- 반품조회 테이블 -->
		<div class="col-12" style="margin-top:20px;">
		<div class="bg-light rounded h-100 p-4">
		<h6  class="mb-4">총 ${fn:length(returnList)} 건</h6>
		
		<div class="d-flex justify-content-between">
		<div>
		<button onclick="showTab('all') " class="btn btn-outline-dark m-2">전체</button>
		<button onclick="showTab('waiting') " class="btn btn-outline-dark m-2">대기</button>
		<button onclick="showTab('inProgress') " class="btn btn-outline-dark m-2">검수중</button>
		<button onclick="showTab('completed') " class="btn btn-outline-dark m-2">완료</button>
		</div>
		
		<div class="d-flex align-items-center">
		<button type="button" class="btn btn-outline-dark m-2" data-bs-toggle="modal" data-bs-target="#returnAuditModal" data-bs-whatever="@getbootstrap">반품 등록</button>
		<button type="button" class="btn btn-outline-dark m-2" > 교환 </button>
		</div>
		
		</div>
		
		<div id="allTab" class="tab-content active">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                    	<th scope="col">선택</th>
                        <th scope="col">반품ID</th>
                        <th scope="col">반품코드</th>
                        <th scope="col">제품명</th>
                        <th scope="col">품목</th>
                        <th scope="col">반품날짜</th>
                        <th scope="col">교환날짜</th>
                        <th scope="col">수량</th>
                        <th scope="col">반품상태</th>
                        <th scope="col">검수상태</th>
                        <th scope="col">반품 정보</th>
                        <th scope="col">수정 & 삭제</th>
                        <th scope="col">품질관리등록</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${returnList}" var="returnVO">
                        <tr>
                        	<td><input type="checkbox" name="selectedEmpId" value="${returnVO.returncode}" class="form-check-input"></td>
                            <td>${returnVO.returnid}</td>
                            <td>${returnVO.returncode}</td>
                            <td>${returnVO.returnname}</td>
                            <td>${returnVO.returntype}</td>
                            <td><fmt:formatDate value="${returnVO.returndate }" pattern="yyyy-MM-dd" /></td>
                            <td>${returnVO.exchangedate}</td>                          
                            <td>${returnVO.returnquantity}</td>
                            <td>${returnVO.returnstatus}</td>
                            <td>${returnVO.reprocessmethod}</td>
                            <td>${returnVO.returninfo}</td>
                            <td>
										<!-- 버튼 수정 -->
										<button type="button" class="btn btn-outline-dark" 
										        onclick="openModifyModal('${returnVO.returntype}', '${returnVO.returnReason }', '${returnVO.returnname }', '${returnVO.returnquantity}', '${returnVO.returndate}', '${returnVO.exchangedate}','${returnVO.returnid}')">
										        수정 
										</button>
										<!-- 버튼 삭제 -->
										<button type="button" class="btn btn-outline-dark"
												onclick="deleteReturn('${returnVO.returnid}')">
												삭제
										</button>
							</td>
							<td>
							<button type="button" class="btn btn-outline-dark" 
									onclick="addReturn('${returnVO.returnid}')">
									등록
							</button>
							</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>	
    
    
    	
		<div id="waitingTab" class="tab-content active">
		<div class="table-responsive">
		    <table class="table">
		        <thead>
		        	<tr>
	        			<th scope="col">선택</th>
                        <th scope="col">반품ID</th>
                        <th scope="col">반품코드</th>
                        <th scope="col">제품명</th>
                        <th scope="col">품목</th>
                        <th scope="col">반품날짜</th>
                        <th scope="col">교환날짜</th>
                        <th scope="col">수량</th>
                        <th scope="col">반품상태</th>
                        <th scope="col">검수상태</th>
                        <th scope="col">반품 정보</th>
                        <th scope="col">수정 & 삭제</th>
                        <th scope="col">품질관리등록</th>
                    </tr>
		        </thead>
		        <tbody>
		            <c:forEach items="${returnList}" var="returnVO">
		                <c:if test="${returnVO.returnstatus eq '대기중'}">
	                    <tr>
	                       <td><input type="checkbox" name="selectedEmpId" value="${returnVO.returncode}" class="form-check-input"></td>
                           <td>${returnVO.returnid}</td>
                           <td>${returnVO.returncode}</td>
                           <td>${returnVO.returnname}</td>
                           <td>${returnVO.returntype}</td>
                           <td><fmt:formatDate value="${returnVO.returndate }" pattern="yyyy-MM-dd" /></td>
                           <td>${returnVO.exchangedate}</td>                          
                           <td>${returnVO.returnquantity}</td>
                           <td>${returnVO.returnstatus}</td>
                           <td>${returnVO.reprocessmethod}</td>
                           <td>${returnVO.returninfo}</td>
                           <td>
										<!-- 버튼 수정 -->
										<button type="button" class="btn btn-outline-dark" 
										        onclick="openModifyModal('${returnVO.returntype}', '${returnVO.returnReason }', '${returnVO.returnname }', '${returnVO.returnquantity}', '${returnVO.returndate}', '${returnVO.exchangedate}','${returnVO.returnid}')">
										        수정 
										</button>
										<!-- 버튼 삭제 -->
										<button type="button" class="btn btn-outline-dark"
												onclick="deleteReturn('${returnVO.returnid}')">
												삭제
										</button>
							</td>
							<td>
							<button type="button" class="btn btn-outline-dark" 
									onclick="addReturn('${returnVO.returnid}')">
									등록
							</button>
							</td>
                        </tr>  
                        </c:if>
		            </c:forEach>
		        </tbody>
		    </table>
		</div>
	</div>
	
	
	
		
		<div id="inProgressTab" class="tab-content active">
		<div class="table-responsive">
		    <table class="table">
		        <thead>
		            <tr>
		            	<th scope="col">선택</th>
                        <th scope="col">반품ID</th>
                        <th scope="col">반품코드</th>
                        <th scope="col">제품명</th>
                        <th scope="col">반품날짜</th>
                        <th scope="col">교환날짜</th>
                        <th scope="col">수량</th>
                        <th scope="col">반품상태</th>
                        <th scope="col">검수상태</th>
                        <th scope="col">품목</th>
                        <th scope="col">반품 정보</th>
                        <th scope="col">수정 & 삭제</th>
                        <th scope="col">품질관리등록</th>
                    </tr>
		        </thead>
		        <tbody>
		            <c:forEach items="${returnList}" var="returnVO">
		            <c:if test="${returnVO.reprocessmethod eq '검수중'}">
		                <tr>
		                   <td><input type="checkbox" name="selectedEmpId" value="${returnVO.returncode}" class="form-check-input"></td>
	                       <td>${returnVO.returnid}</td>
                           <td>${returnVO.returncode}</td>
                           <td>${returnVO.returnname}</td>
                           <td><fmt:formatDate value="${returnVO.returndate }" pattern="yyyy-MM-dd" /></td>
                           <td>${returnVO.exchangedate}</td>                          
                           <td>${returnVO.returnquantity}</td>
                           <td>${returnVO.returnstatus}</td>
                           <td>${returnVO.reprocessmethod}</td>
                           <td>${returnVO.returntype}</td>
                           <td>${returnVO.returninfo}</td>
                           <td>
										<!-- 버튼 수정 -->
										<button type="button" class="btn btn-outline-dark" 
										        onclick="openModifyModal('${returnVO.returntype}', '${returnVO.returnReason }', '${returnVO.returnname }', '${returnVO.returnquantity}', '${returnVO.returndate}', '${returnVO.exchangedate}','${returnVO.returnid}')">
										        수정 
										</button>
										<!-- 버튼 삭제 -->
										<button type="button" class="btn btn-outline-dark"
												onclick="deleteReturn('${returnVO.returnid}')">
												삭제
										</button>
							</td>
							<td>
							<button type="button" class="btn btn-outline-dark" 
									onclick="addReturn('${returnVO.returnid}')">
									등록
							</button>
							</td>
		                </tr>
	              	</c:if>
		            </c:forEach>
		        </tbody>
		    </table>
		</div>
		</div>
		
		
		
		<div id="completedTab" class="tab-content active">
		<div class="table-responsive">
		    <table class="table">
		        <thead>
       			<tr>
       				<th scope="col">선택</th>
                    <th scope="col">반품ID</th>
                    <th scope="col">반품코드</th>
                    <th scope="col">제품명</th>
                    <th scope="col">반품날짜</th>
                    <th scope="col">교환날짜</th>
                    <th scope="col">수량</th>
                    <th scope="col">반품상태</th>
                    <th scope="col">검수상태</th>
                    <th scope="col">품목</th>
                    <th scope="col">반품 정보</th>
                    <th scope="col">수정 & 삭제</th>
                    <th scope="col">품질관리등록</th>
                </tr>
		        
		        </thead>
		        <tbody>
		            <c:forEach items="${returnList}" var="returnVO">
		            <c:if test="${returnVO.reprocessmethod eq '완료'}">
		                <tr>
		                   <td><input type="checkbox" name="selectedEmpId" value="${returnVO.returncode}" class="form-check-input"></td>
		                   <td>${returnVO.returnid}</td>
                           <td>${returnVO.returncode}</td>
                           <td>${returnVO.returnname }</td>
                           <td><fmt:formatDate value="${returnVO.returndate }" pattern="yyyy-MM-dd" /></td>
                           <td>${returnVO.exchangedate}</td>                          
                           <td>${returnVO.returnquantity}</td>
                           <td>${returnVO.returnstatus}</td>
                           <td>${returnVO.reprocessmethod}</td>
                           <td>${returnVO.returntype}</td>
                           <td>${returnVO.returninfo}</td>
                           <td>
									<!-- 버튼 수정 -->
									<button type="button" class="btn btn-outline-dark" 
									        onclick="openModifyModal('${returnVO.returntype}', '${returnVO.returnReason }', '${returnVO.returnname }', '${returnVO.returnquantity}', '${returnVO.returndate}', '${returnVO.exchangedate}','${returnVO.returnid}')">
									        수정 
									</button>
									<!-- 버튼 삭제 -->
									<button type="button" class="btn btn-outline-dark"
											onclick="deleteReturn('${returnVO.returnid}')">
											삭제
									</button>
							</td>
							<td>
									<button type="button" class="btn btn-outline-dark" 
											onclick="addReturn('${returnVO.returnid}')">
											등록
									</button>
							</td>
		                </tr>
		 			</c:if>
		            </c:forEach>
		        </tbody>
		    </table>
		</div>
    </div>
   </div>
   </div> 
	<!-- 반품조회 테이블 끝-->
	





<script>

	document.addEventListener("DOMContentLoaded", function () {
	    // 페이지 로딩 후에 실행될 코드
	    showTab('all');
	});
	    function showTab(tabName) {
	        var tabs = document.getElementsByClassName('tab-content');
	        for (var i = 0; i < tabs.length; i++) {
	            tabs[i].classList.remove('active');
	        }
	        document.getElementById(tabName + 'Tab').classList.add('active');
	    }
    
    
    
    // 반품 등록 모달
    var returnAuditModal = document.getElementById('returnAuditModal')
	returnAuditModal.addEventListener('show.bs.modal', function (event) {
  		var button = event.relatedTarget
  		var recipient = button.getAttribute('data-bs-whatever')
  		var modalTitle = exampleModalLabel.querySelector('.modal-title')
 	 	var modalBodyInput = returnAuditModal.querySelector('.modal-body input')
	})
	
	// 수정 버튼 클릭시 서버 정보 가져오기
	function openModifyModal(returntype, returnReason, returnname, returnquantity, returndate, exchangedate,returnid) {
    console.log('Rturn id:', returnid);
    console.log('Return Type:', returntype);
    console.log('Return Reason:', returnReason);
    console.log('Item Name:', returnname);
    console.log('Return Quantity:', returnquantity);
    console.log('Return Date:', returndate);
    console.log('Exchange Date:', exchangedate);

    // 가져온 값들을 모달에 설정
    $("#returnTypeSelect2").val(returntype);
    $("#returnReasonSelect2").val(returnReason);
    $("#floatingSelect2").val(returnname);
    $("#returnquantity2").val(returnquantity);
    $("#returndate2").val(returndate);
    $("#exchangedate2").val(exchangedate);
    $("#returnid").val(returnid);
	
    // 모달 열기
    $("#ModifyModal").modal('show');

}
	
    // 달력 이전날짜 비활성화
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];   
    
	
	// JavaScript를 사용하여 Date 객체로 변환
    var serverDate = new Date(serverDateString);
    
</script>

<!-- 반품 등록 이벤트 처리 -->
<script>
	document.getElementById('returnTypeSelect').addEventListener('change', function () {
		
		var selectedValue = this.value;
		var itemSelect = document.getElementById('floatingSelect');
		
		// 선택된 값이 '원자재'인 경우에만 처리
		if (selectedValue === '원자재') {
			// 원자재에 대한 처리
			itemSelect.innerHTML = ''; // 기존 옵션 제거
			
			// itemList에서 원자재에 해당하는 옵션 추가
			<c:forEach var="itList" items="${itList}" begin="0" step="1">
				<c:if test="${itList.itemtype eq '원자재'}">
					var option = document.createElement('option');
					option.value = "${itList.itemname}";
					option.text = "${itList.itemname}";
					itemSelect.add(option);
				</c:if>
			</c:forEach>
		}
		else if(selectedValue === '부자재'){
			itemSelect.innerHTML = ''; // 기존 옵션 제거
			
			// itemList에서 부자재에 해당하는 옵션 추가
			<c:forEach var="itList" items="${itList}" begin="0" step="1">
				<c:if test="${itList.itemtype eq '부자재'}">
					var option = document.createElement('option');
					option.value = "${itList.itemname}";
					option.text = "${itList.itemname}";
					itemSelect.add(option);
				</c:if>
			</c:forEach>
		}
		else if(selectedValue === '완제품'){
			itemSelect.innerHTML = ''; // 기존 옵션 제거
			
			// itemList에서 완제품에 해당하는 옵션 추가
			<c:forEach var="itList" items="${itList}" begin="0" step="1">
				<c:if test="${itList.itemtype eq '완제품'}">
					var option = document.createElement('option');
					option.value = "${itList.itemname}";
					option.text = "${itList.itemname}";
					itemSelect.add(option);
				</c:if>
			</c:forEach>
		}
		
	});
</script>

<!--  수정 등록 이벤트 처리 -->
<script>
	document.getElementById('returnTypeSelect2').addEventListener('change', function () {
		
		var selectedValue = this.value;
		var itemSelect = document.getElementById('floatingSelect2');
		
		// 선택된 값이 '원자재'인 경우에만 처리
		if (selectedValue === '원자재') {
			// 원자재에 대한 처리
			itemSelect.innerHTML = ''; // 기존 옵션 제거
			
			// itemList에서 원자재에 해당하는 옵션 추가
			<c:forEach var="itList" items="${itList}" begin="0" step="1">
				<c:if test="${itList.itemtype eq '원자재'}">
					var option = document.createElement('option');
					option.value = "${itList.itemname}";
					option.text = "${itList.itemname}";
					itemSelect.add(option);
				</c:if>
			</c:forEach>
		}
		else if(selectedValue === '부자재'){
			itemSelect.innerHTML = ''; // 기존 옵션 제거
			
			// itemList에서 부자재에 해당하는 옵션 추가
			<c:forEach var="itList" items="${itList}" begin="0" step="1">
				<c:if test="${itList.itemtype eq '부자재'}">
					var option = document.createElement('option');
					option.value = "${itList.itemname}";
					option.text = "${itList.itemname}";
					itemSelect.add(option);
				</c:if>
			</c:forEach>
		}
		else if(selectedValue === '완제품'){
			itemSelect.innerHTML = ''; // 기존 옵션 제거
			
			// itemList에서 완제품에 해당하는 옵션 추가
			<c:forEach var="itList" items="${itList}" begin="0" step="1">
			<c:if test="${itList.itemtype eq '완제품'}">
				var option = document.createElement('option');
				option.value = "${itList.itemname}";
				option.text = "${itList.itemname}";
				itemSelect.add(option);
			</c:if>
		</c:forEach>
		}
		
	});
</script>


<script>
// 반품 삭제 버튼
function deleteReturn(returnid) {
	 console.log("returnid in deleteReturn function:", returnid);
    // 새로운 form 엘리먼트를 생성합니다.
    var form = document.createElement('form');
    form.action = '/quality/returnDelete'; // 컨트롤러의 URL을 설정합니다.
    form.method = 'post'; // 전송 방식을 설정합니다. 필요에 따라 'get' 또는 'post'를 사용할 수 있습니다.

    // input 엘리먼트를 생성하고 값을 설정합니다.
    var input = document.createElement('input');
    input.type = 'hidden'; // 숨겨진 필드로 설정합니다.
    input.name = 'returnid'; // 컨트롤러에서 사용할 매개변수 이름을 설정합니다.
    input.value = returnid; // 전송할 값인 returnId를 설정합니다.

    // form에 input을 추가합니다.
    form.appendChild(input);

    // body에 form을 추가하고 submit 합니다.
    document.body.appendChild(form);
    form.submit();
}	

// 품질 관리 등록 버튼
function addReturn(returnid) {
	 console.log("returnid in addReturn function:", returnid);
   // 새로운 form 엘리먼트를 생성합니다.
   var form = document.createElement('form');
   form.action = '/quality/addReturn'; // 컨트롤러의 URL을 설정합니다.
   form.method = 'post'; // 전송 방식을 설정합니다. 필요에 따라 'get' 또는 'post'를 사용할 수 있습니다.

   // input 엘리먼트를 생성하고 값을 설정합니다.
   var input = document.createElement('input');
   input.type = 'hidden'; // 숨겨진 필드로 설정합니다.
   input.name = 'returnid'; // 컨트롤러에서 사용할 매개변수 이름을 설정합니다.
   input.value = returnid; // 전송할 값인 returnId를 설정합니다.

   // form에 input을 추가합니다.
   form.appendChild(input);

   // body에 form을 추가하고 submit 합니다.
   document.body.appendChild(form);
   form.submit();
}	
</script>
</body>
</html>
<%@ include file="../include/footer.jsp" %>