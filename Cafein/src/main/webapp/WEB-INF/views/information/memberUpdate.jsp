<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
${resultVO }
	
    <!-- Modal -->
	<div class="modal fade" id="memberUpdateModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <h5 class="modal-title">직원 정보 수정</h5>&nbsp;&nbsp;
	        <span style="color:red; font-size: 0.8em;">* 표시는 필수입력 사항입니다.</span><br>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
		<form role="form" action="/information/memberUpdate" method="post">
	      <div class="modal-body">
	        	<input type="hidden" name="memberid" id="memberid">
	      	직원명 <span style="color:red;">*</span>
	      		<input type="text" name="membername" class="form-control" id="membername"
					   pattern="^[가-힣]{1,20}$" title="직원명은 20자 이하의 한글만 가능합니다." required><br>
			비밀번호 <span style="color:red;">*</span>
				<input type="password" name="memberpw" class="form-control" id="memberpw" placeholder="비밀번호(6자 이상 10자 이하)"
					   minlength="6" maxlength="10" title="비밀번호는 6자 이상 10자 이하입니다." required><br>
			생년월일 
				<input type="date" name="memberbirth" class="form-control" id="memberbirth"><br>
			입사일 
				<input type="date" name="memberhire" class="form-control" id="memberhire"><br>
				
			수정 전 부서명
				<input type="text" class="form-control" id="departmentname" readonly><br>
				
			수정할 부서명 <span style="color:red; font-size: 0.8em;">* 수정하지 않아도 입력해 주세요.</span><br>
				<input type="radio" name="departmentname" value="생산" class="btn-check" id="productionU">
				<label class="btn btn-outline-primary" for="productionU">생산</label>
				
				<input type="radio" name="departmentname" value="영업" class="btn-check" id="salesU">
				<label class="btn btn-outline-primary" for="salesU">영업</label>
				
				<input type="radio" name="departmentname" value="자재" class="btn-check" id="materialU">
				<label class="btn btn-outline-primary" for="materialU">자재</label>
				
				<input type="radio" name="departmentname" value="품질" class="btn-check" id="qualityU">
				<label class="btn btn-outline-primary" for="qualityU">품질</label><br>

			수정 전 직급				
				<input type="text" class="form-control" id="memberposition" readonly><br>
				
			수정할 직급 <span style="color:red; font-size: 0.8em;">* 수정하지 않아도 입력해 주세요.</span><br>
				<input type="radio" name="memberposition" value="사원" class="btn-check" id="employeeU">
				<label class="btn btn-outline-primary" for="employeeU">사원</label>
				
				<input type="radio" name="memberposition" value="주임" class="btn-check" id="managerU">
				<label class="btn btn-outline-primary" for="managerU">주임</label>
				
				<input type="radio" name="memberposition" value="대리" class="btn-check" id="deputyU">
				<label class="btn btn-outline-primary" for="deputyU">대리</label>
				
				<input type="radio" name="memberposition" value="과장" class="btn-check" id="sectionChiefU">
				<label class="btn btn-outline-primary" for="sectionChiefU">과장</label><br>
				
			E-Mail <span style="color:red;">*</span>
				<input type="email" name="memberemail" class="form-control" id="memberemail" required><br>
			내선번호 
				<input type="tel" name="memberdeptphone" class="form-control" id="memberdeptphone" 
					   title="내선번호는 4자리 숫자만 가능합니다."><br>
<!-- 					   pattern="[0-9]{4}" title="내선번호는 4자리 숫자만 가능합니다."><br> -->
			전화번호 <span style="color:red;">*</span>
				<input type="tel" name="memberphone" class="form-control" id="memberphone"
					   title="전화번호는 11자리 숫자만 가능합니다." required><br>
<!-- 					   pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" title="전화번호는 11자리 숫자만 가능합니다." required><br> -->
			
	        <label for="available">활성화 여부</label>
	        <select id="available" name="available" class="form-select mb-3" aria-label="Default select example" required>
	            <option value="Y">활성화</option>
    			<option value="N">비활성화</option>
	        </select>
		   
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
	        		style="color: #610B0B;background-color: #FBF8EF; border-color: #610B0B;">취소</button>
	        <button type="submit" class="btn btn-primary" id="memberUpdateModal"
	        		style="background-color: #610B0B; border-color: #FBF8EF;">수정</button>
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

<!-- 버튼 색상 css -->
<style>
	.btn-outline-primary {
	    color: #610B0B;
	    border-color: #610B0B;
	}
	.btn-outline-primary:hover {
	    color: #FBF8EF;
	    border-color: #FBF8EF;
	    background-color: #610B0B;
	}
	
	.btn-check:checked+.btn-outline-primary, .btn-check:active+.btn-outline-primary, .btn-outline-primary:active, .btn-outline-primary.active, .btn-outline-primary.dropdown-toggle.show {
	    color: #FBF8EF;
	    background-color: #610B0B;
	    border-color: #610B0B;
	}
</style>
<!-- 버튼 색상 css -->
	


