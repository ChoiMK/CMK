package kr.or.cmk.admin.member.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.cmk.member.service.IMemberService;
import kr.or.cmk.util.RolePagingUtil;
import kr.or.cmk.vo.MemberVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin/member/")
public class MemberController {
	
	@Autowired
	private IMemberService service;

	@RequestMapping("memberMgr")
	public ModelAndView memberMgr(ModelAndView andView, Map<String, String> params, HttpServletRequest request,
			String mem_add1, String mem_hp, String mem_year, 
			String mem_month, String mem_day, String search_base_keyword, String search_base,
			String currentPage, String blockCount) throws Exception{
		
		if(currentPage == null){
			currentPage = "1";
		}
		if(blockCount == null){
			blockCount = "10";
		}
		int blockPage = 5;
		
		params.put("search_base", search_base);
		params.put("search_base_keyword", search_base_keyword);
		params.put("currentPage", currentPage);
		params.put("blockCount", blockCount);
		params.put("mem_hp", mem_hp);
		params.put("mem_add1", mem_add1);
		params.put("mem_year", mem_year);
		params.put("mem_month", mem_month);
		params.put("mem_day", mem_day);
		
		int totalCount;
		String pageHtml;
		
		totalCount = service.getTotalCount(params);
		
//		if(search_base_keyword != null && search_base != null){
			RolePagingUtil pagingUtil = new RolePagingUtil(currentPage, totalCount, Integer.parseInt(blockCount), blockPage, request);
			pageHtml = pagingUtil.getPageHtml().toString();
			params.put("startCount", String.valueOf(pagingUtil.getStartCount()));
			params.put("endCount", String.valueOf(pagingUtil.getEndCount()));
//		}
		
		List<MemberVO> memberList = service.getMemberList(params);
		
		andView.addObject("memberList", memberList);
		andView.addObject("pageHtml", pageHtml);
		andView.addObject("blockCount", blockCount);
		
		
		return andView;
	}
	
	
	@RequestMapping("memberDetail")
	public ModelAndView memberDetail(ModelAndView andView, String mem_id,
			Map<String, String> params) throws Exception{
		params.put("mem_id", mem_id);
		
		MemberVO memberInfo = service.getMemberInfo(params);
		
		andView.addObject("memberInfo", memberInfo);
		
		return andView;
		
	}
	
	@RequestMapping("updateMember")
	public String updateMember(MemberVO memberInfo) throws Exception{
		service.updateAdminInfo(memberInfo);
		return "redirect:/admin/member/memberMgr.do";
		
	}
	
	@RequestMapping("ExcelDownload")
	public ModelAndView excelDownload(HttpServletRequest request, HttpServletResponse response
			,String excel){
		response.setHeader("Content-Disposition", "attachment; filename=member.xls");
	 	response.setHeader("Content-Description", "JSP generate excel file");
	 	response.setContentType("application/vnd.ms-excel");
	 	
		String page = "<table>";
		page += "<tr><th>아이디</th>"
				+ "<th>이름</th>"
				+ "<th>생일</th>"
				+ "<th>메일</th></tr>";
		page += excel;
		page += "</table>";
		request.setAttribute("page", page);
		
		return new ModelAndView("excelDownload");
	}
}
