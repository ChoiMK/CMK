package kr.or.cmk.ziptb.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.cmk.vo.ZiptbVO;

import com.ibatis.sqlmap.client.SqlMapClient;
@Repository("zipCodeDao")
public class IZipCodeDaoImpl implements IZipCodeDao {
	
	@Autowired
	private SqlMapClient client;
	

	@Override
	public List<ZiptbVO> getZiptbList(Map<String, String> params)
			throws Exception {
		return client.queryForList("ziptb.ziptbList",params);
	}
	
	
	
				
}
