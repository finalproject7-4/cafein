<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
${resultVO }
	
	<!-- Modal -->
	<div class="modal fade" id="clientDeleteModal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <h5 class="modal-title">거래처 정보 비활성화</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
		<form role="form" action="/information/clientDelete" method="post">
	      <div class="modal-body">
	      		<input type="hidden" name="clientid" id="clientid2">
	      		<input type="hidden" name="available" value="N">
	      		
			거래처 코드 
				<input type="text" class="form-control" id="clientcode" readonly><br>
			거래처명 
				<input type="text" class="form-control" id="clientname2" readonly><br>
			거래처 구분  
				<input type="text" class="form-control" id="categoryofclient2" readonly><br>
			거래처 업종  
				<input type="text" class="form-control" id="typeofclient2" readonly><br>
			사업자 번호  
				<input type="text" class="form-control" id="businessnumber2" readonly><br>
			대표자  
				<input type="text" class="form-control" id="representative2" readonly><br>
			담당자  
				<input type="text" class="form-control" id="manager2" readonly><br>
			주소  
				<input type="text" class="form-control" id="clientaddress2" readonly><br>
			전화번호  
				<input type="text" class="form-control" id="clientphone2" readonly><br>
			팩스번호  
				<input type="text" class="form-control" id="clientfax2" readonly><br>
			E-Mail  
				<input type="text" class="form-control" id="clientemail2" readonly><br>
			
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="submit" class="btn btn-primary" id="clientDeleteModal">비활성화</button>
	      </div>
		</form>
		
	    </div>
	  </div>
	</div>