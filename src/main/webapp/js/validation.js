/**
 * 입력값 검증 펑션
 * 버전 : 1.0
 * << 개정이력(Modification Information) >>
 * 수정일       수정자          수정내용   
 * =======      =======     ===================== 
 * 2017.03.21.  전인호       최초작성   
 * Copyright (c) 2016 by DDIT  All right reserved  
 */
// 아이디 검증
String.prototype.validationID = function(){
	return /^[a-z][a-z0-9]{3}$/.test(this);
};
// 패스워드 검증
String.prototype.validationPWD = function(){
	return /[a-z0-9]{4,10}$/.test(this)
};
// 이름 검증
String.prototype.validationNM = function(){
	return /^[가-힣]{2,4}$/.test(this)
}
// 주민등록번호 검증(123456-1234567)
String.prototype.validationREGNO = function(){
	// 111111-1111118
	// 1 2 3 4 5 6 - 1 2 3 4 5 6              7(매직넘버)
	// * * * * * *   * * * * * *
	// 2+3+4+5+6+7 + 8+9+2+3+4+5 = 결과
	// (11-(결과%11))%10 = 최종값
	// if(최종값 == 매직넘버) return true else return false
	var value = this.replace('-', '');
	var magicNum = this.substr(13,1);
	var sum = 0;
	var checksum = '234567892345';
	
	for(var i=0; i<12; i++){
		sum += value.charAt(i)*checksum.charAt(i);
	}
	
	var finalValue = (11-(sum%11))%10;
	
	if(finalValue == parseInt(magicNum)){
		return true;
	}else{
		return false;
	}
}
// 생일 검증
String.prototype.validationBIR = function(){
	return /^(19|20)[0-9]{2}-(0|1)[1-9]-[0-9]{2}$/.test(this)
}

// 집 전화번호 검증
String.prototype.validationHOMETEL = function(){
	return /^0[1-9]{1,2}-\d{3,4}-\d{4}$/.test(this)
}
// 회사 전화번호 검증
String.prototype.validationCOMTEL = function(){
	return /^0[1-9]{1,2}-\d{3,4}-\d{4}$/.test(this)
}
// 메일 검증(test@test.com or test@test.go.kr)
String.prototype.validationMAIL = function(){
	return /^[a-zA-Z0-9]+@[a-z]+(\.[a-z]+){1,2}$/.test(this)
}
// 휴대폰 검증
String.prototype.validationHP = function(){
	return /^01(0|1|6|7|8|9)-\d{3,4}-\d{4}$/.test(this)
}










