package kr.or.cmk.view;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.cmk.vo.FileItemVO;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

// <bean name="downloadView" class="kr.or.ddit.view.FileDownloadView"/>
@Component("downloadView")
public class FileDownloadView extends AbstractView {
	// 컨트롤러 메서드 반환 : View 클래스의 빈 등록시의 id 또는 name 값
	// BeanNameViewResolver가 취득 후에 해당 View 빈 클래스의 renderMergedOutputModel() 콜백
	
	// new ModelAndView("downloadView", "downloadFile", downloadFile)
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		File downloadFile = (File)model.get("downloadFile");
		FileItemVO fileInfo = (FileItemVO) model.get("fileInfo");
		
		response.setHeader("Content-Disposition", "attachment;filename=" + fileInfo.getFile_name());
		response.setContentType("application/octet-stream");
		response.setContentLength((int)downloadFile.length());
		
		byte[] buffer = new byte[(int)downloadFile.length()];
		
		BufferedInputStream bi = new BufferedInputStream(new FileInputStream(downloadFile));
		BufferedOutputStream bo = new BufferedOutputStream(response.getOutputStream());
		
		int read = 0;
		while((read = bi.read(buffer)) != -1){
			bo.write(buffer, 0, read);
		}
		
		bi.close();
		bo.close();
	}

}
