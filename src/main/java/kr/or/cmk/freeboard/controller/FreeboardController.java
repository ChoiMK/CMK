package kr.or.cmk.freeboard.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import kr.or.cmk.freeboard.service.FreeBoardService;
import kr.or.cmk.util.GlobalConstant;
import kr.or.cmk.util.RolePagingUtil;
import kr.or.cmk.vo.BoardVO;
import kr.or.cmk.vo.FileItemVO;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;



// http://localhost/cmk/freeboard/main.do
@Controller
@RequestMapping("/freeboard/")
public class FreeboardController {
	@Autowired
	private FreeBoardService service;
	
	 @RequestMapping("main")
	 public ModelAndView freeboardList(ModelAndView andView,
			 @RequestParam(required=false) String search_keycode,
	         @RequestParam(required=false) String search_keyword, 
	         @RequestParam(required=false, defaultValue="1") String currentPage,
	         HttpServletRequest request,
	         Map<String, String>params) throws Exception {
		
		int totalCount;
		int blockCount = 10;
		int blockPage = 5;	
		params.put("search_keycode",search_keycode);
		params.put("search_keyword",search_keyword);
	
		totalCount = service.getTotalCount(params);
		RolePagingUtil pagingUtill = new RolePagingUtil(currentPage, totalCount, blockCount, blockPage, request);
		
		params.put("startCount", String.valueOf(pagingUtill.getStartCount()));
		params.put("endCount", String.valueOf(pagingUtill.getEndCount()));
		List<BoardVO> boardList = service.getBoardList(params);
		
		
		andView.addObject("boardList", boardList);
		andView.addObject("pageHtml", pagingUtill.getPageHtml().toString());
		andView.setViewName("user/freeboard/freeboardList");
		return andView;
	}
	
	@RequestMapping("freeboardView")
	public ModelAndView freeboardView(Map<String,String>params,
			String bo_no,
			ModelAndView andView)throws Exception{
		
		params.put("bo_no", bo_no);
		BoardVO boardInfo = service.getBoardInfo(params);
		andView.addObject("boardInfo",boardInfo);
		andView.setViewName("user/freeboard/freeboardView");
		return andView;
	}
	
	@RequestMapping("updateBoardInfo")
	public ModelAndView updateBoard(BoardVO boardInfo,
			ModelAndView andView)throws Exception{
		service.updateBoardInfo(boardInfo);
		andView.setViewName("redirect:/freeboard/main.do");
		return andView;
	}
	
	@RequestMapping("deleteBoardInfo/{bo_no}")
	public ModelAndView deleteBoard(@PathVariable String bo_no,
			Map<String,String>params,
			ModelAndView andView) throws Exception{
		params.put("bo_no", bo_no);
		service.deleteBoardInfo(params);
		andView.setViewName("redirect:/freeboard/main.do");
		return andView;
	}
	
	@RequestMapping("freeboardForm")
	public ModelAndView freeboardForm(ModelAndView andView)throws Exception{
		andView.setViewName("user/freeboard/freeboardForm");
		return andView;
	}
	
	@RequestMapping("insertBoardInfo")
	public ModelAndView insertBoard(BoardVO boardInfo,
			HttpServletRequest request,
			ModelAndView andView)throws Exception{
		
		MultipartHttpServletRequest wrapper = (MultipartHttpServletRequest)request;
		List<FileItemVO> fileItemList = new ArrayList<FileItemVO>();
		Iterator<String> ItfileNames = wrapper.getFileNames();
		
		while(ItfileNames.hasNext()){
			String fileName = ItfileNames.next();
			MultipartFile file = wrapper.getFile(fileName);
				
				if(file.getSize()>0){
					FileItemVO fileItemInfo = new FileItemVO();
					String contentType = wrapper.getMultipartContentType(fileName);
					
					String originalFileName = file.getOriginalFilename();
					String uploadFileName = originalFileName;
					
					fileItemInfo.setFile_name(uploadFileName);
					String saveFileName = makeSaveFileName(uploadFileName);
					fileItemInfo.setFile_save_name(saveFileName);
					fileItemInfo.setFile_content_type(contentType);
					fileItemInfo.setFile_size(String.valueOf(file.getSize()));
					
					File saveFile = new File(GlobalConstant.SAVE_PATH, saveFileName);
					
					file.transferTo(saveFile);
					
					fileItemList.add(fileItemInfo);
					fileItemInfo = null;
				}
		}
		boardInfo.setAttachFileItemList(fileItemList);
		service.insertBoardInfo(boardInfo);
		andView.setViewName("redirect:/freeboard/main.do");
		return andView;
		
		
		 
	}
	private String makeSaveFileName(String fileNames){
		   String baseName = FilenameUtils.getBaseName(fileNames);
        String uuid = UUID.randomUUID().toString().replace("-", "");
        String extension = FilenameUtils.getExtension(fileNames);
        String saveFileName = baseName + "_" + uuid + "." + extension;
        return saveFileName;
	  }

	@RequestMapping("freeboardReplyForm")
	public ModelAndView freeboardReplyForm(ModelAndView andView)throws Exception{
		andView.setViewName("user/freeboard/freeboardReplyForm");
		return andView;
	}
	
	@RequestMapping("insertFreeboardReply")
	public ModelAndView insertBoardReply(ModelAndView andView,
			BoardVO boardInfo) throws Exception{
		service.insertBoardReplyInfo(boardInfo);
		andView.setViewName("redirect:/freeboard/main.do");
		return andView;
	}
	
	@RequestMapping("fileDownload")
	public ModelAndView fileDownload(String fileSeq,
			Map<String,String>params,
			ModelAndView andView)throws Exception{
		
		params.put("file_Seq", fileSeq);
		FileItemVO fileInfo = service.getFileItemInfo(params);
		
		File downloadFile = new File(GlobalConstant.SAVE_PATH, fileInfo.getFile_save_name());
		
		andView.addObject("fileInfo",fileInfo);
		andView.addObject("downloadFile",downloadFile);
		andView.setViewName("downloadView");
		return andView;
	}
	
	
	
	
	
}
