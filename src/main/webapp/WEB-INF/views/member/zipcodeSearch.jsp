<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
$(function(){
	
	$("#zipFindBtn").click(function(){
		var dong = $.trim( $("#dong").val() );
		if(dong==""){
			alert("검색할 동을 입력하세요");
			return;
		}
		
		$.getJSON(
			"${pageContext.request.contextPath}/member/zipSearch.do",
			{
				"dong" : dong
			},
			function( zipList ){
				var htmlCode = "<table>";
				$.each( zipList.zipList, function(i,v){
					htmlCode += "<tr class='ziptr'>";
					htmlCode += "<td>" + v.zipcode + "</td>";
					//htmlCode += "<td>" + $.trim(v.addr) + "</td>";
					htmlCode += "<td>" + $.trim(v.sido+v.gugun+v.dong) + "</td>";
					htmlCode += "<td>" + v.bunji + "</td></tr>";
				});
				
				htmlCode += "</table>";
				$("#viewTable").html( htmlCode );
			}
		);
	});
	// =================================================
	
	 $("#viewTable").on("click", ".ziptr", function(){
		var zipCode = $("td:eq(0)",this).text().trim();  // 123-456
		var zips = zipCode.split("-");  // zips[0] ==> 앞3자리, zips[1] ==> 뒤3자리
		
		var addr = $("td:eq(1)", this).text().trim(); 
		
		// opener.document.부모창의form이름.입력요소이름.value = 값;
		opener.document.memberForm.mem_zip1.value = zips[0];  // 자바스크립트 형식
		
		$("#mem_zip2", opener.document).val( zips[1] );		// jQuery형식
		
		$("#mem_add1", opener.document).val(addr);
		
		opener.document.memberForm.mem_add2.focus();  // 상세 주소에 포커스 주기
		
		window.close();  // 창 닫기
		
	}); 
});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
td {f on t-family:"돋움";
   font-size: 9pt;
   line-height: 16px;
   color: #818181;
   letter-spacing: 0px;
}

td a {
   font-family: "돋움";
   font-size: 9pt;
   line-height: 16px;
   color: #818181;
   letter-spacing: 0px;
   text-decoration: none;
}

td a:hover {
   font-family: "돋움";
   font-size: 9pt;
   line-height: 16px;
   color: #818181;
   letter-spacing: 0px;
   text-decoration: underline;
}
</style>
</head>
<body>
   <table width="354" border="0" cellspacing="0" cellpadding="0">
      <tr>
         <td height="30"><img src="${pageContext.request.contextPath}/image/open_post.gif" width="136"
            height="22"></td>
      </tr>
      <tr>
         <td><img src="${pageContext.request.contextPath}/image/open_table01.gif" width="354" height="10"></td>
      </tr>
      <tr>
         <td height="10" background="${pageContext.request.contextPath}/image/open_table02.gif" align="center">&nbsp;</td>
      </tr>
      <tr>
         <td height="300" align="center" valign="top"
            background="${pageContext.request.contextPath}/image/open_table02.gif">
            <table width="300" border="0" cellspacing="0" cellpadding="0">
               <tr>
                  <td height="25"><div align="center">찾고자 하는 지역의 동이름을
                        입력해주십시오.</div></td>
               </tr>
               <tr>
                  <td height="38" background="${pageContext.request.contextPath}/image/open_tt.gif" align="center">
                     <input type="text" id="dong">&nbsp;동(읍/면)&nbsp;
                     <input id="zipFindBtn" type="image" src="${pageContext.request.contextPath}/image/bt_search.gif" border='0'
                     align="middle">
                  </td>
               </tr>
               <tr>
                  <td>&nbsp;</td>
               </tr>
               <tr>
                  <td>
                     <div style="overflow: auto; white-space: nowrap; overflow-X: hidden; height: 200px;" id="viewTable">
                     </div>
                  </td>
               </tr>
            </table>
         </td>
      </tr>
      <tr>
         <td><img src="${pageContext.request.contextPath}/image/open_table03.gif" width="354" height="10"></td>
      </tr>
   </table>
</body>
</html>