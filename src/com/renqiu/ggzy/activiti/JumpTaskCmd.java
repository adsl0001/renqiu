package com.renqiu.ggzy.activiti;

import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.interceptor.Command;
import org.activiti.engine.impl.interceptor.CommandContext;
import org.activiti.engine.impl.persistence.entity.ExecutionEntity;
import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.pvm.process.ProcessDefinitionImpl;
import org.activiti.engine.task.Comment;
import org.apache.commons.lang3.StringUtils;

public class JumpTaskCmd implements Command<Comment> {

	protected String executionId;
	protected String activityId;
	protected String reason;

	public JumpTaskCmd(String executionId, String activityId, String reason) {
		this.executionId = executionId;
		this.activityId = activityId;
	}

	public Comment execute(CommandContext commandContext) {
		for (TaskEntity taskEntity : Context.getCommandContext()
				.getTaskEntityManager().findTasksByExecutionId(executionId)) {
			if (!taskEntity.isDeleted()) {
				Context.getCommandContext()
				.getTaskEntityManager()
				.deleteTask(taskEntity,
						"[跳转] " + StringUtils.defaultString(reason, ""),
						false);
			}
		}
		ExecutionEntity executionEntity = Context.getCommandContext()
				.getExecutionEntityManager().findExecutionById(executionId);
		ProcessDefinitionImpl processDefinition = executionEntity
				.getProcessDefinition();
		ActivityImpl activity = processDefinition.findActivity(activityId);
		executionEntity.executeActivity(activity);
		return null;
	}
}
