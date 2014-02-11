package com.renqiu.ggzy.web;

import javax.servlet.http.HttpSession;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.identity.User;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.renqiu.demo.activiti.util.UserUtil;
import com.renqiu.ggzy.entity.Szyzsq;
import com.renqiu.ggzy.service.SzyzsqManager;

@Controller
@RequestMapping(value = "/szyzsq")
public class ListController {

	@Autowired
	protected SzyzsqManager szyzsqManager;
	
	@Autowired
	protected RuntimeService runtimeService;

	@Autowired
	protected TaskService taskService;
	
	@RequestMapping(value = { "gsj", "" })
	public String createForm(Model model, HttpSession session) {
		User user = UserUtil.getUserFromSession(session);
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			return "redirect:/login?timeout=true";
		}
		model.addAttribute("szyssq", new Szyzsq());
		return "/szyzsq/gsj";
	}
	
}
