package com.dailyme.dlm.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dailyme.dlm.service.FodService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class FodController {

	@Autowired
	private FodService fodService;
	
	@RequestMapping("/home.do")
	public ModelAndView getIndex() throws JsonProcessingException {
		ModelAndView mv = new ModelAndView("home");
		List<Map<String,Object>> markerList = fodService.selectMarkerList();
		mv.addObject("markerList", new ObjectMapper().writeValueAsString(markerList));
		return mv;
	}
	
	@RequestMapping("/fod/moveLoginPage.do")
	public ModelAndView moveLoginPage() {
		ModelAndView mv = new ModelAndView("cmm/login");
		return mv;
	}
}
