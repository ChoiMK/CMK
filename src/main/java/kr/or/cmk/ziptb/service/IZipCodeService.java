package kr.or.cmk.ziptb.service;


import java.util.List;
import java.util.Map;

import kr.or.cmk.vo.ZiptbVO;

public interface IZipCodeService {
	public List<ZiptbVO> getZiptbList(Map<String, String> params)throws Exception;
}
