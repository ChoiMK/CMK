package kr.or.cmk.member.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.or.cmk.member.service.IMemberService;
import kr.or.cmk.vo.MemberVO;
import kr.or.cmk.vo.ZiptbVO;
import kr.or.cmk.ziptb.service.IZipCodeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/member/")
public class UserMemberController {
	@Autowired
	private IMemberService service;
	
	@Autowired
	private IZipCodeService zipService;
	
	@RequestMapping("memberForm")
	public ModelAndView memberForm(ModelAndView andView)throws Exception{
		andView.setViewName("user/member/memberForm");
		return andView;
	}
	
	@RequestMapping("zipcodeSearch")
	public ModelAndView zipcodeSearch(ModelAndView andView)throws Exception{
		andView.setViewName("member/zipcodeSearch");
		return andView;
	}
	
	
	@RequestMapping("zipSearch")
	public ModelAndView zipSearch(ModelAndView andView,
			String dong,
			Map<String,String>params)throws Exception{
		params.put("dong", dong);
		
		List<ZiptbVO> zipList = zipService.getZiptbList(params);
		
		andView.addObject("zipList", zipList);
		andView.setViewName("jsonConvertView");
		return andView;
	}
	
	@RequestMapping("idCheck")
	public ModelAndView idCheck(ModelAndView andView,
			Map<String,String>params,
			String mem_id)throws Exception{
		
		params.put("mem_id", mem_id);
		MemberVO memberInfo = service.getMemberInfo(params);
		
		if(memberInfo == null){
			andView.addObject("flag","사용가능한 아이디입니다");
		}else{
			andView.addObject("flag","이미 사용중인 아이디입니다");
		}
		andView.setViewName("jsonConvertView");
		return andView;
	}
	
	@RequestMapping("insertMemberInfo")
	public ModelAndView insertMember(MemberVO memberInfo,
			ModelAndView andView) throws Exception{
		service.insertMemberInfo(memberInfo);
		String message = "";
		try {
			message = URLEncoder.encode("회원가입이 완료되었습니다.로그인해주세요.", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		andView.setViewName("redirect:/freeboard/main.do?message="+message);
		return andView;
	}
	
	@RequestMapping("memberProfile")
	public ModelAndView memberProfileForm(ModelAndView andView,
			String mem_id,
			Map<String,String>params) throws Exception{
		params.put("mem_id", mem_id);
		MemberVO memberInfo = service.getMemberInfo(params);
		andView.addObject("memberInfo",memberInfo);
		andView.setViewName("member/memberProfile");
		return andView;
	}
	
	@RequestMapping("deleteMemberInfo")
	public ModelAndView deleteMember(ModelAndView andView,
			String mem_id,
			Map<String,String>params,
			HttpSession session)throws Exception{
		String message = "";
		params.put("mem_id", mem_id);
		service.deleteMemberInfo(params);
		session.invalidate();
		message = URLEncoder.encode("탈퇴처리가 완료되었습니다.", "UTF-8");
		andView.setViewName("redirect:/member/memberProfile.do?message="+message);
		return andView;
	}
	
	@RequestMapping("updateMemberInfo")
	public ModelAndView updateMember(ModelAndView andView,
			MemberVO memberInfo,
			String mem_id)throws Exception{
		String message = "";
		service.updateMemberInfo(memberInfo);
		message = URLEncoder.encode("회원정보가 수정되었습니다.", "UTF-8");
		andView.setViewName("redirect:/member/memberProfile.do?message="+message);
		return andView;
	}
	
	
	
	
}
