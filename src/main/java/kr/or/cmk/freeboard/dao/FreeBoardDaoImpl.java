package kr.or.cmk.freeboard.dao;


import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.cmk.vo.BoardVO;
import kr.or.cmk.vo.FileItemVO;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository("freeboardDao")
public class FreeBoardDaoImpl implements FreeBoardDao{

	@Autowired
	private SqlMapClient client;
	
	@Override
	public List<BoardVO> getBoardList(Map<String, String> params) throws Exception {
		return client.queryForList("board.boardList", params);
	}

	@Override
	public void insertBoardInfo(BoardVO boardInfo) throws Exception {
		// freeboard table 대상 insert
		// fileitem table 대상 insert*2
		try{
			// commit : startTransaction() => 다수 쿼리 질의 => commitTransaction()
			//			endTransaction()
			// rollback : startTransaction() => 다수 쿼리 질의 중에 에러 => endTransaction()
			client.startTransaction();
			// 다수의 쿼리가 질의
			
			String bo_no = (String) client.insert("board.insertBoard", boardInfo);
			
	
			List<FileItemVO> fileItemList = boardInfo.getAttachFileItemList();
			if(fileItemList != null){
			for(FileItemVO fileItemInfo : fileItemList){
				fileItemInfo.setFile_bo_no(bo_no);
				client.insert("board.insertFileItem", fileItemInfo);
				}
			}
			client.commitTransaction();
		}finally{
			client.endTransaction();
		}
	}

	@Override
	public BoardVO getBoardInfo(Map<String, String> params) throws Exception{
		client.update("board.updateHit", params);
		return (BoardVO) client.queryForObject("board.boardInfo",params);
	}

	@Override
	public int updateBoardInfo(BoardVO boardInfo) throws Exception {
		return client.update("board.updateBoard", boardInfo);
	}

	@Override
	public int deleteBoardInfo(Map<String, String> params ) throws Exception {
		return client.update("board.deleteBoard", params);
	}


	@Override
	public FileItemVO getFileItemInfo(Map<String, String> params) throws Exception{
		client.update("board.updateDownloadHit", params);
		return (FileItemVO) client.queryForObject("board.fileitemInfo", params);
	}

	@Override
	public void insertBoardReplyInfo(BoardVO boardInfo) throws Exception {
		// 부모 게시글 : bo_group, bo_depth, bo_seq
		// 자식 게시글 : bo_title, bo_nickname, bo_content, bo_mail....
		String bo_seq = "";
		if("0".intern() == boardInfo.getBo_seq().intern()){
			bo_seq = (String) client.queryForObject("board.incrementSeq", boardInfo);
		}else{
			client.update("board.updateSeq", boardInfo);
			bo_seq = String.valueOf(Integer.parseInt(boardInfo.getBo_seq()) + 1);
		}
		boardInfo.setBo_seq(bo_seq);
		
		boardInfo.setBo_depth(String.valueOf(Integer.parseInt(boardInfo.getBo_depth())+1));
		
		client.insert("board.insertReplyInfo", boardInfo);
	}

	@Override
	public int getTotalCount(Map<String, String> params) throws Exception {
		return (int) client.queryForObject("board.totalCount", params);
	}


}
