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

  <div>
   종류
   
  </div>
  
  
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
                <label for="name">성명</label>
                <input type="text" name="name" id="name">
            </div>
            <div class="form-group">
                <label for="rankTitle">직책</label>
                <input type="text" name="rankTitle" id="rankTitle">
                <label for="leaveType">휴가종류</label>
                <input type="text" name="leaveType" id="leaveType">
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


<script>

  const fnAttachCheck = () => {
   document.getElementById('files').addEventListener('change', (evt) => {
     const limitPerSize = 1024 * 1024 * 10;
     const limitTotalSize = 1024 * 1024 * 100;
     let totalSize = 0;
     const files = evt.target.files;
     const attachList = document.getElementById('attach-list');
     attachList.innerHTML = '';
     for(let i = 0; i < files.length; i++){
       if(files[i].size > limitPerSize){
         alert('각 첨부 파일의 최대 크기는 10MB입니다.');
         evt.target.value = '';
         attachList.innerHTML = '';
         return;
       }
       totalSize += files[i].size;
       if(totalSize > limitTotalSize){
         alert('전체 첨부 파일의 최대 크기는 100MB입니다.');
         evt.target.value = '';
         attachList.innerHTML = '';
         return;
       }
       attachList.innerHTML += '<div>' + files[i].name + '</div>';
     }
   })
 }
 

 
 
  
  
</script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />