package com.dailyme.dlm.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dailyme.dlm.config.Configuration;

@Controller
public class welcomeController {

	@RequestMapping("/home.do")
	public String getIndex() {
		return "home";
	}
}
