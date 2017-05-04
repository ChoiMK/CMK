package kr.or.cmk.join.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.cmk.member.service.IMemberService;
import kr.or.cmk.vo.MemberVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
@RequestMapping("/admin/join/")
public class AdminJoinController {
	@Autowired
	private IMemberService service;

	@RequestMapping("main")
	public ModelAndView loginForm(){
		return new ModelAndView("admin/main");
	}
	
	@RequestMapping("loginCheck")
	public ModelAndView loginCheck(Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session, ModelAndView andView, String mem_id,
			String mem_pass) throws Exception {

		params.put("mem_id", mem_id);
		params.put("mem_pass", mem_pass);

		MemberVO memberInfo = service.getMemberInfo(params);

		RedirectView redirectView = new RedirectView();
		if(memberInfo != null){
			if (!memberInfo.getMem_id().equals("master")) {
				String message = "";
				message = URLEncoder.encode("관리자가 아닙니다.", "UTF-8");
				redirectView.setUrl(request.getContextPath()
						+ "/admin/join/main.do?message=" + message);
			} else {
				// String message = "";
				session.setAttribute("LOGIN_MEMBERINFO", memberInfo);
				// message = URLEncoder.encode("로그인성공했습니다.", "UTF-8");
				redirectView.setUrl(request.getContextPath()
						+ "/admin/member/memberMgr.do");
			}
		}else{
			String message = "";
			message = URLEncoder.encode("관리자가 아닙니다.", "UTF-8");
			redirectView.setUrl(request.getContextPath()
					+ "/admin/join/main.do?message=" + message);
		}
		redirectView.setExposeModelAttributes(false);
		andView.setView(redirectView);

		return andView;
	}

	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		String message = "";
		try {
			message = URLEncoder.encode("로그아웃했습니다.", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/admin/join/main.do?message=" + message;
	}
}
