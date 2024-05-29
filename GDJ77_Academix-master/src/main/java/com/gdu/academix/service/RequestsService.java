package com.gdu.academix.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.gdu.academix.dto.RequestsDto;

import jakarta.servlet.http.HttpServletRequest;

public interface RequestsService {

 
  int createLeaveRequest(HttpServletRequest request);
  ResponseEntity<Map<String, Object>> getList(HttpServletRequest request);
  RequestsDto getRequestsbyNo(int requestNo);
}
