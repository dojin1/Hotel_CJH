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
import org.springframework.web.bind.annotation.ResponseBody;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

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
	@RequestMapping(value="/signin",method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String doSignin(HttpServletRequest hsr) {
		//insert into member
		String name=hsr.getParameter("newname");
		String loginid=hsr.getParameter("newid");
		int passcode=Integer.parseInt(hsr.getParameter("newpw"));
		iRoom room=sqlSession.getMapper(iRoom.class);
		room.doSignin(name,loginid,passcode);
		return "login";
	}
	@RequestMapping(value="/getRoomList",method=RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String getRoomList(HttpServletRequest hsr) {
		iRoom room=sqlSession.getMapper(iRoom.class);
		ArrayList<Roominfo> roominfo=room.getRoomList();
		// ã���� �����ͷ� JSONArray�����
		JSONArray ja = new JSONArray();
		for(int i=0; i<roominfo.size(); i++) {
			JSONObject jo=new JSONObject();
			jo.put("roomcode", roominfo.get(i).getRoomcode());
			jo.put("roomname", roominfo.get(i).getRoomname());
			jo.put("typename", roominfo.get(i).getTypename());
			jo.put("howmany", roominfo.get(i).getHowmany());
			jo.put("howmuch", roominfo.get(i).getHowmuch());
			ja.add(jo);
		}
		return ja.toString();
	}
	@RequestMapping(value="/updateRoom",method=RequestMethod.POST,
			produces = "application/text; charaset=utf8")
	@ResponseBody
	public String updateRoom(HttpServletRequest hsr) {
		iRoom room=sqlSession.getMapper(iRoom.class);
		room.doUpdateRoom(Integer.parseInt(hsr.getParameter("roomcode")), 
				hsr.getParameter("roomname"),
				Integer.parseInt(hsr.getParameter("roomtype")),
				Integer.parseInt(hsr.getParameter("howmany")),
				Integer.parseInt(hsr.getParameter("howmuch")));
		return "ok";
	}
	@RequestMapping(value="/deleteRoom",method=RequestMethod.POST,
			produces = "application/text; charaset=utf8")
	@ResponseBody
	public String deleteRoom(HttpServletRequest hsr) {
		int roomcode=Integer.parseInt(hsr.getParameter("roomcode"));
		iRoom room=sqlSession.getMapper(iRoom.class);
		room.doDeleteRoom(roomcode);
		return "ok";
	}
	@RequestMapping(value="/addRoom",method=RequestMethod.POST,
			produces = "application/text; charaset=utf8")
	@ResponseBody
	public String addRoom(HttpServletRequest hsr) {
		String rname=hsr.getParameter("roomname");
		int rtype=Integer.parseInt(hsr.getParameter("roomtype"));
		int howmany=Integer.parseInt(hsr.getParameter("howmany"));
		int howmuch=Integer.parseInt(hsr.getParameter("howmuch"));
		iRoom room=sqlSession.getMapper(iRoom.class);
		room.doAddRoom(rname, rtype, howmany, howmuch);
		return "ok";
	}
	
	@RequestMapping("/room")
	public String room(HttpServletRequest hsr,Model model) {
		HttpSession session=hsr.getSession();
		if(session.getAttribute("loginid")==null) {
			return "redirect:/login"; 
		} 
		// ���⼭ interface ȣ��, ����� room.jsp�� ����.
		iRoom room=sqlSession.getMapper(iRoom.class); 
		/*
		 * ArrayList<Roominfo> roominfo=room.getRoomList();
		 * model.addAttribute("list",roominfo);
		 */
		ArrayList<Roomtype> roomtype=room.getRoomType();
		model.addAttribute("roomtype",roomtype);
		return "room";
	}
	
	@RequestMapping(value="/check_user",method=RequestMethod.POST)
	public String check_user(HttpServletRequest hsr, Model model) {
		String userid=hsr.getParameter("userid");
		String userpw=hsr.getParameter("userpw");
		//DB에서 유저확인: 기존유저면 booking 신규유저면 home.
		iRoom room=sqlSession.getMapper(iRoom.class); 
		int n=room.doCheckUser(userid, userpw);
		if(n>0) {
			HttpSession session=hsr.getSession();
			session.setAttribute("loginid", userid);
			return "redirect:/booking";	// RequestMapping 의 경로이름.		
		} else { // 비등록회원
			return "login";
		}
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
