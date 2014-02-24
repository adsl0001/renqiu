package com.renqiu.ggzy.service;

import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricProcessInstanceQuery;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.identity.User;
import org.activiti.engine.impl.TaskServiceImpl;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.pvm.process.ProcessDefinitionImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.renqiu.demo.activiti.dao.LeaveDao;
import com.renqiu.demo.activiti.entity.oa.Leave;
import com.renqiu.demo.activiti.service.oa.leave.LeaveManager;
import com.renqiu.demo.activiti.util.Page;
import com.renqiu.demo.activiti.util.Variable;
import com.renqiu.ggzy.activiti.JumpTaskCmd;
import com.renqiu.ggzy.activiti.ProcessService;
import com.renqiu.ggzy.dao.SzyzsqDao;
import com.renqiu.ggzy.entity.Szyzsq;
import com.renqiu.ggzy.util.DateUtil;
import com.renqiu.ggzy.vo.Comment;

/**
 *  
 * 
 */
@Service
@Transactional(readOnly = true)
public class SzyzsqManager {
	private Logger logger = LoggerFactory.getLogger(getClass());
	private static final String processDefKey = "renqiu_szyzsq";
	@Resource
	private RuntimeService runtimeService;
	@Resource
	protected TaskService taskService;
	@Resource
	protected HistoryService historyService;
	@Resource
	protected RepositoryService repositoryService;
	@Resource
	private IdentityService identityService;
	@Resource
	FormService formService;
	@Resource
	private SzyzsqDao szyzsqDao;
	@Resource
	private ProcessService processService ;
	public Szyzsq getSzyzsq(Long id) {
		return szyzsqDao.findOne(id);
	}

	@Transactional(readOnly = false)
	public void saveSzyzsq(Szyzsq entity) {
		szyzsqDao.save(entity);
	}

	private void getProcessInfo(Szyzsq model) {
		ProcessInstanceQuery query = runtimeService
				.createProcessInstanceQuery()
				.processDefinitionKey("renqiu_szyzsq")
				.processInstanceBusinessKey(String.valueOf(model.getSqbh()))
				.active();
		List<ProcessInstance> list = query.list();
		for (ProcessInstance processInstance : list) {
			model.setProcessInstance(processInstance);
			model.setProcessDefinition(getProcessDefinition(processInstance
					.getProcessDefinitionId()));
			// 设置当前任务信息
			List<Task> tasks = taskService.createTaskQuery()
					.processInstanceId(processInstance.getId()).active()
					.orderByTaskCreateTime().desc().listPage(0, 1);
			Task task = tasks.get(0);
			String formKey = formService.getTaskFormKey(
					processInstance.getProcessDefinitionId(),
					task.getTaskDefinitionKey());
			model.setFormKey(formKey);
			model.setTask(tasks.get(0));
			List<org.activiti.engine.task.Comment> commentList = taskService
					.getProcessInstanceComments(processInstance.getId());
			List<Comment> myCommentList = new ArrayList<Comment>();
			for (org.activiti.engine.task.Comment comment : commentList) {
				myCommentList.add(createComment(comment));
			}
			model.setCommentList(myCommentList);
		}

	}

	public Szyzsq getCurrentProcessInfo(Szyzsq entity) {
		Szyzsq model = this.getSzyzsq(entity.getSqbh());
		getProcessInfo(model);
		return model;
	}

	public boolean canComplete(String taskId) {
		Date endTime = historyService.createHistoricTaskInstanceQuery()
				.taskId(taskId).singleResult().getEndTime();
		return endTime == null ? true : false;
	}

	public Szyzsq getCurrentProcessInfo(String taskId) {
		Task task = this.getTask(taskId);
		String formKey = this.getFormKey(taskId);
		ProcessInstance processInstance = this.getProcessInstance(task);
		String bussinessKey = processInstance.getBusinessKey();
		Szyzsq model = this.getSzyzsq(Long.valueOf(bussinessKey));
		model.setProcessInstance(processInstance);
		model.setProcessDefinition(getProcessDefinition(processInstance
				.getProcessDefinitionId()));
		model.setFormKey(formKey);
		model.setTask(task);
		List<org.activiti.engine.task.Comment> commentList = taskService
				.getProcessInstanceComments(processInstance.getId());
		List<Comment> myCommentList = new ArrayList<Comment>();
		for (org.activiti.engine.task.Comment comment : commentList) {
			myCommentList.add(createComment(comment));
		}
		model.setCommentList(myCommentList);
		return model;
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

	public Task getTask(String taskId) {
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		return task;
	}

	public ProcessInstance getProcessInstance(Task task) {
		return runtimeService.createProcessInstanceQuery()
				.processInstanceId(task.getProcessInstanceId()).singleResult();
	}

	public String getFormKey(String taskId) {
		String formKey = null;
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		if (task != null) {
			formKey = formService.getTaskFormKey(task.getProcessDefinitionId(),
					task.getTaskDefinitionKey());
		}
		return formKey;
	}

	/**
	 * 查询流程定义对象
	 * 
	 * @param processDefinitionId
	 *            流程定义ID
	 * @return
	 */
	protected ProcessDefinition getProcessDefinition(String processDefinitionId) {
		ProcessDefinition processDefinition = repositoryService
				.createProcessDefinitionQuery()
				.processDefinitionId(processDefinitionId).singleResult();
		return processDefinition;
	}

	public RuntimeService getRuntimeService() {
		return runtimeService;
	}

	public void setRuntimeService(RuntimeService runtimeService) {
		this.runtimeService = runtimeService;
	}

	public TaskService getTaskService() {
		return taskService;
	}

	public void setTaskService(TaskService taskService) {
		this.taskService = taskService;
	}

	public HistoryService getHistoryService() {
		return historyService;
	}

	public void setHistoryService(HistoryService historyService) {
		this.historyService = historyService;
	}

	public RepositoryService getRepositoryService() {
		return repositoryService;
	}

	public void setRepositoryService(RepositoryService repositoryService) {
		this.repositoryService = repositoryService;
	}

	public IdentityService getIdentityService() {
		return identityService;
	}

	public void setIdentityService(IdentityService identityService) {
		this.identityService = identityService;
	}

	public SzyzsqDao getSzyzsqDao() {
		return szyzsqDao;
	}

	public void setSzyzsqDao(SzyzsqDao szyzsqDao) {
		this.szyzsqDao = szyzsqDao;
	}

	@Transactional(readOnly = false)
	public ProcessInstance startWorkFlow(Szyzsq szyzsq, User user,
			Map<String, Object> variables) {
		this.saveSzyzsq(szyzsq);
		String businessKey = String.valueOf(szyzsq.getSqbh());
		// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
		identityService.setAuthenticatedUserId(user.getId());
		variables.put("assignee", user.getId());
		ProcessInstance processInstance = runtimeService
				.startProcessInstanceByKey(SzyzsqManager.processDefKey,
						businessKey, variables);
		String processInstanceId = processInstance.getId();
		logger.debug(
				"start process of {key={}, bkey={}, pid={}, variables={}}",
				new Object[] { SzyzsqManager.processDefKey, businessKey,
						processInstanceId, variables });
		return processInstance;

	}

	/**
	 * 签收并完成任务
	 * 
	 * @param id
	 * @return
	 */
	@Transactional(readOnly = false)
	public String completeUserTask(Szyzsq szyzsq, String userId, String taskId,
			Map<String, Object> variables, String assignee,
			String commentMessage) {
		try {
			// TODO 空值判断
			// List taskList =
			// taskService.createTaskQuery().taskId(taskId).list();
			// Task task = (Task) taskList.get(0);
			this.saveSzyzsq(szyzsq);
			identityService.setAuthenticatedUserId(userId);
			Task task = taskService.createTaskQuery().taskId(taskId)
					.singleResult();
			variables = variables == null ? new HashMap<String, Object>()
					: variables;
			taskService.claim(taskId, userId);
			variables.put("assignee", assignee);
			variables.put("sfkz", szyzsq.getSfkz());
			variables.put("sfblgs", szyzsq.getSfblgs());
			taskService.addComment(taskId, task.getProcessInstanceId(),
					commentMessage == null ? "" : commentMessage);
			taskService.setAssignee(taskId, assignee);
			taskService.complete(taskId, variables);

			return "success";
		} catch (Exception e) {
			logger.error("error on complete task {}, variables={}",
					new Object[] { taskId, variables, e });
			return "error";
		}
	}

	public String rejectTask(Szyzsq szyzsq, String taskId,
			Map<String, Object> variables, String assignee,
			String commentMessage) {
		// 当前任务
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		try {
			List<ActivityImpl> list = processService.findBackAvtivity(taskId);
			if (CollectionUtils.isNotEmpty(list)) {
				identityService.setAuthenticatedUserId(assignee);
				processService.backProcess(taskId, list.get(list.size() - 1)
						.getId(), variables, commentMessage);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
		return "sucess";
	}

	private List<ActivityImpl> getPreActivityImpls(Task task) {
		// historyService.createHistoricActivityInstanceQuery().processInstanceId("").

		// 根据当前任务找到前序迁移线
		ProcessDefinitionImpl processDefinition = (ProcessDefinitionImpl) this.repositoryService
				.getProcessDefinition(task.getProcessDefinitionId());
		ActivityImpl activityImpl = processDefinition.findActivity(task
				.getTaskDefinitionKey());
		// 入口迁移线
		List<PvmTransition> pvmTransitions = activityImpl
				.getIncomingTransitions();
		// 根据入口迁移找到对应的活动
		int loop = pvmTransitions.size();
		for (int i = 0; i < loop; i++) {
			PvmTransition pvmTransition = pvmTransitions.get(i);
			PvmActivity pvmActivity = pvmTransition.getSource();
			historyService.createHistoricTaskInstanceQuery()
					.taskDefinitionKey(pvmActivity.getId()).finished()
					.processInstanceId(task.getProcessInstanceId());
		}
		// historyService.createHistoricTaskInstanceQuery().taskParentTaskId(parentTaskId)
		return null;
	}

	/**
	 * 根据法人身份证号和办理人id查找待办 <br>
	 * TODO 如果该法人身份证的待办是别人办理的，这里就查不出来了，暂时不使用userId进行过滤
	 * 
	 * @param frsfzh
	 * @param userId
	 * @return
	 */
	public List<Szyzsq> findTodoTasksByFrsfzh(String frsfzh, String userId) {
		List<Szyzsq> szyzsqList = this.szyzsqDao.findByFrsfzh(frsfzh);
		for (Szyzsq szyzsq : szyzsqList) {
			getProcessInfo(szyzsq);
		}
		return szyzsqList;
	}

	@Transactional(readOnly = true)
	public void findFinishedProcessInstance(String userId, Page<Szyzsq> page,
			int[] pageParams) {
		List<Szyzsq> results = new ArrayList<Szyzsq>();

		List<HistoricTaskInstance> historicTaskInstanceList = this.historyService
				.createHistoricTaskInstanceQuery().taskAssignee(userId)
				.finished().desc().listPage(pageParams[0], pageParams[1]);
		for (HistoricTaskInstance historicTaskInstance : historicTaskInstanceList) {
			HistoricProcessInstance historicProcessInstance = historyService
					.createHistoricProcessInstanceQuery()
					.processInstanceId(
							historicTaskInstance.getProcessInstanceId())
					.singleResult();
			Szyzsq szyzsq = this.getSzyzsq(Long
					.parseLong(historicProcessInstance.getBusinessKey()));
			getProcessInfo(szyzsq);
			results.add(szyzsq);
		}
		page.setTotalCount(historicTaskInstanceList.size());
		page.setResult(results);
	}

	/**
	 * 读取已结束中的流程
	 * 
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<Szyzsq> findFinishedProcessInstaces(Page<Szyzsq> page,
			int[] pageParams) {
		List<Szyzsq> results = new ArrayList<Szyzsq>();
		HistoricProcessInstanceQuery query = historyService
				.createHistoricProcessInstanceQuery()
				.processDefinitionKey(SzyzsqManager.processDefKey).finished()
				.orderByProcessInstanceEndTime().desc();
		List<HistoricProcessInstance> list = query.listPage(pageParams[0],
				pageParams[1]);

		// 关联业务实体
		for (HistoricProcessInstance historicProcessInstance : list) {
			String businessKey = historicProcessInstance.getBusinessKey();
			Szyzsq szyzsq = this.szyzsqDao.findOne(Long.parseLong(businessKey));
			szyzsq.setProcessDefinition(getProcessDefinition(historicProcessInstance
					.getProcessDefinitionId()));
			szyzsq.setHistoricProcessInstance(historicProcessInstance);
			results.add(szyzsq);
		}
		page.setTotalCount(query.count());
		page.setResult(results);
		return results;
	}

	/**
	 * 查询待办任务
	 * 
	 * @param userId
	 *            用户ID
	 * @return
	 */
	@Transactional(readOnly = true)
	public List<Szyzsq> findTodoTasks(String userId, Page<Szyzsq> page,
			int[] pageParams) {
		List<Szyzsq> results = new ArrayList<Szyzsq>();
		List<Task> tasks = new ArrayList<Task>();

		// 根据当前人的ID查询
		TaskQuery todoQuery = taskService.createTaskQuery()
				.processDefinitionKey(SzyzsqManager.processDefKey)
				.taskAssignee(userId).active().orderByTaskId().desc()
				.orderByTaskCreateTime().desc();
		List<Task> todoList = todoQuery.listPage(pageParams[0], pageParams[1]);

		// 根据当前人未签收的任务
		TaskQuery claimQuery = taskService.createTaskQuery()
				.processDefinitionKey(SzyzsqManager.processDefKey)
				.taskCandidateUser(userId).active().orderByTaskId().desc()
				.orderByTaskCreateTime().desc();
		List<Task> unsignedTasks = claimQuery.listPage(pageParams[0],
				pageParams[1]);

		// 合并
		tasks.addAll(todoList);
		tasks.addAll(unsignedTasks);

		// 根据流程的业务ID查询实体并关联
		for (Task task : tasks) {
			String processInstanceId = task.getProcessInstanceId();
			ProcessInstance processInstance = runtimeService
					.createProcessInstanceQuery()
					.processInstanceId(processInstanceId).active()
					.singleResult();
			String businessKey = processInstance.getBusinessKey();
			if (businessKey == null) {
				continue;
			}

			Szyzsq szyzsq = this.getSzyzsq(Long.parseLong(businessKey));
			if (results.contains(szyzsq)) {
				try {
					szyzsq = (Szyzsq) BeanUtils.cloneBean(szyzsq);
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch (InstantiationException e) {
					e.printStackTrace();
				} catch (InvocationTargetException e) {
					e.printStackTrace();
				} catch (NoSuchMethodException e) {
					e.printStackTrace();
				}
			}
			szyzsq.setTask(task);
			szyzsq.setProcessInstance(processInstance);
			szyzsq.setProcessDefinition(getProcessDefinition(processInstance
					.getProcessDefinitionId()));
			String formKey = formService.getTaskFormKey(
					task.getProcessDefinitionId(), task.getTaskDefinitionKey());
			szyzsq.setFormKey(formKey);
			results.add(szyzsq);
		}

		page.setTotalCount(todoQuery.count() + claimQuery.count());
		page.setResult(results);
		return results;
	}
}
