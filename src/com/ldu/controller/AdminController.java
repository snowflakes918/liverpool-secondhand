package com.ldu.controller;

import com.alibaba.druid.stat.TableStat;
import com.ldu.pojo.Admin;
import com.ldu.service.AdminService;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;

	@RequestMapping("")
	public ModelAndView login(){
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/admin/login");
		return modelAndView;
	}

	@RequestMapping("/index")
	public String index(HttpServletRequest request, Admin admin){
		Admin myAdmin = adminService.findAdmin(admin.getPhone(), admin.getPassword());
		if (myAdmin != null){
			request.getSession().setAttribute("admin", myAdmin);
			return "/admin/index";
		}else {
			return "/admin/login";
		}

	}



}