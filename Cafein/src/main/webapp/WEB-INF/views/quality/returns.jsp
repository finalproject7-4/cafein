<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>반품 관리</title>
    <style>
        .tab-content {
            display: none;
        }

        .active {
            display: block;
        }
         form {
        border-radius: 0.25rem;    /* 모서리 깍임 정도 설정 */
        padding: 20px;             /* 내부 여백 설정 */
  		}
    </style>
   
</head>
<body>

     <!-- 검색창 -->
   		<div class="col-12" style="margin-top:20px;">
		<div class="bg-light rounded h-100 p-4">
        <form action="" method="get">
        <h6 class="mb-4">반품 조회</h6>
	<div class="row">
            <div class="form-group" style="width: 200px; margin-right: 20px;">
                <label for="returncode">반품 코드</label>
                <input type="text" class="form-control" id="returncode" name="returncode" value="${returnVO.returncode }" placeholder="반품 코드">
            </div>
            
            
            <div class="form-group" style="width: 200px; margin-right: 20px;">
                <label for="reuturntype">품목</label>
                <select name="returntype" class="form-control" id="returntype">
                	<option ${returnVO.returntype eq "전체" ? "selected" : "" }>전체</option>
                	<option ${returnVO.returntype eq "MOT" ? "selected" : "" }>MOT</option>
                	<option ${returnVO.returntype eq "PRO" ? "selected" : "" }>PRO</option>
                </select>
            </div>
	
            <div class="form-group " style="width: 400px;">
                <label for="returndate">반품 날짜</label>
                <div class="input-group" style="width: 400px">
                    <input type="date" class="form-control" id="startDate" name="startDate"  placeholder="반품 날짜">
                <div >
                &nbsp;~&nbsp;
                </div>
                    <input type="date" class="form-control" id="endDate" name="endDate"  placeholder="반품 날짜">
                </div>
            </div>
            </div>
            
           <div class="d-flex justify-content-end">
            <button type="submit" class="btn btn-outline-warning m-2">조회</button>
           </div>
        </form>
		</div>
		</div>
     <!-- 검색창 -->
     
     
     
	
        

	
	<!-- 반품 등록 모달 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">반품 등록</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
			<div class="modal-body">
		<form>
		    <div class="row">
		        <div class="col">
		            <label for="produce" class="col-form-label">반품사유</label>
		            <select class="form-select" id="floatingSelect" aria-label="Floating label select example" name="process">
		                <option value="" disabled selected>선택하세요</option>
		                <option value="1">품질 불량</option>
		                <option value="2">주문오류</option>
		            </select>
		        </div>
		        <div class="col">
		            <label for="returndate" class="col-form-label">반품일자</label>
		            <input type="date" name="returndate" value="today()" class="form-control" id="floatingInput" placeholder="반품일">
		        </div>
		        </div>
		        <div class="col">
		            <label for="exchangedate" class="col-form-label">교환일자</label>
		            <input type="date" name="exchangedate" value="today()" class="form-control" id="floatingInput" placeholder="교환일">
		        </div>
		    <div class="mb-3">
		        <label for="membercode" class="col-form-label">담당자(사원번호)</label>
		        <input name="membercode" class="form-control" id="floatingInput">
		    </div>
		</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary">저장</button>
					</div>
				</div>
			</div>
		</div>
<!-- 모달창 끝-->
	
	
		<div class="col-12" style="margin-top:20px;">
		<div class="bg-light rounded h-100 p-4">
		<h6 class="mb-4">반품 목록</h6>
		
		<div class="d-flex justify-content-between">
		<div>
		<button onclick="showTab('all')" class="btn btn-outline-warning m-2">전체</button>
		<button onclick="showTab('waiting')" class="btn btn-outline-warning m-2">대기</button>
		<button onclick="showTab('inProgress')" class="btn btn-outline-warning m-2">검수중</button>
		<button onclick="showTab('completed')" class="btn btn-outline-warning m-2">완료</button>
		</div>
		
		<div>
		<button type="button" class="btn btn-outline-warning m-2" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@getbootstrap">반품 등록</button>
		<button type="button" class="btn btn-outline-warning m-2">수정</button>
		<button type="button" class="btn btn-outline-warning m-2">삭제</button>
		</div>
		</div>
		
		<div id="allTab" class="tab-content active">
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">반품ID</th>
                        <th scope="col">반품코드</th>
                        <th scope="col">반품날짜</th>
                        <th scope="col">교환날짜</th>
                        <th scope="col">수량</th>
                        <th scope="col">반품상태</th>
                        <th scope="col">검수상태</th>
                        <th scope="col">품목</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${returnList}" var="returnVO">
                        <tr>
                            <td>${returnVO.returnid}</td>
                            <td>${returnVO.returncode}</td>
                            <td>${returnVO.returndate}</td>    
                            <td><fmt:formatDate value="${returnVO.returndate }" pattern="yyyy-MM-dd" /></td>
                            <td><fmt:formatDate value="${returnVO.submitdate }" pattern="yyyy-MM-dd" /> </td>                     
                            <td>${returnVO.exchangedate}</td>                          
                            <td>${returnVO.returnquantity}</td>
                            <td>${returnVO.returnstatus}</td>
                            <td>${returnVO.reprocessmethod}</td>
                            <td>${returnVO.returntype}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>	
    
    
    	
		<div id="waitingTab" class="tab-content active">
		<div class="table-responsive">
		    <table class="table">
		        <thead>
		        	<tr>
                        <th scope="col">반품ID</th>
                        <th scope="col">반품코드</th>
                        <th scope="col">반품날짜</th>
                        <th scope="col">교환날짜</th>
                        <th scope="col">수량</th>
                        <th scope="col">반품상태</th>
                        <th scope="col">검수상태</th>
                        <th scope="col">품목</th>
                    </tr>
		        </thead>
		        <tbody>
		            <c:forEach items="${returnList}" var="returnVO">
		                <c:if test="${returnVO.returnstatus eq '대기중'}">
	                    <tr>
                           <td>${returnVO.returnid}</td>
                           <td>${returnVO.returncode}</td>
                           <td>${returnVO.returndate}</td>                          
                           <td>${returnVO.exchangedate}</td>                          
                           <td>${returnVO.returnquantity}</td>
                           <td>${returnVO.returnstatus}</td>
                           <td>${returnVO.reprocessmethod}</td>
                           <td>${returnVO.returntype}</td>
                        </tr>  
                        </c:if>
		            </c:forEach>
		        </tbody>
		    </table>
		</div>
	</div>
	
	
	
		
		<div id="inProgressTab" class="tab-content active">
		<div class="table-responsive">
		    <table class="table">
		        <thead>
		            <tr>
                        <th scope="col">반품ID</th>
                        <th scope="col">반품코드</th>
                        <th scope="col">반품날짜</th>
                        <th scope="col">교환날짜</th>
                        <th scope="col">수량</th>
                        <th scope="col">반품상태</th>
                        <th scope="col">검수상태</th>
                        <th scope="col">품목</th>
                    </tr>
		        </thead>
		        <tbody>
		            <c:forEach items="${returnList}" var="returnVO">
		            <c:if test="${returnVO.reprocessmethod eq '검수중'}">
		                <tr>
	                       <td>${returnVO.returnid}</td>
                           <td>${returnVO.returncode}</td>
                           <td>${returnVO.returndate}</td>                          
                           <td>${returnVO.exchangedate}</td>                          
                           <td>${returnVO.returnquantity}</td>
                           <td>${returnVO.returnstatus}</td>
                           <td>${returnVO.reprocessmethod}</td>
                           <td>${returnVO.returntype}</td>
		                </tr>
	              	</c:if>
		            </c:forEach>
		        </tbody>
		    </table>
		</div>
		</div>
		
		
		
		<div id="completedTab" class="tab-content active">
		<div class="table-responsive">
		    <table class="table">
		        <thead>
       			<tr>
                    <th scope="col">반품ID</th>
                    <th scope="col">반품코드</th>
                    <th scope="col">반품날짜</th>
                    <th scope="col">교환날짜</th>
                    <th scope="col">수량</th>
                    <th scope="col">반품상태</th>
                    <th scope="col">검수상태</th>
                    <th scope="col">품목</th>
                </tr>
		        
		        </thead>
		        <tbody>
		            <c:forEach items="${returnList}" var="returnVO">
		            <c:if test="${returnVO.reprocessmethod eq '완료'}">
		                <tr>
		                   <td>${returnVO.returnid}</td>
                           <td>${returnVO.returncode}</td>
                           <td>${returnVO.returndate}</td>                          
                           <td>${returnVO.exchangedate}</td>                          
                           <td>${returnVO.returnquantity}</td>
                           <td>${returnVO.returnstatus}</td>
                           <td>${returnVO.reprocessmethod}</td>
                           <td>${returnVO.returntype}</td>
		                </tr>
		 			</c:if>
		            </c:forEach>
		        </tbody>
		    </table>
		</div>
    </div>
   </div>
   </div> 

<%@ include file="../include/footer.jsp" %>
<script>
document.addEventListener("DOMContentLoaded", function () {
    // 페이지 로딩 후에 실행될 코드
    showTab('all');
});
    function showTab(tabName) {
        var tabs = document.getElementsByClassName('tab-content');
        for (var i = 0; i < tabs.length; i++) {
            tabs[i].classList.remove('active');
        }
        document.getElementById(tabName + 'Tab').classList.add('active');
    }
    
    
    
</script>
</body>
</html>