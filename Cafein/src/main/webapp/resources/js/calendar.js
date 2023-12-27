/**
 * 달력 기능 팝업
 */

 $(function() {
	 
<<<<<<< HEAD
	 //========================== 지시 조회 달력 시작 (start, end) 사용XXXX ============================
=======
>>>>>>> ymi
	 	//=============startDate 선택=====================
	 
       //input을 datepicker로 선언
       $("#datepicker1").datepicker({
           dateFormat: 'yy-MM-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능                
           ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
           ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
           ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
           ,buttonText: "선택" //버튼 호버 텍스트              
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           //,minDate: 0
           
           ,beforeShowDay: function(date){       
        	   /* 일요일만 선택 불가 */      
        	   return [(date.getDay() != 0)]; }

       });  
   
       //초기값을 설정
       $('#datepicker1').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
   		
       // =====================endDate 선택=========================
       
       $("#datepicker2").datepicker({
           dateFormat: 'yy-MM-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능                
           ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
           ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
           ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
           ,buttonText: "선택" //버튼 호버 텍스트              
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           //,minDate: // startDate가 선택된 날짜부터
           
           ,beforeShowDay: function(date){       
        	   /* 일요일만 선택 불가 */      
        	   return [(date.getDay() != 0)]; }

       });  
       
       $('#datepicker1').datepicker("option", "onClose", function ( selectedDate ) {
           $("#datepicker2").datepicker( "option", "minDate", selectedDate );
       }); // 시작일 선택날부터 종료일 선택 가능. 시작일보다 과거 날짜는 선택 불가.
       
       //초기값을 설정
       $('#datepicker2').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
       
      // ================================================================================================== 
       // 모달창 달력
       $("#datepicker3").datepicker({
           dateFormat: 'yy-MM-dd' //달력 날짜 형태
           ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
           ,showMonthAfterYear:true // 월- 년 순서가아닌 년도 - 월 순서
           ,changeYear: true //option값 년 선택 가능
           ,changeMonth: true //option값  월 선택 가능                
           ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
           ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
           ,buttonImageOnly: true //버튼 이미지만 깔끔하게 보이게함
           ,buttonText: "선택" //버튼 호버 텍스트              
           ,yearSuffix: "년" //달력의 년도 부분 뒤 텍스트
           ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
           ,monthNames: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 Tooltip
           ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
           ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 Tooltip
           ,minDate: 0 // today부터
           
           ,beforeShowDay: function(date){       
        	   /* 일요일만 선택 불가 */      
        	   return [(date.getDay() != 0)]; }

       });  
       
       //========================= 모달창 달력 시작 ==========================================
       
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
     
   })(jQuery);