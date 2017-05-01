package kr.or.cmk.freeboard.dao;


import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.cmk.vo.BoardVO;
import kr.or.cmk.vo.FileItemVO;


public interface FreeBoardDao {
	public List<BoardVO> getBoardList(Map<String, String> params) throws Exception;
	public void insertBoardInfo(BoardVO boardInfo) throws Exception;
	public void insertBoardReplyInfo(BoardVO boardInfo) throws Exception;
	public BoardVO getBoardInfo(Map<String, String> params) throws Exception;
	public int updateBoardInfo(BoardVO boardInfo) throws Exception;
	public int deleteBoardInfo(Map<String, String> params) throws Exception;
	public FileItemVO getFileItemInfo(Map<String, String> params) throws Exception;
	public int getTotalCount(Map<String, String> params) throws Exception;
}
