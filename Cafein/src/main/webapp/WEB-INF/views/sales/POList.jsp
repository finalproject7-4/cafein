<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>


<h1>수주관리</h1>
<fieldset>
	<legend>수주관리</legend>
	<form method="post">
		수주일자 <input type="date" name="podate"> ~ <input type="date" name="podate">&nbsp;&nbsp;&nbsp;&nbsp;
		납품처조회 <input class="clientSearch" type="text" name="client" placeholder="납품처코드"> 
				<input class="clientSearch" type="text" name="worknumber" placeholder="납품처명"> <br>
		납품예정일 <input type="date" name="ordersduedate"> ~ <input type="date" name="podate">
		품목조회&nbsp;&nbsp;&nbsp;&nbsp; <input class="itemSearch" type="text" name="itemname" placeholder="품목코드"> 
			<input class="itemSearch" type="text" name="worknumber" placeholder="품명"> 
		<button type="submit" class="btn btn-dark m-2">조회</button>
		<br>

		<div class="col-12">
		
			<button type="button" class="btn btn-dark m-2">전체</button>
			<button type="button" class="btn btn-dark m-2">대기</button>
			<button type="button" class="btn btn-dark m-2">진행중</button>
		
			<!-- 수주 리스트 테이블 조회 -->
			<div class="bg-light rounded h-100 p-4">
				<span class="mb-4">총 ${fn:length(AllPOList)}건</span>
				<span id="buttonset1"><button type="button" class="btn btn-dark m-2" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">신규 등록</button>
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
							<c:forEach items="${AllPOList}" var="spo">
								<tr>
									<td><input type="checkbox"></td>
									<td>${spo.poid }</td>
									<td>${spo.postate }</td>
									<td>${spo.pocode }</td>
									<td>${spo.clientname}</td>
									<td>${spo.itemname}</td>
									<td>${spo.pocnt}</td> 
									<td><fmt:formatDate value="${spo.ordersdate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
									<c:choose>
										<c:when test="${empty spo.updatedate}">
											<td>업데이트 날짜 없음</td>
										</c:when>
										<c:otherwise>
											<td><fmt:formatDate value="${spo.updatedate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
										</c:otherwise>
									</c:choose>
									<td><fmt:formatDate value="${spo.ordersduedate}" dateStyle="short" pattern="yyyy-MM-dd" /></td>
									<td>${spo.membercode}</td>
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
                                 <c:forEach items="${AllPOList}" var="spo">
                                    <tr class="clientset">
                                    	<td>${spo.clientname }</td> 
                                    	<td>${spo.clientcode }</td>
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
                                       <th scope="col">납품처명</th>
                                       <th scope="col">납품처코드</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                 <c:forEach items="${AllPOList}" var="spo">
                                    <tr class="clientset">
                                    	<td>${spo.clientname }</td> 
                                    	<td>${spo.clientcode }</td>
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
		
		<!-- 수주 등록 모달 -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">수주 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form>
							<div class="mb-3">
								<label for="recipient-name" class="col-form-label">수주상태</label> <select class="form-select" id="floatingSelect"
									aria-label="Floating label select example">
									<optgroup label="수주상태">
										<option value="1">대기</option>
										<option value="2">진행</option>
										<option value="3">완료</option>
										<option value="3">취소</option>
									</optgroup>
								</select>
							</div>
							<div class="mb-3">
								납품처<input id="client" class="form-control" id="floatingInput" placeholder="납품처">
							</div>
							<div class="mb-3">
								품명<input id="items" class="form-control" id="floatingInput" placeholder="품명">
							</div>
							<div class="mb-3">
								수량<input type="number" class="form-control" id="floatingInput" placeholder="숫자만 입력하세요">
							</div>
							<div class="mb-3">
								수주일자<input id="todaypo" type="text" class="form-control" id="floatingInput" placeholder="수주일자(클릭)">
							</div>
							<div class="mb-3">
								완납예정일<input type="date" class="form-control" id="floatingInput" placeholder="완납예정일">
							</div>
							<div class="mb-3">
								담당자<input class="form-control" id="floatingInput">
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="submit" class="btn btn-primary">저장</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 수주등록 - 납품처 모달 -->
        <div class="modal fade" id="clientModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLabel">납품처</h5>
                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                     <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                              <table class="table">
                                 <thead>
                                    <tr>
                                       <th scope="col">No.</th>
                                       <th scope="col">납품처명</th>
                                       <th scope="col">납품처코드</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                 <c:forEach items="${AllPOList}" var="spo">
                                    <tr class="clientset">
                                    	<td>${spo.poid }</td> 
                                    	<td>${spo.clientname }</td> 
                                    	<td>${spo.clientcode }</td>
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
		
		<!-- 수주등록 - 품목 모달 -->
        <div class="modal fade" id="itemModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLabel">품목</h5>
                     <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                     <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                              <table class="table">
                                 <thead>
                                    <tr>
                                       <th scope="col">No.</th>
                                       <th scope="col">품명</th>
                                       <th scope="col">품목코드</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                 <c:forEach items="${AllPOList}" var="spo">
                                    <tr class="itemset">
                                    	<td>${spo.poid }</td> 
                                    	<td>${spo.itemname }</td> 
                                    	<td>${spo.itemcode }</td> 
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
	</form>
</fieldset>

  <!-- 모달 js&jq -->
   <script>
    var exampleModal = document.getElementById('exampleModal')
    exampleModal.addEventListener('show.bs.modal', function (event) {
      var button = event.relatedTarget
      var recipient = button.getAttribute('data-bs-whatever')
      var modalTitle = exampleModal.querySelector('.modal-title')
      var modalBodyInput = exampleModal.querySelector('.modal-body input')
    })
    
    $(document).ready(function() {
    	// 납품처 모달
	    $("#client").click(function() {
	        $("#clientModal").modal('show');
	   	});
    	
	    $(".clientset").click(function() {
	        var columns = $(this).find('td');
	        var selectedClientName = $(columns[1]).text(); // 납품처명
	        var selectedClientCode = $(columns[2]).text(); // 납품처코드
	        $('#client').val(selectedClientName);
	        $('#clientModal').modal('hide');
	    });
	    
	 	// 납품처 조회 모달
	    $(".clientSearch").click(function() {
	        $("#clientSM").modal('show');
	   	});
	 
		// 품목 모달    	
	    $("#items").click(function() {
	        $("#itemModal").modal('show');
	   	});
	    
	    $(".itemset").click(function() {
	        var columns = $(this).find('td');
	        var selectedItemName = $(columns[1]).text(); // 품명
	        var selectedItemCode = $(columns[2]).text(); // 품목코드
            $('#items').val(selectedItemName);
	        $('#itemModal').modal('hide');
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