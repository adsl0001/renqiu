package com.renqiu.ggzy.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.activiti.engine.ActivitiException;
import org.activiti.engine.HistoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstanceQuery;
import org.activiti.engine.identity.User;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.activiti.engine.task.Task;
import org.activiti.spring.annotations.TaskId;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.renqiu.demo.activiti.entity.oa.Leave;
import com.renqiu.demo.activiti.service.oa.leave.LeaveManager;
import com.renqiu.demo.activiti.service.oa.leave.LeaveWorkflowService;
import com.renqiu.demo.activiti.util.Page;
import com.renqiu.demo.activiti.util.PageUtil;
import com.renqiu.demo.activiti.util.UserUtil;
import com.renqiu.demo.activiti.util.Variable;
import com.renqiu.ggzy.entity.Szyzsq;
import com.renqiu.ggzy.service.SzyzsqManager;
import com.renqiu.ggzy.util.DateUtil;
import com.renqiu.ggzy.util.NumberUtil;

@Controller
@RequestMapping(value = "/query")
public class QueryController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	protected SzyzsqManager szyzsqManager;

	@Autowired
	protected TaskService taskService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	protected HistoryService historyService;
	private static final String processDefKey = "renqiu_szyzsq";

	// @RequestMapping(value={"queryProcessInfo"})
	// public ModelAndView queryProcessInfo()
	// {
	// ModelAndView view = new ModelAndView("query/queryProcessInfo");
	// return view ;
	// }
	@RequestMapping(value = { "queryProcessInfo" })
	public ModelAndView queryProcessInfo(
			@RequestParam(value = "startTime", required = false) String startTime,
			@RequestParam(value = "endTime", required = false) String endTime) {
		ModelAndView view = new ModelAndView("query/queryProcessInfo");
		long bjl = 0;
		long running = 0;
		long all = 0;
		long finished = 0;
		long unfinished = 0;
		ProcessInstanceQuery processInstanceQuery = runtimeService
				.createProcessInstanceQuery();
		processInstanceQuery = processInstanceQuery.processDefinitionKey(
				this.processDefKey).active();
		HistoricProcessInstanceQuery finishedHistoricProcessInstanceQuery = historyService
				.createHistoricProcessInstanceQuery();
		HistoricProcessInstanceQuery unfinishedHistoricProcessInstanceQuery = historyService
				.createHistoricProcessInstanceQuery();
		finishedHistoricProcessInstanceQuery = finishedHistoricProcessInstanceQuery
				.processDefinitionKey(processDefKey).finished();
		unfinishedHistoricProcessInstanceQuery = unfinishedHistoricProcessInstanceQuery
				.processDefinitionKey(processDefKey).unfinished();
		Date startDate = null;
		if (StringUtils.isNotBlank(startTime)) {
			startDate = DateUtil.convertStringToDate(startTime,
					DateUtil.STANDARD_DATE_FORMAT, null);
			if (startDate != null) {
				finishedHistoricProcessInstanceQuery = finishedHistoricProcessInstanceQuery
						.finishedAfter(startDate);
				unfinishedHistoricProcessInstanceQuery = unfinishedHistoricProcessInstanceQuery
						.finishedAfter(startDate);
			}
		}
		Date endDate = null;
		if (StringUtils.isNotBlank(endTime)) {
			endDate = DateUtil.convertStringToDate(endTime,
					DateUtil.STANDARD_DATE_FORMAT, null);
			if (endDate != null) {
				finishedHistoricProcessInstanceQuery = finishedHistoricProcessInstanceQuery
						.finishedBefore(endDate);
				unfinishedHistoricProcessInstanceQuery = unfinishedHistoricProcessInstanceQuery
						.finishedBefore(endDate);
			}

		}
		running = processInstanceQuery.processDefinitionKey(this.processDefKey)
				.active().count();
		finished = finishedHistoricProcessInstanceQuery.count();
		unfinished = unfinishedHistoricProcessInstanceQuery.count();
		all = unfinished + finished;
		bjl = finished;
		double bjlv = all != 0 ? NumberUtil.round((double)(finished) / all * 100, 3) : 0;
		view.addObject("bjl", bjl);
		view.addObject("bjlv", bjlv);
		view.addObject("running", running);
		view.addObject("all", all);
		view.addObject("startTime", DateUtil.getDateFormatString(startDate,
				DateUtil.STANDARD_DATE_FORMAT));
		view.addObject("endTime", DateUtil.getDateFormatString(endDate,
				DateUtil.STANDARD_DATE_FORMAT));
		return view;
	}

	/**
	 * 公示信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "public")
	public ModelAndView publicInfo() {
		ModelAndView modelAndView = new ModelAndView("query/public");
		
		return modelAndView;

	}

}
