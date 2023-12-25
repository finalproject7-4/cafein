<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>

${POList}
${result } <br>

<h1>수주관리</h1>
<fieldset>
	<legend>수주관리</legend>
	<form method="post">
		수주일자 <input type="date" class="date" name="podate"> ~ <input type="date" class="date" name="podate">&nbsp;&nbsp;&nbsp;&nbsp;
		납품처조회 <input class="clientSearch" type="text" name="client" placeholder="납품처코드"> 
				<input class="clientSearch" type="text" name="worknumber" placeholder="납품처명"> <br>
		납품예정일 <input type="date" class="date" name="ordersduedate"> ~ <input type="date" class="date" name="podate">
		품목조회&nbsp;&nbsp;&nbsp;&nbsp; <input class="itemSearch" type="text" name="itemname" placeholder="품목코드"> 
			<input class="itemSearch" type="text" name="worknumber" placeholder="품명"> 
		<button type="submit" class="btn btn-dark m-2">조회</button>
		<br>
	</form>
		<div class="col-12">
		
			<button type="button" class="btn btn-dark m-2">전체</button>
			<button type="button" class="btn btn-dark m-2">대기</button>
			<button type="button" class="btn btn-dark m-2">진행중</button>
		
			<!-- 수주 리스트 테이블 조회 -->
			<div class="bg-light rounded h-100 p-4">
				<span class="mb-4">총 ${fn:length(AllPOList)}건</span>
				<span id="buttonset1"><button type="button" class="btn btn-dark m-2" onclick="location.href='/sales/registPO';">신규 등록</button>
			<button type="button" class="btn btn-dark m-2">수정</button>
			<button type="button" class="btn btn-dark m-2">삭제</button></span>
				<div class="table-responsive">

					<table class="table">
						<thead>
							<tr>
								<th scope="col"><input type="checkbox"></th>
								<th scope="col">수주번호</th>
								<th scope="col">수주상태</th>
								<th scope="col">수주코드</th>
								<th scope="col">납품처</th>
								<th scope="col">품명</th>
								<th scope="col">수량</th>
								<th scope="col">수주일자</th>
								<th scope="col">수정일자</th>
								<th scope="col">완납예정일</th>
								<th scope="col">담당자</th>
							</tr>
						</thead>
						<!-- http://localhost:8088/sales/POList -->
						<tbody>
							<c:forEach items="${POList}" var="po">
								<tr>
									<td><input type="checkbox"></td>
									<td>${po.poid }</td>
									<td>${po.postate }</td>
									<td>${po.pocode }</td>
									<td>${po.clientname}</td>
									<td>${po.itemname}</td>
									<td>${po.pocnt}</td> 
									<td><fmt:formatDate value="${po.ordersdate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
									<c:choose>
										<c:when test="${empty po.updatedate}">
											<td>업데이트 날짜 없음</td>
										</c:when>
										<c:otherwise>
											<td><fmt:formatDate value="${po.updatedate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
										</c:otherwise>
									</c:choose>
									<td><fmt:formatDate value="${po.ordersduedate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
									<td>${po.membercode}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		<!-- 납품처 조회 모달 -->
        <div class="modal fade" id="clientSM" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLabel">납품처 조회 </h5>
                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                  
                  납품처명 <input type="search" class="clientNS" ><br>
                  납품처코드 <input type="search" class="clientCS">
                <button type="submit" class="btn btn-dark m-2">조회</button><br>
					<br>
                     <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                              <table class="table">
                                 <thead>
                                    <tr>
                                       <th scope="col">납품처명</th>
                                       <th scope="col">납품처코드</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                 <c:forEach items="${POList}" var="po">
                                    <tr class="clientset">
                                    	<td>${po.clientname }</td> 
                                    	<td>${po.clientcode }</td>
                                    </tr>
                                    </c:forEach>
                                    </tbody>
                                    </table>
                           </div>
                           <div class="modal-footer">
                           </div>
                        </div>
                     </div>
                  </div>
			  </div>
		  </div>
		  
		<!-- 품목 조회 모달 -->
        <div class="modal fade" id="itemSM" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLabel">품목 조회 </h5>
                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                  
                  품명 <input type="search" class="clientNS" ><br>
                  품목코드 <input type="search" class="clientCS">
                  <button type="submit" class="btn btn-dark m-2">조회</button><br>
					<br>	
                     <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                              <table class="table">
                                 <thead>
                                    <tr>
                                       <th scope="col">품명</th>
                                       <th scope="col">품목코드</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                 <c:forEach items="${POList}" var="po">
                                    <tr class="clientset">
                                    	<td>${po.clientname }</td> 
                                    	<td>${po.clientcode }</td>
                                    </tr>
                                    </c:forEach>
                                    </tbody>
                                    </table>
                           </div>
                           <div class="modal-footer">
                           </div>
                        </div>
                     </div>
                  </div>
			  </div>
		  </div>
		</fieldset>
  <!-- 모달 js&jq -->
   <script>
   /*달력 이전날짜 비활성화*/
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
	
	// class="date"인 모든 요소에 날짜 비활성화
	document.querySelectorAll('.date').forEach(function(input) {
	  input.setAttribute('min', today);
	});
   
    var exampleModal = document.getElementById('exampleModal')
    exampleModal.addEventListener('show.bs.modal', function (event) {
      var button = event.relatedTarget
      var recipient = button.getAttribute('data-bs-whatever')
      var modalTitle = exampleModal.querySelector('.modal-title')
      var modalBodyInput = exampleModal.querySelector('.modal-body input')
    })
    
    $(document).ready(function() {
	    
	 	// 납품처 조회 모달
	    $(".clientSearch").click(function() {
	        $("#clientSM").modal('show');
	   	});

	 	// 품목 조회 모달
	    $(".itemSearch").click(function() {
	        $("#itemSM").modal('show');
	   	});
	 
	 $('#todaypo').click(function(){
            var today = new Date();
            // 날짜를 YYYY-MM-DD 형식으로 포맷팅
            var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
            $('#todaypo').val(formattedDate);
        });
	 
    });
    </script>

<%@ include file="../include/footer.jsp"%>