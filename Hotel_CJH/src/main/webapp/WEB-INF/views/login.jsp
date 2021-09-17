<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
 <style>
     @import url('https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap');
     body,input,select {
     font-family: 'Gowun Batang', serif; 
       }
     body{
     background-image:url(https://cdn.pixabay.com/photo/2018/09/30/14/05/hotel-3713613_960_720.jpg);
     background-size:100%;
     text-align:center;
     }
     
  </style>
<body text="#FFC0CB">
<로그인> 페이지 입니다.<br>
 아이디와 비밀번호를 입력해 주세요. <br>
[취소] 클릭시 <홈화면> 으로 이동합니다. <br><br>
<form method="post" action="/app/check_user/" id=frmLogin>
   아이디명: <input type=text name=userid><br><br>
   비밀번호: <input type=password name=userpw><br><br>
 <input type=submit value="확인" style="background-color:#FFD0AF; color: #0000FF;">
 </form>
<form method="get" action="/app/" style=padding-top:10px; >
<input type=submit value="취소" style="background-color:#FFD0AF; color: #CD1039;">
</form>
<form method="get" action="/app/newbie" style=padding-top:10px;>
<input type=submit value="회원가입" style="background-color:#FFD0AF; color: #FF8200;" >
</form>
</body>
<script src='http://code.jquery.com/jquery-3.5.0.js'></script>
<script>
$(document)
.on('submit','#frmLogin',function(){
	let pstr=$.trim($('[name=userid]').val());
	$('[name=userid]').val(pstr);
	pstr=$.trim($('[name=userpw]').val());
	$('[name=userpw]').val(pstr);
	if($('[name=userid]').val()==''){
		alert("로그인 아이디를 입력하세요.");
		return false;
	}
	if($('[name=userpw]').val()==''){
		alert("비밀번호를 입력해주세요.");
		return false;
	}
	if($('[name=userid]').val()!='ad'){
		alert("등록되지 않은 아이디입니다.");
		return false;
	}
})
</script>
</html>