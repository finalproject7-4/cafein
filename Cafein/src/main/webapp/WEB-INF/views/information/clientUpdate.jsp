<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
${resultVO }
	
	<!-- Modal -->
	<div class="modal fade" id="clientUpdateModal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <h5 class="modal-title">거래처 정보 수정</h5>&nbsp;&nbsp;
	        <span style="color:red; font-size: 0.8em;">* 표시는 필수입력 사항입니다.</span><br>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	        ${resultVO }
	      </div>
	      
		<form role="form" action="/information/clientUpdate" method="post">
	      <div class="modal-body">
	      		<input type="hidden" name="clientid" id="clientid">
			거래처명 <span style="color:red;">*</span>  
				<input type="text" name="clientname" class="form-control" id="clientname" required><br>
			
			수정 전 거래처 구분
				<input type="text" id="categoryofclient" class="form-control" readonly><br>

			수정할 거래처 구분 <span style="color:red; font-size: 0.8em;">* 수정하지 않아도 입력해 주세요.</span><br>
				<input type="radio" name="categoryofclient" value="납품" class="btn-check" id="ordererU">
				<label class="btn btn-outline-primary" for="ordererU">납품</label>
			
				<input type="radio" name="categoryofclient" value="공급" class="btn-check" id="deliveryDestinationU">
				<label class="btn btn-outline-primary" for="deliveryDestinationU">공급</label><br>
			
			수정 전 거래처 업종
				<input type="text" id="typeofclient" class="form-control" placeholder="거래처 구분이 '납품'입니다." readonly><br>
			
      	  	수정할 거래처 업종 <span style="color:blue; font-size: 0.8em;">&nbsp;거래처 구분이 '공급'일 때만 선택하세요.</span><br>
					<input type="radio" name="typeofclient" value="원자재" class="btn-check" id="rawMaterialU">
					<label class="btn btn-outline-primary" for="rawMaterialU">원자재</label>
					<input type="radio" name="typeofclient" value="부자재" class="btn-check" id="additionalMaterialU">
					<label class="btn btn-outline-primary" for="additionalMaterialU">부자재</label><br>
					
			사업자 번호
				<input type="text" name="businessnumber" class="form-control" id="businessnumber"
				  	   title="사업자 번호는 10자리 숫자만 가능합니다."><br>
			대표자 <span style="color:red;">*</span>  
				<input type="text" name="representative" class="form-control" id="representative" required><br>
			담당자 <span style="color:red;">*</span>
				<input type="text" name="manager" class="form-control" id="manager" required><br>
			주소   
				<input type="text" name="clientaddress" class="form-control" id="clientaddress"><br>
			전화번호 <span style="color:red;">*</span>  
				<input type="tel" name="clientphone" class="form-control" id="clientphone"
					   title="전화번호는 11자리 숫자만 가능합니다." required><br>
			팩스번호   
				<input type="tel" name="clientfax" class="form-control" id="clientfax"
					   title="팩스번호는 10자리 숫자만 가능합니다."><br>
			E-Mail <span style="color:red;">*</span>  
				<input type="email" name="clientemail" class="form-control" id="clientemail" required><br>
			
	        <label for="available">활성화 여부</label>
	        <select id="available" name="available" class="form-select mb-3" aria-label="Default select example" required>
	            <option value="Y">활성화</option>
    			<option value="N">비활성화</option>
	        </select>
		   
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="submit" class="btn btn-primary" id="clientUpdateModal">수정</button>
	      </div>
		</form>
		
	    </div>
	  </div>
	</div>
	
<!-- select css -->
<style>
	.input-group>.form-control, .input-group>.form-select {
	    position: relative;
	    flex: none;
	    width: 20%;
	    min-width: 0;
	}
</style>
<!-- select css -->
