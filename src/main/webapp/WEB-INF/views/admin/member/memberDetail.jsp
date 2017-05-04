<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원상세정보</title>
</head>
<script type="text/javascript" src = "http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src =  " ${pageContext.request.contextPath }/js/commons.js"></script>
<script type="text/javascript">
$(function() {
	var hp = settingDisernNum();
	var sido = getSido();

	var mail = '${memberInfo.mem_mail}';
	var mem_mail = mail.split('@');
	$('#mem_mail1').val(mem_mail[0]);
	$('#mem_mail2').val(mem_mail[1]);
	
	$('select[name=mem_hp1]').append(hp);
	var hp = '${memberInfo.mem_hp}';
	var mem_hp = hp.split('-');
	$('select[name=mem_hp1]').val(mem_hp[0]);
	$('#mem_hp2').val(mem_hp[1]);
	$('#mem_hp3').val(mem_hp[2]);
	
	
	$('#cancle').click(function() {
		$(location).attr('href','${pageContext.request.contextPath}/admin/member/memberMgr.do');
	});
	$('#reset').click(function() {
		location.reload();
	});
	
	var sido = getSido();
	
	$('select[name=mem_sido]').append(sido);
	

	var gugun = getGugun('${memberInfo.mem_add1}');
	var options = "";
	for(var i = 1; i<gugun.length; i++){
		
		options += '<option value="'+gugun[i]+'">' + gugun[i] + '</option>'; 
	};
	$('select[name=mem_gugun]').html(options);
	
	
	$('select[name=mem_sido]').change(function() {
		var gugun = getGugun($('select[name=mem_sido]').val());
		var options = "";
		for(var i = 1; i<gugun.length; i++){
			
			options += '<option value="'+gugun[i]+'">' + gugun[i] + '</option>'; 
		};
		$('select[name=mem_gugun]').html(options);
	});
	
	
	var addr = '${memberInfo.mem_add1}';
	var mem_addr1 = addr.split(" ");
	$('select[name=mem_sido]').val(mem_addr1[0]).prop("selected", true);
	var mem_addr2 = addr.split(" ");
	$('select[name=mem_gugun]').val(mem_addr2[1]).prop("selected", true);

	$('input[value=${memberInfo.mem_date_type}]').attr('checked',true);
	
	var day = new Date();
	var year =getYearsOptions(day);
	var month = getMonthOptions();
	$('#mem_year').append(year);
	$('#mem_month').append(month);
	var bir = '${memberInfo.mem_bir}';
	var mem_bir = bir.split('-');
	$('#mem_year').val(mem_bir[0]);
	$('#mem_month').val(mem_bir[1]);

	day.setFullYear($('#mem_year').val(), ($('#mem_month').val()-1),1)
	var date = getLastDate(day);
	var dateoption = "";
	for(var i = 1; i<=date; i++){
		if(i < 10){
			dateoption += '<option value="0'+i+'">' + '0'+i + '</option>';
		}else{
			dateoption += '<option value="'+i+'">' + i + '</option>';
		} 
	};
	$('#mem_day').html(dateoption);
	
	$('#mem_day').val(mem_bir[2].substr(0,2));
	
	
	$('#mem_month').change(function() {
		if($('#mem_year').val() != ""){
		var day1 = new Date();
		day1.setFullYear($('#mem_year').val(), ($('#mem_month').val()-1),1)
		var days = getLastDate(day1);
		var options = "";
		for(var i = 1; i<=days; i++){
			if(i < 10){
				options += '<option value="0'+i+'">' + '0'+i + '</option>';
			}else{
				options += '<option value="'+i+'">' + i + '</option>';
			} 
		};
		$('#mem_day').html(options);
		}else{
			alert("년도를 선택해주세요!!");
		}
	});
	
	$('form[name=updateMemberForm]').submit(function(){
		  var mem_add1 = $('select[name=mem_sido]').val() +" " +$('select[name=mem_gugun]').val();
	      var mem_hp = $('select[name=mem_hp1]').val() + "-" + $('input[name=mem_hp2]').val() + "-" +$('input[name=mem_hp3]').val();
	      var mem_bir = $('#mem_year').val() +"-" + $('#mem_month').val() + "-" + $('#mem_day').val();
	      var mem_mail = $('input[name=mem_mail1]').val()+"@"+$('input[name=mem_mail2]').val();
// 	      var mem_date_type = $('input[name=mem_calendar]').val();
	      $('#mem_add1').val(mem_add1);   
	      $('#mem_hp').val(mem_hp);   
	      $('#mem_bir').val(mem_bir);   
	      $('#mem_mail').val(mem_mail);

	});
	   $('#updateMember').click(function() {
		  
			$('form[name=updateMemberForm]').submit();
		});
	
	
	
	
});

</script>
<body onload="setInitContents();">
<div class="wrap">	
	<table width="1000" border="0" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td width="30">&nbsp;</td>
			<td width="790">
				<div id="container">
					<div class="title">회원정보</div>
					<form method="post" name="updateMemberForm" action="${pageContext.request.contextPath }/admin/member/updateMember.do">
						<table border="0" cellspacing="1" cellpadding="1">
							<tr>
								<th><span class="r">*</span>이름</th>
								<td><label class="mem_name">${memberInfo.mem_name }</label></td>
							</tr>
							<tr>
								<th><span class="r">*</span>아이디</th>
								<td><label class="mem_id">${memberInfo.mem_id }</label></td>
							</tr>
							<tr>
								<th><span class="r">*</span>비밀번호</th>
								<td><input name="mem_pass" type="text" id="mem_pass" size="20" value="${memberInfo.mem_pass }" /></td>
							</tr>
							<tr>
								<th><span class="r">*</span>비밀번호 확인</th>
								<td><input name="mem_pass_confirm" type="text" id="mem_pass_confirm" size="20" value="${memberInfo.mem_pass }" /></td>
							</tr>
							<tr>
								<th>이메일 주소</th>
								<td>
								    <input type="hidden" name="mem_mail" id="mem_mail" value=""/>
                          			<input type="hidden" name="mem_hp" id="mem_hp" value=""/>
                          			<input type="hidden" name="mem_id" id="mem_id" value="${memberInfo.mem_id }"/>
                         		  	<input type="hidden" name="mem_add1" id="mem_add1" value=""/>
                          			<input type="hidden" name="mem_bir" id="mem_bir" value=""/>
								
									<input name="mem_mail1" type="text" id="mem_mail1" size="20" />@
									<input name="mem_mail2" type="text" id="mem_mail2" size="20" /> 
								</td>
							</tr>
							<tr>
								<th>거주지</th>
								<td>
									<select style="width: 130px; margin-right: 10px;" name="mem_sido">
											<option selected="selected">선택하세요</option>
									</select>
									
									<select style="width: 130px;" name="mem_gugun">
										<option selected="selected">선택하세요</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>연락처</th>
								<td><select style="width: 100px;" name="mem_hp1">
										<option selected="selected">선택하세요</option>
									</select> - 
									<input name="mem_hp2" type="text" id="mem_hp2" size="20" /> - 
									<input name="mem_hp3" type="text" id="mem_hp3" size="20" />
								</td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td>
									<input type="radio" name="mem_date_type" value="solar" />양력
									<input type="radio" name="mem_date_type" value="lunar" />음력 
									<select style="width: 130px; margin-left: 10px;" name="mem_year" id="mem_year">
										<option selected="selected">선택하세요</option>
									</select> 
									<select style="width: 130px;" name="mem_month" id="mem_month">
										<option selected="selected">선택하세요</option>
									</select> 
									<select style="width: 130px;" name="mem_day" id="mem_day">
										<option selected="selected">선택하세요</option>
									</select>
								</td>
							</tr>
						</table>
						<div style="float: right;">
							<input class="btn2" type="submit" value="변경내용 저장" id="updateMember"/>
							<input class="btn2" type="button" value="목록" id="cancle"/>
							<input class="btn2" type="button" value="취소" id="reset" />
						</div>
					</form>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>