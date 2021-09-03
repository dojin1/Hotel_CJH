<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join membership page</title>
</head>
<body>
<form method="post" action="/app/signin/">
실명: <input type="text" name=newname ><br>
아이디: <input type="text" name=newid ><br>
비밀번호: <input type="password" name=newpw><br>
비밀번호확인: <input type="password" name=newpw2><br>
<input type=submit value="회원가입" id=join >
</form>
<form method="post" action="/app/">
<input type=submit value="취소">
</form>
</body>
<script src='http://code.jquery.com/jquery-3.5.0.js'></script>
<script>
$(document)
.on('click','#join',function(){
	if($('input[name=newname]').val()==''){
		alert('이름을 입력하세요.');
		return false;
	}
	if($('input[name=newid]').val()==''){
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