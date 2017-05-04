package kr.or.cmk.member.service;

import java.util.List;
import java.util.Map;

import kr.or.cmk.vo.MemberVO;

// 기존의 트랜잭션 처리 : DAO 익셉션은 iBatis가 rollback 후 Sevice에 전달 후 Service에서
//                       익셉션 처리
//                                    @Transactional(Rollback 정보)
// 스프링 트랜잭션 처리 : Dao 익셉션 -> Service 익셉션 취득 -> Controller 익셉션 취득
//                                                           Rollback 정보 취득                                                      
//                       -> 스프링 프레임웍 익셉션 취득(RollBack)
//                          Rollback 정보 취득
public interface IMemberService {
	public MemberVO getMemberInfo(Map<String, String> params) throws Exception;
	public List<MemberVO> getMemberList(Map<String, String> params) throws Exception;
	public void insertMemberInfo(MemberVO memberInfo) throws Exception;
	public int deleteMemberInfo(Map<String, String> params) throws Exception;
	public int updateMemberInfo(MemberVO memberInfo) throws Exception;
	public int getTotalCount(Map<String, String> params) throws Exception;
	public int updateAdminInfo(MemberVO memberInfo) throws Exception;
}
