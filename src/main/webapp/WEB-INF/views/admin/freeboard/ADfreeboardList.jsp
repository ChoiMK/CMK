<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
$(function(){
	$("tbody>tr>td:nth-child(2)").click(function(){
		var rnum =$(this).prev().text();
		var bo_no = $(this).find('input').val(); 
		$(location).attr('href','${pageContext.request.contextPath}/admin/freeboard/ADfreeboardView.do?rnum=' + rnum + '&bo_no='+bo_no);
	});
	
	
	$('#RegisBtn').click(function(){
		$(location).attr('href','${pageContext.request.contextPath}/admin/freeboard/ADfreeboardForm.do');
	});
	
	
});
</script>
<style>
#pointerTd:hover{cursor:pointer; }
</style>
<title>자유게시판리스트</title>
</head>
<body>
<div class="wrap">
	<table width="1000" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td width="790"> 
			<div id="container">
               <div class="title">자유게시판리스트</div>
               <table id="tbl" border="0" cellspacing="1" cellpadding="1">
                  <thead>
                     <tr>
                       <th width="5%">번호</th>
                       <th width="60%">제목</th>
                       <th>작성자</th>
                       <th>작성일</th>
                       <th>조회수</th>
                     </tr>                     
                  </thead>
                  <tbody>
				<c:forEach items="${boardList}" var="boardInfo">
					<tr>
						<td>${boardInfo.rnum}
						
						<td style="cursor:pointer" id="title" align = "left">
							<c:forEach begin="1" end="${boardInfo.bo_depth}" varStatus="stat">
								&nbsp;&nbsp;&nbsp;
								<c:if test="${stat.last}">
									<i class="fa fa-angle-right">RE:</i>
								</c:if>						 
							</c:forEach>
							
							<input type="hidden" name="bo_no" value="${boardInfo.bo_no}"/>
							${boardInfo.bo_title }
							
						  </td>	
							
							<td>${boardInfo.bo_nickname }</td>
							<td>${boardInfo.bo_reg_date.substring(0,10) }</td>
							<td>${boardInfo.bo_hit }</td>
					</tr>
				</c:forEach>
			</tbody>
               </table>
               </div>
              
	
		<div style="text-align:right;">
               <form action="${pageContext.request.contextPath }/admin/freeboard/ADfreeboardList.do" method="post" class="form-inline pull-right" name="searchForm">
				<input name="search_keyword" type="text" placeholder="검색어 입력..." class="form-control" />
				<select class="form-control" name="search_keycode" >
					<option>검색조건</option>
					<option value="TITLE">제목</option>
					<option value="CONTENT">내용</option>
					<option value="WRITER">작성자</option>
				</select>
			    <div style="text-align:right">
						<input class="btn2" type="submit" value="검색"/> 
						<input class="btn2" type="button" value="등록" id="RegisBtn"/>
				</div>

				</form>
              ${pageHtml }	
      	</div>
      </td>
    </tr>
 </table>
</div>	
</body>
</html>