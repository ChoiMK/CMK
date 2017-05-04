<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/validation.js"></script>
<script type="text/javascript">
$(function(){
if(eval('${!empty param.message}')){
  alert('${param.message}');
  opener.parent.location.reload();
  window.close();
}

var bir = '${memberInfo.mem_bir}';
var mem_bir = bir.split('-');
$('input[name=mem_bir1]').val(mem_bir[0]);
$('input[name=mem_bir2]').val(mem_bir[1]);
$('input[name=mem_bir3]').val(mem_bir[2].substr(0,2));

var hometel = '${memberInfo.mem_hometel}';
var mem_hometel = hometel.split('-');
$('select[name=mem_hometel1]').val(mem_hometel[0]);
$('input[name=mem_hometel2]').val(mem_hometel[1]);
$('input[name=mem_hometel3]').val(mem_hometel[2]);

var phone = '${memberInfo.mem_hp}';
var mem_hp = phone.split('-');
$('select[name=mem_hp1]').val(mem_hp[0]);
$('input[name=mem_hp2]').val(mem_hp[1]);
$('input[name=mem_hp3]').val(mem_hp[2]);

var mail  = '${memberInfo.mem_mail}';
var mem_mail = mail.split('@');
$('input[name=mem_mail1]').val(mem_mail[0]);
$('select[name=mem_mail2]').val(mem_mail[1]);

var zip = '${memberInfo.mem_zip}';
var	mem_zip = zip.split('-'); 
$('input[name=mem_zip1]').val(mem_zip[0]);
$('input[name=mem_zip2]').val(mem_zip[1]);

var add1 = '${memberInfo.mem_add1}';
var add2= '${memberInfo.mem_add2}';
$('input[name=mem_add1]').val(add1);
$('input[name=mem_add2]').val(add2);

$('#btn2').click(function(){
	location.reload();	
});



$('form[name=memberForm]').submit(function(){
	$('input[name=mem_bir]').val($('input[name=mem_bir1]').val()+$('input[name=mem_bir2]').val()+$('input[name=mem_bir3]').val());
	
	$('input[name=mem_hometel]').val($('select[name=mem_hometel1]').val()+'-'+$('input[name=mem_hometel2]').val()+'-'+$('input[name=mem_hometel3]').val());
	
	$('input[name=mem_hp]').val($('select[name=mem_hp1]').val()+'-'+$('input[name=mem_hp2]').val()+'-'+$('input[name=mem_hp3]').val());
	
	$('input[name=mem_mail]').val($('input[name=mem_mail1]').val()+'@'+$('select[name=mem_mail2]').val());
	
	$('input[name=mem_zip]').val($('input[name=mem_zip1]').val()+'-'+$('input[name=mem_zip2]').val());
	
	$('input[name=mem_add]').val($('input[name=mem_add1]').val()+'-'+$('input[name=mem_add2]').val());
	
	if(!$('input[name=mem_pass]').val().validationPWD()){               
        alert('패스워드를 바르게 입력해주세요');                                
        return false;                                                    
     } 
	
	if(!$('input[name=mem_hometel]').val().validationHOMETEL()){
		alert('집 전화번호를 바르게 입력해주세요');
		return false;
	}
	
	if(!$('input[name=mem_hp').val().validationHP()){
		alert('휴대폰번호를 바르게 입력해주세요');
		return false;
	}
	if(!$('input[name=mem_mail]').val().validationMAIL()){
		alert('메일을 바르게 입력해주세요');
		return false;
	}
	
	$(this).append('<input type="hidden" name="mem_id" value="${memberInfo.mem_id}"/>');	
	$(this).attr('action','${pageContext.request.contextPath}/member/updateMemberInfo.do');

});

//삭제
$('#btn3').click(function(){
	$(location).attr('href','${pageContext.request.contextPath}/member/deleteMemberInfo.do?mem_id=${memberInfo.mem_id}');
});


//닫기
$('#btn4').click(function(){
	window.close();
});


$("#search").click(function(){
 	window.open("${pageContext.request.contextPath}/member/zipcodeSearch.do", "zipFind", 
 	"width=400, height=500, left=350, top=100, scrollbars=yes");

});





});


</script>

</head>
<style>
.fieldName {text-align: center; background-color: #f4f4f4;}
.tLine {background-color: #d2d2d2; height: 1px;}
.btnGroup { text-align: right; }
td {text-align: left; }
</style>
<body>
<form name="memberForm" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<!-- 	<tr><td class="tLine" colspan="2"></td></tr> -->
<!-- 	<tr><td rowspan="13" class="pic" colspan="2" style="vertical-align: bottom; width: 150px; text-align: center;"> -->
<%-- 			<img src="${pageContext.request.contextPath }/image/btn_pic.gif" alt="사진올리기" class="btn" title="인적사항에 올릴 증명	을 검색합니다."  --%>
<!-- 				style="cursor: pointer;"/><br/> -->
<!-- 			<div style="width: 100%" align="center"> -->
<!-- 				size : 235x315 이하 -->
<!-- 			</div> -->
<!-- 		</td> -->
<!-- 	</tr> -->
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr>
		<td class="fieldName" width="100px" height="25">성 명</td>
		<td>
			<input type="text" name="mem_name" value="${memberInfo.mem_name}" disabled="disabled"/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr>
		<td class="fieldName" width="100px" height="25">주민등록번호</td>
		<td>
			<input type="text" name="mem_regno1" size="6" value="${memberInfo.mem_regno1}" disabled="disabled"/>
  			<input type="text" name="mem_regno2" size="7" value="${memberInfo.mem_regno2 }" disabled="disabled"/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">생년월일</td>
		<td>
				<input type="hidden" name="mem_bir" value=""/>
				<input type="text" name="mem_bir1" size="4" value="" disabled="disabled"/>년
				<input type="text" name="mem_bir2" size="2" value="" disabled="disabled"/>월
				<input type="text" name="mem_bir3" size="2" value="" disabled="disabled"/>일
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">아이디</td>
		<td>
			<input type="text" name="mem_id" value="${memberInfo.mem_id }" disabled="disabled">
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">비밀번호</td>
		<td>
			<input type="text" name="mem_pass" value="${memberInfo.mem_pass }" /> 8 ~ 20 자리 영문자 및 숫자 사용
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">비밀번호확인</td>
		<td>
			<input type="text" name="mem_pass_confirm" value="${memberInfo.mem_pass }" /> 8 ~ 20 자리 영문자 및 숫자 사용
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
	<tr>
		<td class="fieldName" width="100px" height="25">전화번호</td>
		<td>
			<div>
			<input type="hidden" name="mem_hometel" value=""/>
			<select name="mem_hometel1">
				<option value="02">02</option>
				<option value="031">031</option>
				<option value="032">032</option>								        	
				<option value="033">033</option>				        	
				<option value="041">041</option>
				<option value="042">042</option>				        	
				<option value="043">043</option>				        	
				<option value="051">051</option>				        	
				<option value="052">052</option>
				<option value="053">053</option>				        					        	
				<option value="061">061</option>
				<option value="062">062</option>
				<option value="063">063</option>				        					        					        	
				<option value="064">064</option>				        					        					        	
				<option value="070">070</option>				        					        					        	
			</select>	- 	
			<input type="text" name="mem_hometel2" size="4" value="" /> - 
			<input type="text" name="mem_hometel3" size="4" value="" />
			</div>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">핸드폰</td>
		<td>
			<input type="hidden" name="mem_hp" value=""/>
			<select name="mem_hp1">
				<option value="010">010</option>
				<option value="011">011</option>
				<option value="016">016</option>				        	
				<option value="017">017</option>				        	
				<option value="019">019</option>				        	
			</select>	-
			<input type="text" name="mem_hp2" size="4" value="" /> - 
			<input type="text" name="mem_hp3" size="4" value="" />
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">이메일</td>
		<td>
		
			<input type="hidden" name="mem_mail" value="" />
			<input type="text" name="mem_mail1" value="" /> @
			<select name="mem_mail2">
				<option value="naver.com">naver.com</option>
				<option value="daum.net">daum.net</option>
				<option value="hanmail.net">hanmail.net</option>
				<option value="nate.com">nate.com</option>
				<option value="gmail.com">gmail.com</option>				
			</select>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
		
	<tr>
		<td class="fieldName" width="100px" height="25">주소</td>
		<td>
			<input type="hidden" name="mem_zip" value=""/>
			<input type="text" name="mem_zip1" id="mem_zip1" size="3" value="" /> - 
			<input type="text" name="mem_zip2" id="mem_zip2" size="3" value="" />
			<button type="button" id="search" class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">우편번호검색</button><br>
			<input type="text" name="mem_add1" id="mem_add1" value="" />
			<input type="text" name="mem_add2" id="mem_add2" value="" />
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr>
		<td class="fieldName" width="100px" height="25">직 업</td>
		<td>
			<input type="text" name="mem_job" value="${memberInfo.mem_job }"/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr>
		<td class="fieldName" width="100px" height="25">취 미</td>
		<td>
			<input type="text" name="mem_like" value="${memberInfo.mem_like }"/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr><td colspan="2" height="20"></td></tr>
	
	<tr>
		<td class="btnGroup" colspan="2" >
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn1" type="submit">수정하기</button>
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn2" type="button">취소</button>
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn3" type="button">탈퇴</button>
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn4" type="button">닫기</button>
		</td>
	</tr>
</table>
</form>
</body>
</html>








