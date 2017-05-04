package kr.or.cmk.admin.freeboard.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kr.or.cmk.freeboard.service.FreeBoardService;
import kr.or.cmk.util.GlobalConstant;
import kr.or.cmk.util.RolePagingUtil;
import kr.or.cmk.vo.BoardVO;
import kr.or.cmk.vo.FileItemVO;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin/freeboard/")
public class AdminFreeboardController {

	@Autowired
	private FreeBoardService service;
	@Autowired
	private HttpSession session;

	@RequestMapping("ADfreeboardList")
	public ModelAndView freeboardList(String search_keyword, String search_keycode, HttpServletRequest request,
			 String currentPage, Map<String, String> params, ModelAndView andView) throws Exception{
		
		int totalCount; 
		int blockCount = 10;
		int blockPage = 5;
		if(currentPage == null){
			currentPage = "1";
		}
		params.put("search_keycode", search_keycode);
		params.put("search_keyword", search_keyword);

		totalCount = service.getTotalCount(params);
		RolePagingUtil pagingUtill = new RolePagingUtil(currentPage, totalCount, blockCount, blockPage, request);
		
		params.put("startCount", String.valueOf(pagingUtill.getStartCount()));
		params.put("endCount", String.valueOf(pagingUtill.getEndCount()));
		List<BoardVO> boardList = service.getBoardList(params);
		
		andView.addObject("boardList", boardList);
		andView.addObject("pageHtml", pagingUtill.getPageHtml().toString());
//		andView.setViewName("freeboard/freeboardList");
		return andView;
	}
	
	@RequestMapping("ADfreeboardView")
	public ModelAndView freeboardView(ModelAndView andView, Map<String, String> params, 
			String bo_no) throws Exception{
		params.put("bo_no", bo_no);
		
		BoardVO boardInfo = service.getBoardInfo(params);
		andView.addObject("boardInfo", boardInfo);
		
		return andView;
	}
	
	@RequestMapping("ADfreeboardForm")
	public void freeboardForm(){}
	
	@RequestMapping("ADinsertBoard")
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
		andView.setViewName("redirect:/admin/freeboard/ADfreeboardList.do");
		return andView;
		
		
		 
	}
	private String makeSaveFileName(String fileNames){
		   String baseName = FilenameUtils.getBaseName(fileNames);
        String uuid = UUID.randomUUID().toString().replace("-", "");
        String extension = FilenameUtils.getExtension(fileNames);
        String saveFileName = baseName + "_" + uuid + "." + extension;
        return saveFileName;
	  }
	
	@RequestMapping("ADupdateBoard")
	public String updateBoard(String bo_no, BoardVO boardInfo) throws Exception{
		service.updateBoardInfo(boardInfo);
		return "redirect:/admin/freeboard/ADfreeboardList.do";
	}
	
	@RequestMapping("ADdeleteBoard")
	public String deleteBoard(String bo_no, Map<String, String> params) throws Exception{
		params.put("bo_no", bo_no);
		service.deleteBoardInfo(params);
		return "redirect:/admin/freeboard/ADfreeboardList.do";
	}
	
	@RequestMapping("ADfreeboardReplyForm")
	public void freeboardReplyForm(){}
	
	@RequestMapping("ADinsertFreeboardReply")
	public String insertFreeboardReply(BoardVO boardInfo) throws Exception{
		
		service.insertBoardReplyInfo(boardInfo);
		return "redirect:/admin/freeboard/ADfreeboardList.do";
	}
	
	@RequestMapping("fileDownload")
	public ModelAndView fileDownload(ModelAndView andView, Map<String, String> params, String file_seq) throws Exception{
		 params.put("file_seq", file_seq);
	      FileItemVO fileInfo = service.getFileItemInfo(params);
	      
	      File downloadFile = new File(GlobalConstant.SAVE_PATH, fileInfo.getFile_save_name());
	      andView.setViewName("downloadView");
	      andView.addObject("downloadFile",downloadFile);
	      String filename = fileInfo.getFile_name();
	      andView.addObject("filename", filename);
//	      return new ModelAndView("downloadView", "downloadFile", downloadFile, "fileName" , fileInfo.getFile_name());
		return andView;
	}
}
