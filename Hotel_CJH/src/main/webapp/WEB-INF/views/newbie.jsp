<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join membership page</title>
</head>
<body>
<form method=get action="/app/new">
실명: <input type="text" name=realname><br>
아이디: <input type="text" name=userid><br>
비밀번호: <input type="password" name=userpw><br>
비밀번호확인: <input type="password" name=userpw><br>
모바일: <input type="text" name=mobile><br><br>
<input type=submit value ='회원가입'><br>
</form>

<form method=get action="/app/">
<input type=submit value ='취소' action="/app/home"><br>
</form>

<form method=get action="/app/login">
<input type=submit value ='로그인' action="/app/home"><br>
</form>

</body>
</html>