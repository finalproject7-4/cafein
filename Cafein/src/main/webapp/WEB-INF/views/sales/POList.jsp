<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>

<h1>수주관리</h1>
<fieldset>
	<legend>수주관리</legend>
	<form method="post">
		수주일자 <input type="date" class="date" name="podate"> ~ <input type="date" class="date" name="podate">&nbsp;&nbsp;&nbsp;&nbsp;
		납품처조회 <input class="clientSearch1" type="text" name="client" placeholder="납품처코드"> 
				<input class="clientSearch2" type="text" name="worknumber" placeholder="납품처명"> <br>
		납품예정일 <input type="date" class="date" name="ordersduedate"> ~ <input type="date" class="date" name="podate">
		품목조회&nbsp;&nbsp;&nbsp;&nbsp; <input class="itemSearch1" type="text" name="itemname" placeholder="품목코드"> 
			<input class="itemSearch2" type="text" name="worknumber" placeholder="품명"> 
		<button id="searchbtn" type="button" class="btn btn-dark m-2">조회</button>
		<br>
	</form>
		<div class="col-12">
		
			<div class="btn-group" role="group">
			<form role="form1">
				<input type="hidden" name="state" value="전체">
				<button type="button" class="btn btn-outline-dark"
					id="allpo">전체</button>
			</form>
			<form role="form2">
				<input type="hidden" name="state" value="대기">
				<button type="button" class="btn btn-outline-dark"
					id="stop">대기</button>
			</form>
			<form role="form3">
				<input type="hidden" name="state" value="진행">
				<button type="button" class="btn btn-outline-dark" id="ingpro">진행</button>
			</form>
			<form role="form4">
				<input type="hidden" name="state" value="완료">
				<button type="button" class="btn btn-outline-dark"
					id="complete">완료</button>
			</form>
		</div>

			<!-- 수주 리스트 테이블 조회 -->
			<div class="bg-light rounded h-100 p-4">
				<span class="mb-4">총 ${fn:length(AllPOList)}건</span>
			<button type="button" class="btn btn-dark m-2" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">등록</button>			
			<button type="button" class="btn btn-dark m-2">수정</button>
			<button type="button" class="btn btn-dark m-2">삭제</button>
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
		<jsp:include page="registPO.jsp"/>
		
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
                <button id="clibtn" type="submit" class="btn btn-dark m-2">조회</button><br>
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
                  
                  품명 <input type="search" class="itemNS" ><br>
                  품목코드 <input type="search" class="itemCS">
                  <button id="itembtn" type="submit" class="btn btn-dark m-2">조회</button><br>
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
                                    <tr class="itemset">
                                    	<td>${po.itemname }</td> 
                                    	<td>${po.itemcode }</td>
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
   
	var clientSM = document.getElementById('clientSM');
	clientSM.addEventListener('show.bs.modal', function (event) {
	  var button = event.relatedTarget;
	  var recipient = button.getAttribute('data-bs-whatever');
	  var modalTitle = clientSM.querySelector('.modal-title');
	  var modalBodyInput = clientSM.querySelector('.modal-body input');
	});

    
    $(document).ready(function() {
    	
	 	// 납품처 조회 모달
	    $(".clientSearch1, .clientSearch2").click(function() {
		    $("#clientSM").modal('show');
		});


	 	// 품목 조회 모달
	    $(".itemSearch1, .itemSearch2").click(function() {
	        $("#itemSM").modal('show');
	   	});
	 	
	  // 클릭한 행의 정보를 가져와서 clientNS와 clientCS에 입력
      $(".clientset").click(function() {
         var clientName = $(this).find('td:eq(0)').text();
         var clientCode = $(this).find('td:eq(1)').text(); 

         $(".clientNS").val(clientName);
         $(".clientCS").val(clientCode);
      });
	  
      $(".itemset").click(function() {
         var itemName = $(this).find('td:eq(0)').text();
         var itemCode = $(this).find('td:eq(1)').text();

         $(".itemNS").val(itemName);
         $(".itemCS").val(itemCode);
      });
      
      $("#clibtn").click(function() {
    	    $(".clientSearch1").val($(".clientNS").val());
    	    $(".clientSearch2").val($(".clientCS").val());
    	    $("#clientSM").modal('hide');
    	});
      $("#itembtn").click(function() {
    	    $(".itemSearch1").val($(".itemNS").val());
    	    $(".itemSearch2").val($(".itemCS").val());
    	    $("#itemSM").modal('hide');
    	});
	 
	 $('#todaypo').click(function(){
            var today = new Date();
            // 날짜를 YYYY-MM-DD 형식으로 포맷팅
            var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
            $('#todaypo').val(formattedDate);
        });
    });
    </script>
    <script>
    $(document).ready(function() {
        $("#searchbtn").click(function() {
            // 수주일자
            var podateStart = $("input[name='podateStart']").val();
            var podateEnd = $("input[name='podateEnd']").val();
            
            // 납품처조회
            var clientCode = $(".clientSearch1").val();
            var clientName = $(".clientSearch2").val();
            
            // 납품예정일
            var ordersDueDateStart = $("input[name='ordersDueDateStart']").val();
            var ordersDueDateEnd = $("input[name='ordersDueDateEnd']").val();
            
            // 품목조회
            var itemCode = $(".itemSearch1").val();
            var itemName = $(".itemSearch2").val();
            
            // Ajax를 사용해 서버로 데이터 전송 및 조회
            $.ajax({
                type: "GET",
                url: "/sales/POList",
                data: {
                    podateStart: podateStart,
                    podateEnd: podateEnd,
                    clientCode: clientCode,
                    clientName: clientName,
                    ordersDueDateStart: ordersDueDateStart,
                    ordersDueDateEnd: ordersDueDateEnd,
                    itemCode: itemCode,
                    itemName: itemName
                },
                success: function(POList) {
                    // 성공 시에 테이블을 생성하고 화면에 표시하는 로직 추가
                    var tableHtml = '<table>';
                    for (var i = 0; i < POList.length; i++) {
                        tableHtml += '<tr>';
                        tableHtml += '<td>' + POList[i].poid + '</td>';
                        tableHtml += '<td>' + POList[i].postate + '</td>';
                        tableHtml += '<td>' + POList[i].pocode + '</td>';
                        tableHtml += '<td>' + POList[i].clientname + '</td>';
                        tableHtml += '<td>' + POList[i].itemname + '</td>';
                        tableHtml += '<td>' + POList[i].pocnt + '</td>';
                        tableHtml += '<td>' + POList[i].ordersdate + '</td>';
                        tableHtml += '<td>' + POList[i].updatedate + '</td>';
                        tableHtml += '<td>' + POList[i].ordersduedate + '</td>';
                        tableHtml += '<td>' + POList[i].membercode + '</td>';
                        tableHtml += '</tr>';
                    }
                    tableHtml += '</table>';
                    
                    // 결과를 어떤 엘리먼트에 넣을 것인지 지정 (예: <div id="result"></div>)
                    $("#result").html(tableHtml);
                },
                error: function(error) {
                    console.error("Error during search:", error);
                }
            });
        });
    });
    </script>

<%@ include file="../include/footer.jsp"%>