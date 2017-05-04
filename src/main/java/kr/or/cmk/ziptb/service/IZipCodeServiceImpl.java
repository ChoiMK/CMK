package kr.or.cmk.ziptb.service;

import java.util.List;
import java.util.Map;

import kr.or.cmk.vo.ZiptbVO;
import kr.or.cmk.ziptb.dao.IZipCodeDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("zipCodeService")
public class IZipCodeServiceImpl implements IZipCodeService {
	
	@Autowired
	private IZipCodeDao dao;
	
	
	@Transactional(propagation=Propagation.REQUIRED, readOnly=true)
	@Override
	public List<ZiptbVO> getZiptbList(Map<String, String> params)throws Exception {
		List<ZiptbVO> zibtbList = dao.getZiptbList(params);
		return zibtbList;
	}

}
