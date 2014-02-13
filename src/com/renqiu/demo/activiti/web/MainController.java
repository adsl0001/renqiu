package com.renqiu.demo.activiti.web;

import java.text.NumberFormat;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RuntimeService;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.renqiu.ggzy.util.NumberUtil;

/**
 * 首页控制器
 * 
 * @author HenryYan
 */
@Controller
@RequestMapping("/main")
public class MainController {
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	protected HistoryService historyService;
	private static final String processDefKey = "renqiu_szyzsq";

	@RequestMapping(value = "/index")
	public String index() {
		return "/main/index";
	}

	@RequestMapping(value = "/welcome")
	public ModelAndView welcome() {

		ModelAndView view = new ModelAndView("/main/welcome");
		long bjl = 0;
		long running = 0;
		long all = 0;
		long finished = 0;
		running = runtimeService.createProcessInstanceQuery()
				.processDefinitionKey(this.processDefKey).active().count();
		finished = historyService.createHistoricProcessInstanceQuery()
				.processDefinitionKey(processDefKey).finished().count();
		all = running + finished;
		bjl = finished;
		double bjlv = all != 0 ? NumberUtil.round(finished / all * 100, 3) : 0;
		view.addObject("bjl", bjl);
		view.addObject("bjlv", bjlv);
		view.addObject("running", running);
		view.addObject("all", all);
		return view;
	}

}
