<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>





<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="전자결재" name="title"/>
 </jsp:include>

<style>

 .requests-wrapper {
    width: 80%;
    margin: 0 auto;
    border: 1px solid #000;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    color: black;
}

.header-wrapper {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 2px solid #000;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.title h1 {
    margin: 0;
}

.title-right {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
}

.title-right span {
    font-weight: bold;
    margin-bottom: 5px;
}

.dept-approval {
    border: 1px solid #000;
    padding: 5px 10px;
}

.form-group {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.form-group label {
    flex: 1;
    margin-right: 10px;
    text-align: right;
    line-height: 2.5;
}

.form-group input {
    flex: 3;
    padding: 5px;
}

.reason input {
    width: 100%;
}

.period input {
    width: calc(50% - 10px);
    margin-right: 20px;
}

button {
    display: block;
    width: 100%;
    padding: 10px;
    background-color: #007BFF;
    color: #fff;
    border: none;
    cursor: pointer;
}

button:hover {
    background-color: #0056b3;
}

</style>

  <div class="content-wrapper">
  
   
  
  
  
  <form action="${contextPath}/requests/write.do" method="POST">
        <div class="requests-wrapper">
            <div class="header-wrapper">
                <div class="title">
                    <h1>연차 신청서</h1>
                </div>
                <div class="title-right">
                    <span>결재</span>
                    <div class="dept-approval">
                        <span>인사과</span>
                    </div>
                    <div class="stamp-box">
                        <span>결재 도장</span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="departName">부서명</label>
                <input type="text" name="departName" id="departName">
            </div>
            <div class="form-group">
                <label for="name">성명</label>
                <input type="text" name="name" id="name">
            </div>
            <div class="form-group">
                <label for="rankTitle">직책</label>
                <input type="text" name="rankTitle" id="rankTitle">
            </div>
            <div class="form-group">
                <label for="all-day">연차</label>
                <input type="radio" name="leaveType" id="all-day" value="0">
                <label for="half-day">반차</label>
                <input type="radio" name="leaveType" id="half-day" value="1">
            </div>
            <div class="form-group reason">
                <label for="reason">사유</label>
                <input type="text" name="reason" id="reason">
            </div>
            <div class="form-group period">
                <label for="startDate">시작일</label>
		        <input type="text" name="startDate" id="startDate">
		        <label for="endDate">종료일</label>
		        <input type="text" name="endDate" id="endDate">
		        <label for="duration">기간</label>
		        <input type="text" name="duration" id="duration">
		        <label for="employeeNo">사원번호</label>
            <input type="text" name="employeeNo" id="employeeNo">
            </div>
            <button type="submit">기안하기</button>
        </div>
        <!--<input type="hidden" name="employeeNo" value="1"> -->
        <input type="hidden" name="picNo" value="0">
        <input type="hidden" name="requestStatus" value="0">
        <input type="hidden" name="requestSort" value="1">
    </form>



</div>
<script>

  
// 폼 제출 이벤트 리스너를 추가합니다.
document.querySelector('form').addEventListener('submit', function(event) {
    // 휴가종류 필드의 값을 가져옵니다.
    var leaveTypeValue = document.getElementById('leaveType').value;
    
    // 만약 휴가종류가 "연차"라면
    if (leaveTypeValue === "연차") {
        // 해당 필드의 값을 "0"으로 변경합니다.
        document.getElementById('leaveType').value = "0";
    }
    // 만약 휴가종류가 "반차"라면
    else if (leaveTypeValue === "반차") {
        // 해당 필드의 값을 "1"으로 변경합니다.
        document.getElementById('leaveType').value = "1";
    }
    // 그 외의 경우에는 아무 작업도 하지 않습니다.
});
 
 
 
$(document).ready(function () {
    $.datepicker.setDefaults($.datepicker.regional['ko']); 
    $( "#startDate" ).datepicker({
         changeMonth: true, 
         changeYear: true,
         nextText: '다음 달',
         prevText: '이전 달', 
         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         dateFormat: "yy-mm-dd",
         maxDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
         onClose: function( selectedDate ) {    
              //시작일(startDate) datepicker가 닫힐때
              //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
             $("#endDate").datepicker( "option", "minDate", selectedDate );
         }    

    });
    $( "#endDate" ).datepicker({
         changeMonth: true, 
         changeYear: true,
         nextText: '다음 달',
         prevText: '이전 달', 
         dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
         dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
         monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
         dateFormat: "yy-mm-dd",
         maxDate: 0,                       // 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
         onClose: function( selectedDate ) {    
             // 종료일(endDate) datepicker가 닫힐때
             // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
             $("#startDate").datepicker( "option", "maxDate", selectedDate );
         }    

    });    
});
 
 
/* $(document).ready(function() {
    // 휴가종류 입력란이 변경될 때마다 실행되는 이벤트 핸들러
    $("#leaveType").change(function() {
        // 선택된 휴가종류 값을 가져옴
        var leaveType = $(this).val();
        
        // 휴가종류가 '연차'인 경우
        if (leaveType === '연차') {
            // 휴가종류 입력란의 값을 0으로 설정 (연차의 경우)
            $("input[name='leaveType']").val("0");
        }
        // 휴가종류가 '반차'인 경우
        else if (leaveType === '반차') {
            // 휴가종류 입력란의 값을 1으로 설정 (반차의 경우)
            $("input[name='leaveType']").val("1");
        }
        // 이 외의 경우 (예: 다른 휴가종류)
        else {
            // 특별한 동작 없음
            // 원하는 경우 다른 휴가종류에 대한 처리를 여기에 추가할 수 있습니다.
        }
    });
}); */
 
 
  
  
</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />