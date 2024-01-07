<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

	<script>
	$(".search").click(function (searchBtnValue) {
	    $.ajax({
	        url: "/sales/POList",
	        type: "GET",
	        data: {
	            searchBtn: searchBtnValue
	        },
	        success: function (data) {
	            $(".table-responsive").html(data);
	        },
	        error: function (error) {
	            console.error("Error fetching data:", error);
	        }
	    });

	    $("form[action='/sales/POList']").submit(function (event) {
	        event.preventDefault(); // 기본 폼 제출 동작 방지

	        // 폼 데이터 수집
	        let formData = {
	            startDate: $("input[name='startDate']").val(),
	            endDate: $("input[name='endDate']").val()
	        };

	        // 선택된 검색 버튼 값이 있으면 추가
	        if ($("input[name='searchBtn']").length > 0) {
	            formData.searchBtn = $("input[name='searchBtn']").val();
	        }

	        // AJAX 요청 수행
	        $.ajax({
	            url: "/sales/POList",
	            type: "GET",
	            data: formData,
	            success: function (data) {
	                // 성공적으로 데이터를 받아왔을 때 처리할 코드
	                $(".table-responsive").html(data);
	            },
	            error: function (error) {
	                console.error("Error fetching data:", error);
	            }
	        });
	    });

	    /* 날짜비교 */
	    const checkDates = function () {
	        const startDateStr = document.getElementById("startDate").value;
	        const endDateStr = document.getElementById("endDate").value;

	        // 둘 다 유효한 날짜 문자열인지 확인
	        if (startDateStr && endDateStr) {
	            const startDate = new Date(startDateStr);
	            const endDate = new Date(endDateStr);

	            if (startDate > endDate) {
	                Swal.fire("종료일은 시작일과 같거나 이후여야 합니다.");
	                document.getElementById("endDate").value = "";
	            }
	        }
	    };

	    // 페이지 로드 시 한 번 실행
	    checkDates();

	    // 날짜 입력 값에서 포커스가 빠져나갈 때 실행
	    $("#startDate, #endDate").on("blur", checkDates);

	    // 툴팁
	    $('[data-toggle="tooltip"]').tooltip();
	});

	
	</script>
	
			<script>
		$("#allpo").click(function() {
		   location.href="/sales/POList";
		});

		$("#stop").click(function () {
		 	console.log("대기 버튼 클릭됨");
			event.preventDefault();
		    location.href="/sales/POList?postate=대기";
		});

		$("#ing").click(function() {
		 console.log("진행 버튼 클릭됨");
		 event.preventDefault();
		 location.href="/sales/POList?postate=진행";
		});

		$("#complete").click(function() {
			console.log("완료 버튼 클릭됨");
			 event.preventDefault();
			 location.href="/sales/POList?postate=완료";
		});

		$("#cancel").click(function() {
			console.log("취소 버튼 클릭됨");
			 event.preventDefault();
			 location.href="/sales/POList?postate=취소";
		});

		function updateTotalCount() {
			var totalCount = $(".table tbody tr:visible").length;
			$(".settingPO").text("총 " + totalCount + "건");
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
		
		<!-- 진행 동작(수주상태 진행으로 변경) -->
	<script>
		$(".ingUpdate").click(function() {
			event.preventDefault();

			var poid = $(this).data("poid");
			var postate = $(this).closest('tr').find('td:nth-child(3)').text(); // 주문 상태 가져오기

			console.log('poid 값:', poid);
			console.log('postate 값:', postate);

			// 주문 상태가 '대기'인 경우만 진행 가능
			if (postate !== '대기') {
				Swal.fire({
					title : '이 주문은 진행할 수 없는 상태입니다.',
					text : '수주상태를 확인해주세요.',
					icon : 'error',
				});
				return;
			}

			Swal.fire({
				title : '수주를 진행하시겠습니까?',
				text : '수주가 진행상태로 업데이트 됩니다.',
				icon : 'warning',
				showCancelButton : true,
				confirmButtonColor : '#3085d6',
				cancelButtonColor : '#d33',
				confirmButtonText : '승인',
				cancelButtonText : '취소',
				reverseButtons : false,
			}).then(function(result) {
				if (result.value) { //승인시
					// Ajax 요청 실행
					$.ajax({
						type : 'POST',
						url : '/sales/ingUpdate',
						data : {
							poid : poid
						},
						success : function(response) {
							console.log('Ajax success:', response);
							location.reload();
						},
						error : function(error) {
							console.error('Error during cancellation:', error);
							Swal.fire('취소에 실패했습니다.', '다시 시도해주세요.', 'error');
						}
					});
				}
			});
		});
	</script>
		
		<!-- 취소 동작(수주상태 취소로 변경) -->
	<script>
		$(".cancelUpdate").click(function() {
			event.preventDefault();

			var poid = $(this).data("poid");
			var postate = $(this).closest('tr').find('td:nth-child(3)').text(); // 주문 상태 가져오기

			console.log('poid 값:', poid);
			console.log('postate 값:', postate);

			// 주문 상태가 '완료'인 경우 취소 불가
			if (postate === '완료') {
				Swal.fire({
					title : '이미 완료된 주문입니다.',
					text : '완료된 상태는 취소할 수 없습니다.',
					icon : 'error',
				});
				return;
			}
			// 주문 상태가 '완료'인 경우 취소 불가
			if (postate === '취소') {
				Swal.fire({
					title : '이미 취소된 주문입니다.',
					icon : 'error',
				});
				return; // 취소할 수 없는 상태이므로 함수 종료
			}

			Swal.fire({
				title : '수주를 취소하시겠습니까?',
				text : '수주가 취소상태로 업데이트 됩니다.',
				icon : 'warning',
				showCancelButton : true,
				confirmButtonColor : '#3085d6',
				cancelButtonColor : '#d33',
				confirmButtonText : '승인',
				cancelButtonText : '취소',
				reverseButtons : false,
			}).then(function(result) {
				if (result.value) { //승인시
					// Ajax 요청 실행
					$.ajax({
						type : 'POST',
						url : '/sales/cancelUpdate',
						data : {
							poid : poid
						},
						success : function(response) {
							console.log('Ajax success:', response);
							location.reload();
						},
						error : function(error) {
							console.error('Error during cancellation:', error);
							Swal.fire('취소에 실패했습니다.', '다시 시도해주세요.', 'error');
						}
					});
				}
			});
		});
	</script>
		
		
		<script>
	/* 리스트 값 수정 모달로 값 전달 */
	function openModifyModal(poid, clientid, itemid, clientname, itemname,
			postate, pocnt, ordersdate, ordersduedate, membercode) {
		console.log('poid:', poid);
		console.log('clientid:', clientid);
		console.log('itemid:', itemid);
		console.log('clientname:', clientname);
		console.log('itemname:', itemname);
		console.log('postate:', postate);
		console.log('pocnt:', pocnt);
		console.log('ordersdate:', ordersdate);
		console.log('ordersduedate:', ordersduedate);
		console.log('membercode:', membercode);

		// 가져온 값들을 모달에 설정
		$("#poid3").val(poid);
		$("#clientid3").val(clientid);
		$("#itemid3").val(itemid);
		$("#clientid2").val(clientname);
		$("#itemid2").val(itemname);
		$("#floatingSelect2").val(postate);
		$("#pocnt2").val(pocnt);
		$("#ordersdate2").val(ordersdate);
		$("#date2").val(ordersduedate);
		$("#membercode2").val(membercode);

		// 모달 열기
		$("#openModifyModal").modal('show');
	}

	/*달력 이전날짜 비활성화*/
	var now_utc = Date.now(); // 현재 날짜를 밀리초로
	var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
	var today = new Date(now_utc - timeOff).toISOString().split("T")[0];

	var clientSM = document.getElementById('clientSM');
	clientSM.addEventListener('show.bs.modal', function(event) {
		var button = event.relatedTarget;
		var recipient = button.getAttribute('data-bs-whatever');
		var modalTitle = clientSM.querySelector('.modal-title');
		var modalBodyInput = clientSM.querySelector('.modal-body input');
	});

	// 납품처 조회 모달
	$(".clientSearch1, .clientSearch2").click(function() {
		$("#clientSM").modal('show');
	});

	// 품목 조회 모달
	$(".itemSearch1, .itemSearch2").click(function() {
		$("#itemSM").modal('show');
	});

	// 클릭한 행의 정보를 가져와서 clientNS와 clientCS에 입력
	$(".clientset").click(function() {
		var clientName = $(this).find('td:eq(0)').text();
		var clientCode = $(this).find('td:eq(1)').text();

		$(".clientNS").val(clientName);
		$(".clientCS").val(clientCode);
	});

	$(".itemset").click(function() {
		var itemName = $(this).find('td:eq(0)').text();
		var itemCode = $(this).find('td:eq(1)').text();

		$(".itemNS").val(itemName);
		$(".itemCS").val(itemCode);
	});

	$("#clibtn").click(function() {
		$(".clientSearch1").val($(".clientNS").val());
		$(".clientSearch2").val($(".clientCS").val());
		$("#clientSM").modal('hide');
	});
	$("#itembtn").click(function() {
		$(".itemSearch1").val($(".itemNS").val());
		$(".itemSearch2").val($(".itemCS").val());
		$("#itemSM").modal('hide');
	});

	$('#todaypo').click(
			function() {
				var today = new Date();
				// 날짜를 YYYY-MM-DD 형식으로 포맷팅
				var formattedDate = today.getFullYear() + '-'
						+ ('0' + (today.getMonth() + 1)).slice(-2) + '-'
						+ ('0' + today.getDate()).slice(-2);
				$('#todaypo').val(formattedDate);
			});

	$("#searchbtn").click(function() {
		// 수주일자
		var podateStart = $("input[name='podateStart']").val();
		var podateEnd = $("input[name='podateEnd']").val();

		// 납품처조회
		var clientCode = $(".clientSearch1").val();
		var clientName = $(".clientSearch2").val();

		// 납품예정일
		var ordersDueDateStart = $("input[name='ordersDueDateStart']").val();
		var ordersDueDateEnd = $("input[name='ordersDueDateEnd']").val();

		// 품목조회
		var itemCode = $(".itemSearch1").val();
		var itemName = $(".itemSearch2").val();

		// Ajax를 사용해 서버로 데이터 전송 및 조회
		$.ajax({
			type : "GET",
			url : "/sales/POList",
			data : {
				podateStart : podateStart,
				podateEnd : podateEnd,
				clientCode : clientCode,
				clientName : clientName,
				ordersDueDateStart : ordersDueDateStart,
				ordersDueDateEnd : ordersDueDateEnd,
				itemCode : itemCode,
				itemName : itemName
			},
			success : function(POList) {
				// 성공 시에 테이블을 생성하고 화면에 표시
				var tableHtml = '<table>';
				for (var i = 0; i < POList.length; i++) {
					tableHtml += '<tr>';
					tableHtml += '<td>' + POList[i].poid + '</td>';
					tableHtml += '<td>' + POList[i].postate + '</td>';
					tableHtml += '<td>' + POList[i].pocode + '</td>';
					tableHtml += '<td>' + POList[i].clientname + '</td>';
					tableHtml += '<td>' + POList[i].itemname + '</td>';
					tableHtml += '<td>' + POList[i].pocnt + '</td>';
					tableHtml += '<td>' + POList[i].ordersdate + '</td>';
					tableHtml += '<td>' + POList[i].updatedate + '</td>';
					tableHtml += '<td>' + POList[i].ordersduedate + '</td>';
					tableHtml += '<td>' + POList[i].membercode + '</td>';
					tableHtml += '</tr>';
				}
				tableHtml += '</table>';

				$("#result").html(tableHtml);
			},
			error : function(error) {
				console.error("Error during search:", error);
			}
		});

	});
</script>