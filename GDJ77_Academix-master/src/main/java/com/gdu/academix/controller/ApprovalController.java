package com.gdu.academix.controller;

import jakarta.servlet.http.HttpServletRequest;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.academix.service.BbsService;
import com.gdu.academix.service.RequestsService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/requests")
@RequiredArgsConstructor
@Controller
public class ApprovalController {
  
  @Autowired
  private RequestsService requestsService;
  
  @GetMapping("/main.page")
  public String approvalMain() {
    return "requests/main";
  }
  
  @GetMapping("/write.page")
  public String write() {
	  return "requests/write";
  }
  
  @PostMapping("/write.do")
  public String createLeaveRequest(HttpServletRequest request, RedirectAttributes redirectAttributes) {
	  int insertCount = requestsService.createLeaveRequest(request);
	    
	  redirectAttributes.addFlashAttribute("insertCount", insertCount == 1  ? "기안되었습니다." : "기안 되지 않았습니다");
	   
	    return "redirect:/requests/main.page"; // 리디렉션
	}

  @GetMapping(value="/getList.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> getBlogList(HttpServletRequest request) {
    return requestsService.getList(request);
  }
  
  @GetMapping("/detail.do")
  public String detail(@RequestParam int requestNo, Model model) {
     
  }
  
}
