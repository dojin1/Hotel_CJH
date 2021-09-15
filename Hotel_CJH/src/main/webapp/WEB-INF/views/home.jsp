<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page session="false" %>
<html>
<head>
	<title>홈</title>
</head>
 <style>
     @import url('https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap');
     body,input,select {
       font-family: 'Gowun Batang', serif; 
       }
    body{
    background-image:url(https://cdn.pixabay.com/photo/2018/09/30/14/05/hotel-3713613_960_720.jpg);
    background-size:100% 100%;
    }
  </style>
<body text="#FFC0CB">
호텔관리 프로그램 홈화면 입니다.<br><br>
<form method="post" action="/app/login" style=padding-top:10px;>
<input type=submit value="로그인" style="background-color:#000000; color: #FFC0CB;">
</form>
<form method="post" action="/app/newbie">
<input type=submit value="회원가입" style="background-color:#000000; color: #FFC0CB;">
</form>
<!--  <a href='selected?path=login'>로그인</a>&nbsp;&nbsp;
<a href='selected?path=newbie'>회원가입</a>-->
</body>
</html>
