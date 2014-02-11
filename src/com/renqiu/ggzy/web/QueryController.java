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
@RequestMapping(value = "/query")
public class QueryController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	protected SzyzsqManager szyzsqManager;

	@Autowired
	protected RuntimeService runtimeService;

	@Autowired
	protected TaskService taskService;
 
}
