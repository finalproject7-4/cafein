<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>
<link href="../resources/css/po.css" rel="stylesheet">
<br>
<fiedset>
	<!-- 검색 폼 -->
		<div class="col-12">
		<div class="bg-light rounded h-100 p-4">
				<form action="/sales/PFList" method="GET" style="margin-bottom: 10px;">
				<h6>실적 조회</h6>
				<c:if test="${!empty param.searchBtn }">
				<input type="hidden" name="searchBtn" value="${param.searchBtn}" placeholder="납품처명을 입력하세요">
				</c:if>
				<span style="display:flex;">
				<label style="margin: 5px 10px 0 0;">검색</label>
				<input type="text" name="searchText" placeholder="검색어를 입력하세요" class="form-control fcsearch">
				<label style="margin: 5px 10px 0 0; margin-left:10em;">
				작업지시일자</label>		
				<input type="date" id="startDate" name="startDate" class="form-control fc fcsearch"> &nbsp; ~ &nbsp;
				<input type="date" id="endDate" name="endDate" class="form-control fc fcsearch">
				<input class="btn btn-sm btn-dark m-2 searchmini" type="submit" value="조회" data-toggle="tooltip" title="등록일이 필요합니다!" style="margin-left:2em"></span>
			</form>	
			<form action="POList" method="GET">
					<c:if test="${!empty param.searchBtn }">
						<input type="hidden" name="searchBtn" value="${param.searchBtn}">
					</c:if>
					<c:if test="${!empty param.startDate }">
						<input type="hidden" value="${param.startDate }" name="startDate">
					</c:if>
					<c:if test="${!empty param.endDate }">
						<input type="hidden" value="${param.endDate }" name="endDate">
					</c:if>
				</form>
		</div>
	</div>

	<!-- 작업지시 조회 -->
	<div class="col-12" style="margin-top: 20px;">
		<div class="bg-light rounded h-100 p-4">
			<h6 class="mb-4">실적 관리  <span class="settingPF">[총 ${countPF}건]</span> </h6>

		<div class="col-12">
		<div class="buttonarea1" style="margin-bottom: 10px;">
			<input type="hidden" name="state" value="전체">
			<button type="button" class="btn btn-sm btn-primary" id="allpf">전체</button>
		</div>
		
<script>
    $("#allpf").click(function() {
        location.href = "/sales/PFList";
    });

    function updateTotalCount() {
        var totalCount = $(".table tbody tr:visible").length;
        $(".settingPF").text("총 " + totalCount + "건");
    }

    // 필터링할 때마다 호출하여 업데이트
    function updateRowNumbers() {
        var counter = 1;
        $(".table tbody tr:visible").each(function() {
            $(this).find('td:nth-child(2)').text(counter);
            counter++;
        });

        // 총 건수 업데이트 호출
        updateTotalCount();
    }
</script>
					<input type="hidden" class="btn btn-dark m-2" data-bs-toggle="modal" data-bs-target="#modifyModal" data-bs-whatever="@getbootstrap" value="수정">
			<form role="form" action="/sales/PFList" method="post">
			<div class="table-responsive">
				<div class="table-responsive" style="text-align: center;">
					<table class="table" id="pfTable">
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">지시완료일자</th>
								<th scope="col">작업지시코드</th>
								<th scope="col">납품처</th>
								<th scope="col">제품명</th>
								<th scope="col">지시수량</th>
								<th scope="col">반품수량</th>
								<th scope="col">반품사유</th>
								<th scope="col">담당자</th>
								<c:if test="${sessionScope.membercode eq '1006' or membername eq 'admin'}"> Model model
								<th scope="col">관리</th>
								</c:if>
							</tr>
						</thead>
						<tbody>
							<c:set var="counter" value="1" />
							<c:forEach items="${ AllPFList }" var="pf">
								<tr>
									<td id="workidd" style="display: none;">${pf.workid }</td>
									<td>${counter }</td>
									<td><fmt:formatDate value="${pf.workdate2 }"
											pattern="yyyy-MM-dd" /></td>
									<td>${pf.workcode }</td>
									<td>${pf.clientname}</td>
									<td>${pf.itemname }</td>
									<td>${pf.pocnt }</td>
									<c:choose>
            						<c:when test="${empty pf.returncount}">
               						<td>X</td>
            						</c:when>
            						<c:otherwise>
                					<td>${pf.returncount}</td>
            						</c:otherwise>
        							</c:choose>
									<c:choose>
            						<c:when test="${empty pf.returnreason}">
                					 <td style="font-weight: bold; color: blue;">반품없음</td>
            						</c:when>
            						<c:otherwise>
                					<td style="font-weight: bold; color: red;">${pf.returnreason}</td>
            						</c:otherwise>
        							</c:choose>
									<td>${pf.membername }</td>
									<c:if test="${sessionScope.membercode eq '1006' or membername eq 'admin'}">
									<td>
									<!-- 버튼 수정 -->
									<button type="button" class="btn btn-sm btn-warning"
										onclick="openModifyModal('${pf.workid}', '${pf.workcode }', '${pf.clientname}', '${pf.itemname}', '${pf.pocnt}', '${pf.workdate2}', '${pf.returncount}', '${pf.returnreason}', '${pf.membercode}')">
   										수정
									</button>
									</td>
									</c:if>
								</tr>
								<c:set var="counter" value="${counter+1 }" />
							</c:forEach>

						</tbody>
					</table>
				</div>
			</div>
			</form>
			</div>
			
			
			<!-- 페이지 블럭 생성 -->
			<nav aria-label="Page navigation example">
  				<ul class="pagination justify-content-center">
    				<li class="page-item">
    					<c:if test="${pageVO.prev }">
      						<a class="page-link pageBlockPrev" href="" aria-label="Previous" data-page="${pageVO.startPage - 1}">
        						<span aria-hidden="true">&laquo;</span>
      						</a>
      						
							<!-- 버튼에 파라미터 추가 이동 (이전) -->
							<script>
								$(document).ready(function(){
   									$('.pageBlockPrev').click(function(e) {
   										e.preventDefault(); // 기본 이벤트 제거
   									
   						            	let prevPage = $(this).data('page');
   									
   						            	let searchBtn = "${param.searchBtn}";
   						            	let searchText = "${param.searchText}";
   						            	let startdate = "${param.startdate}";
   						            	let enddate = "${param.enddate}";

   						            	url = "/sales/PFList?page=" + nextPage;

   						            	if (searchBtn) {
   						            	  url += "&searchBtn=" + encodeURIComponent(searchBtn);
   						            	}

   						            	if (searchText) {
   						            	  url += "&searchText=" + encodeURIComponent(searchText);
   						            	}

   						            	if (startdate) {
   						            	  url += "&startdate=" + encodeURIComponent(startdate);
   						            	}

   						            	if (enddate) {
   						            	  url += "&enddate=" + encodeURIComponent(enddate);
   						            	}

   				                		location.href = url;
    								});
								});
							</script>
							<!-- 버튼에 파라미터 추가 이동 (이전) -->
      						
    					</c:if>
    				</li>
					<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1" var="i">
    				<li class="page-item ${pageVO.cri.page == i? 'active' : ''}"><a class="page-link pageBlockNum" href="" data-page="${i}">${i }</a></li>
					
					<!-- 버튼에 파라미터 추가 이동 (번호) -->
					<script>
					$(document).ready(function(){
			            $('.pageBlockNum[data-page="${i}"]').click(function (e) {
			                e.preventDefault(); // 기본 이벤트 방지
			                
			               	let searchText = "${param.searchText}";	
			                let searchBtn = "${param.searchBtn}";
			                let startdate = "${param.startdate}";
			            	let enddate = "${param.enddate}";

			                let pageValue = $(this).data('page');
		                	url = "/sales/PFList?page=" + pageValue;
			                
			                if (searchBtn) {
			                    url += "&searchBtn=" + encodeURIComponent(searchBtn);
			                }
			                
			                if (searchText) {
			                    url += "&searchText=" + encodeURIComponent(searchText);
			                }
			                if (startdate) {
			            	  url += "&startdate=" + encodeURIComponent(startdate);
			            	}

			            	if (enddate) {
			            	  url += "&enddate=" + encodeURIComponent(enddate);
			            	}
			                
			                location.href = url;
			            });
					});	
					</script>
					<!-- 버튼에 파라미터 추가 이동 (번호) -->
					
					</c:forEach>
    				<li class="page-item">
    					<c:if test="${pageVO.next }">
      						<a class="page-link pageBlockNext" href="" aria-label="Next" data-page="${pageVO.endPage + 1}">
        						<span aria-hidden="true">&raquo;</span>
      						</a>	
      					<!-- 버튼에 파라미터 추가 이동 (이후) -->
						<script>
							$(document).ready(function(){
   								$('.pageBlockNext').click(function(e) {
   									e.preventDefault(); // 기본 이벤트 제거
   									
   						            let nextPage = $(this).data('page');
   									
   									let searchBtn = "${param.searchBtn}";
   									let searchText = "${param.searchText}";
   									let startdate = "${param.startdate}";
					            	let enddate = "${param.enddate}";

   				                	url = "/sales/PFList?page=" + nextPage;
   				                
   				                	if (searchBtn) {
   				                    	url += "&searchBtn=" + encodeURIComponent(searchBtn);
   				                	}
   				                
   				                	if (searchText) {
   				                    	url += "&searchText=" + encodeURIComponent(searchText);
   				                	}
   				                	if (startdate) {
					            	  url += "&startdate=" + encodeURIComponent(startdate);
					            	}

					            	if (enddate) {
					            	  url += "&enddate=" + encodeURIComponent(enddate);
					            	}
   				                
   				                	location.href = url;
    							});
							});
						</script>
						<!-- 버튼에 파라미터 추가 이동 (이전) -->  					
    					</c:if>
    				</li>
  				</ul>
			</nav>
			<!-- 페이지 블럭 생성 -->
			</div>
		</div>
</fiedset>

<jsp:include page="modifyPF.jsp"/>



<script>
// 수정된 값을 서버로 전송	
	
									
$("#modifyButton").click(function() {
    // 가져온 값들을 변수에 저장
    var modifiedWorkid = $("#workid3").val();
    var modifiedWorkCode = $("#workcode3").val();
    var modifiedClientName = $("#clientname3").val();
    var modifiedItemName = $("#itemname3").val();
    var modifiedPocnt = $("#pocnt3").val();
    var modifiedWorkdate2 = $("#workdate23").val();
    var modifiedReturnCount = $("#returncount3").val();
    var modifiedReturnReason = $("#returnreason3").val();
    var modifiedMemberCode = $("#membercode3").val();

    // Ajax를 사용하여 서버로 수정된 값 전송
    $.ajax({
        type: "POST",
        url: "/sales/modifyPF",
        data: {
        	 workid: modifiedWorkid,
        	 workcode: modifiedWorkCode,
        	 clientname: modifiedClientName,
             itemname: modifiedItemName,
             pocnt: modifiedPocnt,
             workdate2: modifiedworkdate2,
             returncount: modifiedReturnCount,
             returnreason: modifiedReturnReason,
             membercode: modifiedMemberCode
        },
        success: function(response) {
            console.log("Modification success:", response);
            $("#modifyModal").modal('hide');
        },
        error: function(error) {
            console.error("Error during modification:", error);
        }
    });
});
	   function openModifyModal(workid, workcode, clientname, itemname, pocnt, workdate2, returncount, returnreason, membercode) {

		   console.log('workid', workid);
		   console.log('workcode', workcode);
		   console.log('clientname', clientname);
		   console.log('itemname', itemname);
		   console.log('pocnt', pocnt);
		   console.log('workdate2', workdate2);
		   console.log('returncount', returncount);
		   console.log('returnreason', returnreason);
		   console.log('membercode', membercode);
		   
		   // 가져온 값들을 모달에 설정
		   $("#workid3").val(workid);
		   $("#workcode3").val(workcode);
		    $("#clientname3").val(clientname);
		    $("#itemname3").val(itemname);
		    $("#pocnt3").val(pocnt);
		    $("#workdate23").val(workdate2);
		    $("#returncount3").val(returncount);
		    $("#returnreason3").val(returnreason);
		    $("#membercode3").val(membercode);

		    // 모달 열기
		    $("#modifyModal").modal('show');
		    
		}
	    
	   </script>
	   


<%@ include file="../include/footer.jsp"%>