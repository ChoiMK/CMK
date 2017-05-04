<%@ page language="JAVA" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<title>아빠!!!미안해!!!</title>
<body>
<tiles:insertAttribute name="header"></tiles:insertAttribute>
<div class="wrap">
   <table width="1000" border="0" cellpadding="0" cellspacing="0">
      <tr valign="top">
         <td width="180"><tiles:insertAttribute name="menu"></tiles:insertAttribute></td>
         <td width="30">&nbsp;</td>
         <td width="790"> 
            <div id="container">
               <tiles:insertAttribute name="content"></tiles:insertAttribute>
            </div>
         </td>
      </tr>
   </table>
</div>
</body>
</html>