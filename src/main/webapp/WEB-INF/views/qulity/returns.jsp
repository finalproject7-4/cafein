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
        border: 1px solid #ced4da; /* 테두리 색상 및 굵기 설정 */
        border-radius: 0.25rem;    /* 모서리 깍임 정도 설정 */
        padding: 20px;             /* 내부 여백 설정 */
  		}
    </style>
   
</head>
<body>

     
        <form action="/quality/returns" method="post">
        <h6 class="mb-4">반품 조회</h6>
            <div class="form-group">
                <label for="returncode">반품 코드</label>
                <input type="text" class="form-control" id="returncode" name="returncode" placeholder="반품 코드">
            </div>
            <div class="form-group">
                <label for="reuturntype">품목</label>
                <input type="text" class="form-control" id="returntype" name="returntype" placeholder="품목">
            </div>
            <div class="form-group">
                <label for="returndate">반품 날짜</label>
                <div class="input-group">
                    <input type="date" class="form-control" id="returndate" name="returndate"  placeholder="반품 날짜">
                </div>
            </div>
            <button type="submit" class="btn btn-outline-warning m-2">조회</button>
        </form>
	
        
	<button onclick="showTab('all')" class="btn btn-outline-warning m-2">전체</button>
	<button onclick="showTab('waiting')" class="btn btn-outline-warning m-2">대기</button>
	<button onclick="showTab('inProgress')" class="btn btn-outline-warning m-2">검수중</button>
	<button onclick="showTab('completed')" class="btn btn-outline-warning m-2">완료</button>
	
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
                        <th scope="col">등록</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${returnList}" var="returnVO">
                        <tr>
                            <td>${returnVO.returnid}</td>
                            <td>${returnVO.returncode}</td>
                            <td>${returnVO.returndate}</td>                          
                            <td>${returnVO.exchangedate}</td>                          
                            <td>${returnVO.returnquantity}</td>
                            <td>${returnVO.returnstatus}</td>
                            <td>${returnVO.reprocessmethod}</td>
                            <td>${returnVO.returntype}</td>
                            <td>
                            <button class="btn btn-danger pull-right">등록</button>
                            </td>
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
                        <th scope="col">등록</th>
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
                           <td>
                           <button class="btn btn-danger pull-right">등록</button>
                   		   </td>
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
                        <th scope="col">등록</th>
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
                           <td>
                           <button class="btn btn-danger pull-right">등록</button>
                   		   </td> 
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
                    <th scope="col">등록</th>
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
                           <td>
                           <button class="btn btn-danger pull-right">등록</button>
                   		   </td> 
		                </tr>
		 			</c:if>
		            </c:forEach>
		        </tbody>
		    </table>
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