package kr.or.cmk.join.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.cmk.member.service.IMemberService;
import kr.or.cmk.vo.MemberVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/join/")
public class JoinController {
	@Autowired
	public IMemberService service;
	
	@RequestMapping("loginCheck.do")
	public ModelAndView loginCheck(String mem_id,
			 String mem_pass,
			 HttpSession session,
			 HashMap<String, String>params,
			 ModelAndView andView,
			 HttpServletRequest request)throws Exception{
	
		params.put("mem_id", mem_id);
		params.put("mem_pass", mem_pass);
		
		MemberVO memberInfo = service.getMemberInfo(params);
		
		RedirectView redirectView = new RedirectView();
		if(memberInfo == null){
			String message = "";
			message = URLEncoder.encode("회원이아닙니다", "UTF-8");
			redirectView.setUrl(request.getContextPath() + "/freeboard/main.do?message="+message);
		}else{
			redirectView.setUrl(request.getContextPath() + "/freeboard/main.do");
			session.setAttribute("LOGIN_MEMBERINFO", memberInfo);
		}
		redirectView.setExposeModelAttributes(false);
		andView.setView(redirectView);
		return andView;
	}
	
	@RequestMapping("logout")
	public ModelAndView logout(HttpSession session,
			ModelAndView andView){
		session.invalidate();
		String message = ""; 
		try {
			message = URLEncoder.encode("로그아웃 됬습니다", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		andView.setViewName("redirect:/freeboard/main.do?message="+message);
		return andView;
	}
}
