<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script> -->
<style type="text/css">
.carousel{
	width:200px;
    height:150px;
    margin-left: 200px;
}
.carousel-inner > .item > img{
    width:200px;
    height:150px;
}      

</style>
<script type="text/javascript">
$(function(){
	$('#bo_content').summernote({
		height: 150,
		codemirror: {
		theme: 'monokai'
	}
	});
	$("#bo_content").summernote('code', '${boardInfo.bo_content}');
	
	$("form[name=boardForm]").submit(function(){
		var val = $('#bo_content').summernote('code');
		$(this).append('<input type="hidden" name="bo_no" value="${boardInfo.bo_no}"/>');
		$(this).append("<input type='hidden' name='bo_content' value='"+val+"'/>");
		$(this).attr('action','${pageContext.request.contextPath}/admin/freeboard/ADupdateBoard.do');
	});
	
	$('#listBtn').click(function(){
		$(location).attr('href','${pageContext.request.contextPath}/admin/freeboard/ADfreeboardList.do');
	});
	
	$("#DeleteBtn").click(function(){
		$(location).attr('href','${pageContext.request.contextPath}/admin/freeboard/ADdeleteBoard.do?bo_no=${boardInfo.bo_no}');
	});
	
	$('#reply').click(function(){
		var $frm = $('<form action="${pageContext.request.contextPath}/admin/freeboard/ADfreeboardReplyForm.do" method="post">')
		$frm.append('<input type="hidden" name="rnum" value="${param.rnum}"/>');
		$frm.append('<input type="hidden" name="bo_title" value="${boardInfo.bo_title}"/>');
		$frm.append('<input type="hidden" name="bo_group" value="${boardInfo.bo_group}"/>');
		$frm.append('<input type="hidden" name="bo_depth" value="${boardInfo.bo_depth}"/>');
		$frm.append('<input type="hidden" name="bo_seq" value="${boardInfo.bo_seq}"/>');
		
		$(document.body).append($frm);
		$frm.submit();
	});
});

</script>
<title>자유게시판 보기</title>
</head>
<body>
<form action="" method="post" name="boardForm">
<div class="wrap">
   <table width="1000" border="0" cellpadding="0" cellspacing="0">
      <tr valign="top">
         <td width="790"> 
            <div id="container">
               <div class="title">자유게시판 보기</div>
               <table border="0" cellspacing="1" cellpadding="1">
                  <tr>
                    <th>제목</th>
                    <td><label class="bo_title"></label>
                    <input type="text" id="bo_title" name="bo_title" value="${boardInfo.bo_title }">
                    </td>
                  </tr>
                  <tr>
                    <th>작성자</th>
                    <td><label class="bo_nickname"></label>
                     <input type="text" id="bo_nickname" name="bo_nickname" value="${boardInfo.bo_nickname }" >
                    </td>
                  </tr>
                  <tr>
                    <th>내용</th>
                    <td><div id="bo_content"><p>내용을 입력해주세요</p></div></td>
                  </tr>
                  <tr>
                    <th>첨부파일</th>
                    <td><div class="col-sm-10"> 
			      <div id="myCarousel" class="carousel slide" data-ride="carousel">
			   <!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
				</ol>
			        	<!-- Wrapper for slides -->
			<div class="carousel-inner" role="listbox" style="height: 200px;">
			<c:forEach items="${boardInfo.attachFileItemList}" var="fileitem" varStatus="stat">
				<c:if test="${stat.first }">
					<div class="item active">
				</c:if>
				<c:if test="${stat.last }">
					<div class="item">
				</c:if>
				<img src="http://192.168.201.30/file/${fileitem.file_save_name}" alt="pic${stat.count}"
					onclick="javascript:location.href='${pageContext.request.contextPath}/freeboard/fileDownload.do?fileSeq=${fileitem.file_seq}'">
				</div>
			</c:forEach>
			</div>
         <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
      </div></td>
                  </tr>
               </table>
               <div style="text-align:right">
                  <input class="btn2" type="submit" value="수정"/> 
                  <input class="btn2" type="button" value="답글" id="reply">
                  <input class="btn2" type="button" value="삭제" id="DeleteBtn"/> 
                  <input class="btn2" type="button" value="목록" id="listBtn"/>
               </div>
            </div>
         </td>
      </tr>
   </table>
</div>
</form>

</body>
</html>