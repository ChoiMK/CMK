package kr.or.cmk.freeboard.service;


import java.util.List;
import java.util.Map;

import kr.or.cmk.freeboard.dao.FreeBoardDao;
import kr.or.cmk.vo.BoardVO;
import kr.or.cmk.vo.FileItemVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("freeboardService")
public class FreeBoardServiceImpl implements FreeBoardService{
	
	@Autowired
	private FreeBoardDao dao;

	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public List<BoardVO> getBoardList(Map<String, String> params) throws Exception {
		List<BoardVO> boardList  = dao.getBoardList(params);
		return boardList;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public void insertBoardInfo(BoardVO boardInfo) throws Exception{
			dao.insertBoardInfo(boardInfo);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public BoardVO getBoardInfo(Map<String, String> params)throws Exception {
		BoardVO boardInfo = dao.getBoardInfo(params);
		return boardInfo;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public int updateBoardInfo(BoardVO boardInfo)throws Exception {
		int updateCnt = dao.updateBoardInfo(boardInfo);
		return updateCnt;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public int deleteBoardInfo(Map<String , String> params)throws Exception {
		int deleteCnt = dao.deleteBoardInfo(params);
		return deleteCnt;
	}

	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public FileItemVO getFileItemInfo(Map<String, String> params) throws Exception{
		FileItemVO fileItemInfo = dao.getFileItemInfo(params);
		return fileItemInfo;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public void insertBoardReplyInfo(BoardVO boardInfo) throws Exception{
			dao.insertBoardReplyInfo(boardInfo);
	}
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public int getTotalCount(Map<String, String> params)throws Exception {
		int totalCount = dao.getTotalCount(params);
		return totalCount;
	}


}
