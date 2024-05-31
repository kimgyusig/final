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

  #requestTableBody{
  
  }
</style>
  
  
  
  <div class="content-wrapper">
  
  
  
  
  
  
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
  
 </div>
  
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
		          row += '<td>' + requests.requestSort + '</td>';
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

   
    
    const fnPostDetail = () => {
      
      $(document).on('click', '.requests', (evt) => {
          // 클릭된 요소로부터 가장 가까운 '.post' 클래스 요소를 찾음
          const $requests = $(evt.target).closest('.requests');
  
          // .post 요소에서 데이터셋을 읽음
          const requestNo = $requests.data('requestNo');
          
      
       
              location.href = '${contextPath}/requests/detail.do?requestNo=' + requestNo;
         
      })
    }
    
    RequestsList();
    fnPostDetail();
    
  </script>

<jsp:include page="${contextPath}/WEB-INF/views/layout/footer.jsp" />