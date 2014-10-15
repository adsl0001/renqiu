package com.renqiu.ggzy.web;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.identity.User;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.renqiu.demo.activiti.util.UserUtil;
import com.renqiu.ggzy.entity.TestModel;
import com.renqiu.ggzy.service.TestModelManager;
import com.renqiu.ggzy.util.DateUtil;
import com.renqiu.ggzy.vo.Comment;

@Controller
@RequestMapping(value = "/test")
public class TestController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	protected TaskService taskService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	protected HistoryService historyService;
	@Autowired
	TestModelManager testModelManager;
	@Autowired
	private IdentityService identityService;

	/**
	 * 公示页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "shenqing")
	public ModelAndView shenqing(HttpSession session, HttpServletRequest request) {
		User user = UserUtil.getUserFromSession(session);
		TestModel testModel = this.testModelManager.start(user.getId());
		ProcessInstance processInstance = runtimeService
				.createProcessInstanceQuery()
				.processInstanceBusinessKey(String.valueOf(testModel.getId()))
				.singleResult();
		Task task = taskService.createTaskQuery()
				.processInstanceId(processInstance.getId()).singleResult();
		List<Comment> comments = new ArrayList<Comment>();
		ModelAndView modelAndView = new ModelAndView("test/view");
		modelAndView.addObject("testModel", testModel);
		modelAndView.addObject("task", task);
		modelAndView.addObject("commentList", comments);
		return modelAndView;
	}
	@RequestMapping("shenhe")
	public ModelAndView shenhe(String taskId) {
		Task task = this.taskService.createTaskQuery().taskId(taskId)
				.singleResult();
		ProcessInstance processInstance = this.runtimeService
				.createProcessInstanceQuery()
				.processInstanceId(task.getProcessInstanceId()).singleResult();
		// processInstance.getBusinessKey()
		TestModel testModel = this.testModelManager.findById(processInstance
				.getBusinessKey());
		List<org.activiti.engine.task.Comment> comments = taskService
				.getProcessInstanceComments(processInstance.getId());
		List<Comment> myCommentList = new ArrayList<Comment>();
		for (org.activiti.engine.task.Comment comment : comments) {
			myCommentList.add(createComment(comment));
		}
		ModelAndView modelAndView = new ModelAndView("test/view");
		modelAndView.addObject("testModel", testModel);
		modelAndView.addObject("task", task);
		modelAndView.addObject("commentList", myCommentList);
		return modelAndView;
	}
	private Comment createComment(org.activiti.engine.task.Comment comment) {
		Comment temp = new Comment();
		temp.setId(comment.getId());
		temp.setFullMessage(comment.getFullMessage());
		temp.setProcessInstanceId(comment.getProcessInstanceId());
		temp.setTaskId(comment.getTaskId());
		temp.setTime(DateUtil.getDateFormatString(comment.getTime(),
				DateUtil.STANDARD_DATETIME_FORMAT));
		temp.setType(comment.getType());
		temp.setUserId(comment.getUserId());
		if (!StringUtils.isBlank(temp.getUserId())) {
			User user = identityService.createUserQuery()
					.userId(temp.getUserId()).singleResult();
			temp.setUserName(user.getLastName() + user.getFirstName());
		}
		String taskName = historyService.createHistoricTaskInstanceQuery()
				.taskId(temp.getTaskId()).singleResult().getName();
		temp.setTaskName(taskName);
		return temp;
	}
	@RequestMapping(value = "complete")
	public ModelAndView complete(TestModel testModel, String taskId,
			String assignee, String commentMessage, HttpSession session)
			throws Exception {
		User user = UserUtil.getUserFromSession(session);
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			ModelAndView view = new ModelAndView("redirect:/login?timeout=true");
			return view;
		}
		if (StringUtils.isEmpty(assignee)) {
			assignee = user.getId();
		}
		Map paramMap = new HashMap();
		
		paramMap.put("assignee", assignee);
		Calendar now=	Calendar.getInstance();
		now.add(Calendar.DAY_OF_MONTH, 3);
		paramMap.put("dueDate", now.getTime());
		taskService.complete(taskId, paramMap);
		// 判断是否可以办理，如果不可以办理跳转到错误页面
		this.testModelManager.complete(taskId, user.getId(), assignee,
				paramMap, commentMessage);
		return new ModelAndView("redirect:/szyzsq/todoList");
	}

}
