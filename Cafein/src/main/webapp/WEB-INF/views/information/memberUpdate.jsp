<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인 여부(세션정보)에 따라서 페이지 이동 -->
<c:if test="${empty membercode}">
	<c:redirect url="/main/login" />
</c:if>    
	
    <!-- Modal -->
	<div class="modal fade" id="memberUpdateModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <h5 class="modal-title">직원 정보 수정</h5>&nbsp;&nbsp;
	        <span style="color:red; font-size: 0.8em;">* 표시는 필수입력 사항입니다.</span><br>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      
		<form role="form" action="/information/memberUpdate" method="post" onsubmit="return validateFormUpdate()">
	      <div class="modal-body">
	        	<input type="hidden" name="memberid" id="memberid">
	      	직원명 <span style="color:red;">*</span>
	      		<input type="text" name="membername" class="form-control" id="membername" placeholder="직원명(20자 이하, 한글만 가능)" 
					   pattern="^[가-힣]{1,20}$" title="직원명은 20자 이하의 한글만 가능합니다."><br>
			비밀번호 <span style="color:red;">*</span>
				<input type="password" name="memberpw" class="form-control" id="memberpw" placeholder="비밀번호(6자 이상 10자 이하)"
					   minlength="6" maxlength="10" title="비밀번호는 6자 이상 10자 이하입니다."><br>
			생년월일 
				<input type="date" name="memberbirth" class="form-control" id="memberbirth"><br>
			입사일 
				<input type="date" name="memberhire" class="form-control" id="memberhire"><br>
				
			수정 전 부서명
				<input type="text" class="form-control" id="departmentname" readonly><br>
			
			수정할 부서명 <span style="color:red; font-size: 0.8em;">* 수정하지 않아도 입력해 주세요.</span>
			<select name="departmentname" class="form-select mb-3" id="updateDepartment" aria-label="select Departmentname">
				<option value="생산">생산</option>
				<option value="영업">영업</option>
				<option value="자재">자재</option>
				<option value="품질">품질</option>
			</select>

			수정 전 직급				
				<input type="text" class="form-control" id="memberposition" readonly><br>
				
			수정할 직급 <span style="color:red; font-size: 0.8em;">* 수정하지 않아도 입력해 주세요.</span>
			<select name="memberposition" class="form-select mb-3" id="updatePosition" aria-label="select Departmentname">
				<option value="사원">사원</option>
				<option value="대리">대리</option>
				<option value="팀장">팀장</option>
				<option value="과장">과장</option>
			</select>	
				
			E-Mail <span style="color:red;">*</span>
				<input type="email" name="memberemail" class="form-control" id="memberemail"><br>
			내선번호 
				<input type="tel" name="memberdeptphone" class="form-control" id="memberdeptphone" placeholder="내선번호(예:1234)" 
					   title="내선번호는 4자리 숫자만 가능합니다." pattern="[0-9]{4}"><br>
			전화번호 <span style="color:red;">*</span>
				<input type="tel" name="memberphone" class="form-control" id="memberphone" placeholder="전화번호(예:01012345678)" 
					   title="전화번호는 11자리 숫자만 가능합니다." pattern="[0-9]{11}"><br>
			
	        <label for="available">활성화 여부</label>
	        <select id="available" name="available" class="form-select mb-3" aria-label="Default select example">
	            <option value="Y">활성화</option>
    			<option value="N">비활성화</option>
	        </select>
		   
	      </div>
	      
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="submit" class="btn btn-primary" id="memberUpdateModal">수정</button>
	      </div>
		</form>
		
	    </div>
	  </div>
	</div>
	
