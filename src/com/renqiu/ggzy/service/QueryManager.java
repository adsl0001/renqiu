package com.renqiu.ggzy.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.renqiu.ggzy.dao.SzyzsqDao;
@Service
public class QueryManager {
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
	
	public List<Map<String,Object>> find(Date startDate,Date endDate){
		return null;
		
	}
}
