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
		<span style="margin-left: 81%;">
			<button type="button" class="btn btn-sm btn-dark m-1" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">등록</button>
			<button type="button" class="btn btn-sm btn-dark m-1">수정</button>
			<button type="button" class="btn btn-sm btn-dark m-1">삭제</button>
		</span>
		
		<div class="table-responsive">
			<table class="table" style="margin-top: 10px;">
				<thead>
					<tr>
						<th scope="col">
							<input type="checkbox" id="delete-list-all" name="delete-list" data-group="delete-list">
						</th>
						<th scope="col">번호</th>
						<th scope="col">품목코드</th>
						<th scope="col">품목유형</th>
						<th scope="col">품명</th>
						<th scope="col">거래처명</th>
						<th scope="col">원산지</th>
						<th scope="col">중량(g)</th>
						<th scope="col">단가(원)</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="itemList" items="${itemList }">
						<tr>
							<td>
								<input type="checkbox" id="delete-list-all" name="delete-list" data-group="delete-list">
							</td>
							<td>${itemList.itemid }</td>
							<td>${itemList.itemcode }</td>
							<td>${itemList.itemtype }</td>
							<td>${itemList.itemname }</td>
							<td>${itemList.clientname }</td>
							<td>${itemList.origin }</td>
							<td>${itemList.itemweight }</td>
							<td>${itemList.itemprice }</td>
						</tr>
					</c:forEach>	
				</tbody>
			</table>
		</div>
	</div>
	<!-- 품목 목록 -->		
		
	<!-- 품목 등록 모달 -->
	<jsp:include page="itemRegist.jsp"/>
		
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
                                 <c:forEach var="itemList" items="${itemList }">
                                    <tr class="clientset">
                                    	<td>${itemList.itemid }</td> 
                                    	<td>${itemList.clientname }</td> 
                                    	<td>${itemList.clientcode }</td>
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
    <!-- 공급처 모달 -->
    
    <!-- 품목 등록 모달 -->
</div>    

<script>
	var exampleModal = document.getElementById('exampleModal')
	exampleModal.addEventListener('show.bs.modal', function (event) {
  		var button = event.relatedTarget
  		var recipient = button.getAttribute('data-bs-whatever')
  		var modalTitle = exampleModal.querySelector('.modal-title')
 	 	var modalBodyInput = exampleModal.querySelector('.modal-body input')
	})
	
	// 체크박스 전체 선택
	var selectAllCheckbox = document.getElementById("delete-list-all");
	var checkboxes = document.querySelectorAll('[data-group="delete-list"]');
	selectAllCheckbox.addEventListener("change", function () {
    	checkboxes.forEach(function (checkbox) {
        	checkbox.checked = selectAllCheckbox.checked;
    	});
	});
	
	checkboxes.forEach(function (checkbox) {
    	checkbox.addEventListener("change", function () {
        	if (!this.checked) {
            	selectAllCheckbox.checked = false;
        	} else {
            	// 모든 체크박스가 선택되었는지 확인
            	var allChecked = true;
            	checkboxes.forEach(function (c) {
                	if (!c.checked) {
                    	allChecked = false;
                	}
            	});
            	selectAllCheckbox.checked = allChecked;
        	}
    	});
	});
	
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