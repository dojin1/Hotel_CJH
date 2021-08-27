package com.humanhotel.app;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping("/room")
	public String room() {
		return "room";
	}
	
	@RequestMapping("/booking")
	public String booking() {
		return "booking";
	}
	
	@RequestMapping("/info")
	public String viewInfo(HttpServletRequest hsr, Model model) {
		String uid=hsr.getParameter("userid");
		String upw=hsr.getParameter("userpw");
		System.out.println("uid="+uid);
		System.out.println("ups="+upw);
		model.addAttribute("loginid",uid);
		model.addAttribute("loginpw",upw);
		return "viewinfo";
	}
	@RequestMapping("/new")
	public String newInfo(HttpServletRequest hsr, Model model) {
		String name=hsr.getParameter("realname");
		String uid=hsr.getParameter("userid");
		String upw=hsr.getParameter("userpw");
		String mob=hsr.getParameter("mobile");
		System.out.println("name="+name);
		System.out.println("uid="+uid);
		System.out.println("upw="+upw);
		System.out.println("mob="+mob);
		model.addAttribute("realname",name);
		model.addAttribute("loginid",uid);
		model.addAttribute("loginpw",upw);
		model.addAttribute("mobile",mob);
		return "newinfo";
	}
	
	@RequestMapping("/login")
	public String getinfo() {
		return "login";
	}
	
	@RequestMapping("/")
	public String onHoem() {
		return "home";
	}
	@RequestMapping("/selected")
	public String doJob(HttpServletRequest hsr, Model model) {
		String strPath=hsr.getParameter("path");
		if(strPath.equals("login")){
			return "login";
		}else if(strPath.equals("newbie")) {
			return "newbie";
		}else {
			return "home";
		}
	}
}
