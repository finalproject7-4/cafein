<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<br>

		<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
			<h2>자재 재고 관리</h2>
			<div class="form-check form-check-inline">
  				<input class="form-check-input" type="radio" name="stocktype" id="materialRadio" value="자재" checked>
  				<label class="form-check-label" for="materialRadio">자재</label>
			</div>
			<div class="form-check form-check-inline">
  				<input class="form-check-input" type="radio" name="stocktype" id="productRadio" value="완제품">
  				<label class="form-check-label" for="productRadio">완제품</label>
			</div>
			<form action="/material/materialStockList" method="POST">
				<input type="text" name="search" placeholder="검색어를 입력하세요">
				<input type="submit" value="검색">
			</form>
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">구분</th>
								<th scope="col">코드</th>
								<th scope="col">품명</th>
								<th scope="col">LOT</th>
								<th scope="col">재고량</th>
								<th scope="col">창고</th>
								<th scope="col">작업자</th>
								<th scope="col">등록일</th>
								<th scope="col">변경일</th>
								<th scope="col">최근 변경 내역</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="slist" items="${list }" varStatus="loop">
								<tr>
									<th>${slist.stockid }</th>
									<th>${slist.itemtype }</th>
									<th>${slist.itemcode }</th>
									<th>${slist.itemname }</th>
									<th>${slist.lotnumber }</th>
									<th>
									<c:if test="${slist.stockquantity < 10 }">
										<b style="color: red;">${slist.stockquantity }</b>개
									</c:if>
									<c:if test="${slist.stockquantity >= 10 }">
										${slist.stockquantity }개
									</c:if>
									<button type="button" class="btn btn-primary btn-sm" 
									data-bs-toggle="modal" data-bs-target="#exampleModal"
									data-stockid="${slist.stockid}" data-qualityid="${slist.qualityid}" 
									data-stockquantity="${slist.stockquantity }" data-itemname="${slist.itemname }" 
									data-lotnumber="${slist.lotnumber }">
 									실사 변경
									</button>
									</th>
									<th>${slist.storagecode }-${slist.storagename }
									<button type="button" class="btn btn-danger btn-sm" 
									data-bs-toggle="modal" data-bs-target="#exampleModal2"
									data-stockid="${slist.stockid }" data-qualityid="${slist.qualityid }" 
									data-itemname="${slist.itemname }" data-lotnumber="${slist.lotnumber }" 
									data-storagename="${slist.storagename }" data-storagecode="${slist.storagecode }">
									창고 이동
									</button>
									</th>
									<th>${slist.workerbycode }</th>
									<th>${slist.registerationdate }</th>
									<th>${slist.updatedate }</th>
									<th>${slist.updatehistory }</th>
								</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>	


<!-- 모달창1 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/material/updateStockQuantity" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">재고량 변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      	<div class="row">
 			<div class="col">
           		<label for="stockid" class="col-form-label">재고ID:</label>
            	<input type="text" class="form-control" id="stockid" name="stockid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="qualityid" class="col-form-label">품질관리ID:</label>
            	<input type="text" class="form-control" id="qid" name="qualityid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="itemname" class="col-form-label">제품명:</label>
            	<input type="text" class="form-control" id="itemname" name="itemname" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="lotnumber" class="col-form-label">LOT번호:</label>
            	<input type="text" class="form-control" id="lotnumber" name="lotnumber" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="nowquantity" class="col-form-label">현재 재고량:</label>
            	<input type="number" class="form-control" id="nowquantity" name="nowquantity" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="stockquantity" class="col-form-label">변경 재고량:</label>
            	<input type="number" class="form-control" id="qid" name="stockquantity" value="" required>
  			</div>
		</div>
		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">재고량 변경</button>
      </div>
    </div>
   </form>
  </div>
</div>
<!-- 모달창1 -->

<!-- 모달창2 -->
<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <form action="/material/updateStockStorage" method="POST">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel2">창고 이동</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      	<div class="row">
 			<div class="col">
           		<label for="stockid" class="col-form-label">재고ID:</label>
            	<input type="text" class="form-control" id="stockid" name="stockid" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="qualityid" class="col-form-label">품질관리ID:</label>
            	<input type="text" class="form-control" id="qid" name="qualityid" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="itemname" class="col-form-label">제품명:</label>
            	<input type="text" class="form-control" id="itemname" name="itemname" value="" readonly>
  			</div>
  			<div class="col">
            	<label for="lotnumber" class="col-form-label">LOT번호:</label>
            	<input type="text" class="form-control" id="lotnumber" name="lotnumber" value="" readonly>
  			</div>
		</div>
		<div class="row">
 			<div class="col">
           		<label for="nowstorage" class="col-form-label">현재창고:</label>
            	<input type="text" class="form-control" id="nowstorage" name="nowstorage" value="" readonly>
  			</div>
  			<div class="col">
           		<label for="storageid" class="col-form-label">이동창고:</label>
				<select class="form-select" aria-label="Default select example" id="storageid" name="storageid">
				<c:forEach var="str" items="${slist }">
  					<option value="${str.storageid }">${str.storagecode }-${str.storagename }</option>
  				</c:forEach>	
				</select>
  			</div>
		</div>	
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" class="btn btn-primary">창고 이동</button>
      </div>
    </div>
   </form>
  </div>
</div>
<!-- 모달창2 -->

<!-- 모달 1 출력 -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('exampleModal');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let stockId = button.getAttribute('data-stockid'); // stockid
        let qualityId = button.getAttribute('data-qualityid'); // qualityid
        let nowQuantity = button.getAttribute('data-stockquantity'); // stockquantity
        let itemName = button.getAttribute('data-itemname'); // stockquantity
        let lotNumber = button.getAttribute('data-lotnumber'); // stockquantity
        
        // 모달 내부의 입력 필드에 값을 설정
        let sinputField = myModal.querySelector('input[name="stockid"]');
        sinputField.value = stockId;
        
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityId;
        
        let ninputField = myModal.querySelector('input[name="nowquantity"]');
        ninputField.value = nowQuantity;
        
        let iinputField = myModal.querySelector('input[name="itemname"]');
        iinputField.value = itemName;
        
        let linputField = myModal.querySelector('input[name="lotnumber"]');
        linputField.value = lotNumber;
    });
});
</script>
<!-- 모달 1 출력 -->

<!-- 모달 2 출력 -->
<script>
$(document).ready(function() {
    let myModal = document.getElementById('exampleModal2');
    myModal.addEventListener('show.bs.modal', function(event) {
        let button = event.relatedTarget;  // 클릭한 버튼 요소를 가져옴
        let stockId = button.getAttribute('data-stockid'); // stockid
        let qualityId = button.getAttribute('data-qualityid'); // qualityid
        let itemName = button.getAttribute('data-itemname'); // stockquantity
        let lotNumber = button.getAttribute('data-lotnumber'); // stockquantity
        let storageName = button.getAttribute('data-storagename'); // storagename
        let storageCode = button.getAttribute('data-storagecode'); // storagecode
        
        // 모달 내부의 입력 필드에 값을 설정
        let sinputField = myModal.querySelector('input[name="stockid"]');
        sinputField.value = stockId;
        
        let qinputField = myModal.querySelector('input[name="qualityid"]');
        qinputField.value = qualityId;
        
        let iinputField = myModal.querySelector('input[name="itemname"]');
        iinputField.value = itemName;
        
        let linputField = myModal.querySelector('input[name="lotnumber"]');
        linputField.value = lotNumber;
        
        let stinputField = myModal.querySelector('input[name="nowstorage"]');
        stinputField.value = storageCode + "-" + storageName;
    });
});
</script>
<!-- 모달 2 출력 -->

<!-- 라디오 버튼 이동 -->
<script>
$(document).ready(function(){
    $('#materialRadio').click(function(){ // 자재를 눌렀을 때
        console.log("Material radio clicked!");
        $.ajax({
            url: "/material/materialStockList",
            type: "GET",
            success: function(data) {
                $("#stockListContainer").html(data);
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
    
    $('#productRadio').click(function(){ // 완제품을 눌렀을 때
        console.log("Product radio clicked!");
        $.ajax({
            url: "/material/productStockList",
            type: "GET",
            success: function(data) {
                $("#stockListContainer").html(data);
            },
            error: function(error) {
                console.error("Error fetching data:", error);
            }
        });
    });
});
</script>
<!-- 라디오 버튼 이동 -->