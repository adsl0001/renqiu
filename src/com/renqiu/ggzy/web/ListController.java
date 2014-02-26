package com.renqiu.ggzy.web;

import javax.servlet.http.HttpSession;

import oracle.net.aso.s;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.identity.User;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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

	// 工商局需要准备全部的全部材料列表页面
	@RequestMapping(value = { "gsj", "" })
	public String gsjList(Model model, HttpSession session) {
		User user = UserUtil.getUserFromSession(session);
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			return "redirect:/login?timeout=true";
		}
		return "/szyzsq/gsj";
	}

	// 告知单页面
	@RequestMapping(value = { "gzd", "" })
	public String gzdList(Model model, HttpSession session) {
		User user = UserUtil.getUserFromSession(session);
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			return "redirect:/login?timeout=true";
		}
		model.addAttribute("szyssq", new Szyzsq());
		return "/szyzsq/gzd";
	}

	// 材料列表页面
	@RequestMapping(value = { "clml", "" })
	public String clmlList(Model model, HttpSession session) {
		User user = UserUtil.getUserFromSession(session);
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			return "redirect:/login?timeout=true";
		}
		return "/szyzsq/clml";
	}

	// 弹出打印页面
	@RequestMapping(value = "inputApplyPrint/{sqbh}"   )
	public ModelAndView inputApplyPrint(@PathVariable(value="sqbh") String sqbh , HttpSession session) {
		ModelAndView mv;
		User user = UserUtil.getUserFromSession(session);
		if (user == null || StringUtils.isBlank(user.getId())) {
			mv = new ModelAndView("redirect:/login?timout=true");
			return mv;
		}
		Szyzsq szyzsq = new Szyzsq();
		szyzsq.setSqbh(Long.valueOf(sqbh));
		szyzsq = szyzsqManager.getSzyzsq(Long.valueOf(sqbh));
		mv = new ModelAndView("/szyzsq/inputApplyPrint");
		mv.addObject("szyzsq",szyzsq);
		return mv;
	}
	// 弹出收件通知书
	@RequestMapping(value = "sjtzs/{sqbh}")
	public ModelAndView sjtzs( @PathVariable(value="sqbh") String sqbh ,HttpSession session) {
		ModelAndView mv;
		User user = UserUtil.getUserFromSession(session);
		// 用户未登录不能操作，实际应用使用权限框架实现，例如Spring Security、Shiro等
		if (user == null || StringUtils.isBlank(user.getId())) {
			mv = new ModelAndView("redirect:/login?timeout=true");
			return mv;
		}
		Szyzsq szyzsq = new Szyzsq();
		szyzsq.setSqbh(Long.valueOf(sqbh));
		mv = new ModelAndView("/szyzsq/sjtzs");
		mv.addObject(szyzsq);
		return mv;
	}
}
