package kr.or.cmk.member.dao;

import java.util.List;
import java.util.Map;

import kr.or.cmk.vo.MemberVO;

public interface IMemberDao {
	public MemberVO getMemberInfo(Map<String, String> params) throws Exception;
	public List<MemberVO> getMemberList(Map<String, String> params) throws Exception;
	public void insertMemberInfo(MemberVO memberInfo) throws Exception;
	public int deleteMemberInfo(Map<String, String> params) throws Exception;
	public int updateMemberInfo(MemberVO memberInfo) throws Exception;
	public int getTotalCount(Map<String, String> params) throws Exception;
	public int updateAdminInfo(MemberVO memberInfo) throws Exception;

}
