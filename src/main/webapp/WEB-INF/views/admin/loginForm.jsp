<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="${pageContext.request.contextPath}/script/jquery-1.8.3.js"></script>
<script type="text/javascript">
$(function(){
	if(eval('${!empty param.message}')){
		alert('${param.message}');
	}	
	$("#loginBtn").click(function(){
		if($('input[name=mem_id]').val() == ''){
			alert("아이디를 입력해주세요");
			return 
		}
		if($('input[name=mem_pass]').val() == ''){
			alert("패스워드를 입력해주세요");
			return 
		}
		var mem_id = $('input[name=mem_id]').val();
		var mem_pass = $('input[name=mem_pass]').val();
		var $frm = $('<form action="${pageContext.request.contextPath}/admin/join/loginCheck.do"/>')
		$frm.append('<input type="hidden" name="mem_id" value="'+mem_id+'"/>');
		$frm.append('<input type="hidden" name="mem_pass" value="'+mem_pass+'"/>');
		$(document.body).append($frm);
		$frm.submit();
	});
});
</script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/admin.css" type="text/css">
<title>회원관리 관리자 로그인</title>
</head>
<body>
	<table width="770" border="0" align="center" cellpadding="0"
		cellspacing="0" style="margin: 90px;">
		<tr>
			<td height="150" align="center"><img src="${pageContext.request.contextPath }/image/p_login.gif" /></td>
		</tr>
		<tr>
			<td height="174"
				style="background: url(${pageContext.request.contextPath }/image/login_bg.jpg); border: 1px solid #e3e3e3;">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="260" height="110" align="center"
							style="border-right: 1px dotted #736357;">
							<img src="${pageContext.request.contextPath }/image/logo.jpg" />
						</td>
						<td>
						<form action="" method="post" name="loginForm">
							<table border="0" align="center" cellpadding="5"
								cellspacing="0">
								<tr>
									<td><b>아이디</b></td>
									<td><input type="text" name="mem_id" class="box" tabindex="3" height="18" /></td>
									<td rowspan="2">
										<img src="${pageContext.request.contextPath }/image/login.gif" class="loginBtn" id="loginBtn"/>
									</td>
								</tr>
								<tr>
									<td><b>패스워드</b></td>
									<td><input type="password" name="mem_pass" class="box" tabindex="3" height="18"/></td>
								</tr>
							</table>
						</form>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
