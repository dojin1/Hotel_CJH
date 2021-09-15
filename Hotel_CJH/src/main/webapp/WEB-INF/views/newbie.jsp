<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
 <style>
     @import url('https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap');
     body,input,select {
       font-family: 'Gowun Batang', serif; 
       }
     body{background-color: #FFE6CC;}  
  </style>
<body>
<회원가입> 페이지 입니다. 아래 빈칸을 채워주세요.<br>
[취소] 클릭시 <홈화면> 으로 이동합니다. <br><br>
<form method="post" action="/app/signin/">
회원실명: <input type="text" name=newname id=newname ><br><br>
아이디명: <input type="text" name=newid id=newid ><br><br>
비밀번호: <input type="password" name=newpw id=newpw><br><br>
비밀번호: <input type="password" name=newpw2 id=newpw2> 재확인<br><br>

<input type=submit value="회원가입" id=join style="background-color:#FFD0AF; color: #000000;">
</form>
<form method="post" action="/app/" style=padding-top:10px;>
<input type=submit value="취소" style="background-color:#FFD0AF; color: #000000;">
</form>
</body>
<script src='http://code.jquery.com/jquery-3.5.0.js'></script>
<script>
$(document)
.on('click','#join',function(){
	if($('input[name=newname]').val()==''){ // id값 줬다면 왼쪽처럼 해도되고 $('[id=newname]'),val()도 가능
		alert('이름을 입력하세요.');
		return false;
	}
	if($('input[name=newid]').val()==''){ // id값 줬다면 $('#newid').val()도 가능.
		alert('아이디를 입력하세요.');
		return false;
	}
	if($('input[name=newpw]').val()==''){
		alert('비밀번호를 입력하세요.')
		return false;
	}
	if($('input[name=newpw]').val()!=$('input[name=newpw2]').val()){
	alert('비밀번호가 일치하지 않습니다.');
	return false;
	}
	return ture;
	
});
</script>
</html>