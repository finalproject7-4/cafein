<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
		
		<script>
function receiptSend(poid) {
    $.ajax({
        url: '/sales/receipt',  // 서버에서 데이터를 가져올 URL
        type: 'GET',
        data: { poid: poid },  // poid 값을 서버에 전달
        success: function() {

            // 예시: 새로운 페이지로 이동
            location.href = "/sales/receipt?poid=" + encodeURIComponent(poid);
        },
        error: function() {
            console.error('Error fetching receipt information');
        }
    });
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
	<!-- 진행 동작(수주상태 취소로 변경) -->
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
	