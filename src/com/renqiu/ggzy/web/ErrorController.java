package com.renqiu.ggzy.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/error")
public class ErrorController {
	@RequestMapping(value = "error")
	public ModelAndView error(String errorInfo) {
		ModelAndView view = new ModelAndView("/error/error");
		view.addObject("errorInfo", errorInfo);
		return view;
	}
}
