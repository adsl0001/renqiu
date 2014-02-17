package com.renqiu.ggzy.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.renqiu.demo.activiti.util.Page;
import com.renqiu.ggzy.dao.SzyzsqDao;
import com.renqiu.ggzy.entity.Szyzsq;
import com.renqiu.ggzy.util.DateUtil;
import com.renqiu.ggzy.vo.PublicInfo;

@Service
public class QueryManager {
	private Logger logger = LoggerFactory.getLogger(getClass());
	private static final String processDefKey = "renqiu_szyzsq";
	@PersistenceContext
	EntityManager em;
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

	public List<Map<String, Object>> find(Date startDate, Date endDate) {
		Query query =  em.createNativeQuery("select * from t_szyzsq",Szyzsq.class);
		List list = query.getResultList();
		for (int i = 0; i < list.size(); i++) {
			
		}
		return null;

	}

	public void queryPublicInfo(Page<PublicInfo> page, int[] pageParams) {
		List<HistoricProcessInstance> historicProcessInstanceList = historyService
				.createHistoricProcessInstanceQuery()
				.orderByProcessInstanceStartTime().desc()
				.processDefinitionKey(processDefKey)
				.listPage(pageParams[0], pageParams[1]);
		ProcessInstanceQuery processInstanceQuery = runtimeService
				.createProcessInstanceQuery()
				.processDefinitionKey(processDefKey).active();
		List<ProcessInstance> processInstanceList = processInstanceQuery
				.listPage(pageParams[0], pageParams[1]);
		List<PublicInfo> results = new ArrayList<PublicInfo>(
				processInstanceList.size());
		for (ProcessInstance processInstance : processInstanceList) {
			PublicInfo publicInfo = new PublicInfo();
			processInstance.getActivityId();
			List<Task> taskList = taskService.createTaskQuery()
					.processInstanceId(processInstance.getId()).active().list();
			String taskName = "";
			String sfcq = "";
			for (Task task : taskList) {
				taskName += task.getName() + ";";
				if (task.getDueDate() != null
						&& task.getDueDate().before(
								Calendar.getInstance().getTime())) {
					// 已超期
					sfcq += task.getName() + "已超期;";
				}
			}
			if (StringUtils.isEmpty(sfcq)) {
				sfcq = "未超期";
			}
			HistoricProcessInstance historicProcessInstance = historyService
					.createHistoricProcessInstanceQuery()
					.processDefinitionKey(processDefKey)
					.processInstanceId(processInstance.getId()).singleResult();
			publicInfo.setDqhj(taskName);
			publicInfo.setSbsj(DateUtil.getDateFormatString(
					historicProcessInstance.getStartTime(),
					DateUtil.STANDARD_DATETIME_FORMAT));
			publicInfo.setLsh(processInstance.getBusinessKey());
			publicInfo.setLczt("运行中");
			publicInfo.setSfcq(sfcq);
			results.add(publicInfo);
		}
		page.setTotalCount(processInstanceQuery.count());
		page.setResult(results);
	}
}
