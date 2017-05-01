function createXMLHttpRequest(){
	var xmlHttp;
	if(window.ActiveXObject){
		// IE
		xmlHttp = new ActiveXObject('Microsoft.XMLHTTP');
	}else{
		// IE 외 브라우저
		xmlHttp = new XMLHttpRequest();
	}
	return xmlHttp;
}