<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp" %>

<div class="col-12">
	<!-- 품목 조회 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<form name="search" action="itemSearchList" method="post">
		<select name="option">
			<option value="">선택</option>
			<option value="itemtype">품목유형</option>
			<option value="itemname">품명</option>
		</select>
			<input type="text" name="keyword">
			<input type="submit" class="btn btn-sm btn-dark m-2" value="조회">
		</form>
	</div>
	<!-- 품목 조회 -->

	<!-- 품목 목록 -->
	<div class="bg-light rounded h-100 p-4" style="margin-top: 20px;">
		<span class="mb-4">총 ${fn:length(itemList)} 건</span>
		<span style="margin-left: 91%;">
			<button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#itemRegistModal" data-bs-whatever="@getbootstrap">등록</button>
			<!-- <button type="button" class="btn btn-sm btn-dark m-1">수정</button> -->
			<!-- <button type="button" class="btn btn-sm btn-dark m-1">삭제</button> -->
		</span>
		
		<div class="table-responsive">
			<table class="table" style="margin-top: 10px;">
				<thead>
					<tr style="text-align: center;">
						<th scope="col">번호</th>
						<th scope="col">품목코드</th>
						<th scope="col">품목유형</th>
						<th scope="col">품명</th>
						<th scope="col">거래처명</th>
						<th scope="col">원산지</th>
						<th scope="col">중량(g)</th>
						<th scope="col">단가(원)</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="itemList" items="${itemList }">
						<tr style="text-align: center;">
							<td>${itemList.itemid }</td>
							<td>${itemList.itemcode }</td>
							<td>${itemList.itemtype }</td>
							<td>${itemList.itemname }</td>
							<td>${itemList.clientname }</td>
							<td>${itemList.origin }</td>
							<td>${itemList.itemweight }</td>
							<td>${itemList.itemprice }</td>
							<td>
								<button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#itemModifyModal" data-bs-whatever="@getbootstrap" onclick="modifyModal('${itemList}')">수정</button>
								<button type="button" class="btn btn-sm btn-dark m-1">삭제</button>
							</td>
						</tr>
					</c:forEach>	
				</tbody>
			</table>
		</div>
	</div>
	<!-- 품목 목록 -->		
		
	<!-- 품목 등록 모달 -->
	<jsp:include page="itemRegist.jsp"/>
	
	<!-- 품목 수정 모달 -->
	<jsp:include page="itemModify.jsp"/>
		
	<!-- 공급처 모달 -->
    <div class="modal fade" id="clientModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">공급처</h5>
                	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <div class="modal-body">
                	<div class="col-12">
                    	<div class="bg-light rounded h-100 p-4">
                        	<table class="table">
                            	<thead>
                                	<tr>
                                       <th scope="col">번호</th>
                                       <th scope="col">공급처명</th>
                                       <th scope="col">공급처코드</th>
                                    </tr>
                                 </thead>
                                 <tbody>
                                 <c:set var="counter" value="1" />                                 
                                 <c:forEach var="clientList" items="${clientList }" varStatus="status">
                                  <c:if test="${clientList.categoryofclient eq '공급'}">
                                    <tr class="clientset">
                                    	<td>${counter }</td> 
                                    	<td>${clientList.clientname }</td> 
                                    	<td>${clientList.clientcode }</td>
                                    </tr>
                                   <c:set var="counter" value="${counter + 1}" />
                                  </c:if>                                    
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
    <!-- 공급처 모달 -->
    
    <!-- 품목 등록 모달 -->
</div>    

<script>
	var itemRegistModal = document.getElementById('itemRegistModal')
	itemRegistModal.addEventListener('show.bs.modal', function (event) {
  		var button = event.relatedTarget
  		var recipient = button.getAttribute('data-bs-whatever')
  		var modalTitle = itemRegistModal.querySelector('.modal-title')
 	 	var modalBodyInput = itemRegistModal.querySelector('.modal-body input')
	})

	var itemModifyModal = document.getElementById('itemModifyModal')
	itemModifyModal.addEventListener('show.bs.modal', function (event) {
  		var button = event.relatedTarget
  		var recipient = button.getAttribute('data-bs-whatever')
  		var modalTitle = itemModifyModal.querySelector('.modal-title')
 	 	var modalBodyInput = itemModifyModal.querySelector('.modal-body input')
	})
	
	function modifyModal(itemList) {
		console.log(itemList);
		// 모달 띄우기
        $('#itemModifyModal').modal('show');
    }	
	
    // 공급처 모달
    $(document).ready(function() {
	    $("#clientcode").click(function() {
	        $("#clientModal").modal('show');
	   	});
    	
	    $(".clientset").click(function() {
	        var columns = $(this).find('td');
	        var selectedClientName = $(columns[1]).text(); // 공급처명
	        var selectedClientCode = $(columns[2]).text(); // 공급처코드
	        $('#clientcode').val(selectedClientCode);
	        $('#clientModal').modal('hide');
	    });

    });	 

</script>

<%@ include file="../include/footer.jsp" %>