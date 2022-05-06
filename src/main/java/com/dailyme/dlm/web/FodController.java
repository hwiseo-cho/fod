package com.dailyme.dlm.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dailyme.dlm.service.FodService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class FodController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(FodController.class);

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
	
	@RequestMapping("/fod/moveLoginrePage.do")
	public ModelAndView moveLoginrePage() {
		ModelAndView mv = new ModelAndView("cmm/login");
		return mv;
	}
	
}
