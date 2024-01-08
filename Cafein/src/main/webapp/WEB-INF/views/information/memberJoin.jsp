<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	<!-- Modal -->
	<div class="modal fade" id="memberJoinModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <h5 class="modal-title">직원 정보 등록</h5>&nbsp;&nbsp;
	        <span style="color:red; font-size: 0.8em;">* 표시는 필수입력 사항입니다.</span><br>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
		<form action="/information/memberJoin" method="post">
	      <div class="modal-body">
			직원명 <span style="color:red;">*</span>
				<input type="text" name="membername" class="form-control" placeholder="직원명(20자 이하, 한글만 가능)" 
					   pattern="^[가-힣]{1,20}$" title="직원명은 20자 이하의 한글만 가능합니다." required><br>
			비밀번호 <span style="color:red;">*</span> 
				<input type="password" name="memberpw" class="form-control" placeholder="비밀번호(6자 이상 10자 이하)" 
					   minlength="6" maxlength="10" title="비밀번호는 6자 이상 10자 이하입니다." required><br>
			생년월일 
				<input type="date" name="memberbirth" class="form-control"><br>
			입사일 
				<input type="date" name="memberhire" class="form-control"><br>
				
			부서명 <span style="color:red;">*</span> 
				<input type="radio" name="departmentname" value="생산" class="btn-check" id="production">
				<label class="btn btn-outline-primary" for="production">생산</label>
				<input type="radio" name="departmentname" value="영업" class="btn-check" id="sales">
				<label class="btn btn-outline-primary" for="sales">영업</label>
				<input type="radio" name="departmentname" value="자재" class="btn-check" id="material">
				<label class="btn btn-outline-primary" for="material">자재</label>
				<input type="radio" name="departmentname" value="품질" class="btn-check" id="quality">
				<label class="btn btn-outline-primary" for="quality">품질</label><br>
				
			직급 <span style="color:red;">*</span> 
				<input type="radio" name="memberposition" value="사원" class="btn-check" id="employee">
				<label class="btn btn-outline-primary" for="employee">사원</label>
				<input type="radio" name="memberposition" value="주임" class="btn-check" id="manager">
				<label class="btn btn-outline-primary" for="manager">주임</label>
				<input type="radio" name="memberposition" value="대리" class="btn-check" id="deputy">
				<label class="btn btn-outline-primary" for="deputy">대리</label>
				<input type="radio" name="memberposition" value="과장" class="btn-check" id="sectionChief">
				<label class="btn btn-outline-primary" for="sectionChief">과장</label><br>
				
			E-Mail <span style="color:red;">*</span> 
				<input type="email" name="memberemail" class="form-control" required><br>
			내선번호 
				<input type="tel" name="memberdeptphone" class="form-control" placeholder="내선번호(예:1234)" 
					   title="내선번호는 4자리 숫자만 가능합니다."><br>
			전화번호 <span style="color:red;">* 다음과 같이 입력하세요:01012345678</span> 
				<input type="tel" name="memberphone" class="form-control" placeholder="전화번호(예:01012345678)" 
					   title="전화번호는 11자리 숫자만 가능합니다." required><br>
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="submit" class="btn btn-primary" id="memberJoinModal">등록</button>
	      </div>
		</form>
		
	    </div>
	  </div>
	</div>
	
