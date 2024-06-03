<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>


<jsp:include page="${contextPath}/WEB-INF/views/layout/header.jsp">
   <jsp:param value="전자결재" name="title"/>
 </jsp:include>

<style>

  table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
            vertical-align: top;
        }
        th {
            background-color: #f2f2f2;
        }
        .section-title {
            background-color: #f2f2f2;
            text-align: center;
        }
        .split-cell {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .left {
            width: 50%;
            text-align: left;
        }
        .right {
            width: 50%;
            text-align: right;
        }
   input {
            border: none;
            width: 100%;  /* 부모 요소의 크기와 동일하게 설정 */
            box-sizing: border-box;  /* padding, border를 width에 포함시킴 */
        }
        textarea {
            width: 100%;
            box-sizing: border-box;
        }

</style>
  
  

  
 <div class="content-wrapper">
  <form id="frm-btn" method="POST">  
        <input type="hidden" name="requestNo" value="${leaveRequests.requests.requestNo}">
        <button type="button" id="btn-edit" class="btn btn-warning btn-sm">편집</button>
        <button type="button" id="btn-remove" class="btn btn-danger btn-sm">삭제</button>
      </form>
   <div class="start" data-set-employee-no="${leaveRequests.requests.employees.employeeNo}">
    
  ${leaveRequests.requests.requestNo}
     <h2>연차 신청서</h2>
    <form action="${contextPath}/requests/requestModify.do" method="post"
          id="frm-requests-modify" onsubmit="submitFormWithApproval()">
          <div>
     <button type="submit" id="btn-approval">승인</button>
     <button type="button" id="" onclick="rejectRequest()">반려</button>
    </div>
        <table>
            <tr>
                <td colspan="2">결재</td>
                <td colspan="2" class="split-cell">
                    <div class="left">인사과</div>
                    <div class="right"></div> <!-- 빈 칸 추가 -->
                </td>
            </tr>
            <tr>
                <th class="section-title" colspan="1">부서명</th>
                <td colspan="3">${leaveRequests.requests.employees.depart.departName}</td>
            </tr>
            <tr>
                <th class="section-title" colspan="1">성명</th>
                <td colspan="3">${leaveRequests.requests.employees.name}</td>
            </tr>
            <tr>
                <th class="section-title" colspan="1">직책</th>
                <td colspan="3">${leaveRequests.requests.employees.rank.rankTitle}</td>
            </tr>
            <tr>
                <th class="section-title" colspan="1">휴가 종류</th>
                <td colspan="3">
                 <c:choose>
                <c:when test="${leaveRequests.leaveType eq '0'}">
					        연차
					    </c:when>
                <c:when test="${leaveRequests.leaveType eq '1'}">
					        반차
					    </c:when>
			   </c:choose>
                </td>
            </tr>
            <tr>
                <th class="section-title" colspan="4">사유</th>
            </tr>
            <tr>
                <td colspan="4"><textarea name="reason" rows="5" required>${leaveRequests.requests.reason}</textarea></td>
            </tr>
            <tr>
                <th class="section-title" colspan="4">기간</th>
            </tr>
            <tr>
                <td>0000년 <input type="text" name="startYear" size="4" required>년 <input type="text" name="startMonth" size="2" required>월 <input type="text" name="startDay" size="2" required>일 부터</td>
                <td>0000년 <input type="text" name="endYear" size="4" required>년 <input type="text" name="endMonth" size="2" required>월 <input type="text" name="endDay" size="2" required>일 까지</td>
                <td colspan="2">(<input type="text" name="days" size="2" required> 일간)</td>
                <input type="hidden" name="picNo" value="0">
                <input type="hidden" name="requestStatus" value="0">
                <input type="hidden" name="requestSort" value="1">
                   <label for="employeeNo">사원번호</label>
            ${leaveRequests.requests.employees.employeeNo}
            </tr>
        </table>
        <div style="text-align: center; margin-top: 20px;">
            
        </div>
    </form>
    
   
   </div>
  
 </div>
  
  <script>
   
   function submitFormWithApproval() {
        // requestStatus 필드의 값을 1로 변경
        document.getElementById("requestStatus").value = "1";
    }
    
     function rejectRequest() {
        // requestStatus 필드의 값을 2로 변경
        document.getElementById("requestStatus").value = "2";
    }
    
     var frmBtn = document.getElementById('frm-btn');
     
     const fnRemoveRequest = () => {
    		document.getElementById('btn-remove').addEventListener('click', (evt) => {
    			if(confirm('해당 게시글을 삭제할까요?')){
    	      frmBtn.action = '${contextPath}/requests/removeRequest.do';
    	      frmBtn.submit();
    			}
    	  })
    	}

     fnRemoveRequest();
     
     
  </script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />