/**
 * 달력 기능 팝업
 */

 $(function() {

       // 새로운 조회 달력 설정 (사용)
    // startDate와 endDate input 요소 가져오기
       const startDateInput = document.getElementById('startDate');
       const endDateInput = document.getElementById('endDate');

       // startDate가 변경될 때의 이벤트 핸들러
       startDateInput.addEventListener('change', function() {
           // 선택된 startDate 값 가져오기
           const selectedStartDate = new Date(startDateInput.value);
           
           // 만약 startDate가 선택되지 않았다면 종료
           if (!selectedStartDate) {
               return;
           }

           // endDate의 최소 날짜를 선택된 startDate로 설정
           endDateInput.min = startDateInput.value;

           // endDate가 선택된 startDate 이전의 날짜를 선택하지 못하도록 설정
           const selectedEndDate = new Date(endDateInput.value);
           if (selectedEndDate < selectedStartDate) {
               endDateInput.value = startDateInput.value;
           }
       });
       
       /*모달창 달력 이전날짜 비활성화*/
   		var now_utc = Date.now(); // 현재 날짜를 밀리초로
   		var timeOff = new Date().getTimezoneOffset() * 60000; // 분 단위를 밀리초로 변환
   		var today = new Date(now_utc - timeOff).toISOString().split("T")[0];
   	
   		// class="date"인 모든 요소에 날짜 비활성화
   		document.querySelectorAll('.date').forEach(function(input) {
   			input.setAttribute('min', today);
   		});
       
       
     
   });