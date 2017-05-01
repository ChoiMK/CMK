<%@ page language="JAVA" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시글 목록</title>
<script type="text/javascript">
 	$(function(){
		$("tbody>tr>td:nth-child(2)").click(function(){
			if(eval('${empty LOGIN_MEMBERINFO}')){
				alert("로그인후 이용해주세용");
				return false;
			}	
			var rnum =$(this).prev().text();
			var bo_no = $(this).find('input').val(); 
			$(location).attr('href','${pageContext.request.contextPath}/freeboard/freeboardView.do?rnum=' + rnum + '&bo_no='+bo_no);
		});
		
		
		$('#write').click(function(){
			if(eval('${empty LOGIN_MEMBERINFO}')){
				alert("로그인후 이용해주세용");
				return false;
			}	
			$(location).attr('href','${pageContext.request.contextPath}/freeboard/freeboardForm.do');
		});
		
		
	});
</script>
</head>
<body>

<div id="freeboardList_content">
	<div class="panel panel-blue">
    	<div class="panel-heading">자유게시판 목록</div>
		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th scope="col" width="5%">No</th>
					<th scope="col" width="65%">제목</th>
					<th scope="col" width="10%">작성자</th>
					<th scope="col" width="10%">작성일</th>
					<th scope="col" width="10%">조회수</th>
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
									<i class="fa fa-angle-right"></i>
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
	${pageHtml}
</div>
<div >
<form action="${pageContext.request.contextPath}/freeboard/freeboardList.do" method="post" class="form-inline pull-right">
		<input id="search_keyword" name="search_keyword" type="text" placeholder="검색어 입력..." class="form-control" />
		<select class="form-control" name="search_keycode" >
			<option>검색조건</option>
			<option value="TOTAL">전체</option>
			<option value="TITLE">제목</option>
			<option value="CONTENT">내용</option>
			<option value="WRITER">작성자</option>
		</select>
	    <button type="submit" class="btn btn-primary form-control">검색</button>
	   <c:if test="${not empty LOGIN_MEMBERINFO}">
	    <button type="button" id="write" class="btn btn-info form-control">게시글 등록</button>
	   </c:if>
</form>
</div>	
</body>
</html>