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

<!-- 로그인 여부(세션정보)에 따라서 페이지 이동 -->
<c:if test="${empty membercode}">
    <c:redirect url="/main/login" />
</c:if> 

<%
  // 세션에서 membercode 가져오기
  Object memberCodeObject = session.getAttribute("membercode");
  int memberCodeFromSession = (memberCodeObject != null) ? (int) memberCodeObject : 0;
%>

     <!-- 검색창 -->
   		<div class="col-12" style="margin-top:20px;">
		<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
        <form action="" method="get">
	<div class="d-flex align-items-center">
            <div class="form-group" style="width: 200px; margin-right: 20px;">
                <input type="text" class="form-control" id="returncode" name="returncode" value="${returnVO.returncode }" placeholder="반품 코드">
            </div>
            
            <div class="form-group" style="width: 200px; margin-right: 20px;">
                <select name="returntype" class="form-control" id="returntype">
                	<option ${returnVO.returntype eq "전체" ? "selected" : "" }>품목-전체</option>
                	<option ${returnVO.returntype eq "원자재" ? "selected" : "" }>원자재</option>
                	<option ${returnVO.returntype eq "부자재" ? "selected" : "" }>부자재</option>
                	<option ${returnVO.returntype eq "완제품" ? "selected" : "" }>완제품</option>
                </select>
            </div>
            
            <div class="form-group" style="width: 200px; margin-right: 20px;">
                <select name="returnstatus" class="form-control" id="returnstatus">
                	<option ${returnVO.returnstatus eq "전체" ? "selected" : "" }>반품상태-전체</option>
                	<option ${returnVO.returnstatus eq "대기" ? "selected" : "" }>대기</option>
                	<option ${returnVO.returnstatus eq "완료" ? "selected" : "" }>완료</option>
                </select>
            </div>
            
	
            <div class="form-group " style="width: 400px;">
                <div class="input-group" style="width: 400px">
                    <input type="date" class="form-control" id="startDate" name="startDate" value="${returnVO.startDate}">
                <div >
                &nbsp;~&nbsp;
                </div>
                    <input type="date" class="form-control" id="endDate" name="endDate" value="${returnVO.endDate}">
                </div>
            </div>
           <div >
            <button type="submit" class="btn btn-dark btn-sm m-2">조회</button>
           </div>
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
								<option value="포장불량">포장불량</option>
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
					<div class="row">
						<div class="col">
							<b>반납날짜</b><input type="date" id="returndate" name="returndate" class="form-control" id="returnDateInput" readonly>
						</div><br>
						<div class="col">
							<b>담당자 사번</b><input type="number" name="membercode" id="membercode" value="<%= memberCodeFromSession %>" readonly>
						</div>
				</div>
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
							aria-label="Floating label select example" disabled>
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
							aria-label="Floating label select example" disabled>
							<optgroup label="반품사유">
								<option value="제품불량">제품불량</option>
								<option value="포장불량">포장불량</option>
							</optgroup>
						</select>
					</div>	
				</div>
					<div class="row">
						<div class="col">
							<label for="returnname" class="col-form-label">제품명</label> 
							
								<select class="form-select" id="floatingSelect2" name="returnname" disabled>
									<c:forEach var="rList" items="${returnList }" begin="0" step="1">
											<option value="${rList.returnname }">${rList.returnname}</option>
									</c:forEach>
								</select>
						</div>
					</div><br>
					<div class="row">
						<div class="col">
							<b>수량</b><input id="returnquantity2" name="returnquantity" class="form-control" id="floatingInput" value="">
						</div>
						<div class="col">
							<b>반납날짜</b><input type="date" id="returndate2" name="returndate" class="form-control" id="floatingInput" value="" disabled>
						</div>
					</div><br>
					<div class="row">
						<div class="col">
							<b>환불날짜</b><input type="date" id="refunddate2" name="refunddate" class="form-control" id="floatingInput" value="">
						</div>
						<div class="col">
							<b>담당자 사번</b><input type="number" name="membercode" id="membercode" value="<%= memberCodeFromSession %>" readonly>
						</div>
					</div><br>		
				</div>
					
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary" >저장</button>
				</div>
				</form>
			</div>
		</div>
	</div> 
	<!-- 수정 등록 모달창 끝 -->	
	
        
	
	<!-- 반품조회 테이블 -->
	
		<div class="col-12" style="margin-top:20px;">
		<div class="bg-light rounded h-100 p-4">
		<h6  class="mb-4">반품 목록</h6>
		
		<div class="d-flex justify-content-between">
		<div>
		<h6>총 ${vo.totalCount}건</h6>
		</div>
		
		<div class="d-flex align-items-center">
		<form action="returnListExcelDownload" method="get" id="excelDownloadForm" style="display: none;">
                <input type="submit" value="엑셀 파일 다운로드" class="btn btn-sm btn-success" >
        </form>
        <button type="button" class="btn btn-sm btn-success" onclick="submitExcelDownloadForm()"> 엑셀 파일 다운로드 </button>
        <c:if test="${departmentname eq '품질' and memberposition eq '팀장' or membername eq 'admin'}">
		<button type="button" class="btn btn-primary btn-sm m-2" data-bs-toggle="modal" data-bs-target="#returnAuditModal" data-bs-whatever="@getbootstrap">반품 등록</button>
		<button id="hiddenRefundButton" class="btn btn-danger btn-sm m-2" onclick="submitRefundForm()"> 환불 </button>
		</c:if>
		</div>
		
		</div>
		
        <div class="table-responsive">
		<form action="/quality/refund" method="POST" id="refundForm">
		<button type="submit" class="btn btn-dark btn-sm m-2" style="display: none;"> 환불 </button>
            <table class="table">
                <thead>
                    <tr>
                    	<th scope="col">선택</th>
                        <th scope="col">반품ID</th>
                        <th scope="col">반품코드</th>
                        <th scope="col">담당자 사번</th>                        
                        <th scope="col">제품명</th>
                        <th scope="col">품목</th>
                        <th scope="col">반품날짜</th>
                        <th scope="col">환불날짜</th>
                        <th scope="col">수량</th>
                        <th scope="col">반품상태</th>
                        <th scope="col">검수상태</th>
                        <th scope="col">반품 처리</th>
                        <c:if test="${departmentname eq '품질' and memberposition eq '팀장' or membername eq 'admin'}">
                        <th scope="col">수정 & 삭제</th>
                        <th scope="col">품질관리등록</th>
                        </c:if>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${returnList}" var="returnVO">
                        <tr>
                        	<c:choose>
	                        	<c:when test="${fn:startsWith(returnVO.returncode, 'PRO') and empty returnVO.refunddate}">
	                        		<td><input type="checkbox" name="selectedReturnId" value="${returnVO.returncode}" class="form-check-input"></td>
	                        	</c:when>
	                        	<c:otherwise>
	                        		<td><input type="checkbox" class="form-check-input" disabled></td>
	                        	</c:otherwise>
                        	</c:choose>
                            <td>${returnVO.returnid}</td>
                            <td>${returnVO.returncode}</td>
                            <td>${returnVO.membercode}</td>
                            <td>${returnVO.returnname}</td>
                            <td>${returnVO.returntype}</td>
                            <td><fmt:formatDate value="${returnVO.returndate }" pattern="yyyy-MM-dd" /></td>
                            <td>${returnVO.refunddate}</td>                          
                            <td>${returnVO.returnquantity}</td>
                            <td>${returnVO.returnstatus}</td>
                            <td>${returnVO.reprocessmethod}</td>
                            <td>${returnVO.returninfo}</td>
                            <c:if test="${departmentname eq '품질' and memberposition eq '팀장' or membername eq 'admin'}">
                            <td>
										<!-- 버튼 수정 -->
										<button type="button" class="btn btn-success btn-sm" 
										        onclick="openModifyModal('${returnVO.returntype}', '${returnVO.returnReason }', '${returnVO.returnname }', '${returnVO.returnquantity}', '${returnVO.returndate}', '${returnVO.refunddate}','${returnVO.returnid}')">
										        수정 
										</button>
										<!-- 버튼 삭제 -->
										<button type="button" class="btn btn-danger btn-sm"
												onclick="deleteReturn('${returnVO.returnid}')">
												삭제
										</button>
							</td>
							<td>
							<button type="button" class="btn btn-primary btn-sm" 
									onclick="addReturn('${returnVO.returnid}')">
									등록
							</button>
							</td>
							</c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
         </form>
            
             <!-- 페이지 블럭 생성 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
   
		
		<!-- 이전버튼 -->
		<c:if test="${vo.prev }">
			<li class="page-item">
			
			<c:choose>
				<c:when test="${not empty rvo.returncode  || not empty rvo.returntype || not empty rvo.returnstatus || not empty rvo.startDate || not empty rvo.endDate }">
				<a class="page-link"
				href="/quality/returns?page=${vo.startPage-1 }&returncode=${rvo.returncode}&returnstatus=${rvo.returnstatus}&returntype=${rvo.returntype}&startDate=${rvo.startDate}&endDate=${rvo.endDate}" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>
				</c:when>
				
				<c:otherwise>
				<a class="page-link"
				href="/quality/returns?page=${vo.startPage-1 }" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
				</a>
				</c:otherwise>
			</c:choose>
				
			</li>
		</c:if>
		<!-- 이전버튼 -->
			
		<!-- 버튼 -->
		<c:forEach begin="${vo.startPage }" end="${vo.endPage }" step="1" var="idx">
		<li class="<c:out value='${vo.cri.page == idx ? "page-item active" : "page-item"}' />">
			
			<c:choose>
				<c:when test="${not empty rvo.returncode  || not empty rvo.returntype || not empty rvo.returnstatus || not empty rvo.startDate || not empty rvo.endDate }">
				<a class="page-link"
				href="/quality/returns?page=${idx}&returncode=${rvo.returncode}&returntype=${rvo.returntype}&returnstatus=${rvo.returnstatus}&startDate=${rvo.startDate}&endDate=${rvo.endDate}">${idx }</a>
				</c:when>
				
				<c:otherwise>
				<a class="page-link"
				href="/quality/returns?page=${idx}">${idx }</a>
				</c:otherwise>
			</c:choose>
				
		</li>
		</c:forEach>
		<!-- 버튼 -->
			
		<!-- 다음버튼 -->
		<c:if test="${vo.next && vo.endPage > 0}">
		<li class="page-item">
			
			<c:choose>
				<c:when test="${not empty rvo.returncode  || not empty rvo.returntype || not empty rvo.returnstatus || not empty rvo.startDate || not empty rvo.endDate }">
				<a class="page-link"
				href="/quality/returns?page=${vo.endPage+1}&returncode=${rvo.returncode}&returntype=${rvo.returntype}&returnstatus=${rvo.returnstatus}&startDate=${rvo.startDate}&endDate=${rvo.endDate}" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
				</a>
				</c:when>
				
				<c:otherwise>
				<a class="page-link"
				href="/quality/returns?page=${vo.endPage+1}" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
				</a>
				</c:otherwise>
			</c:choose>
			
		</li>
		</c:if>
		<!-- 다음버튼 -->
			
		</ul>
	</nav>
	<!-- 페이징 버튼 -->
            
   </div>
   </div>
   </div>
	<!-- 반품조회 테이블 끝-->
	





<script>

    // 반품 등록 모달
    var returnAuditModal = document.getElementById('returnAuditModal')
	returnAuditModal.addEventListener('show.bs.modal', function (event) {
  		var button = event.relatedTarget
  		var recipient = button.getAttribute('data-bs-whatever')
  		var modalTitle = exampleModalLabel.querySelector('.modal-title')
 	 	var modalBodyInput = returnAuditModal.querySelector('.modal-body input')
	})
	
	// 수정 버튼 클릭시 서버 정보 가져오기
	function openModifyModal(returntype, returnReason, returnname, returnquantity, returndate, refunddate,returnid) {
    console.log('Rturn id:', returnid);
    console.log('Return Type:', returntype);
    console.log('Return Reason:', returnReason);
    console.log('Item Name:', returnname);
    console.log('Return Quantity:', returnquantity);
    console.log('Return Date:', returndate);
    console.log('Refund Date:', refunddate);

    // 가져온 값들을 모달에 설정
    $("#returnTypeSelect2").val(returntype);
    $("#returnReasonSelect2").val(returnReason);
    $("#floatingSelect2").val(returnname);
    $("#returnquantity2").val(returnquantity);
    $("#returndate2").val(returndate);
    $("#refunddate2").val(refunddate);
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

// 폼안에 환불버튼을 숨기고 바깥 환불버튼 기능하게 만들어줌
function submitRefundForm() {
    // 히든 폼의 submit을 트리거
    document.getElementById('refundForm').submit();
}

// 폼안에 엑셀다운버튼을 숨기고 바깥 엑셀다운버튼 기능하게 만들어줌
function submitExcelDownloadForm() {
    document.getElementById('excelDownloadForm').submit();
}

</script>
</body>
</html>
<%@ include file="../include/footer.jsp" %>