package com.renqiu.demo.activiti.entity;

import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;

import com.renqiu.ggzy.vo.Comment;

public abstract class AbsProcess {
	// 运行中的流程实例
	@Transient
	private ProcessInstance processInstance;
	@Transient
	// 历史的流程实例
	private HistoricProcessInstance historicProcessInstance;
	@Transient
	// 流程定义
	private ProcessDefinition processDefinition;
	@Transient
    // 流程任务
    private Task task;
	@Transient
    private Map<String, Object> variables;
	@Transient
	private String formKey ;
	@Transient
	private List<Comment> commentList;
	public ProcessInstance getProcessInstance() {
		return processInstance;
	}

	public void setProcessInstance(ProcessInstance processInstance) {
		this.processInstance = processInstance;
	}

	public HistoricProcessInstance getHistoricProcessInstance() {
		return historicProcessInstance;
	}

	public void setHistoricProcessInstance(
			HistoricProcessInstance historicProcessInstance) {
		this.historicProcessInstance = historicProcessInstance;
	}

	public ProcessDefinition getProcessDefinition() {
		return processDefinition;
	}

	public void setProcessDefinition(ProcessDefinition processDefinition) {
		this.processDefinition = processDefinition;
	}

	public Task getTask() {
		return task;
	}

	public void setTask(Task task) {
		this.task = task;
	}

	public Map<String, Object> getVariables() {
		return variables;
	}

	public void setVariables(Map<String, Object> variables) {
		this.variables = variables;
	}

	public String getFormKey() {
		return formKey;
	}

	public void setFormKey(String formKey) {
		this.formKey = formKey;
	}

	public List<Comment> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}

}
