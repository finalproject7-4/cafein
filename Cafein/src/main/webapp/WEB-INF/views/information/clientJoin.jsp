<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<!-- Modal -->
	<div class="modal fade" id="clientJoinModal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <h5 class="modal-title">거래처 정보 등록</h5>&nbsp;&nbsp;
	        <span style="color:red; font-size: 0.8em;">* 표시는 필수입력 사항입니다.</span><br>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
		<form role="form" action="/information/clientJoin" method="post">
	      <div class="modal-body">
			거래처명 <span style="color:red;">*</span> 
				<input type="text" name="clientname" class="form-control" required><br>
			
			거래처 구분 <span style="color:red;">*</span><br>
				<input type="radio" name="categoryofclient" value="납품" class="btn-check" id="orderer">
				<label class="btn btn-outline-primary" for="orderer">납품</label>
				<input type="radio" name="categoryofclient" value="공급" class="btn-check" id="deliveryDestination">
				<label class="btn btn-outline-primary" for="deliveryDestination">공급</label><br>
     	  	
      	  	거래처 업종 <span style="color:blue; font-size: 0.8em;">&nbsp;거래처 구분이 '공급'일 때만 선택하세요.</span><br>
				<input type="radio" name="typeofclient" value="원자재" class="btn-check" id="rawMaterial">
				<label class="btn btn-outline-primary" for="rawMaterial">원자재</label>
				<input type="radio" name="typeofclient" value="부자재" class="btn-check" id="additionalMaterial">
				<label class="btn btn-outline-primary" for="additionalMaterial">부자재</label><br>
			
			사업자 번호 
				<input type="text" name="businessnumber" class="form-control" placeholder="사업자 번호(예:1234567890)" 
				  	   title="사업자 번호는 10자리 숫자만 가능합니다."><br>
			대표자 <span style="color:red;">*</span>
				<input type="text" name="representative" class="form-control" required><br>
			담당자 <span style="color:red;">*</span>
				<input type="text" name="manager" class="form-control" required><br>
			주소 
				<input type="text" name="clientaddress" class="form-control"><br>
			전화번호 <span style="color:red;">*</span>
				<input type="tel" name="clientphone" class="form-control" placeholder="전화번호(예:01012345678)" 
					   title="전화번호는 11자리 숫자만 가능합니다." required><br>
			팩스번호 
				<input type="tel" name="clientfax" class="form-control" placeholder="팩스번호(예:0101234567)" 
					   title="팩스번호는 10자리 숫자만 가능합니다."><br>
			E-Mail <span style="color:red;">*</span>
				<input type="email" name="clientemail" class="form-control" required><br>
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="submit" class="btn btn-primary" id="clientJoinModal">등록</button>
	      </div>
		</form>
		
	    </div>
	  </div>
	</div>

