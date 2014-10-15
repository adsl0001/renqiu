package com.renqiu.ggzy.service;

import java.util.HashMap;
import java.util.Map;

import org.activiti.engine.IdentityService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.renqiu.ggzy.dao.TestModelDao;
import com.renqiu.ggzy.entity.TestModel;

@Service
public class TestModelManager {

	@Autowired
	private TestModelDao testModelDao;
	@Autowired
	RuntimeService runtimeService;
	@Autowired
	TaskService taskService;
	@Autowired
	private IdentityService identityService;

	private static String processName = "testProcess";

	public void save(TestModel model) {
		this.testModelDao.save(model);
	}
	private TestModel testModel   ;
	
	public TestModelManager setId(Long id) {
		 testModel.setId(id);
		 return this;
	}
 
	public TestModel list()
	{
		return this.testModelDao.findOne( testModel.getId());
	}
	
	public TestModel name1() {
	
		return	this.setId(1232232l).list();
	}
	
	public TestModel findById(String id) {
		
		return this.testModelDao.findOne(Long.parseLong(id));
	}

	public TestModel start(String userid) {
		TestModel testModel = new TestModel();
		this.testModelDao.save(testModel);
		String businessKey = String.valueOf(testModel.getId());
		// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
		identityService.setAuthenticatedUserId(userid);
		Map<String, Object> variables = new HashMap<String, Object>();
		variables.put("assignee", userid);
		ProcessInstance processInstance = runtimeService
				.startProcessInstanceByKey(this.processName, businessKey,
						variables);
		return testModel;
	}

	public void complete(String taskId, String userId, String assignee,
			Map variables, String commentMessage) {
		try {
			TaskQuery taskQuery = taskService.createTaskQuery();
			taskQuery = taskQuery.taskId(taskId);
			
			// TODO 空值判断
			Task task = taskService.createTaskQuery().taskId(taskId)
					.singleResult();
			if (task == null) {
				// 已经办理过了
				throw new Exception("没有找到id为\"" + taskId + "\"的待办任务。");
			}
			identityService.setAuthenticatedUserId(userId);
			variables = variables == null ? new HashMap<String, Object>()
					: variables;
			// taskService.claim(taskId, userId);
			variables.put("assignee", assignee);
			taskService.addComment(taskId, task.getProcessInstanceId(),
					commentMessage == null ? "" : commentMessage);
			taskService.setAssignee(taskId, userId);
			taskService.complete(taskId, variables);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
