<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/validation.js"></script>
<script type="text/javascript">
	$(function(){
		$('form[name=memberForm]').submit(function(){
			
			$('input[name=mem_bir]').val($('input[name=mem_bir1]').val()+$('input[name=mem_bir2]').val()+$('input[name=mem_bir3]').val());
			
			$('input[name=mem_hometel]').val($('select[name=mem_hometel1]').val()+'-'+$('input[name=mem_hometel2]').val()+'-'+$('input[name=mem_hometel3]').val());
			
			$('input[name=mem_hp]').val($('select[name=mem_hp1]').val()+'-'+$('input[name=mem_hp2]').val()+'-'+$('input[name=mem_hp3]').val());
			
			$('input[name=mem_mail]').val($('input[name=mem_mail1]').val()+'@'+$('select[name=mem_mail2]').val());
			
			$('input[name=mem_zip]').val($('input[name=mem_zip1]').val()+'-'+$('input[name=mem_zip2]').val());
			
			$('input[name=mem_add]').val($('input[name=mem_add1]').val()+'-'+$('input[name=mem_add2]').val());
			
             
	         if(!$('input[name=mem_name]').val().validationNM()){                
	            alert('이름을 입력해주세요');                                    
	            return false;                                                    
	         }                                                                   
			
	         var regno = $('input[name=mem_regno1]').val()+'-'+$('input[name=mem_regno2]').val();
	         
			if(!regno.validationREGNO()){                                  
	            alert('주민등록번호 바르게 입력해주세요');                  
	            return false;                                               
	         }                                                              
			
	         var mem_bir = $('input[name=mem_bir1]').val()+'-'+$('input[name=mem_bir2]').val()+'-'+$('input[name=mem_bir3]').val();
	         
	         if(!mem_bir.validationBIR()){           
	            alert('생일을 바르게 입력해주세요');                        
	            return false;                                               
	         }
			 
	         if(!$('#mem_id').val().validationID()){                   
	            alert('아이디를 입력해주세요');                                  
	            return false;                                                    
	         }
			
	         if(!$('.mem_pass').val().validationPWD()){               
	            alert('패스워드를 입력해주세요');                                
	            return false;                                                    
	         }                                                                   
	         
	         var mem_hometel = $('select[name=mem_hometel1]').val()+'-'+$('input[name=mem_hometel2]').val()+'-'+$('input[name=mem_hometel3]').val();
	         if(!mem_hometel.validationHOMETEL()){   
	            alert('집 전화번호를 바르게 입력해주세요');                 
	            return false;                                               
	         } 
	         
	         var mem_hp = $('select[name=mem_hp1]').val()+'-'+$('input[name=mem_hp2]').val()+'-'+$('input[name=mem_hp3]').val();
	         if(!mem_hp.validationHP()){             
	            alert('휴대폰 번호를 바르게 입력해주세요');                 
	            return false;                                               
	         }  
	         
	         var mem_mail = $('input[name=mem_mail1]').val()+'@'+$('select[name=mem_mail2]').val();
	         if(!mem_mail.validationMAIL()){         
	            alert('메일을 바르게 입력해주세요');                        
	            return false;                                               
	         }                                                              
			return;
		});
		
	
		$("#zip_search").click(function(){
		 	window.open("${pageContext.request.contextPath}/member/zipcodeSearch.do", "zipFind", 
		 	"width=400, height=500, left=350, top=100, scrollbars=yes");
		});
		
		$("#btn3").click(function(){
			$(location).attr('href','${pageContext.request.contextPath}/feeeboard/main.do');
		});
		
		
		
		$('#idCheck').click(function(){
			$.ajax({
				type:"POST",
				async:true,
				url:"${pageContext.request.contextPath}/member/idCheck.do",
				dataType:"json",
				data:{mem_id : $('#mem_id').val()},
				timeout:3000,
				contentType:"application/x-www-form-urlencoded;charset=UTF-8",
				error:function(result){
					alert(result.status + " | " + result.responseText);
					},
				success:function(result){
						alert(result.flag);
					},
				beforeSend:function(){
					
					},
				complete:function(){
					// 해당 ajax 요청이 완전 종료
					// 다른 ajax 요청이 시작
					},
			});
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
<form action="${pageContext.request.contextPath}/member/insertMemberInfo.do" name="memberForm" method="post">
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
			<input type="text" name="mem_name" value=""/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr>
		<td class="fieldName" width="100px" height="25">주민등록번호</td>
		<td>
			<input type="text" name="mem_regno1" size="6" value=""/>
  			<input type="text" name="mem_regno2" size="7" value=""/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">생년월일</td>
		<td>
				<input type="hidden" name="mem_bir" />
				<input type="text" name="mem_bir1" size="4" value="" />년
				<input type="text" name="mem_bir2" size="2" value="" />월
				<input type="text" name="mem_bir3" size="2" value="" />일
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">아이디</td>
		<td>
			<input type="text" name="mem_id" id="mem_id" value="">&nbsp;&nbsp;<b><a id="idCheck">[ID 중복검사]</a></b>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">비밀번호</td>
		<td>
			<input type="text" class="mem_pass" name="mem_pass" value="" /> 8 ~ 20 자리 영문자 및 숫자 사용
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr>
		<td class="fieldName" width="100px" height="25">비밀번호확인</td>
		<td>
			<input type="text" class="mem_pass" name="mem_pass_confirm" value="" /> 8 ~ 20 자리 영문자 및 숫자 사용
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
	<tr>
		<td class="fieldName" width="100px" height="25">전화번호</td>
		<td>
			<div>
			<input type="hidden" name="mem_hometel"/>
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
			<input type="hidden" name="mem_hp"/>
			<select name="mem_hp1">
				<option value="010">010</option>
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
			<input type="hidden" name="mem_mail" />
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
			<input type="hidden" name="mem_zip" />
			<input type="text" name="mem_zip1" id="mem_zip1" size="3" value="" /> - 
			<input type="text" name="mem_zip2" id="mem_zip2" size="3" value="" />
			<button id="zip_search" class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent" type="button">우편번호검색</button><br>
			<input type="text" name="mem_add1" id="mem_add1" value="" />
			<input type="text" name="mem_add2" id="mem_add2" value="" />
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr>
		<td class="fieldName" width="100px" height="25">직 업</td>
		<td>
			<input type="text" name="mem_job" value=""/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	<tr>
		<td class="fieldName" width="100px" height="25">취 미</td>
		<td>
			<input type="text" name="mem_like" value=""/>
		</td>
	</tr>
	<tr><td class="tLine" colspan="2"></td></tr>
	
	<tr><td colspan="2" height="20"></td></tr>
	
	<tr>
		<td class="btnGroup" colspan="2" >
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn1" type="submit">가입하기</button>
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn2" type="reset">취소</button>
			<button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" id="btn3" type="button">목록</button>
		</td>
	</tr>
</table>
</form>
</body>
</html>








