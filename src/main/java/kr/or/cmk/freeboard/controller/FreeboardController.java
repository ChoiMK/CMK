package kr.or.cmk.freeboard.controller;

import java.util.HashMap;
import java.util.List;

import kr.or.cmk.freeboard.service.FreeBoardService;
import kr.or.cmk.vo.BoardVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


// http://localhost/cmk/freeboard/main.do
@Controller
@RequestMapping("/freeboard/")
public class FreeboardController {
	@Autowired
	private FreeBoardService service;
	
	@RequestMapping("main")
	public ModelAndView freeboardList() throws Exception{
		List<BoardVO> boardList = service.getBoardList(new HashMap<String, String>());
		ModelAndView andView = new ModelAndView();
		andView.addObject("boardList", boardList);
		andView.setViewName("user/freeboard/freeboardList");
		return andView;
	}


}
