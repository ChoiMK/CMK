package kr.or.cmk.ziptb.dao;


import java.util.List;
import java.util.Map;

import kr.or.cmk.vo.ZiptbVO;



public interface IZipCodeDao {
	public List<ZiptbVO> getZiptbList(Map<String, String> params) throws Exception;
}
