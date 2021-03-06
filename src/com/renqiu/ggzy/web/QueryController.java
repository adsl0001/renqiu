package com.renqiu.ggzy.web;

import java.util.ArrayList;
import java.util.Calendar;
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
import org.activiti.engine.history.HistoricActivityInstanceQuery;
import org.activiti.engine.history.HistoricProcessInstanceQuery;
import org.activiti.engine.history.HistoricTaskInstanceQuery;
import org.activiti.engine.identity.User;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.activiti.engine.task.Task;
import org.activiti.spring.annotations.TaskId;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
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
import com.renqiu.ggzy.service.QueryManager;
import com.renqiu.ggzy.service.SzyzsqManager;
import com.renqiu.ggzy.util.DateUtil;
import com.renqiu.ggzy.util.NumberUtil;
import com.renqiu.ggzy.vo.ActivityCount;
import com.renqiu.ggzy.vo.PublicInfo;

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
	@Autowired
	private QueryManager queryManager;
	private static final String processDefKey = "renqiu_szyzsq";

	// @RequestMapping(value={"queryProcessInfo"})
	// public ModelAndView queryProcessInfo()
	// {
	// ModelAndView view = new ModelAndView("query/queryProcessInfo");
	// return view ;
	// }
	// @RequestMapping(value = { "queryProcessInfo" })
	// public ModelAndView queryProcessInfo(
	// @RequestParam(value = "startTime", required = false) String startTime,
	// @RequestParam(value = "endTime", required = false) String endTime) {
	// ModelAndView view = new ModelAndView("query/queryProcessInfo");
	// long bjl = 0;
	// long running = 0;
	// long all = 0;
	// long finished = 0;
	// long unfinished = 0;
	// ProcessInstanceQuery processInstanceQuery = runtimeService
	// .createProcessInstanceQuery();
	// processInstanceQuery = processInstanceQuery.processDefinitionKey(
	// this.processDefKey).active();
	// HistoricProcessInstanceQuery finishedHistoricProcessInstanceQuery =
	// historyService
	// .createHistoricProcessInstanceQuery();
	// HistoricProcessInstanceQuery unfinishedHistoricProcessInstanceQuery =
	// historyService
	// .createHistoricProcessInstanceQuery();
	// finishedHistoricProcessInstanceQuery =
	// finishedHistoricProcessInstanceQuery
	// .processDefinitionKey(processDefKey).finished();
	// unfinishedHistoricProcessInstanceQuery =
	// unfinishedHistoricProcessInstanceQuery
	// .processDefinitionKey(processDefKey).unfinished();
	// Date startDate = null;
	// if (StringUtils.isNotBlank(startTime)) {
	// startDate = DateUtil.convertStringToDate(startTime,
	// DateUtil.STANDARD_DATE_FORMAT, null);
	// if (startDate != null) {
	// finishedHistoricProcessInstanceQuery =
	// finishedHistoricProcessInstanceQuery
	// .finishedAfter(startDate);
	// unfinishedHistoricProcessInstanceQuery =
	// unfinishedHistoricProcessInstanceQuery
	// .finishedAfter(startDate);
	// }
	// }
	// Date endDate = null;
	// if (StringUtils.isNotBlank(endTime)) {
	// endDate = DateUtil.convertStringToDate(endTime,
	// DateUtil.STANDARD_DATE_FORMAT, null);
	// if (endDate != null) {
	// finishedHistoricProcessInstanceQuery =
	// finishedHistoricProcessInstanceQuery
	// .finishedBefore(endDate);
	// unfinishedHistoricProcessInstanceQuery =
	// unfinishedHistoricProcessInstanceQuery
	// .finishedBefore(endDate);
	// }
	//
	// }
	// running = processInstanceQuery.processDefinitionKey(this.processDefKey)
	// .active().count();
	// finished = finishedHistoricProcessInstanceQuery.count();
	// unfinished = unfinishedHistoricProcessInstanceQuery.count();
	// all = unfinished + finished;
	// bjl = finished;
	// double bjlv = all != 0 ? NumberUtil.round((double) (finished) / all
	// * 100, 3) : 0;
	// view.addObject("bjl", bjl);
	// view.addObject("bjlv", bjlv);
	// view.addObject("running", running);
	// view.addObject("all", all);
	// view.addObject("startTime", DateUtil.getDateFormatString(startDate,
	// DateUtil.STANDARD_DATE_FORMAT));
	// view.addObject("endTime", DateUtil.getDateFormatString(endDate,
	// DateUtil.STANDARD_DATE_FORMAT));
	// return view;
	// }

	/**
	 * 公示数据
	 * 
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "queryPublic")
	@ResponseBody
	public Map<String, Object> queryPublic(HttpSession session,
			HttpServletRequest request) {
		Page<PublicInfo> page = new Page<PublicInfo>(PageUtil.PAGE_SIZE);
		int[] pageParams = PageUtil.init(page, request);
		this.queryManager.queryPublicInfo(page, pageParams);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>(1);
		Map<String, Object> map = new HashMap<String, Object>(1);
		map.put("page", page);
		return map;
	}

	/**
	 * 大厅公示
	 * 
 
	 * @param timeout 切换时间 ，单位是秒
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "publicInfo/{timeout}")
	public ModelAndView dating(@PathVariable("timeout") String timeout,
			HttpSession session, HttpServletRequest request) {
		queryManager.find(null, null);
		int i_timeout = 1000 * 60;
		if (NumberUtils.isNumber(timeout)) {
			i_timeout = NumberUtils.toInt(timeout);
			i_timeout = i_timeout * 1000;
		}
		ModelAndView modelAndView = new ModelAndView("query/dating");
		modelAndView.addObject("timeout", i_timeout);
		return modelAndView;
	}
	/**
	 * 显示照片
	 * 
 
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "showPhoto/{timeout}")
	public ModelAndView showPhoto(@PathVariable("timeout") String timeout,
			HttpSession session, HttpServletRequest request) {
		queryManager.find(null, null);
		int i_timeout = 1000 * 60;
		if (NumberUtils.isNumber(timeout)) {
			i_timeout = NumberUtils.toInt(timeout);
			i_timeout = i_timeout * 1000;
		}
		ModelAndView modelAndView = new ModelAndView("query/zhaopian");
		modelAndView.addObject("timeout", i_timeout);
		return modelAndView;
	}	 
	/**
	 * 公示页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "public/{pageSize}")
	public ModelAndView publicInfo(@PathVariable("pageSize") String pageSize,
			HttpSession session, HttpServletRequest request) {
		queryManager.find(null, null);
		int iPageSize = 20;
		if (NumberUtils.isNumber(pageSize)) {
			iPageSize = NumberUtils.toInt(pageSize);
		}
		ModelAndView modelAndView = new ModelAndView("query/public");
		modelAndView.addObject("pageSize", iPageSize);
		return modelAndView;
	}

	@RequestMapping(value = "queryProcessInfo")
	// @ResponseBody
	public ModelAndView queryProcessInfoCount(
			@RequestParam(value = "startTime", required = false) String startTime,
			@RequestParam(value = "endTime", required = false) String endTime) {
		//
		// String[] dw = new String[] { "工商", "质监", "国税", "地税", "印章刻制处" };
		// Map<String, String[]> dwActivity = new HashMap<String, String[]>(
		// dw.length);
		// dwActivity.put(dw[0], new String[] { "工商窗口审核", "办理营业执照" });
		// dwActivity.put(dw[1], new String[] { "质监窗口办理代码证" });
		// dwActivity.put(dw[2], new String[] { "国税窗口办理" });
		// dwActivity.put(dw[3], new String[] { "地税窗口办理" });
		// dwActivity.put(dw[4], new String[] { "印章刻制处办理" });
		// 未完成
		HistoricTaskInstanceQuery q_gongshang1 = historyService
				.createHistoricTaskInstanceQuery().taskName("工商窗口审核");
		HistoricTaskInstanceQuery q_gongshang2 = historyService
				.createHistoricTaskInstanceQuery().taskName("办理营业执照");
		HistoricTaskInstanceQuery q_zhijian = historyService
				.createHistoricTaskInstanceQuery().taskName("质监窗口办理代码证");
		HistoricTaskInstanceQuery q_guoshui = historyService
				.createHistoricTaskInstanceQuery().taskName("国税窗口办理");
		HistoricTaskInstanceQuery q_dishui = historyService
				.createHistoricTaskInstanceQuery().taskName("地税窗口办理");
		HistoricTaskInstanceQuery q_yinzhang = historyService
				.createHistoricTaskInstanceQuery().taskName("印章刻制处办理");
		// 已完成
		HistoricTaskInstanceQuery f_q_gongshang1 = historyService
				.createHistoricTaskInstanceQuery().taskName("工商窗口审核");
		HistoricTaskInstanceQuery f_q_gongshang2 = historyService
				.createHistoricTaskInstanceQuery().taskName("办理营业执照");
		HistoricTaskInstanceQuery f_q_zhijian = historyService
				.createHistoricTaskInstanceQuery().taskName("质监窗口办理代码证");
		HistoricTaskInstanceQuery f_q_guoshui = historyService
				.createHistoricTaskInstanceQuery().taskName("国税窗口办理");
		HistoricTaskInstanceQuery f_q_dishui = historyService
				.createHistoricTaskInstanceQuery().taskName("地税窗口办理");
		HistoricTaskInstanceQuery f_q_yinzhang = historyService
				.createHistoricTaskInstanceQuery().taskName("印章刻制处办理");
		HistoricProcessInstanceQuery historicProcessInstanceQuery = historyService
				.createHistoricProcessInstanceQuery().processDefinitionKey(
						processDefKey);
		Date startDate = null;
		if (StringUtils.isNotBlank(startTime)) {
			startDate = DateUtil.convertStringToDate(startTime,
					DateUtil.STANDARD_DATE_FORMAT, null);
			if (startDate != null) {
				q_gongshang1 = q_gongshang1.taskCreatedAfter(startDate);
				q_gongshang2 = q_gongshang2.taskCreatedAfter(startDate);
				q_zhijian = q_zhijian.taskCreatedAfter(startDate);
				q_guoshui = q_guoshui.taskCreatedAfter(startDate);
				q_dishui = q_dishui.taskCreatedAfter(startDate);
				q_yinzhang = q_yinzhang.taskCreatedAfter(startDate);

				f_q_gongshang1 = f_q_gongshang1.taskCreatedAfter(startDate);
				f_q_gongshang2 = f_q_gongshang2.taskCreatedAfter(startDate);
				f_q_zhijian = f_q_zhijian.taskCreatedAfter(startDate);
				f_q_guoshui = f_q_guoshui.taskCreatedAfter(startDate);
				f_q_dishui = f_q_dishui.taskCreatedAfter(startDate);
				f_q_yinzhang = f_q_yinzhang.taskCreatedAfter(startDate);
				historicProcessInstanceQuery.startedAfter(startDate);
			}
		}
		Date endDate = null;
		if (StringUtils.isNotBlank(endTime)) {
			endDate = DateUtil.convertStringToDate(endTime,
					DateUtil.STANDARD_DATE_FORMAT, null);
			if (endDate != null) {
				q_gongshang1 = q_gongshang1.taskCreatedBefore(endDate);
				q_gongshang2 = q_gongshang2.taskCreatedBefore(endDate);
				q_zhijian = q_zhijian.taskCreatedBefore(endDate);
				q_guoshui = q_guoshui.taskCreatedBefore(endDate);
				q_dishui = q_dishui.taskCreatedBefore(endDate);
				q_yinzhang = q_yinzhang.taskCreatedBefore(endDate);

				f_q_gongshang1 = f_q_gongshang1.taskCreatedBefore(endDate);
				f_q_gongshang2 = f_q_gongshang2.taskCreatedBefore(endDate);
				f_q_zhijian = f_q_zhijian.taskCreatedBefore(endDate);
				f_q_guoshui = f_q_guoshui.taskCreatedBefore(endDate);
				f_q_dishui = f_q_dishui.taskCreatedBefore(endDate);
				f_q_yinzhang = f_q_yinzhang.taskCreatedBefore(endDate);
				historicProcessInstanceQuery.startedBefore(startDate);
			}

		}
		// 流程总数
		long process_all = historicProcessInstanceQuery.count();
		long process_bjl = historicProcessInstanceQuery.finished().count();
		double process_bjlv = process_all == 0 ? 0 : NumberUtil.round(
				(double) process_bjl / process_all * 100, 3);

		// 在增加完成情况条件前先查出总量
		long all_gongshang1 = q_gongshang1.count();
		long all_gongshang2 = q_gongshang2.count();
		long all_zhijian = q_zhijian.count();
		long all_guoshui = q_guoshui.count();
		long all_dishui = q_dishui.count();
		long all_yinzhang = q_yinzhang.count();
		ActivityCount all = new ActivityCount();
		all.setDishui(String.valueOf(all_dishui));
		all.setGongshang(String.valueOf(all_gongshang2 + all_gongshang1));
		all.setGuoshui(String.valueOf(all_guoshui));
		all.setYinzhang(String.valueOf(all_yinzhang));
		all.setZhijian(String.valueOf(all_zhijian));

		// 办结量
		long f_gongshang1 = f_q_gongshang1.finished().count();
		long f_gongshang2 = f_q_gongshang2.finished().count();
		long f_zhijian = f_q_zhijian.finished().count();
		long f_guoshui = f_q_guoshui.finished().count();
		long f_dishui = f_q_dishui.finished().count();
		long f_yinzhang = f_q_yinzhang.finished().count();
		ActivityCount bjl = new ActivityCount();
		bjl.setDishui(String.valueOf(f_dishui));
		bjl.setGongshang(String.valueOf(f_gongshang2 + f_gongshang1));
		bjl.setGuoshui(String.valueOf(f_guoshui));
		bjl.setYinzhang(String.valueOf(f_yinzhang));
		bjl.setZhijian(String.valueOf(f_zhijian));
		// 办结率
		ActivityCount bjlv = new ActivityCount();
		bjlv.setDishui(!"0".equals(all.getDishui()) ? String.valueOf(NumberUtil
				.round(Double.parseDouble(bjl.getDishui())
						/ Double.parseDouble(all.getDishui()) * 100, 3)) : "0");
		bjlv.setGongshang(!"0".equals(all.getGongshang()) ? String
				.valueOf(NumberUtil.round(
						Double.parseDouble(bjl.getGongshang())
								/ Double.parseDouble(all.getGongshang()) * 100,
						3)) : "0");
		bjlv.setGuoshui(!"0".equals(all.getGuoshui()) ? String
				.valueOf(NumberUtil.round(Double.parseDouble(bjl.getGuoshui())
						/ Double.parseDouble(all.getGuoshui()) * 100, 3)) : "0");
		bjlv.setYinzhang(!"0".equals(all.getYinzhang()) ? String
				.valueOf(NumberUtil.round(Double.parseDouble(bjl.getYinzhang())
						/ Double.parseDouble(all.getYinzhang()) * 100, 3))
				: "0");
		bjlv.setYinzhang(!"0".equals(all.getYinzhang()) ? String
				.valueOf(NumberUtil.round(Double.parseDouble(bjl.getYinzhang())
						/ Double.parseDouble(all.getYinzhang()) * 100, 3))
				: "0");
		bjlv.setZhijian(!"0".equals(all.getZhijian()) ? String
				.valueOf(NumberUtil.round(Double.parseDouble(bjl.getZhijian())
						/ Double.parseDouble(all.getZhijian()) * 100, 3)) : "0");

		ModelAndView view = new ModelAndView("query/queryProcessInfo");
		view.addObject("bjl", bjl);
		view.addObject("bjlv", bjlv);
		view.addObject("all", all);
		view.addObject("process_bjl", process_bjl);
		view.addObject("process_bjlv", process_bjlv);
		view.addObject("process_all", process_all);
		view.addObject("startTime", DateUtil.getDateFormatString(startDate,
				DateUtil.STANDARD_DATE_FORMAT));
		view.addObject("endTime", DateUtil.getDateFormatString(endDate,
				DateUtil.STANDARD_DATE_FORMAT));
		return view;
	}

	@RequestMapping(value = "queryTimeoutTask")
	@ResponseBody
	public List<Map<String, Object>> queryTimeoutTask(HttpSession session) {
		Calendar now = Calendar.getInstance();
		User user = UserUtil.getUserFromSession(session);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> map;
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			return list;
		}
		// 所有超期时间在现在之后的待办
		// 在现在之后的是即将超期的
		List<Task> taskList = taskService.createTaskQuery().active()
				.taskAssignee(user.getId()).dueAfter(now.getTime()).list();

		// 判断是否需要提醒
		for (Task task : taskList) {
			// TODO 根据超期时间点设置 判断是否是即将超期的任务
			map = new HashMap<String, Object>();
			map.put("taskId", task.getId());
			map.put("createTime", DateUtil.getDateFormatString(
					task.getCreateTime(), DateUtil.STANDARD_DATETIME_FORMAT));
			map.put("taskName", task.getName());
			map.put("pid", task.getProcessInstanceId());
			map.put("dueDate", DateUtil.getDateFormatString(task.getDueDate(),
					DateUtil.STANDARD_DATETIME_FORMAT));
			list.add(map);
		}
		return list;
	}

}
