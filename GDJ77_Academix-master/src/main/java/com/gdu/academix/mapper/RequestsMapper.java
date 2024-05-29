package com.gdu.academix.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.academix.dto.LeaveRequestDto;
import com.gdu.academix.dto.RequestAttachDto;
import com.gdu.academix.dto.RequestsDto;

@Mapper
public interface RequestsMapper {

  int insertRequest(RequestsDto requests);
  int insertLeaveRequest(LeaveRequestDto leaveRequest);
  List<RequestsDto>getList(Map<String, Object> map);
  int getRequestsCount();
  RequestsDto getRequestsbyNo(int requestNo);
}