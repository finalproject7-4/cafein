<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>


<h1>수주관리</h1>
<fieldset>
	<div class="col-12">
	<div class="bg-light rounded h-100 p-4">
<form name="dateSearch" action="/sales/POList" method="get" onsubmit="return filterRows(event)">
    납품처조회 <input class="clientSearch" type="text" name="clientname" placeholder="납품처명을 입력하세요"><br>
    수주일자 <input type="date" id="startDate" name="ordersdate"> ~ <input type="date" id="endDate" name="ordersdate">
    <button type="submit" class="datesubmitbtn btn btn-dark m-2">조회</button>
    <br>
</form>

</div>
</div><br>

<!-- 수정된 스크립트 -->
<!-- 수정된 스크립트 -->
<script>
// 사용자가 입력한 조건으로 테이블 행 필터링 및 업데이트를 수행하는 함수
function filterRows(event) {
    // 기본 폼 제출 동작 방지
    event.preventDefault();

    // 입력된 키워드 가져오기
    var keyword = $('.clientSearch').val().toLowerCase();

    // 시작일자와 종료일자 가져오기
    var startDate = $('#startDate').val() ? new Date($('#startDate').val()) : null;
    var endDate = $('#endDate').val() ? new Date($('#endDate').val()) : null;

    // 테이블의 모든 행 가져오기
    var rows = $('.table tbody tr');

    // 각 행에 대해 키워드 및 날짜 포함 여부 확인
    rows.each(function () {
        var clientName = $(this).find('td:nth-child(4)').text().toLowerCase();
        var orderDateStr = $(this).find('td:nth-child(7)').text(); // 7번째 열은 수주일자
        var orderDate = orderDateStr ? new Date(orderDateStr) : null;

        var keywordMatch = keyword === '' || clientName.includes(keyword);
        var dateMatch = (startDate === null || (orderDate !== null && orderDate >= startDate && orderDate <= endDate));

        if (keywordMatch && dateMatch) {
            $(this).show(); // 키워드 및 날짜가 포함된 경우 행을 표시
        } else {
            $(this).hide(); // 키워드 또는 날짜가 포함되지 않은 경우 행을 숨김
        }

        // 콘솔에 출력 (디버깅용)
        console.log('Client Name:', clientName, 'Order Date:', orderDate, 'Keyword Match:', keywordMatch, 'Date Match:', dateMatch);
    });

    // 번호 업데이트
    updateRowNumbers();

    // 폼이 실제로 제출되지 않도록 false 반환
    return false;
}

// 테이블에 표시되는 행의 번호를 업데이트하는 함수
function updateRowNumbers() {
    // 표시된 행만 선택하여 번호 업데이트
    var visibleRows = $('.table tbody tr:visible');
    visibleRows.each(function (index) {
        // 첫 번째 자식 요소인 td 엘리먼트를 찾아 번호를 업데이트
        $(this).find('td:first').text(index + 1);
    });
}
</script>














		<!-- 수주 상태에 따라 필터링하는 버튼 -->
		<div class="col-12">
			<div class="btn-group" role="group">
				<input type="hidden" name="state" value="전체">
				<button type="button" class="btn btn-outline-dark"
					id="allpo">전체</button>
				<input type="hidden" name="state" value="대기">
				<button type="button" class="btn btn-outline-dark"
					id="stop">대기</button>
				<input type="hidden" name="state" value="진행">
				<button type="button" class="btn btn-outline-dark" id="ing">진행</button>
				<input type="hidden" name="state" value="완료">
				<button type="button" class="btn btn-outline-dark"
					id="complete">완료</button>
				<input type="hidden" name="state" value="취소">
				<button type="button" class="btn btn-outline-dark"
					id="cancel">취소</button>
		</div>

			<!-- 수주 리스트 테이블 조회 -->
			<div class="bg-light rounded h-100 p-4" id="ListID">
			<span class="mb-4">총 ${fn:length(POList)}건</span>
			<input type="hidden" name="poid" class="poidDel">
			
			<input type="button" class="btn btn-dark m-2" data-bs-toggle="modal" data-bs-target="#registModal" id="regist" value="등록">		
			<input type="hidden" class="btn btn-dark m-2" data-bs-toggle="modal" data-bs-target="#modifyModal" data-bs-whatever="@getbootstrap" value="수정">
				
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">수주상태</th>
								<th scope="col">수주코드</th>
								<th scope="col">납품처</th>
								<th scope="col">품명</th>
								<th scope="col">수량</th>
								<th scope="col">수주일자</th>
								<th scope="col">수정일자</th>
								<th scope="col">완납예정일</th>
								<th scope="col">담당자</th>
								<th scope="col">관리</th>
								<th scope="col">납품서발행</th>
							</tr>
						</thead>
					<tbody>
						<c:set var="counter" value="1" />
						<c:choose>
							<c:when test="${empty POList}">
								<p>No data available.</p>
							</c:when>
							<c:otherwise>
							<c:set var="counter" value="1" />
								<c:forEach items="${POList}" var="po" varStatus="status">
									<tr>
										<td>${counter }</td>
										<td>${po.postate }</td>
										<td>${po.pocode }</td>
										<td>${po.clientname}</td>
										<td>${po.itemname}</td>
										<td>${po.pocnt}</td>
										<c:choose>
											<c:when test="${empty po.ordersdate}">
												<td>수정일자 참조</td>
											</c:when>
											<c:otherwise>
												<td><fmt:formatDate value="${po.ordersdate}"
														dateStyle="short" pattern="yyyy-MM-dd" /></td>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${empty po.updatedate}">
												<td>업데이트 날짜 없음</td>
											</c:when>
											<c:otherwise>
												<td><fmt:formatDate value="${po.updatedate}"
														dateStyle="short" pattern="yyyy-MM-dd" /></td>
											</c:otherwise>
										</c:choose>
										<td><fmt:formatDate value="${po.ordersduedate}"
												dateStyle="short" pattern="yyyy-MM-dd" /></td>
										<td>${po.membercode}</td>
										<td>
											<!-- 버튼 수정 -->
											<button type="button" class="btn btn-outline-dark" 
									        onclick="openModifyModal('${po.poid}','${po.clientid}','${po.itemid}','${po.clientname}', '${po.itemname}', '${po.postate}', '${po.pocnt}', '${po.ordersdate}', '${po.ordersduedate}', '${po.membercode}')">
									        수정
											</button>
										</td>
										<td>
											<button type="button" class="btn btn-outline-dark" 
											        onclick="location.href='/sales/receipt';">
											        불러오기
											</button>
											</td>
									</tr>
									<c:set var="counter" value="${counter+1 }" />
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				</div>
		</div>
		</div>
		<!-- 품목 등록 모달 -->
		<jsp:include page="registPO.jsp"/>
		<!-- 품목 수정 모달 -->
		<jsp:include page="modifyPO.jsp"/>
		
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
								<c:forEach items="${cliList}" var="cli">
                                    <tr class="clientset">
                                    	<td>${cli.clientname }</td> 
                                    	<td>${cli.clientcode }</td>
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
								<c:forEach items="${iList}" var="item">
                                    <tr class="itemset">
                                    	<td>${item.itemname }</td> 
                                    	<td>${item.itemcode }</td>
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
   
   /* 리스트 값 수정 모달로 값 전달 */
   function openModifyModal(poid, clientid, itemid, clientname, itemname, postate, pocnt, ordersdate, ordersduedate, membercode) {
       console.log('poid:', poid); 
       console.log('clientid:', clientid); 
       console.log('itemid:', itemid); 
	   console.log('clientname:', clientname);
       console.log('itemname:', itemname);
       console.log('postate:', postate);
       console.log('pocnt:', pocnt);
       console.log('ordersdate:', ordersdate);
       console.log('ordersduedate:', ordersduedate);
       console.log('membercode:', membercode); 
	   
	   // 가져온 값들을 모달에 설정
	   $("#poid3").val(poid);
	   $("#clientid3").val(clientid);
	   $("#itemid3").val(itemid);
	    $("#clientid2").val(clientname);
	    $("#itemid2").val(itemname);
	    $("#floatingSelect2").val(postate);
	    $("#pocnt2").val(pocnt);
	    $("#todaypo2").val(ordersduedate);
	    $("#date2").val(ordersduedate);
	    $("#membercode2").val(membercode);

	    // 모달 열기
	    $("#openModifyModal").modal('show');
	    

	}
		   
   /*달력 이전날짜 비활성화*/
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
	
	var clientSM = document.getElementById('clientSM');
	clientSM.addEventListener('show.bs.modal', function (event) {
	  var button = event.relatedTarget;
	  var recipient = button.getAttribute('data-bs-whatever');
	  var modalTitle = clientSM.querySelector('.modal-title');
	  var modalBodyInput = clientSM.querySelector('.modal-body input');
	});

    /******************************************************************/
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
                    // 성공 시에 테이블을 생성하고 화면에 표시
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
                    
                    $("#result").html(tableHtml);
                },
                error: function(error) {
                    console.error("Error during search:", error);
                }
            });
        });
        
    
        $("#allpo").click(function() {
            // 모든 수주 항목 숨김
            $(".table tbody tr").show();
            // 번호 업데이트
            updateRowNumbers();
        });

        $("#stop").click(function() {
            // 모든 수주 항목 숨김
            $(".table tbody tr").hide();
            // 대기 상태인 수주만 보이도록 필터링
            $(".table tbody tr:has(td:nth-child(2):contains('대기'))").show();
            // 번호 업데이트
            updateRowNumbers();
        });

        $("#ing").click(function() {
            // 모든 수주 항목 숨김
            $(".table tbody tr").hide();
            // 대기 상태인 수주만 보이도록 필터링
            $(".table tbody tr:has(td:nth-child(2):contains('진행'))").show();
            // 번호 업데이트
            updateRowNumbers();
        });

        $("#complete").click(function() {
            // 모든 수주 항목 숨김
            $(".table tbody tr").hide();
            // 대기 상태인 수주만 보이도록 필터링
            $(".table tbody tr:has(td:nth-child(2):contains('완료'))").show();
            // 번호 업데이트
            updateRowNumbers();
        });

        $("#cancel").click(function() {
            // 모든 수주 항목 숨김
            $(".table tbody tr").hide();
            // 대기 상태인 수주만 보이도록 필터링
            $(".table tbody tr:has(td:nth-child(2):contains('취소'))").show();
            // 번호 업데이트
            updateRowNumbers();
        });

        // 함수를 정의하는 부분
        function updateRowNumbers() {
            var counter = 1;
            $(".table tbody tr:visible").each(function() {
                $(this).find('td:first').text(counter);
                counter++;
            });
        }



    });
</script>


<%@ include file="../include/footer.jsp"%>