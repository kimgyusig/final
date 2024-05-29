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
body {
 color:white;
}
  #requestTableBody{
  width: 1000px;
  text-align: center; /* 가로 가운데 정렬 */
        display: flex;
        justify-content: center; /* 세로 가운데 정렬 */
        align-items: center;
        height: 100vh; /* 화면 전체 높이에 따라 가운데 정렬 */
  font-size: 25px;
   margin-left: auto; /* 오른쪽으로 이동 */
  }
</style>
  
  
  
  
  <div><a href="${contextPath}/requests/write.page">기안하기</a></div>
  
  
  
  
  
  <table class="req-list">
  <thead>
    <tr>
      <th>신청서 번호</th>
      <th>기안서 종류</th>
      <th>기안자</th>
      <th>기안일</th>
      <th>결재 상태</th>
    </tr>
  </thead>
  <tbody id="requestTableBody">
    <!-- 데이터를 여기에 추가합니다 -->
  </tbody>
</table>
  
  <script>
   
   var page =1;
   
   
   const RequestsList = ()=>{
	   $.ajax({
		    // 요청
		    type: 'GET',
		    url: '${contextPath}/requests/getList.do',
		    data: 'page=' + page,
		    // 응답
		    dataType: 'json',
		    success: (resData) => {  // resData = {"blogList": [], "totalPage": 10}
		    	totalPage = resData.totalPage;
		      $.each(resData.RequestsList, (i, requests) => {
		    	  console.log(requests);
		    	  let row = '<tr class="requests" data-request-no="' + requests.requestNo + '">';
		          row += '<td>' + requests.requestNo + '</td>';
		          row += '<td>' + requests.requestsSort + '</td>';
		          row += '<td>' + requests.employees.name + '</td>';
		          //row += '<td>' + moment(requests.createDt).format('YYYY.MM.DD') + '</td>';
		          row += '<td>' + requests.requestStatus + '</td>';
		          row += '</tr>';
		          $('#requestTableBody').append(row);
		        
		      })
		    },
		    error: (jqXHR) => {
		      alert(jqXHR.statusText + '(' + jqXHR.status + ')');
		    }
		  });
   }

	var requests = document.getElementsByClassName('requests');
	 for (var i = 0; i < requests.length; i++) {
      requests[i].addEventListener('click', function() {
        // 클릭된 요소에 대한 처리
        
        let requestNo = this.getAttribute('data-request-no');
        location.href = '${contextPath}/requests/detail.do?requestNo=' + requestNo;
    });
}
   RequestsList();
    
    
  </script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />