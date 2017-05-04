package kr.or.cmk.member.dao;

import java.util.List;
import java.util.Map;

import kr.or.cmk.vo.MemberVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

//public class IMemberDaoImpl implements IMemberDao, ApplicationContextAware {
// <bean name="memberDao" class="kr.or.ddit.member.dao.IMemberDaoImpl"/>
@Repository("memberDao")
public class IMemberDaoImpl implements IMemberDao {
//	@Resource
	@Autowired
	private SqlMapClient client;
	
	public IMemberDaoImpl() {
	}

//	@Override
//	public void setApplicationContext(ApplicationContext webApplicationConext)
//			throws BeansException {
//		client = (SqlMapClient) webApplicationConext.getBean("sqlMapClient");
//	}

	@Override
	public MemberVO getMemberInfo(Map<String, String> params)
			throws Exception {
		return (MemberVO) client.queryForObject("member.memberInfo", params);
	}

	@Override
	public List<MemberVO> getMemberList(Map<String, String> params) throws Exception {
		return client.queryForList("member.memberList", params);
	}

	@Override
	public void insertMemberInfo(MemberVO memberInfo) throws Exception {
		client.insert("member.insertMember", memberInfo);
	}

	@Override
	public int deleteMemberInfo(Map<String, String> params) throws Exception {
		return client.update("member.deleteMember", params);
	}

	@Override
	public int updateMemberInfo(MemberVO memberInfo) throws Exception {
		return client.update("member.updateMember", memberInfo);
	}


	public void initMethod(){
	}
	
	public void destroyMethod(){
	}

	@Override
	public int getTotalCount(Map<String, String> params) throws Exception {
		return (int) client.queryForObject("member.totalCount", params);
	}

	@Override
	public int updateAdminInfo(MemberVO memberInfo) throws Exception {
		return client.update("member.updateAdmin", memberInfo);
	}
}











