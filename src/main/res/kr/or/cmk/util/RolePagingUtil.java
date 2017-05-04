package kr.or.cmk.util;


import javax.servlet.http.HttpServletRequest;

public class RolePagingUtil {
	private int currentPage;	// 현재 페이지 넘버
	private int totalCount;		// 전체 게시글 수
	private int totalPage;		// 전체 페이지 수
	private int blockCount;		// 페이지 당 출력 될 게시글 수
	private int blockPage;		// 페이지별 출력될 네비게이션 메뉴(넘버) 수
	private int startCount;		// 해당 페이지에서 게시글의 시작번호
	private int endCount;		// 해당 페이지에서 게시글의 끝번호
	private int startPage;	 	// 페이지 네비게이션 시작 넘버 
	private int endPage;	 	// 페이지 네비게이션 끝 넘버 
	private HttpServletRequest request;
	private StringBuffer pageHtml = new StringBuffer();		// StringBuffer는 메모리상 하나만 만들어짐
	
	public RolePagingUtil(String currentPage, int totalCount, int blockCount, int blockPage, HttpServletRequest request){
		this.currentPage = Integer.parseInt(currentPage);
		this.totalCount = totalCount;
		this.blockCount = blockCount;
		this.blockPage = blockPage;
		this.request = request;
		
		makePagingHtml();
	}
	
	public void makePagingHtml(){
		// 총 페이지 수
		this.totalPage = (int) Math.ceil(this.totalCount / (double)this.blockCount);
		
		if(this.totalCount == 0){
			this.totalCount = 1;
		}
		
		// 페이지 당 출력될 게시글 넘버(RNUM)
		this.startCount = this.totalCount - (this.currentPage - 1) * this.blockCount;
		this.endCount = this.startCount - this.blockCount + 1;
		
		if(this.endCount < 0){
			this.endCount = 1;
		}
		
		// 페이지 네비게이션 메뉴(넘버) 시작 번호
		this.startPage = ((this.currentPage - 1) / this.blockPage * this.blockPage) + 1;
		this.endPage = this.startPage + this.blockPage - 1;
		if(this.endPage > this.totalPage){
			this.endPage = this.totalPage;
		}
		
		String requestURI = this.request.getRequestURI();
		// 이전
		this.pageHtml.append("<div class='text-center'>");
		this.pageHtml.append("<ul class='pagination mtm mbm'>");
		if((this.currentPage - 1) ==0){
			this.pageHtml.append("<li class='disabled'><a href='#'>&laquo;</a></li>");
		}else{
			this.pageHtml.append("<li><a href='"+requestURI+"?currentPage="+(this.currentPage - 1)+"'>&laquo;</a></li>");
		}
		
		// 이전|1|2|3|4|5
		for(int i=this.startPage; i<=this.endPage; i++){
			if(this.currentPage == i){
				this.pageHtml.append("<li class='active'><a href='#'>"+ i +"</a></li>");
			}else{
				this.pageHtml.append("<li><a href='"+requestURI+"?currentPage="+i+"'>"+ i +"</a></li>");
			}
		}
		
		// 이전 |1|2|3|4|5|다음
		if(this.currentPage < this.totalPage){
			this.pageHtml.append("<li><a href='"+requestURI+"?currentPage="+(this.currentPage + 1)+"'>&raquo;</a></li>");
		}else{
			this.pageHtml.append("<li class='disabled'><a href='#'>&raquo;</a></li>");
		}
		
		this.pageHtml.append("</ul>");
		this.pageHtml.append("</div>");
	}

	public int getStartCount() {
		return startCount;
	}

	public int getEndCount() {
		return endCount;
	}

	public StringBuffer getPageHtml() {
		return pageHtml;
	}
	
	
	
}
