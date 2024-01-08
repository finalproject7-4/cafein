<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
${resultVO }    
	
	<!-- Modal -->
	<div class="modal fade" id="memberDeleteModal" tabindex="-1">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <h5 class="modal-title">직원 정보 비활성화</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
		<form role="form" action="/information/memberDelete" method="post">
	      <div class="modal-body">
	      		<input type="hidden" name="memberid" id="memberid2">
	      		<input type="hidden" name="available" value="N">
	      		
	      	직원코드
	      		<input type="text" class="form-control" id="membercode2" readonly><br>
	      	직원명  
				<input type="text" class="form-control" id="membername2" readonly><br>
			생년월일  
				<input type="date" class="form-control" id="memberbirth2" readonly><br>
			입사일  
				<input type="date" class="form-control" id="memberhire2" readonly><br>
			부서명  
				<input type="text" class="form-control" id="departmentname2" readonly><br>
			직급  
				<input type="text" class="form-control" id="memberposition2" readonly><br>
			E-Mail  
				<input type="email" class="form-control" id="memberemail2" readonly><br>
			내선번호  
				<input type="text" class="form-control" id="memberdeptphone2" readonly><br>
			전화번호  
				<input type="text" class="form-control" id="memberphone2" readonly><br>
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
	        		style="color: #610B0B;background-color: #FBF8EF; border-color: #610B0B;">취소</button>
	        <button type="submit" class="btn btn-primary" id="memberDeleteModal"
	        		style="background-color: #610B0B; border-color: #FBF8EF;">비활성화</button>
	      </div>
		</form>
		
	    </div>
	  </div>
	</div>
