package com.humanhotel.app;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
	private HttpSession session;
	
	@Autowired
	private SqlSession sqlSession; 
	
	@RequestMapping("/")
	public String onHoem() {
		return "home";
	}
	@RequestMapping("/login")
	public String getinfo() {
		return "login";
	}
	@RequestMapping("/logout")
	public String logout(HttpServletRequest hsr) {
		HttpSession session=hsr.getSession();
		session.invalidate();
		return "home";
	}
	@RequestMapping("/newbie")
	public String getInfo() {
		return "newbie";
	}
	
	@RequestMapping("/room")
	public String room(HttpServletRequest hsr,Model model) {
		HttpSession session=hsr.getSession();
		if(session.getAttribute("loginid")==null) {
			return "redirect:/login"; 
		} 
		// 여기서 interface 호출, 결과를 room.jsp로 전송.
		iRoom room=sqlSession.getMapper(iRoom.class); 
		ArrayList<Roominfo> roominfo=room.getRoomList();
		model.addAttribute("list",roominfo); 
		ArrayList<Roomtype> roomtype=room.getRoomType();
		model.addAttribute("type",roomtype);
		return "room";
	}
	
	@RequestMapping(value="/check_user",method=RequestMethod.POST)
	public String check_user(HttpServletRequest hsr, Model model) {
		String userid=hsr.getParameter("userid");
		String userpw=hsr.getParameter("userpw");
		System.out.println("userid: " +userid);
		System.out.println("userpw: "+userpw);
		 HttpSession session=hsr.getSession();
		 session.setAttribute("loginid", userid);
		 return "redirect:/booking";
	}
	@RequestMapping(value="/booking",method=RequestMethod.GET)
	public String booking(HttpServletRequest hsr) {
		HttpSession session=hsr.getSession();
		String loginid=(String)session.getAttribute("loginid");
		if(loginid.equals("") || loginid==null) {
			return "redirect:/login";
		}else {
			return "booking";
		}
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

	/*
	 * @RequestMapping("/info") public String viewInfo(HttpServletRequest hsr, Model
	 * model) { String uid=hsr.getParameter("userid"); String
	 * upw=hsr.getParameter("userpw"); System.out.println("uid="+uid);
	 * System.out.println("ups="+upw); model.addAttribute("loginid",uid);
	 * model.addAttribute("loginpw",upw); return "viewinfo"; }
	 */
	/*
	 * @RequestMapping("/new") public String newInfo(HttpServletRequest hsr, Model
	 * model) { String name=hsr.getParameter("realname"); String
	 * uid=hsr.getParameter("userid"); String upw=hsr.getParameter("userpw"); String
	 * mob=hsr.getParameter("mobile"); System.out.println("name="+name);
	 * System.out.println("uid="+uid); System.out.println("upw="+upw);
	 * System.out.println("mob="+mob); model.addAttribute("realname",name);
	 * model.addAttribute("loginid",uid); model.addAttribute("loginpw",upw);
	 * model.addAttribute("mobile",mob); return "newinfo"; }
	 */
	
}
