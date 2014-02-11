package com.renqiu.ggzy.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.activiti.engine.ActivitiException;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.identity.User;
import org.activiti.engine.runtime.ProcessInstance;
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

@Controller
@RequestMapping(value = "/szyzsq")
public class SzyzsqController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	protected SzyzsqManager szyzsqManager;

	// @Autowired
	// protected LeaveWorkflowService workflowService;

	@Autowired
	protected RuntimeService runtimeService;

	@Autowired
	protected TaskService taskService;

	@RequestMapping(value = { "apply", "" })
	public String createForm(Model model, HttpSession session) {
		User user = UserUtil.getUserFromSession(session);
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			return "redirect:/login?timeout=true";
		}
		model.addAttribute("szyssq", new Szyzsq());
		return "/szyzsq/apply";
	}
//	@RequestMapping(value = "gsj")
//	public String gsjList(Model model, HttpSession session) {
//		User user = UserUtil.getUserFromSession(session);
//		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
//		if (user == null || StringUtils.isBlank(user.getId())) {
//			return "redirect:/login?timeout=true";
//		}
//		return "/szyzsq/gsj";
//	}
//	@RequestMapping(value="gzd")
//	public String gzdList(Model model, HttpSession session){
//		User user = UserUtil.getUserFromSession(session);
//		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
//		if (user == null || StringUtils.isBlank(user.getId())) {
//			return "redirect:/login?timeout=true";
//		}
//		return "/szyzsq/gzd";
//	}
	/**
	 * 录入申请信息，或者跳转到某步流程节点继续流转
	 * 
	 * @param sqbh
	 *            申请编号 ，如果为空则认为是新办流程
	 * @param frsfzh
	 *            法人身份证号
	 * @return
	 */
	@RequestMapping(value = "inputApply", method = RequestMethod.POST)
	public ModelAndView applyForm(String sqbh, String frsfzh,
			RedirectAttributes redirectAttributes, HttpSession session) {
		Szyzsq szyzsq = new Szyzsq();
		szyzsq.setFrsfzh(frsfzh);
		ModelAndView view;
		User user = UserUtil.getUserFromSession(session);
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			view = new ModelAndView("redirect:/login?timeout=true");
			return view;
		}
		if (sqbh == null || "".equals(sqbh)) {
			// 新办流程
			// 新办时要启动流程
			Map<String, Object> variables = new HashMap<String, Object>();
			variables.put("user", user);
			szyzsq.setFrxm("");
			szyzsq.setLxfs("");
			szyzsq.setQymc("");
			szyzsq.setSlr(user.getId());
			szyzsq.setSlrxm(user.getFirstName()+user.getLastName());
			ProcessInstance processInstance = szyzsqManager.startWorkFlow(
					szyzsq, user, variables);
			redirectAttributes.addFlashAttribute("message", "流程已启动，流程ID："
					+ processInstance.getId());
			szyzsq = szyzsqManager.getCurrentProcessInfo(szyzsq);
			view = new ModelAndView(szyzsq.getFormKey());
			view.addObject("szyzsq", szyzsq);
		} else {
			// 老流程
			szyzsq.setSqbh(Long.valueOf(sqbh));
			szyzsq = szyzsqManager.getCurrentProcessInfo(szyzsq);
			view = new ModelAndView(szyzsq.getFormKey());
			view.addObject("szyzsq", szyzsq);
		}
		return view;
	}

	/**
	 * 
	 * @param szyzsq
	 *            业务对象
	 * @param taskId
	 *            taskid
	 * @param assignee
	 *            参与者
	 * @param commentMessage
	 *            意见
	 * @param variable
	 *            变量
	 */
	@RequestMapping(value = "completeTask")
	public String completeTask(Szyzsq szyzsq, String taskId, String assignee,
			String commentMessage, HttpSession session, String input) {
		User user = UserUtil.getUserFromSession(session);
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			return "redirect:/login?timeout=true";
		}
		if (StringUtils.isEmpty(assignee)) {
			assignee = user.getId();
		}
		Map paramMap = new HashMap();
		if (!StringUtils.isBlank(input)) {
			paramMap.put("input", input);
		}
		this.szyzsqManager.completeUserTask(szyzsq, user.getId(), taskId,
				paramMap, assignee, commentMessage);
		return "redirect:/szyzsq/todoList";
	}

	/**
	 * 工商窗口审核
	 * 
	 * @param szyzsq
	 *            实体
	 * @param redirectAttributes
	 * @param session
	 * @param audioValue
	 *            单选框的值:0是"接受并办理",1是"不接受办理"
	 * @return
	 */
	public ModelAndView branch(Szyzsq szyzsq,
			RedirectAttributes redirectAttributes, HttpSession session,
			Integer audioValue) {
		ModelAndView view = null;
		User user = UserUtil.getUserFromSession(session);
		// TODO 参数校验
		if (audioValue == 0) {
			Map<String, Object> variables = new HashMap<String, Object>();
			variables.put("user", user);

			// ProcessInstance processInstance =
			// szyzsqManager.completeUserTask(taskId, variables, assignee,
			// commentMessage);
			// redirectAttributes.addFlashAttribute("message", "流程已提交，流程ID："
			// + processInstance.getId());
			view = new ModelAndView("");
		}
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (audioValue == 1) {
			Map<String, Object> variables = new HashMap<String, Object>();
			variables.put("user", user);
			ProcessInstance processInstance = szyzsqManager.startWorkFlow(
					szyzsq, user, variables);
			redirectAttributes.addFlashAttribute("message", "流程已提交，流程ID："
					+ processInstance.getId());
		}
		return view;

	}

	/**
	 * 办理业务
	 * 
	 * @param taskId
	 * @param redirectAttributes
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "handleTask/{taskId}")
	public ModelAndView handleTask(@PathVariable("taskId") String taskId,
			RedirectAttributes redirectAttributes, HttpSession session) {
		if (StringUtils.isEmpty(taskId)) {
			redirectAttributes.addFlashAttribute("message", "任务ID不能为空.");
		}
		Szyzsq szyzsq = szyzsqManager.getCurrentProcessInfo(taskId);
		ModelAndView view = new ModelAndView(szyzsq.getFormKey());
		view.addObject("szyzsq", szyzsq);
		return view;

	}

	/**
	 * todo
	 * 
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "todoList")
	public ModelAndView todoList(HttpSession session, HttpServletRequest request) {
		User user = UserUtil.getUserFromSession(session);
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			return new ModelAndView("redirect:/login?timeout=true");
		}
		ModelAndView view = new ModelAndView("/szyzsq/todoList");
		Page<Szyzsq> page = new Page<Szyzsq>(PageUtil.PAGE_SIZE);
		int[] pageParams = PageUtil.init(page, request);
		String userId = UserUtil.getUserFromSession(session).getId();
		szyzsqManager.findTodoTasks(userId, page, pageParams);
		view.addObject("page", page);
		return view;
	}
	@RequestMapping(value = "finishedList")
	public ModelAndView finishedList(HttpSession session, HttpServletRequest request) {
		User user = UserUtil.getUserFromSession(session);
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			return new ModelAndView("redirect:/login?timeout=true");
		}
		ModelAndView view = new ModelAndView("/szyzsq/finishedList");
		Page<Szyzsq> page = new Page<Szyzsq>(PageUtil.PAGE_SIZE);
		int[] pageParams = PageUtil.init(page, request);
		this.szyzsqManager.findFinishedProcessInstaces(page, pageParams);
		view.addObject("page", page);
		return view;
	}

	@RequestMapping(value = "queryList")
	 @ResponseBody
	public List<Map<String, Object>> queryList(String frsfzh,
			HttpSession session, HttpServletRequest request,
			RedirectAttributes redirectAttributes) {
		if (StringUtils.isBlank(frsfzh)) {
			// TODO 为空判断
		}
		User user = UserUtil.getUserFromSession(session);
		String userId = user.getId();
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(userId)) {
			// return new ModelAndView("redirect:/login?timeout=true");
		}
		List<Szyzsq> szyzsqList = this.szyzsqManager.findTodoTasksByFrsfzh(
				frsfzh, user.getId());
		List<Map<String, Object>> value = new ArrayList<Map<String, Object>>(
				szyzsqList == null ? 0 : szyzsqList.size());
		
		for (Szyzsq szyzsq : szyzsqList) {
			if (szyzsq.getTask()==null) {
				//没有待办任务
				continue;
			}
			String assignee = szyzsq .getTask().getAssignee();
//			//不是自己办理的
//			if (!StringUtils.equals(assignee, userId)) {
//				continue;
//			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sqbh", szyzsq.getSqbh());
			map.put("frsfzh", szyzsq.getFrsfzh());
			map.put("frxm", szyzsq.getFrxm());
			map.put("lxfs", szyzsq.getLxfs());
			map.put("pi_id", szyzsq.getProcessInstance().getId());
			map.put("task_name", szyzsq.getTask().getName());
			map.put("task_id", szyzsq.getTask().getId());
			map.put("task_assignee", assignee);
			map.put("task_createTime", DateUtil.getDateFormatString(szyzsq.getTask().getCreateTime(),DateUtil.STANDARD_DATETIME_FORMAT));
			map.put("processDefinition_version", szyzsq.getProcessDefinition()
					.getVersion());
			value.add(map);
		}
		return value;

	}
}
