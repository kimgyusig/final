package com.gdu.academix.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.academix.dto.DepartMentsDto;
import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.LeaveRequestDto;
import com.gdu.academix.dto.RanksDto;
import com.gdu.academix.dto.RequestsDto;
import com.gdu.academix.mapper.RequestsMapper;
import com.gdu.academix.utils.MyPageUtils;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class RequestsServiceImpl implements RequestsService {

  @Autowired
  private RequestsMapper requestsMapper;
  @Autowired
  private MyPageUtils myPageUtils;
  
  @Override
  @Transactional
  public int createLeaveRequest(HttpServletRequest request) {
    
	  String departName = request.getParameter("departName");
	    String name = request.getParameter("name");
	    String rankTitle = request.getParameter("rankTitle");
	    String reason = request.getParameter("reason");
	    int employeeNo = Integer.parseInt(request.getParameter("employeeNo"));
	    int picNo = Integer.parseInt(request.getParameter("picNo"));
	    int requestStatus = Integer.parseInt(request.getParameter("requestStatus"));
	    int requestSort = Integer.parseInt(request.getParameter("requestSort"));
	    
	    DepartMentsDto depart = new DepartMentsDto();
	    depart.setName(departName);
	    RanksDto rank = new RanksDto();
	    rank.setTitle(rankTitle);
	    
	    EmployeesDto employees = EmployeesDto.builder()
	                                         .depart(depart)
	                                         .name(name)
	                                         .employeeNo(employeeNo)
	                                         .rank(rank)
	                                         
	                                         .build();
	    RequestsDto requests = RequestsDto.builder()
	                                      .employees(employees)
	                                      .requestSort(requestSort)
	                                      .reason(reason)
	                                      .picNo(picNo)
	                                      .requestStatus(requestStatus)
	                                      .build();
	    
	    
	    int duration = Integer.parseInt(request.getParameter("duration"));
	    String startDateString = request.getParameter("startDate");
	    String endDateString = request.getParameter("endDate");
	    int leaveType = Integer.parseInt(request.getParameter("leaveType"));

	    LocalDate startDate = LocalDate.parse(startDateString);
	    LocalDate endDate = LocalDate.parse(endDateString);

	    // LocalDate를 SQL Date로 변환
	    Date sqlStartDate = Date.valueOf(startDate);
	    Date sqlEndDate = Date.valueOf(endDate);

	    LeaveRequestDto leaveRequest = LeaveRequestDto.builder()
	                                                  .requests(requests)
	                                                  .startDate(sqlStartDate)
	                                                  .endDate(sqlEndDate)
	                                                  .duration(duration)
	                                                  .leaveType(leaveType)
	                                                  .build();
	    
	    int insertCount = requestsMapper.insertRequest(requests);
	    int requestNo = requests.getRequestNo(); // 요청에서 requestNo 가져오기
	    leaveRequest.getRequests().setRequestNo(requestNo); // LeaveRequestDto에 설정
	     insertCount += requestsMapper.insertLeaveRequest(leaveRequest);
	    
	    
	    return insertCount;
  }
  
 
  @Override
	public ResponseEntity<Map<String, Object>> getList(HttpServletRequest request) {
	
	  // 전체 블로그 개수
	    int total = requestsMapper.getRequestsCount();
	    
	 // 스크롤 이벤트마다 가져갈 목록 개수
	    int display = 10;
	    
	    // 현재 페이지 번호
	    int page = Integer.parseInt(request.getParameter("page"));
	    
	    // 페이징 처리
	      myPageUtils.setPaging(total, display, page);
	      
	   // 목록 가져올 때 전달할 Map 생성
	      Map<String, Object> map = Map.of("begin" , myPageUtils.getBegin()
	                                     , "end", myPageUtils.getEnd());
	      
	      // 목록 화면으로 반환할 값 (목록 + 전체 페이지 수)
	      return new ResponseEntity<>(Map .of("RequestsList", requestsMapper.getList(map)
	                                        , "totalPage", myPageUtils.getTotalPage())
	                                , HttpStatus.OK);
	}
  
  @Override
	public RequestsDto getRequestsbyNo(int requestNo) {
		
		return null;
	}
  

}
