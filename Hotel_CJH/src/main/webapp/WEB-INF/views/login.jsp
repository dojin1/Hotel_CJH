<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login page</title>
</head>
<body>
로그인 페이지 입니다. 아이디와 비밀번호를 입력해주세요. <br><br>
<form method="post" action="/app/check_user/">
	아이디: <input type=text name=userid><br>
	비밀번호: <input type=text name=userpw><br><br>
 <input type=submit value="확인">
 </form>
<form method="get" action="/app/">
<input type=submit value="취소">
</form>
<form method="get" action="/app/newbie">
<input type=submit value="회원가입">
</form>
</body>
</html>