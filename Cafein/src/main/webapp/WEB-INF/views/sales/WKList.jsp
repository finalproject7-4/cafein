<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ include file="../include/header.jsp"%>

<form method="post">
	<!-- 검색 폼 -->
	<div class="col-12" style="margin-top: 20px;">
		<div class="bg-light rounded h-100 p-4">
			<h6 class="mb-4">작업지시 조회</h6>

			작업 지시 코드: <input type="text" name="poname" class="m-2"> 수주
			코드: <input type="text" name="poname" class="m-2">


			<!-- 달력 -->

			작업 지시 기간 : <input type="text" class="m-2" id="datepicker1"
				name="startDate"> ~ <input type="text" class="m-2"
				id="datepicker2" name="endDate">
			<!-- 달력 -->
			<!-- Date: <input type="text" id="datepicker3" name="startDate">
~  <input type="text" id="datepicker4" name="endDate"> -->
			<button type="submit" class="btn btn-dark m-2">조회</button>

		</div>
	</div>

	<!-- 작업지시 조회 -->
	<div class="col-12" style="margin-top: 20px;">
		<div class="bg-light rounded h-100 p-4">
			<h6 class="mb-4">작업 지시 관리</h6>

			<div class="btn-group" role="group">
				<form role="form">
					<input type="hidden" name="state" value="대기">
					<button type="button" class="btn btn-outline-secondary"
						id="beforepro">대기</button>
				</form>
				<form role="form1">
					<input type="hidden" name="state" value="생산중">
					<button type="button" class="btn btn-outline-secondary" id="ingpro">진행</button>
				</form>
				<form role="form2">
					<input type="hidden" name="state" value="완료">
					<button type="button" class="btn btn-outline-secondary"
						id="completpro">완료</button>
				</form>
			</div>
			<span id="buttonset1"><button type="button"
					class="btn btn-dark m-2" data-bs-toggle="modal"
					data-bs-target="#registModal" data-bs-whatever="@getbootstrap">신규
					등록</button></span>
					<input type="hidden" class="btn btn-dark m-2" data-bs-toggle="modal" data-bs-target="#modifyModal" data-bs-whatever="@getbootstrap" value="수정">
			<div class="table-responsive">
				<div class="table-responsive" style="text-align: center;">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">No.</th>
								<th scope="col">작업지시일</th>
								<th scope="col">작업지시코드</th>
								<th scope="col">수주코드</th>
								<th scope="col">라인명</th>
								<th scope="col">제품명</th>
								<th scope="col">지시상태</th>
								<th scope="col">지시수량</th>
								<th scope="col">수정일자</th>
								<th scope="col">완료일자</th>
								<th scope="col">담당자</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach items="${ AllWKList }" var="wk">
								<tr>
									<td>${wk.workid }</td>
									<td><fmt:formatDate value="${wk.workdate1 }"
											pattern="yyyy-MM-dd" /></td>
									<td>${wk.workcode }</td>
									<td>${wk.pocode }</td>
									<td>${wk.produceline }</td>
									<td>${wk.itemname }</td>
									<td>${wk.worksts }</td>
									<td>${wk.pocnt }</td>
									<td><fmt:formatDate value="${wk.workupdate }"
											pattern="yyyy-MM-dd" /></td>
									<td><fmt:formatDate value="${wk.workdate2 }"
											pattern="yyyy-MM-dd" /></td>
									<td>${wk.membercode }</td>
									<td>
									<!-- 버튼 수정 -->
									<button type="button" class="btn btn-outline-dark"
									        onclick="openModifyModal('${wk.pocode}, ${wk.clientname}', '${wk.itemname}', '${wk.worksts}', '${wk.pocnt}', '${wk.workdate1}', '${wk.workupdate}', '${wk.membercode}')">
									        수정
									</button>
									</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
				</div>
			</div>
			</div>
		</div>
		
		<jsp:include page="registWK.jsp"/>
		<jsp:include page="modifyWK.jsp"/>
</form>

<script>
	   
	   function openModifyModal(pocode, clientname, itemname, worksts, pocnt, workdate1, workupdate, membercode) {
		   console.log('Pocode:', Pocode);
		   console.log('Client Name:', clientname);
	       console.log('Item Name:', itemname);
	       console.log('Worksts:', worksts);
	       console.log('Pocnt:', pocnt);
	       console.log('Work date1:', workdate1);
	       console.log('Work Update:', workupdate);
	       console.log('Member Code:', membercode); 
		   
		   // 가져온 값들을 모달에 설정
		    $("#pocode2").val(pocode2);
		    $("#clientid2").val(clientname);
		    $("#itemid2").val(itemname);
		    $("#worksts2").val(worksts);
		    $("#pocnt2").val(pocnt);
		    $("#workdate11").val(workdate1);
		    $("#workupdate2").val(workupdate);
		    $("#membercode2").val(membercode);

		    // 모달 열기
		    $("#modifyModal").modal('show');
		    
		    // 수정된 값을 서버로 전송
		    $("#modifyButton").click(function() {
		        // 가져온 값들을 변수에 저장
		        var modifiedPocode = $("#pocode2").val();
		        var modifiedClientName = $("#clientid2").val();
		        var modifiedItemName = $("#itemid2").val();
		        var modifiedWorksts = $("#worksts2").val();
		        var modifiedPocnt = $("#pocnt2").val();
		        var modifiedWorkdate1 = $("#workdate11").val();
		        var modifiedWorkupdate = $("#workupdate2").val();
		        var modifiedMemberCode = $("#membercode2").val();

		        // Ajax를 사용하여 서버로 수정된 값 전송
		        $.ajax({
		            type: "POST",
		            url: "/sales/modifyWK",
		            data: {
		            	pocode: modifiedPocode,
		            	 clientname: modifiedClientName,
		                 itemname: modifiedItemName,
		                 worksts: modifiedWorksts,
		                 pocnt: modifiedPocnt,
		                 workdate1: modifiedworkDate1,
		                 workupdate: modifiedWorkupDate,
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
		}
	   </script>


<%@ include file="../include/footer.jsp"%>