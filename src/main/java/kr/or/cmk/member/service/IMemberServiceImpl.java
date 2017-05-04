package kr.or.cmk.member.service;

import java.util.List;
import java.util.Map;

import kr.or.cmk.member.dao.IMemberDao;
import kr.or.cmk.vo.MemberVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

//public class IMemberServiceImpl implements IMemberService, ApplicationContextAware {
// <bean name="memberService" class="kr.or.ddit.member.service.IMemberServiceImpl"/>
@Service("memberService")
public class IMemberServiceImpl implements IMemberService{
	
//	@Resource
	@Autowired
	private IMemberDao dao;
	
	
//	@Override
//	public void setApplicationContext(ApplicationContext context)
//			throws BeansException {
//		this.dao = context.getBean("memberDao", IMemberDao.class);
//	}

	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public MemberVO getMemberInfo(Map<String, String> params) throws Exception{
		MemberVO memberInfo = dao.getMemberInfo(params);
		return memberInfo;
	}
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public List<MemberVO> getMemberList(Map<String, String> params) throws Exception{
		List<MemberVO> memberList = dao.getMemberList(params);
		return memberList;
	}
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public void insertMemberInfo(MemberVO memberInfo) throws Exception{
		dao.insertMemberInfo(memberInfo);
	}
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public int deleteMemberInfo(Map<String, String> params) throws Exception{
		int deleteCnt = dao.deleteMemberInfo(params);
		return deleteCnt;
	}
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@Override
	public int updateMemberInfo(MemberVO memberInfo) throws Exception{
		int updateCnt = dao.updateMemberInfo(memberInfo);
		return updateCnt;
	}

	public void initMethod(){
	}
	
	public void destroyMethod(){
	}

	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public int getTotalCount(Map<String, String> params) throws Exception {
		int totalCnt = 0;
		totalCnt = dao.getTotalCount(params);
		return totalCnt;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)

	@Override
	public int updateAdminInfo(MemberVO memberInfo) throws Exception {
		int updateCnt = 0;
		updateCnt = dao.updateAdminInfo(memberInfo);
		return updateCnt;
	}
}










