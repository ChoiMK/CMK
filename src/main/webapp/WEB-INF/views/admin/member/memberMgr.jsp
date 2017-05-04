<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/js/commons.js"></script>
<!-- <script type="text/javascript" src = "http://code.jquery.com/jquery-latest.js"></script> -->
<script type="text/javascript">
$(function(){
   
   $('#reset').click(function() {
      location.reload();
   });
   
   var day = new Date();
   var year = getYearsOptions(day);
   var month = getMonthOptions();
    var sido = getSido();
   var hp = settingDisernNum();
    
   $('#search_year').append(year);
   $('#search_month').append(month);
   $('#search_day').append(day);
   $('#sido').append(sido);
   $('#search_hp1').append(hp);
   
   $('#search_month').change(function(){
      var date = new Date;
      date.setFullYear($('#search_year').val(),($('#search_month').val()-1),1);
      var day = getLastDate(date);
      
      var options="";
      for(var i=1; i<=day; i++){
         if(i < 10){
            options += '<option value="0'+i+'">' + '0'+i + '</option>';
         }else{
            options += '<option value="'+i+'">' + i + '</option>';
         }
      }
      $('#search_day').html(options);
   });
   
   $('#sido').change(function(){
    var gugun = getGugun($('#sido').val());
      var options = "";
      for(var i = 1; i<gugun.length; i++){
         options += '<option value="'+gugun[i]+'">' + gugun[i] + '</option>'; 
      };
      $('#gugun').html(options);
   });
   
   
   $('#memberList').on('click','#clickTd', function(){
      var parent = $(this).parent();
      var mem_id = parent.children('td:eq(1)').text();
      
      $(location).attr('href','${pageContext.request.contextPath}/admin/member/memberDetail.do?mem_id='+mem_id)
   });
   
   $('select[name=search_count]').val('${blockCount}').attr('selected',true);
   $('select[name=search_count]').change(function(){
      var blockCount = $(this).val();
      $(location).attr('href','${pageContext.request.contextPath}/admin/member/memberMgr.do?currentPage=1&blockCount='+blockCount);
   });
   
   $('form[name=search_form]').submit(function(){
      var mem_add1 = "";
      if($('#sido').val()!="" || $('#gugun').val()!=""){
         mem_add1 = $('#sido').val() +" " +$('#gugun').val() ;
      }
      var mem_hp ="";
      var mem_hp1 ="";
      if($('#search_hp1').val()!="" && $('#search_hp2').val()!="" &&  $('#search_hp3').val()!=""){
         mem_hp = $('#search_hp1').val() + "-" + $('#search_hp2').val() + "-" +$('#search_hp3').val();
      }
      
      
      var mem_year = "";
      var mem_month = "";
      var mem_day = "";
      if($('#search_year').val()!=""){
         mem_year = $('#search_year').val().substring(2,4)+'/';
      }
      if($('#search_month').val()!=""){
         mem_month = '/'+$('#search_month').val()+'/';
      }
      if($('#search_day').val()!=""){
         mem_day = '/'+$('#search_day').val();
      }
      
      $(this).append('<input type="hidden" name="mem_add1" value="'+mem_add1+'">');
      $(this).append('<input type="hidden" name="mem_hp" value="'+mem_hp+'">');
      $(this).append('<input type="hidden" name="mem_year" value="'+mem_year+'">');
      $(this).append('<input type="hidden" name="mem_month" value="'+mem_month+'">');
      $(this).append('<input type="hidden" name="mem_day" value="'+mem_day+'">');
   });
      
   $('#exelBtn').click(function(){
      var excel = getExcel();
      var uri = '${pageContext.request.contextPath}/admin/member/ExcelDownload.do?excel='+excel;
      $(location).attr('href', encodeURI(uri) );
   });
   
   function getExcel(){
      var checkValue = "";
      $("input[name=selectTotal]:checked").each(function(i,v){
         checkValue += "<tr>"
         checkValue += "<td>"+ $(this).parent().parent().children('td:eq(1)').text() +"</td>";
         checkValue += "<td>"+ $(this).parent().parent().children('td:eq(2)').text() +"</td>";
         checkValue += "<td>"+ $(this).parent().parent().children('td:eq(3)').text() +"</td>";
         checkValue += "<td>"+ $(this).parent().parent().children('td:eq(4)').text() +"</td>";
         checkValue += "</tr>"
      });
      return checkValue;
   }
   
//    function paging(currentPage) {
//        var $form = $('<form></form>');
//       $form.attr('action', '${pageContext.request.contextPath}/admin/member/memberMgr.do');
//       $form.attr('method', 'post');
       
//        var idx1 = $('<input type="hidden" value="${searchValue.search_base}" name="search_base">');
//        var idx2 = $('<input type="hidden" value="${searchValue.search_base_keyword}" name="search_base_keyword">');
//        var idx3 = $('<input type="hidden" value="${searchValue.mem_add1}" name="mem_addr1">');
//        var idx4 = $('<input type="hidden" value="${searchValue.mem_tel}" name="mem_tel">');
//        var idx5 = $('<input type="hidden" value="${searchValue.mem_bir_type}" name="mem_bir_type">');
//        var idx6 = $('<input type="hidden" value="${searchValue.mem_bir1}" name="mem_bir1">');
//        var idx7 = $('<input type="hidden" value="${searchValue.mem_bir2}" name="mem_bir2">');
//        var idx8 = $('<input type="hidden" value="${searchValue.mem_bir3}" name="mem_bir3">');
//        var idx9 = $('<input type="hidden" value="'+$('select[name=search_count]').val()+'" name="blockCount">');
//        if (currentPage != "") {
//            var idx10 = $('<input type="hidden" value="'+currentPage+'" name="currentPage">');
//            $form.append(idx1).append(idx2).append(idx3).append(idx4).append(idx5).append(idx6).append(idx7).append(idx8).append(idx9).append(idx10)
//       } else {
//            $form.append(idx1).append(idx2).append(idx3).append(idx4).append(idx5).append(idx6).append(idx7).append(idx8).append(idx9)

//       }
//       $(document.body).append($form);
//       $form.submit();
//    }
   
   $('#reset').click(function(){
      location.reload();
   });
    
});
</script>
<style type="text/css">
#clickTd:hover{cursor:pointer; }
</style>
<title>회원리스트</title>
</head>
<body>
<div class="wrap">   
   <table width="1000" border="0" cellpadding="0" cellspacing="0">
      <tr valign="top">
         <td width="30">&nbsp;</td>
         <td width="790">
            <div id="container">
               <div class="title">회원관리</div> 
               <form name="search_form" action="${pageContext.request.contextPath}/admin/member/memberMgr.do" method="post">
                  <table border="0" cellspacing="1" cellpadding="1">
                     <tr>
                        <th width="120">기본검색</th>
                        <td>
                           <select style="width: 130px;" name="search_base">
                                 <option selected="selected">선택하세요</option>
                                 <option value="mem_name">이름</option>
                                 <option value="mem_id">아이디</option>
                           </select>
                        <input name="search_base_keyword" type="text" size="20" /></td>
                     </tr>
                     <tr>
                        <th>거주지</th>
                        <td>
                           <select style="width: 130px;" name="search_sido" id="sido">
                                 <option selected="selected" value="">선택하세요</option>
                           </select> 
                           <select style="width: 130px;" name="search_gugun" id="gugun">
                              <option selected="selected" value="">선택하세요</option>
                           </select>
                        </td>
                     </tr>
                     <tr>
                        <th>연락처</th>
                        <td>
                           <select style="width: 100px;" name="search_hp1" id="search_hp1">
                              <option selected="selected" value="">선택하세요</option>
                           </select> - 
                           <input name="search_hp2" type="text" id="search_hp2" size="20" /> - 
                           <input name="search_hp3" type="text" id="search_hp3" size="20" />
                        </td>
                     </tr>
                     <tr>
                        <th>생년월일</th>
                        <td><input type="radio" name="mem_date_type" value="solar" checked="checked"/>양력
                           <input type="radio" name="mem_date_type" value="lunar" />음력 
                           <select style="width: 130px;" name="search_year" id="search_year">
                              <option selected="selected" value="">선택하세요</option>
                           </select> 
                           <select style="width: 130px;" name="search_month" id="search_month">
                              <option selected="selected" value="">선택하세요</option>
                           </select> 
                           <select style="width: 130px;" name="search_day" id="search_day">
                              <option selected="selected" value="">선택하세요</option>
                           </select>
                        </td>
                     </tr>
                  </table>
                  <div style="padding-top: 5px; text-align: right;">
                     <input class="btn1" id="reset" value="초기화" style="width:60px; height:30px;"/>
                     <input class="btn1" type="submit" value="검색하기" style="width:60px; height:30px;"/>
                  </div>
               </form>
               <div style="padding-top: 5px;" id="search_totalMembers">
                  <label class="totalmembers"></label>
                  <select style="width: 50px; float: right;" name="search_count">
                     <option selected="selected" value="10">10</option>
                     <option value="25">25</option>
                     <option value="50">50</option>
                  </select>
               </div>
               <div style="height: 15px;"></div>
               <table border="0" cellspacing="1" cellpadding="1">
                  <thead>
                     <tr>
                        <th width="10%">
                            선택
                        </th>
                        <th width="20%">아이디</th>
                        <th>이름</th>
                        <th>생일</th>
                        <th>메일</th>
                     </tr>
                  </thead>
                  <tbody class="memberList" id="memberList">
                     <c:forEach items="${memberList }" var="memberList">
                     <tr>
                        <td><input type="checkbox" name="selectTotal" class="checkbox_align"/>&nbsp;</td>                        
                        <td name="clickTd" id="clickTd">${memberList.mem_id }</td>
                        <td>${memberList.mem_name }</td>
                        <td>${memberList.mem_bir.substring(0,10) }</td>
                        <td>${memberList.mem_mail }</td>
                     </tr>
                     </c:forEach>
                  </tbody>
               </table>   
               ${pageHtml }
               <div align="center">
                  <span class="pagingHtml"></span>
                  <input class="btn2" type="button" id="exelBtn" value="Excel작성" style="float: right;"/>
               </div>
            </div>
         </td>
      </tr>

   </table>
</div>
</body>
</html>