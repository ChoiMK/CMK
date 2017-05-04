<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--Loading KAdmin css 시작 -->
<link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,400,300,700">
<link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family=Oswald:400,700,300">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/styles/jquery-ui-1.10.4.custom.min.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/styles/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/styles/bootstrap.min.css">

<!--Loading KAdmin css 끝 -->
<!-- summernote 에디터 스타일 파일 시작 -->
<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.7.1/summernote.css" rel="stylesheet">
<!-- summernote 에디터 스타일 파일 끝 -->
<!-- 부트스트랩 다이얼로그 스타일 파일 시작 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/css/bootstrap-dialog.min.css" rel="stylesheet" type="text/css" />
<!-- 부트스트랩 다이얼로그 스타일 파일 끝 -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/admin.css" type="text/css">


<title>회원관리 관리자</title>
</head>
<body>
   <div class="wrap">
      <div id="header">
         <div class="top_bn">
            <ul>
               <li><a href="http://www.twitter.com"><img src="${pageContext.request.contextPath }/image/admin_t.jpg" /></a></li>
               <li><a href="http://www.facebook.com"><img src="${pageContext.request.contextPath }/image/admin_f.jpg" /></a></li>
               <li><a href="${pageContext.request.contextPath }/admin/member/memberMgr.do"><img src="${pageContext.request.contextPath }/image/admin_homelink.jpg" /></a></li>
               <li><a href="${pageContext.request.contextPath }/admin/join/main.do"><img src="${pageContext.request.contextPath }/image/admin_logout.jpg" /></a></li>
            </ul>
         </div>
         <div class="logo">
            <img src="${pageContext.request.contextPath }/image/logo.jpg" />
         </div>
         <div class="gnb">
            <ul>
               <li><a href="#" id="AdminInfo">회원관리</a></li>
               <li><a href="#" id="ADBoardBtn">자유게시판</a></li>
            </ul>
         </div>
      </div>
   </div>
</body>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="${pageContext.request.contextPath}/script/jquery-ui.js"></script>
<!-- summernote 에디터 js 파일 시작 -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.7.1/summernote.js"></script>
<!-- summernote 에디터 js 파일 끝 -->
<!-- 부트스트랩 다이얼로그 js 파일 시작 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap3-dialog/1.34.7/js/bootstrap-dialog.min.js"></script>
<!-- 부트스트랩 다이얼로그 js 파일 끝 -->
<script type="text/javascript">
$(function(){
	
	$('#ADBoardBtn').click(function(){
		$(location).attr('href','${pageContext.request.contextPath}/admin/freeboard/ADfreeboardList.do');
	});
	
	$('#AdminInfo').click(function(){
		$(location).attr('href','${pageContext.request.contextPath}/admin/member/memberMgr.do');
	});
	
	
});
</script>

</html>